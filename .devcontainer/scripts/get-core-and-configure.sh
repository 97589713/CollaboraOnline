#!/bin/bash
set -e

echo "=== Get Core & Configure ==="

# Download and extract LibreOffice core
cd /workspace
if [ ! -d "instdir" ]; then
    echo "Downloading LibreOffice core..."
    wget --no-verbose https://github.com/CollaboraOnline/online/releases/download/for-code-assets/core-co-25.04-assets.tar.gz
    tar xf core-co-25.04-assets.tar.gz
    rm core-co-25.04-assets.tar.gz
else
    echo "LibreOffice core already exists, skipping download."
fi

# Return to project directory
cd /workspace/CollaboraOnline

# Run autogen and configure
echo "Running autogen.sh..."
./autogen.sh

echo "Running configure..."
./configure --enable-silent-rules --with-lokit-path=/workspace/include --with-lo-path=/workspace/instdir --enable-debug -enable-cypress

# Copy configuration files
echo "Copying configuration files..."
cp .gitpod-files/coolwsd-gitpod.xml coolwsd.xml
mkdir -p .vscode
cp .gitpod-files/settings.json .vscode/settings.json

echo "=== Configuration complete ==="
