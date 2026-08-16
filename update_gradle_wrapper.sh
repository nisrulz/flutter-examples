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
#  ./update_gradle_wrapper.sh --version 9.7.0
# ______________________________________________________________________

get_version() {
	if [ "$1" = "--version" ]; then
		if [ -z "$2" ]; then
			echo "      ✖  No version specified. Use: ./update_gradle_wrapper.sh --version 9.7.0" >&2
			exit 1
		fi
		echo "      Using provided Gradle version: $2" >&2
		echo "$2"
	else
		echo "      Fetching the latest Gradle version from GitHub..." >&2
		local latest
		latest=$(curl -sL https://api.github.com/repos/gradle/gradle/releases/latest | grep -m1 '"tag_name":' | sed -E 's/.*"tag_name":[[:space:]]*"v?([^"]+)".*/\1/')
		if [ -z "$latest" ]; then
			echo "      ✖  Could not fetch the latest Gradle version. Check your network connection." >&2
			exit 1
		fi
		echo "      Latest Gradle version is: $latest" >&2
		echo "$latest"
	fi
}

update_wrapper() {
	local project_dir="$1"
	local props="$project_dir/gradle/wrapper/gradle-wrapper.properties"
	if [ ! -f "$props" ]; then
		echo "      ↪️  $(basename "$project_dir") — no gradle-wrapper.properties, skipped" >&2
		return
	fi

	sed -i '' -E "s#(gradle-)[0-9]+(\.[0-9]+)*(-(bin|all)\.zip)#\1${version}\3#" "$props"
	echo "      ↪️  $(basename "$(dirname "$project_dir")") ✔️ (gradle $version)"
}

version=$(get_version "$1" "$2")

echo "      Updating gradle wrapper for:"
for DIR in ./*;
do
	if [ -f "$DIR/android/gradlew" ]; then
		update_wrapper "$DIR/android"
	fi
done

# Delete all generated build folders, because they will eat up a lot of space on the disc
./delete_build_folder.sh
