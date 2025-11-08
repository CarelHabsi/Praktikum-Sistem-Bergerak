@echo off
echo ====================================
echo FULL EMULATOR DIAGNOSTICS
echo ====================================
echo.

echo [INFO] This script will help diagnose emulator problems
echo.
pause

echo.
echo ====================================
echo 1. CHECKING ADB VERSION
echo ====================================
adb version
echo.

echo ====================================
echo 2. CHECKING CONNECTED DEVICES
echo ====================================
adb devices -l
echo.

echo ====================================
echo 3. CHECKING RUNNING EMULATOR PROCESSES
echo ====================================
tasklist | findstr /I "emulator qemu-system adb"
echo.

echo ====================================
echo 4. CHECKING ANDROID SDK PATH
echo ====================================
if defined ANDROID_HOME (
    echo ANDROID_HOME = %ANDROID_HOME%
) else (
    echo WARNING: ANDROID_HOME not set!
)

if defined ANDROID_SDK_ROOT (
    echo ANDROID_SDK_ROOT = %ANDROID_SDK_ROOT%
) else (
    echo WARNING: ANDROID_SDK_ROOT not set!
)
echo.

echo ====================================
echo 5. LISTING AVAILABLE EMULATORS
echo ====================================
emulator -list-avds
echo.

echo ====================================
echo 6. CHECKING IF APP IS INSTALLED
echo ====================================
adb shell pm list packages | findstr rally
echo.

echo ====================================
echo DIAGNOSTICS COMPLETE!
echo ====================================
echo.
echo ANALYSIS:
echo - If no devices shown: Start emulator from Android Studio
echo - If device shows "offline": Run restart-emulator.bat
echo - If app not found: Run fix-emulator.bat
echo.
pause

