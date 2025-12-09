@echo off
REM Script to install Composer dependencies for InfinityFree deployment
REM Run this script locally before uploading files to InfinityFree

echo Installing Composer dependencies for InfinityFree deployment...

REM Check if composer.json exists
if not exist "composer.json" (
    echo Error: composer.json not found!
    echo Please run this script from the laravel-app directory.
    pause
    exit /b 1
)

REM Install dependencies optimized for production
echo Installing dependencies...
composer install --no-dev --optimize-autoloader --no-interaction

REM Check if installation was successful
if %ERRORLEVEL% EQU 0 (
    echo Dependencies installed successfully!
    
    REM Show installed packages
    echo Installed packages:
    composer show --no-dev
    
    echo.
    echo Next steps:
    echo 1. Upload the vendor folder along with your application files to InfinityFree
    echo 2. Make sure to set proper permissions on storage and bootstrap/cache directories
) else (
    echo Error: Failed to install dependencies!
    echo Please check your composer.json file and try again.
    pause
    exit /b 1
)

pause