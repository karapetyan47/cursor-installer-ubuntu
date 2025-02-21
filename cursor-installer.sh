#!/bin/bash
CURSOR_DOWNLOAD_URL="https://downloader.cursor.sh/linux/appImage/x64"
CURSOR_ICON_URL="https://raw.githubusercontent.com/karapetyan47/cursor-installer-ubuntu/refs/heads/master/cursor.png"

# Install Cursor
CURSOR_FOLDER="/opt/cursor"
FILE_PATH="$CURSOR_FOLDER/cursor.AppImage"
ICON_PATH="$CURSOR_FOLDER/cursor.webp"

# Create folder with elevated privileges
echo "Creating installation directory..."
sudo mkdir -p $CURSOR_FOLDER  # -p flag creates parent directories if needed

# Set permissions (optional)
sudo chmod 755 $CURSOR_FOLDER  # 755 = rwxr-xr-x


echo "Downloading Cursor..."
sudo curl --location $CURSOR_DOWNLOAD_URL \
  --header 'Content-Type: binary/octet-stream' \
  --output $FILE_PATH

echo "Downloading icon..."
sudo curl --location $CURSOR_ICON_URL \
  --output $ICON_PATH


echo "Making $FILE_PATH executable"
sudo chmod a+x $FILE_PATH

# Create desktop entry
DESKTOP_FILE="/usr/share/applications/cursor.desktop"
echo "Creating desktop entry..."
sudo tee $DESKTOP_FILE > /dev/null <<EOL
[Desktop Entry]
Name=Cursor
Exec=$FILE_PATH --no-sandbox
Icon=$ICON_PATH
Type=Application
Categories=Development;IDE;
StartupWMClass=cursor
EOL

echo "Cursor installed successfully!" 