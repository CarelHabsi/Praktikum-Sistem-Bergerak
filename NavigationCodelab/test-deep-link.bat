@echo off
echo ════════════════════════════════════════════════════════════
echo   TEST DEEP LINK - Rally App
echo ════════════════════════════════════════════════════════════
echo.

echo [INFO] This script will test deep linking to Rally app
echo        Deep Link: rally://single_account/Checking
echo.

REM Cari lokasi ADB di berbagai lokasi umum
set ADB_PATH=

REM Check di Android Studio installation
if exist "C:\Users\%USERNAME%\AppData\Local\Android\Sdk\platform-tools\adb.exe" (
    set ADB_PATH=C:\Users\%USERNAME%\AppData\Local\Android\Sdk\platform-tools\adb.exe
    goto :found_adb
)

REM Check di Program Files
if exist "C:\Program Files\Android\Android Studio\jbr\bin\adb.exe" (
    set ADB_PATH=C:\Program Files\Android\Android Studio\jbr\bin\adb.exe
    goto :found_adb
)

REM Check di gradlew location (Android Studio SDK)
if exist "%ANDROID_HOME%\platform-tools\adb.exe" (
    set ADB_PATH=%ANDROID_HOME%\platform-tools\adb.exe
    goto :found_adb
)

REM Tidak ditemukan
echo ✗ ERROR: ADB tidak ditemukan!
echo.
echo SOLUSI:
echo 1. Jalankan command ini dari Android Studio Terminal:
echo    Tools ^> Terminal, lalu ketik perintah adb
echo.
echo 2. Atau gunakan cara manual:
echo    a. Buka Android Studio
echo    b. Klik Run ▶ untuk install app
echo    c. Setelah app terbuka, di address bar ketik:
echo       rally://single_account/Checking
echo.
pause
exit /b 1

:found_adb
echo ✓ ADB ditemukan di: %ADB_PATH%
echo.

echo [STEP 1] Checking connected devices...
echo --------------------------------------------------------
"%ADB_PATH%" devices
echo.

echo [STEP 2] Testing deep link...
echo --------------------------------------------------------
echo Command: adb shell am start -d "rally://single_account/Checking" -a android.intent.action.VIEW
echo.

"%ADB_PATH%" shell am start -d "rally://single_account/Checking" -a android.intent.action.VIEW

if %errorlevel% equ 0 (
    echo.
    echo ════════════════════════════════════════════════════════════
    echo ✓ SUCCESS! Deep link executed!
    echo ════════════════════════════════════════════════════════════
    echo.
    echo Check your emulator, it should open:
    echo - Rally app
    echo - Single Account screen
    echo - Account type: Checking
    echo.
) else (
    echo.
    echo ════════════════════════════════════════════════════════════
    echo ✗ FAILED! Possible reasons:
    echo ════════════════════════════════════════════════════════════
    echo.
    echo 1. Emulator tidak running
    echo    Solusi: Start emulator dari Android Studio
    echo.
    echo 2. App belum terinstall
    echo    Solusi: Jalankan run-fix-all.bat
    echo.
    echo 3. Deep link belum dikonfigurasi di app
    echo    Solusi: Check AndroidManifest.xml
    echo.
)

pause

