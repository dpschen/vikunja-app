#!/usr/bin/env bash
set -euo pipefail

# Directory where Flutter SDK will be installed. You can override this by
# setting the FLUTTER_DIR environment variable before running the script.
FLUTTER_DIR="${FLUTTER_DIR:-$(pwd)/.flutter}"

# Determine which Flutter version to install. By default this reads the
# version from a `.flutter-version` file if present. You can override it with
# the FLUTTER_VERSION environment variable.
if [ -z "${FLUTTER_VERSION:-}" ] && [ -f .flutter-version ]; then
    FLUTTER_VERSION="$(cat .flutter-version)"
fi

if [ ! -d "$FLUTTER_DIR" ]; then
    mkdir -p "$FLUTTER_DIR"

    echo "Fetching Flutter releases information..."
    RELEASES_JSON=$(curl -s https://storage.googleapis.com/flutter_infra_release/releases/releases_linux.json)

    if [ -z "${FLUTTER_VERSION:-}" ]; then
        VERSION=$(echo "$RELEASES_JSON" | jq -r '.current_release.stable')
    else
        VERSION="$FLUTTER_VERSION"
    fi

    ARCHIVE_PATH=$(echo "$RELEASES_JSON" | jq -r --arg ver "$VERSION" '.releases[] | select(.version==$ver) | .archive')
    DOWNLOAD_URL="https://storage.googleapis.com/flutter_infra_release/releases/$ARCHIVE_PATH"

    echo "Downloading Flutter SDK $VERSION from $DOWNLOAD_URL"
    curl -L "$DOWNLOAD_URL" -o flutter.tar.xz
    tar xf flutter.tar.xz --strip-components=1 -C "$FLUTTER_DIR"
    rm flutter.tar.xz
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

echo "Flutter installation complete. Version:"
flutter --version
