#!/bin/bash

# Move to project root (assumes .scripts is one level deep)
cd "$(dirname "$0")/.."

# Define paths
SWIFTLINT_PATH="$(pwd)/.executionFiles/swiftlint"
SWIFTLINT_CONFIG="$(pwd)/.configs/.swiftlint.yml"

# Skip for SwiftUI preview builds
if [ "${XCODE_RUNNING_FOR_PREVIEWS}" == "1" ]; then
  echo "ℹ️ Skipping SwiftLint for SwiftUI Previews."
  exit 0
fi

# Skip for CI if needed
if [[ -n "${CI}" ]]; then
  echo "ℹ️ Skipping SwiftLint in CI."
  exit 0
fi

# Prefer bundled SwiftLint if present
if [ -x "${SWIFTLINT_PATH}" ]; then
  echo "✅ Running bundled SwiftLint..."
  "${SWIFTLINT_PATH}" --config "${SWIFTLINT_CONFIG}"
elif which swiftlint > /dev/null; then
  echo "✅ Running system SwiftLint..."
  swiftlint --config "${SWIFTLINT_CONFIG}"
else
  echo "⚠️ warning: SwiftLint not found"
fi

