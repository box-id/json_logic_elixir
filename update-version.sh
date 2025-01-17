#!/bin/bash

# Check if an argument was provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide an argument"
    echo "Usage: ./update-version.sh <argument>"
    exit 1
fi

NEW_TAG_VERSION=$1

echo "New tag version: $NEW_TAG_VERSION"

# Update the version in the CHANGELOG.md file
sed -i "s/## \[Unreleased\]/## \[$NEW_TAG_VERSION\] - $(date +%Y-%m-%d)/" CHANGELOG.md

# Create a new `## [Unreleased]` section above the new version
sed -i "s/## \[$NEW_TAG_VERSION\] - $(date +%Y-%m-%d)/## [Unreleased]\n\n## \[$NEW_TAG_VERSION\] - $(date +%Y-%m-%d)/" CHANGELOG.md
