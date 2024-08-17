#!/bin/bash

# Change directory to the root of the repository
cd "$(git rev-parse --show-toplevel)"

# Updates the URL and SHA256 checksum of the latest release of the git-recon Homebrew formula.
# Currently supports only the `git-recon` formula, but could be made generic to support multiple formulas.

# Variables
REPO="williamthorsen/git-recon"
FORMULA_PATH="Formula/git-recon.rb"
API_URL="https://api.github.com/repos/$REPO/releases/latest"
TARBALL_URL=$(curl -s $API_URL | grep "tarball_url" | cut -d '"' -f 4)
LATEST_VERSION=$(echo $TARBALL_URL | grep -oP "(?<=/archive/)(v[0-9.]+)(?=\.tar\.gz)")
TARBALL_FILE="$LATEST_VERSION.tar.gz"

# Download the tarball
curl -L -o $TARBALL_FILE $TARBALL_URL

# Compute the SHA256 checksum
SHA256=$(shasum -a 256 $TARBALL_FILE | awk '{ print $1 }')

# Update the Formula
sed -i "" "s|^  url \".*\"|  url \"$TARBALL_URL\"|" $FORMULA_PATH
sed -i "" "s|^  sha256 \".*\"|  sha256 \"$SHA256\"|" $FORMULA_PATH

# Clean up
rm $TARBALL_FILE

echo "Formula updated with URL: $TARBALL_URL and SHA256: $SHA256"
