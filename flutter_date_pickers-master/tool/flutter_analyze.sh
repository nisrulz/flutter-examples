#!/bin/sh

OUTPUT="$(flutter analyze)"
echo "$OUTPUT"
echo
if grep -q "error •" echo "$OUTPUT"; then
    echo "flutter analyze found errors"
    exit 1
else
    echo "flutter analyze didn't find any errors"
    exit 0
fi