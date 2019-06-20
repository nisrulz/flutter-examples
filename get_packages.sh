#!/bin/bash
# Written by Nishant Srivastava

#  Call as
#  ./get_packages.sh

echo "# Updating to packages..."

# Iterate over each sub-directory inside the current directory
for DIR in ./*;
do
	# Check if pubspec.yaml file exists inside the $DIR directory
	# If it does then it is a Flutter project
	if [ -f "$DIR/pubspec.yaml" ]; then
		# Update the packages in the project
		echo ""
		echo ">>>> Get packages for " "$DIR"
		# Run `flutter packages get` command inside the sub-directory i.e Flutter project
		(cd "$DIR" && flutter packages get);
		echo ""
		echo ">>>> Done."
	fi
done