#!/bin/sh

#1
set -e

#2
swift build -c release
BUILD_PATH=$(swift build -c release --show-bin-path)
echo -e "\n\nBuild at ${BUILD_PATH}"

#3
DESTINATION="builds/ProjectAnalyzer-linux"
if [ ! -d "builds" ]; then
    mkdir "builds"
fi

cp "$BUILD_PATH/ProjectAnalyzer" "$DESTINATION"
echo "Copied binary to $DESTINATION"