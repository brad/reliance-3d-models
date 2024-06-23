#!/bin/bash

rm -rf dist && mkdir dist

openscad src/plug.scad -o dist/plug-new.stl
openscad -D original=true src/plug.scad -o dist/plug-original.stl

# Extract version from package.json
VERSION=$(jq -r '.version' package.json)

# Use the extracted version in the zip filename
(cd dist && zip -j "reliance-${VERSION}.zip" *.stl)
