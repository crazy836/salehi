#!/bin/bash

# Deployment script for InfinityFree
# This script helps prepare the application for deployment

echo "Preparing Laravel application for InfinityFree deployment..."

# Generate application key (run this locally before deployment)
echo "Generating application key..."
php artisan key:generate

# Run migrations (optional - can be done manually through phpMyAdmin)
echo "Running database migrations..."
php artisan migrate --force

# Clear caches
echo "Clearing caches..."
php artisan config:clear
php artisan route:clear
php artisan view:clear
php artisan cache:clear

echo "Deployment preparation complete!"
echo "Remember to:"
echo "1. Update the .env file with your InfinityFree database credentials"
echo "2. Run 'composer install' locally and upload the vendor folder"
echo "3. Set proper permissions on storage and bootstrap/cache directories"
echo "4. Upload all files to your InfinityFree htdocs directory via FTP"