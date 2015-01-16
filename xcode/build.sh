#!/usr/bin/bash

set -e

echo "-----Building iOS arches------"
xcodebuild VALID_ARCHS="armv7 arm64" ARCHS="armv7 arm64" -sdk iphoneos

echo "-----Building iOS arches------"
xcodebuild VALID_ARCHS="x86_64" ARCHS="x86_64" -sdk iphonesimulator

printf "Creating install paths..."

SCRIPT_PATH="`dirname \"$0\"`"
INSTALL_PATH="$SCRIPT_PATH/../prebuilt/ios"
LIB_NAME="libGladmanAES.a"

mkdir -p "$INSTALL_PATH"

echo "OK"

printf "Lipo'n libs...."
lipo -create "build/Release-iphoneos/$LIB_NAME" "build/Release-iphonesimulator/$LIB_NAME" -o "$INSTALL_PATH/$LIB_NAME"
echo "OK"

printf "Copying headers..."
cp -r "build/Release-iphoneos/include" "$INSTALL_PATH"
echo "OK"

pushd "$INSTALL_PATH" > /dev/null
echo "Done - files installed to $PWD"
popd  > /dev/null
