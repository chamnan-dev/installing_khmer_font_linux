#!/bin/bash

# Define font directory and ZIP file URL
FONT_DIR="$HOME/.local/share/fonts"
ZIP_FILE="./Khmer-fonts.zip"

# Ensure the font directory exists
if [ ! -d "$FONT_DIR" ]; then
    echo "Creating font directory at $FONT_DIR..."
    mkdir -p "$FONT_DIR"
fi

# Check if Khmer fonts are already installed
#if fc-list | grep -qi "Khmer"; then
 #   echo "Khmer fonts are already installed."
#else
 #   echo "No Khmer fonts found on the system. Proceeding with installation..."

    # Check if the ZIP file exists
    if [ ! -f "$ZIP_FILE" ]; then
        echo "Font ZIP file not found: $ZIP_FILE"
        echo "Please download the Khmer fonts and place the ZIP file at the specified location."
        exit 1
    fi

    # Extract the files to a temporary location
    TEMP_DIR=$(mktemp -d)  # Create a temporary directory
    echo "Extracting ZIP to temporary directory: $TEMP_DIR..."
    unzip -o "$ZIP_FILE" -d "$TEMP_DIR"

    # Move new font files to the target directory, avoiding overwrites
    echo "Copying new fonts to $FONT_DIR..."
    find "$TEMP_DIR" -type f -name "*.ttf" -or -name "*.otf" | while read -r FILE; do
        BASENAME=$(basename "$FILE")
        if [ ! -f "$FONT_DIR/$BASENAME" ]; then
            echo "Installing font: $BASENAME"
            mv "$FILE" "$FONT_DIR/"
        else
            echo "Font already exists: $BASENAME (skipping)"
        fi
    done

    # Update font cache
    echo "Updating font cache..."
    fc-cache -fv

    # Clean up
    echo "Cleaning up temporary files..."
    rm -rf "$TEMP_DIR"

    echo "Khmer fonts installed successfully!"
#fi

