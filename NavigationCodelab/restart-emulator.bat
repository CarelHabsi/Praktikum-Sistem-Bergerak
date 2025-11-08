@echo off
echo ====================================
echo Quick Emulator Restart Script
echo ====================================
echo.

echo Killing all emulator processes...
taskkill /F /IM qemu-system-x86_64.exe 2>nul
taskkill /F /IM emulator.exe 2>nul
taskkill /F /IM adb.exe 2>nul

timeout /t 2 >nul

echo Restarting ADB server...
adb kill-server
adb start-server

echo.
echo ====================================
echo Done! Now start your emulator from Android Studio Device Manager
echo ====================================
pause

