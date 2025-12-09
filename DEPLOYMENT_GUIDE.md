# Laravel E-Commerce System Deployment Guide

This guide provides instructions for deploying the Laravel E-Commerce System to both GitHub and InfinityFree hosting platforms.

## Table of Contents
1. [GitHub Deployment](#github-deployment)
2. [InfinityFree Deployment](#infinityfree-deployment)
3. [Post-Deployment Configuration](#post-deployment-configuration)

## GitHub Deployment

### Prerequisites
- Git installed on your local machine
- A GitHub account

### Steps

1. **Initialize Git Repository** (Already done)
   ```bash
   git init
   git add .
   git commit -m "Initial commit: Laravel E-Commerce System"
   git branch -M main
   ```

2. **Create GitHub Repository**
   - Go to https://github.com/new
   - Create a new repository named `sia-ecommerce-system`
   - Don't initialize with README, .gitignore, or license

3. **Push to GitHub**
   ```bash
   git remote add origin https://github.com/crazy836/sia-ecommerce-system.git
   git push -u origin main
   ```

## InfinityFree Deployment

### Prerequisites
- An InfinityFree account (https://infinityfree.net/)
- An FTP client (e.g., FileZilla)
- Composer installed locally (for dependency management)

### Deployment Structure
The deployment has been structured to work with InfinityFree's limitations:
```
htdocs/                    # Root directory for web files
├── index.php             # Modified entry point
├── .htaccess
├── favicon.ico
├── test-form.html
├── images/               # Public images
└── laravel-app/          # Laravel application files
    ├── app/
    ├── bootstrap/
    ├── config/
    ├── database/
    ├── resources/
    ├── routes/
    ├── storage/
    ├── vendor/           # Must be uploaded after local composer install
    ├── .env              # Environment configuration
    ├── artisan
    ├── composer.json
    └── ... (other Laravel files)
```

### Steps

1. **Prepare Local Environment**
   ```bash
   # Navigate to the project directory
   cd /path/to/project
   
   # Install dependencies
   composer install --no-dev --optimize-autoloader
   
   # Generate application key
   php artisan key:generate
   
   # Optimize performance
   php artisan config:cache
   php artisan route:cache
   php artisan view:cache
   ```

2. **Set Up InfinityFree Account**
   - Sign up at https://infinityfree.net/
   - Log in to hPanel at https://hpanel.infinityfree.com/
   - Create a free subdomain or add your custom domain

3. **Create Database**
   - In hPanel, go to "MySQL Databases"
   - Create a new database
   - Note the database name, username, hostname, and password

4. **Configure Environment**
   - Edit the `.env` file in the `laravel-app` directory:
   ```env
   APP_NAME="SIA E-Commerce System"
   APP_ENV=production
   APP_KEY= # This will be generated automatically
   APP_DEBUG=false
   APP_URL=https://yourdomain.infinityfreeapp.com
   
   DB_CONNECTION=mysql
   DB_HOST= # From InfinityFree database setup
   DB_PORT=3306
   DB_DATABASE= # From InfinityFree database setup
   DB_USERNAME= # From InfinityFree database setup
   DB_PASSWORD= # From InfinityFree database setup
   ```

5. **Upload Files via FTP**
   - Use an FTP client to connect to your InfinityFree account
   - Upload all contents of the `infinityfree-deploy` directory to the `htdocs` folder
   - Ensure file permissions are set correctly:
     - Directories: 755
     - Files: 644
     - Storage directories: 775 or 777

6. **Run Database Migrations**
   Option A: Through command line (if SSH is available):
   ```bash
   cd /home/volXX_X/user/htdocs/laravel-app
   php artisan migrate --force
   ```
   
   Option B: Manually import SQL (recommended for InfinityFree):
   - Export your local database as SQL
   - Import via phpMyAdmin in hPanel

7. **Set Up Email (Optional)**
   - Sign up for an SMTP service (e.g., SMTP2GO, SendGrid)
   - Update the MAIL_* variables in your `.env` file

8. **Set Up PayPal (Optional)**
   - Get PayPal API credentials from PayPal Developer Dashboard
   - Update the PAYPAL_* variables in your `.env` file

## Post-Deployment Configuration

### Performance Optimization
```bash
# Cache configurations
php artisan config:cache

# Cache routes
php artisan route:cache

# Cache views
php artisan view:cache

# Optimize autoloader
composer dump-autoload --optimize
```

### Security Considerations
1. Ensure `APP_DEBUG` is set to `false` in production
2. Set proper file permissions (755 for directories, 644 for files)
3. Protect sensitive files from direct access
4. Regularly update dependencies

### Maintenance
1. Regularly backup your database
2. Monitor error logs in `laravel-app/storage/logs/`
3. Keep dependencies updated with security patches

## Troubleshooting

### Common Issues

1. **500 Internal Server Error**
   - Check file permissions
   - Verify paths in `index.php` are correct
   - Check error logs in `laravel-app/storage/logs/`

2. **Database Connection Error**
   - Verify database credentials in `.env` file
   - Ensure database is created and accessible
   - Check if MySQL extension is enabled in PHP

3. **Missing Vendor Folder**
   - Run `composer install` locally before uploading
   - Ensure the `vendor` folder is uploaded completely

4. **Permission Denied**
   - Set proper permissions on `laravel-app/storage` and `laravel-app/bootstrap/cache`
   - These directories need to be writable by the web server

### Need Help?
- Check InfinityFree's documentation: https://infinityfree.net/support/
- Visit InfinityFree forums: https://forum.infinityfree.com/
- Refer to Laravel documentation: https://laravel.com/docs/

## Additional Notes

- This deployment structure works around InfinityFree's limitations by placing the Laravel application in a subdirectory while keeping public files at the root level
- The `index.php` file has been modified to point to the correct paths for the Laravel application
- Composer dependencies must be installed locally and uploaded since InfinityFree doesn't support Composer
- For better performance, consider using a paid hosting provider with SSH access and Composer support for future projects