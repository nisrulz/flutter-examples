#!/usr/bin/env bash
set -euo pipefail

# Copyright 2018 Nishant Srivastava
# Licensed under the Apache License, Version 2.0

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

trap 'echo "  [!] Interrupted, stopping..." >&2; exit 130' INT

force=0
version=""

for arg in "$@"; do
	case "$arg" in
		-f) force=1 ;;
		--version) ;;
		-*)
			echo "  [!] Unknown flag: $arg" >&2
			exit 1
			;;
		*) version="$arg" ;;
	esac
done

separator
if [ -z "$version" ]; then
	echo "  Fetching the latest Gradle version from GitHub..." >&2
	version=$(curl -sL https://api.github.com/repos/gradle/gradle/releases/latest | grep -m1 '"tag_name":' | sed -E 's/.*"tag_name":[[:space:]]*"v?([^"]+)".*/\1/')
	if [ -z "$version" ]; then
		echo "  [!] Could not fetch the latest Gradle version. Check your network connection." >&2
		exit 1
	fi
	echo "  Latest Gradle version is: $version" >&2
else
	echo "  Using provided Gradle version: $version" >&2
fi

updated=0
skipped=0
no_props=0
failed=0
updated_apps=()
skipped_apps=()
no_props_apps=()
failed_apps=()

update_wrapper() {
	local dir="$1"
	local project_dir="$dir/android"
	local app_name
	app_name=$(basename "$dir")
	local props="$project_dir/gradle/wrapper/gradle-wrapper.properties"

	if [ ! -f "$props" ]; then
		no_props=$((no_props + 1))
		no_props_apps+=("$app_name")
		return
	fi

	local current
	current=$(grep -oE 'gradle-[0-9]+(\.[0-9]+)+' "$props" | grep -oE '[0-9]+(\.[0-9]+)+')

	if [ "$force" = 0 ] && [ "$current" = "$version" ]; then
		skipped=$((skipped + 1))
		skipped_apps+=("$app_name")
		return
	fi

	if (cd "$project_dir" && ./gradlew wrapper --gradle-version "$version" --distribution-type bin >/dev/null 2>&1); then
		updated=$((updated + 1))
		updated_apps+=("$app_name")
	else
		failed=$((failed + 1))
		failed_apps+=("$app_name")
	fi
}

echo "  Updating gradle wrapper for:"
for_each_app android/gradlew update_wrapper

separator
printf "  %-16s %s\n" "Upgraded:" "$updated"
printf "  %-16s %s\n" "Skipped:" "$skipped already on $version (use -f to force)"
printf "  %-16s %s\n" "No wrapper:" "$no_props"
printf "  %-16s %s\n" "Failed:" "$failed"
if [ "${#skipped_apps[@]}" -gt 0 ]; then
	echo "  Skipped apps:"
	printf "    %s\n" "${skipped_apps[@]}"
fi
if [ "${#updated_apps[@]}" -gt 0 ]; then
	echo "  Upgraded apps:"
	printf "    %s\n" "${updated_apps[@]}"
fi
if [ "${#no_props_apps[@]}" -gt 0 ]; then
	echo "  No wrapper apps:"
	printf "    %s\n" "${no_props_apps[@]}"
fi
if [ "${#failed_apps[@]}" -gt 0 ]; then
	echo "  Failed apps:"
	printf "    %s\n" "${failed_apps[@]}"
fi
