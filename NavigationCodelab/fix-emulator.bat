@echo off
echo ====================================
echo Emulator Troubleshooting Script
echo ====================================
echo.

echo [1] Checking ADB devices...
adb devices
echo.

echo [2] Killing ADB server and restarting...
adb kill-server
timeout /t 2 >nul
adb start-server
echo.

echo [3] Uninstalling old app from emulator (if exists)...
adb uninstall com.example.compose.rally
echo.

echo [4] Checking running emulators...
adb devices
echo.

echo ====================================
echo DONE!
echo ====================================
echo.
echo If emulator is not showing above:
echo 1. Open Android Studio
echo 2. Go to Tools ^> Device Manager
echo 3. Click play button on your emulator
echo 4. Wait 2-3 minutes for first boot
echo.
echo After emulator is running, press any key to install the app...
pause

echo.
echo [5] Installing app to emulator...
cd /d "%~dp0"
gradlew installDebug
echo.

echo ====================================
echo Installation Complete!
echo ====================================
pause

