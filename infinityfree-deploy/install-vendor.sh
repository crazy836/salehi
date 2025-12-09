#!/bin/bash

# Script to install Composer dependencies for InfinityFree deployment
# Run this script locally before uploading files to InfinityFree

echo "Installing Composer dependencies for InfinityFree deployment..."

# Check if composer.json exists
if [ ! -f "composer.json" ]; then
    echo "Error: composer.json not found!"
    echo "Please run this script from the laravel-app directory."
    exit 1
fi

# Install dependencies optimized for production
echo "Installing dependencies..."
composer install --no-dev --optimize-autoloader --no-interaction

# Check if installation was successful
if [ $? -eq 0 ]; then
    echo "Dependencies installed successfully!"
    
    # Show installed packages
    echo "Installed packages:"
    composer show --no-dev
    
    echo ""
    echo "Next steps:"
    echo "1. Upload the vendor folder along with your application files to InfinityFree"
    echo "2. Make sure to set proper permissions on storage and bootstrap/cache directories"
else
    echo "Error: Failed to install dependencies!"
    echo "Please check your composer.json file and try again."
    exit 1
fi