#!/usr/bin/env bash

# Copyright 2018 Nishant Srivastava
# 
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#    http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# ______________________________________________________________________
#  Call as
#  ./update_gradle_wrapper.sh
# ______________________________________________________________________

read -p "  ❓  Update gradle wrapper to which version?   " version

# Iterate over each child directory inside the current directory
echo "      Updating gradle wrapper for:"
# Iterate over each sub-directory inside the current directory
for DIR in ./*;
do
	# Check if gradlew exists inside the $DIR directory
	# If it does then it is an Gradle project
	if [ -f "$DIR/android/gradlew" ]; then
		# Navigate into the sub directory
		cd "$DIR/android"

		# Run command inside the sub-directory i.e Gradle project
		./gradlew clean | egrep 'FAILED|WARNING' 
		./gradlew wrapper --gradle-version $version --distribution-type bin | grep "FAILED"

		# Print the name of the sub directory when done
		echo "$DIR" | awk -F'/' '{print $2}' | xargs -I{} echo "      ↪️  {} ✔️"

		# Go back to parent directory
		cd ../../
	fi
done

# Delete all generated build folders, because they will eat up a lot of space on the disc
./delete_build_folder.sh
