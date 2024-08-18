#!/bin/bash

# Change directory to the root of the repository
cd "$(git rev-parse --show-toplevel)"

# Updates the URL, SHA256 checksum, and version of the latest release of the git-recon Homebrew formula.
# Currently supports only the `git-recon` formula, but could be made generic to support multiple formulas.

# Safely clean up the temporary directory after the tests
cleanup_temp_dir() {
  if [[ "$TEMP_DIR" == /tmp/* || "$TEMP_DIR" == /var/folders/* ]]; then
    rm -rf "$TEMP_DIR"
  else
    echo "Warning: Skipping cleanup of unexpected temporary directory $TEMP_DIR"
  fi
}

# Variables
REPO="williamthorsen/git-recon"
FORMULA_PATH="Formula/git-recon.rb"
API_URL="https://api.github.com/repos/$REPO/releases/latest"
RELEASE_DATA=$(curl -s $API_URL)
LATEST_VERSION=$(echo "$RELEASE_DATA" | jq -r '.tag_name')
# Remove the 'v' prefix if it exists
LATEST_VERSION=${LATEST_VERSION#v}
TARBALL_URL="https://github.com/$REPO/archive/refs/tags/v$LATEST_VERSION.tar.gz"

# Create a temporary directory for the download
TEMP_DIR=$(mktemp -d)
TARBALL_FILE="$TEMP_DIR/$LATEST_VERSION.tar.gz"

# Download the tarball
curl -L -o $TARBALL_FILE $TARBALL_URL

# Compute the SHA256 checksum
SHA256=$(shasum -a 256 $TARBALL_FILE | awk '{ print $1 }')

# Update the Formula with the correct URL, SHA256, and version
sed -i "" "s|^  url \".*\"|  url \"$TARBALL_URL\"|" $FORMULA_PATH
sed -i "" "s|^  sha256 \".*\"|  sha256 \"$SHA256\"|" $FORMULA_PATH
sed -i "" "s|^  version \".*\"|  version \"$LATEST_VERSION\"|" $FORMULA_PATH

cleanup_temp_dir

echo "Formula updated with version: $LATEST_VERSION, URL: $TARBALL_URL, and SHA256: $SHA256"
