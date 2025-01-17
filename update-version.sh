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

# Update the link definitions in the CHANGELOG.md file
# e.g. change `[unreleased]: https://github.com/box-id/json_logic_elixir/compare/<old_tag_version>...HEAD` to `[unreleased]: https://github.com/box-id/json_logic_elixir/compare/<new_tag_version>...HEAD`
# old tag version is not known, so we need to find it in the file   
OLD_TAG_VERSION=$(sed -n 's/\[unreleased\]: .*\/compare\/\(.*\)\.\.\.HEAD$/\1/p' CHANGELOG.md)

sed -i "s/compare\/$OLD_TAG_VERSION\.\.\./compare\/$NEW_TAG_VERSION.../g" CHANGELOG.md

# Create new link definitions for the new tag version underneath the `[Unreleased]` link definition
NEW_LINK="[$NEW_TAG_VERSION]: https:\/\/github.com\/box-id\/json_logic_elixir\/compare\/$OLD_TAG_VERSION...$NEW_TAG_VERSION"
sed -i "/\[unreleased\]:.*/a $NEW_LINK" CHANGELOG.md
