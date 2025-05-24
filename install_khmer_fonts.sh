#!/bin/bash

# Khmer Font Installer Script
# Author: Chamnan dev

# Define font directory and URL source
FONT_DIR="$HOME/.local/share/fonts"  # User-specific fonts directory
KHMER_FONT_URL="https://github.com/chamnan-dev/installing_khmer_font_linux/raw/refs/heads/master/Khmer-fonts.zip"  # Replace with the actual URL

# Create the font directory if it doesn't exist
if [ ! -d "$FONT_DIR" ]; then
    echo "Creating font directory at $FONT_DIR..."
    mkdir -p "$FONT_DIR"
fi

# Download Khmer fonts
echo "Downloading Khmer fonts..."
curl -o /tmp/Khmer-fonts.zip "$KHMER_FONT_URL"

# Check if download was successful
if [ $? -ne 0 ]; then
    echo "Error downloading Khmer fonts. Please check the URL."
    exit 1
fi

# Extract the fonts
echo "Extracting fonts..."
unzip -o /tmp/Khmer-fonts.zip -d "$FONT_DIR"

# Update font cache
echo "Updating font cache..."
fc-cache -fv

# Clean up
echo "Cleaning up..."
rm /tmp/Khmer-fonts.zip

# Confirm installation
echo "Khmer fonts have been successfully installed!"

