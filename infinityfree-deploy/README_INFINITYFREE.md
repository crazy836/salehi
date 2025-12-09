# Deployment Instructions for InfinityFree

## Prerequisites
1. An InfinityFree account (https://infinityfree.net/)
2. A domain (you can use a free subdomain from InfinityFree or your own domain)
3. Access to hPanel (InfinityFree's control panel)

## Deployment Steps

### 1. Set up InfinityFree Account
- Sign up for an InfinityFree account if you haven't already
- Log in to hPanel (https://hpanel.infinityfree.com/)

### 2. Create a Database
- In hPanel, go to "MySQL Databases"
- Create a new database and note down:
  - Database name
  - Database username
  - Database password
  - MySQL Hostname

### 3. Upload Files via FTP
- Use an FTP client (like FileZilla) to connect to your InfinityFree account
- Upload all files from this directory to the `htdocs` folder of your InfinityFree account
- Make sure the folder structure is maintained

### 4. Configure Environment Variables
- Edit the `.env` file in the `laravel-app` directory with your actual database credentials:
  - DB_HOST (from step 2)
  - DB_DATABASE (from step 2)
  - DB_USERNAME (from step 2)
  - DB_PASSWORD (from step 2)

### 5. Install Dependencies
Since InfinityFree doesn't support Composer, you need to:
1. Run `composer install` locally on your development machine
2. Upload the generated `vendor` folder along with your application files

### 6. Set up Database Tables
Run the database migrations using Artisan:
```bash
php artisan migrate --force
```

If you can't run Artisan commands on InfinityFree, you can:
1. Export your local database as SQL
2. Import it via phpMyAdmin in hPanel

### 7. Set Permissions
Ensure the following directories are writable:
- `laravel-app/storage`
- `laravel-app/bootstrap/cache`

You can set permissions to 755 or 777 through your FTP client.

### 8. Configure Email (Optional)
For email functionality, you'll need to set up an external SMTP service like SMTP2GO:
1. Sign up for an SMTP service
2. Update the MAIL_* variables in your `.env` file with your SMTP credentials

### 9. Configure PayPal (Optional)
To enable PayPal payments:
1. Get your PayPal API credentials from PayPal Developer Dashboard
2. Update the PAYPAL_* variables in your `.env` file

## Troubleshooting

### Common Issues
1. **500 Internal Server Error**: Check file permissions and ensure all paths in `index.php` are correct
2. **Database Connection Error**: Verify database credentials in `.env` file
3. **Missing Vendor Folder**: Make sure you've run `composer install` locally and uploaded the `vendor` folder

### Need Help?
Refer to InfinityFree's documentation or forums for additional support:
- https://forum.infinityfree.com/

## Notes
- This deployment structure places the Laravel application in a subdirectory (`laravel-app`) while keeping public files at the root level
- The `index.php` file has been modified to point to the correct paths for the Laravel application