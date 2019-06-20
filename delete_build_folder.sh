#!/bin/bash
# Written by Nishant Srivastava

#  Call as
#  ./delete_build_folder.sh

# Install trash cli
# brew install trash

echo "# Deleting build directories..."

# Iterate over each sub-directory inside the current directory
for DIR in ./*;
do
	# Check if build directory exists inside the $DIR directory
	# If it does then it is a Flutter project
	if [ -d "$DIR/build/" ]; then
		# Update the packages in the project
		echo ""
		echo ">>>> Deleting build directory inside " "$DIR"
		# Run command inside the sub-directory i.e Flutter project
		(cd "$DIR" && trash build);
		echo ""
		echo ">>>> Done."
	fi
done
