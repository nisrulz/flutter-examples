#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

updated=0
failed=0
failed_apps=()

update_packages() {
	local dir="$1"
	local app
	app=$(basename "$dir")

	if ! (cd "$dir" && flutter packages get >/dev/null 2>&1); then
		failed=$((failed + 1))
		failed_apps+=("$app")
		return
	fi

	updated=$((updated + 1))
}

separator
echo "  Updating packages for all Flutter apps:"
for_each_app pubspec.yaml update_packages
separator
printf "  %-16s %s\n" "Updated:" "$updated"
printf "  %-16s %s\n" "Failed:" "$failed"
if [ "${#failed_apps[@]}" -gt 0 ]; then
	echo "  Failed apps:"
	printf "    %s\n" "${failed_apps[@]}"
fi
separator
