#!/bin/sh

#1
set -e

#2
swift build -c release --arch arm64 --arch x86_64
BUILD_PATH=$(swift build -c release --arch arm64 --arch x86_64 --show-bin-path)
echo -e "\n\nBuild at ${BUILD_PATH}"

#3
DESTINATION="builds/ProjectAnalyzer-macos"
if [ ! -d "builds" ]; then
    mkdir "builds"
fi

cp "$BUILD_PATH/ProjectAnalyzer" "$DESTINATION"
echo "Copied binary to $DESTINATION"