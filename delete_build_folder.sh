#!/bin/bash
# Written by Nishant Srivastava

#  Call as
#  ./delete_build_folder.sh

# Install trash cli
# brew install trash

# Iterate over each child directory inside the current directory
echo ""
for dir in ./*;
do
	echo ""
	echo ">>>> Deleting build directory inside " $dir
	trash $dir/build/
	echo ""
	echo ">>>> Done."
done
