#!/usr/bin/env bash

# Shared helpers for scripts in this directory.
# Source this file at the top of each script.

# cd to the repo root so all scripts work regardless of invocation directory.
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.." || exit 1

separator() {
	echo "  ========================================================="
}

# Run a function for every app subdirectory that has the given marker file.
# Usage: for_each_app <marker-path> <function-name>
for_each_app() {
	local marker="$1"
	local fn="$2"
	for dir in ./*; do
		if [ -f "$dir/$marker" ]; then
			"$fn" "$dir"
		fi
	done
}
