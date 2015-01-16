#!/bin/bash

set -e

echo "-----Building android arches------"
ndk-build

printf "Creating install paths..."

SCRIPT_PATH="`dirname \"$0\"`"
INSTALL_PATH="$SCRIPT_PATH/../prebuilt/android"
LIB_NAME="libgladmanaes.a"

mkdir -p "$INSTALL_PATH/armeabi/"
mkdir -p "$INSTALL_PATH/armeabi-v7a/"
mkdir -p "$INSTALL_PATH/x86/"

echo "OK"

printf "Copying libs...."

cp "obj/local/armeabi/$LIB_NAME" "$INSTALL_PATH/armeabi/$LIB_NAME"
cp "obj/local/armeabi-v7a/$LIB_NAME" "$INSTALL_PATH/armeabi-v7a/$LIB_NAME"
cp "obj/local/x86/$LIB_NAME" "$INSTALL_PATH/x86/$LIB_NAME"

echo "OK"

pushd "$INSTALL_PATH" > /dev/null
echo "Done - files installed to $PWD"
popd  > /dev/null
