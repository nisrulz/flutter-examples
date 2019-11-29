#!/bin/bash
# Written by Nishant Srivastava

#  Call as
#  ./get_packages.sh

echo "  ‣  Updating packages..."

# Iterate over each sub-directory inside the current directory
for DIR in ./*;
do
	# Check if pubspec.yaml file exists inside the $DIR directory
	# If it does then it is a Flutter project
	if [ -f "$DIR/pubspec.yaml" ]; then
		# Navigate into the sub directory
		cd "$DIR"

		# Run `flutter packages get` command inside the sub-directory i.e Flutter project
		flutter packages get | grep "FAILED"

		# Print the name of the sub directory when done
		echo "$DIR" | awk -F'/' '{print $2}' | xargs -I{} echo "      ↪️  {} ✔️"

		# Go back to parent directory
		cd ../
	fi
done

echo "  ✔️  Done."