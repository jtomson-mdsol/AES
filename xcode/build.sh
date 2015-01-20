#!/bin/bash

set -e

echo "-----Building iOS arches------"
xcodebuild VALID_ARCHS="armv7 arm64" ARCHS="armv7 arm64" -sdk iphoneos

echo "-----Building iOS arches------"
xcodebuild VALID_ARCHS="x86_64 i386" ARCHS="x86_64 i386" -sdk iphonesimulator

printf "Creating install paths..."

SCRIPT_PATH="`dirname \"$0\"`"
BASE_INSTALL_PATH="$SCRIPT_PATH/../prebuilt/"
INCLUDES_INSTALL_PATH="$BASE_INSTALL_PATH/include/aes"
LIB_INSTALL_PATH="$BASE_INSTALL_PATH/lib/ios"
LIB_NAME="libGladmanAES.a"

mkdir -p "$INCLUDES_INSTALL_PATH"
mkdir -p "$LIB_INSTALL_PATH"

echo "OK"

printf "Lipo'n libs...."
lipo -create "build/Release-iphoneos/$LIB_NAME" "build/Release-iphonesimulator/$LIB_NAME" -o "$LIB_INSTALL_PATH/$LIB_NAME"
echo "OK"

printf "Copying headers..."
cp -r "build/Release-iphoneos/include/" "$INCLUDES_INSTALL_PATH"
echo "OK"

pushd "$BASE_INSTALL_PATH" > /dev/null
echo "Done - files installed to $PWD"
popd  > /dev/null
