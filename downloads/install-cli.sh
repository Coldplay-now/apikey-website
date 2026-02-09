#!/bin/bash
set -euo pipefail

# apikey-cli install script
# Usage: curl -fsSL https://coldplay-now.github.io/apikey-website/downloads/install-cli.sh | bash

BINARY_NAME="apikey"
INSTALL_DIR="/usr/local/bin"
WEBSITE="https://coldplay-now.github.io/apikey-website"
VERSION="1.0.0"
DOWNLOAD_URL="${WEBSITE}/downloads/apikey-cli-v${VERSION}-darwin-universal.tar.gz"

# Detect platform
OS="$(uname -s)"

if [ "$OS" != "Darwin" ]; then
    echo "Error: apikey-cli currently only supports macOS"
    exit 1
fi

echo "Installing apikey-cli v${VERSION}..."

# Create temp directory
TMPDIR=$(mktemp -d)
trap "rm -rf $TMPDIR" EXIT

# Download and extract
echo "Downloading from ${DOWNLOAD_URL}..."
curl -fsSL "$DOWNLOAD_URL" -o "${TMPDIR}/apikey.tar.gz"
tar -xzf "${TMPDIR}/apikey.tar.gz" -C "$TMPDIR"

# Install
echo "Installing to ${INSTALL_DIR}/${BINARY_NAME}..."
if [ -w "$INSTALL_DIR" ]; then
    cp "${TMPDIR}/${BINARY_NAME}" "${INSTALL_DIR}/${BINARY_NAME}"
else
    sudo cp "${TMPDIR}/${BINARY_NAME}" "${INSTALL_DIR}/${BINARY_NAME}"
fi
chmod +x "${INSTALL_DIR}/${BINARY_NAME}"

echo ""
echo "apikey-cli v${VERSION} installed successfully!"
echo ""
echo "Run 'apikey version' to verify."
echo "Run 'apikey status' to check your environment."
echo ""
echo "Prerequisites:"
echo "  - apikey macOS App must be installed and have keys added"
echo "  - ${WEBSITE}"
