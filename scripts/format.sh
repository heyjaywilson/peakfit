#!/usr/bin/env sh

# Check if "--changes" param is passed
if [ "$1" = "--changes" ]; then
    FORMAT_CHANGES=true
else
    FORMAT_CHANGES=false
fi

XCODE_VERSION=$(xcodebuild -version | grep 'Xcode' | awk '{print $2}' | cut -d '.' -f1)

# Determine swift format command based on Xcode version
if [ "$XCODE_VERSION" -ge 16 ]; then
    SWIFT_FORMAT_CMD="swift format"
else
    if ! command -v swift-format > /dev/null 2>&1; then
        echo "Error: 'swift-format' is not installed. Please install it or use Xcode 16 or greater."
        exit 1
    fi
    SWIFT_FORMAT_CMD="swift-format"
fi

# Format based on the param
if [ "$FORMAT_CHANGES" = true ]; then
    echo "Formatting staged Swift changes..."
    git diff --staged --name-only --diff-filter=AM -- "*.swift" | while read line; do
        echo "Formatting $line"
        $SWIFT_FORMAT_CMD format --configuration .swift-format.json -i "${line}"
        git add "$line"
    done
else
    echo "Formatting all Swift files in the project..."
    find . -name "*.swift" | while read line; do
        echo "Formatting $line"
        $SWIFT_FORMAT_CMD format --configuration .swift-format.json -i "${line}"
    done
fi