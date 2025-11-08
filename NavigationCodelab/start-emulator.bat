@echo off
echo ====================================
echo START EMULATOR FROM COMMAND LINE
echo ====================================
echo.

echo Listing available emulators...
emulator -list-avds
echo.

echo ====================================
set /p AVD_NAME="Enter emulator name (or press Enter for default): "

if "%AVD_NAME%"=="" (
    echo.
    echo Starting first available emulator...
    for /f %%i in ('emulator -list-avds') do (
        set AVD_NAME=%%i
        goto :start_emulator
    )
    echo ERROR: No emulator found!
    echo Please create one in Android Studio Device Manager
    pause
    exit /b 1
)

:start_emulator
echo.
echo Starting emulator: %AVD_NAME%
echo.
echo NOTE: This window will show emulator logs.
echo DO NOT CLOSE this window!
echo The emulator window will appear separately.
echo.
echo Press Ctrl+C to stop the emulator.
echo.
pause

start "Android Emulator" emulator -avd %AVD_NAME% -no-snapshot-load

echo.
echo ====================================
echo Emulator starting in separate window...
echo Waiting for device to boot...
echo ====================================
timeout /t 5 >nul

adb wait-for-device
echo.
echo ====================================
echo EMULATOR IS READY!
echo ====================================
echo.
echo You can now:
echo - Run fix-emulator.bat to install the app
echo - Or use Android Studio to build and run
echo.
pause

