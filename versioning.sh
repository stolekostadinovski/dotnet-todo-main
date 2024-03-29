#!/bin/bash

# Get the latest version tag
latest_version=$(git describe --tags --abbrev=0)

if [ -z "$latest_version" ]; then
    # No tags found, set default initial version
    initial_version="0.1.0"
    new_version="$initial_version"
else
    # Extract major, minor, and patch version numbers from the latest tag
    major=$(echo $latest_version | cut -d. -f1)
    minor=$(echo $latest_version | cut -d. -f2)
    patch=$(echo $latest_version | cut -d. -f3)

    # Determine the type of version bump based on commit messages in src/ directory
    commits_since_last_tag=$(git log --oneline $latest_version..HEAD -- src/ | wc -l)
    if [ $commits_since_last_tag -eq 0 ]; then
        echo "No new commits since the last tag in src/ directory. Exiting."
        exit 0
    elif git log --oneline $latest_version..HEAD -- src/ | grep -E 'BREAKING CHANGE' >/dev/null; then
        major=$((major + 1))
        minor=0
        patch=0
        new_version="$major.$minor.$patch"
    elif git log --oneline $latest_version..HEAD -- src/ | grep -E 'feat' >/dev/null; then
        minor=$((minor + 1))
        patch=0
        new_version="$major.$minor.$patch"
    else
        patch=$((patch + 1))
        new_version="$major.$minor.$patch"
    fi
fi

# Output the new version
echo $new_version
