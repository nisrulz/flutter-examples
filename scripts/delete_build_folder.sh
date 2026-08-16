#!/usr/bin/env bash
set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/common.sh"

separator
echo "  Deleting build directories..."
find . -type d -name "build" -exec trash {} +
separator
echo "  Done."
