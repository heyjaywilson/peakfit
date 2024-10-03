#!/bin/bash

# Define the path to the xcconfig file
xcconfig_path="PeakFit/Resources/Project.xcconfig"

# Create the content, using the CI_TEAM_ID environment variable
content="// -----------------------------------------------------------
// Copyright 2024 CCT Plus LLC
// Licensed under the Apache License, Version 2.0 (the \"License\");
// you may obtain a copy of the License at
//     http://www.apache.org/licenses/LICENSE-2.0
// -----------------------------------------------------------
// Project: PeakFit
// Created on 9/25/24
// -----------------------------------------------------------
//
// Configuration settings file format documentation can be found at:
// https://help.apple.com/xcode/#/dev745c5c974

DEVELOPMENT_TEAM = ${$DEVELOPMENT_TEAM}
PRODUCT_BUNDLE_IDENTIFIER = dev.cctplus.PeakFit
"

# Ensure the directory exists
mkdir -p "$(dirname "$xcconfig_path")"

# Write the content to the file
echo "$content" > "$xcconfig_path"

# Check if the write operation was successful
if [ $? -eq 0 ]; then
    echo "Successfully updated $xcconfig_path with team ID {$CI_TEAM_ID}"
else
    echo "Error: Failed to update $xcconfig_path"
    exit 1
fi