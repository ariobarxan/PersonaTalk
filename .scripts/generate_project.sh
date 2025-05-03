#!/bin/bash

# Exit on any error
set -e

# Move to project root directory (assumes .scripts is one level deep in project root)
cd "$(dirname "$0")/.."

# Define paths relative to the project root
XCODEGEN_EXEC=".executables/xcodegen"
SPEC_FILE=".configs/project.yml"
PROJECT_PATH="$(pwd)/PersonaTalk.xcodeproj"

# Ensure XcodeGen is executable
if [ ! -x "$XCODEGEN_EXEC" ]; then
  echo "❌ Error: XcodeGen executable not found at $XCODEGEN_EXEC"
  exit 1
fi

# Run XcodeGen
echo "🔄 Generating Xcode project from $SPEC_FILE..."
"$XCODEGEN_EXEC" generate --spec "$SPEC_FILE" --project "$PROJECT_PATH"

echo "✅ Xcode project generated at: $PROJECT_PATH"
