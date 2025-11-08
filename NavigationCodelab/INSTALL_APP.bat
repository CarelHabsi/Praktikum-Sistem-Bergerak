@echo off
chcp 65001 >nul
echo.
echo ════════════════════════════════════════════════════════════
echo    EMULATOR FIX - ALL IN ONE SOLUTION
echo ════════════════════════════════════════════════════════════
echo.

REM Auto-detect ADB location
set "ADB=C:\Users\%USERNAME%\AppData\Local\Android\Sdk\platform-tools\adb.exe"

REM Check if ADB exists
if not exist "%ADB%" (
    echo ✗ ERROR: ADB tidak ditemukan di lokasi default!
    echo.
    echo SOLUSI:
    echo 1. Buka Android Studio
    echo 2. Tools → Terminal
    echo 3. Jalankan: gradlew installDebug
    echo.
    pause
    exit /b 1
)

echo ℹ Using ADB: %ADB%
echo.

echo [STEP 1] Membersihkan proses emulator yang hang...
echo --------------------------------------------------------
taskkill /F /IM qemu-system-x86_64.exe 2>nul
if %errorlevel% equ 0 (
    echo ✓ Killed qemu-system-x86_64.exe
) else (
    echo ℹ No qemu-system-x86_64.exe running
)

taskkill /F /IM emulator.exe 2>nul
if %errorlevel% equ 0 (
    echo ✓ Killed emulator.exe
) else (
    echo ℹ No emulator.exe running
)

taskkill /F /IM adb.exe 2>nul
if %errorlevel% equ 0 (
    echo ✓ Killed adb.exe
) else (
    echo ℹ No adb.exe running
)

timeout /t 2 >nul

echo.
echo [STEP 2] Restart ADB server...
echo --------------------------------------------------------
"%ADB%" kill-server
"%ADB%" start-server
echo ✓ ADB server restarted
echo.

echo [STEP 3] Checking ADB version...
echo --------------------------------------------------------
"%ADB%" version
echo.

echo [STEP 4] Checking connected devices...
echo --------------------------------------------------------
"%ADB%" devices -l
echo.

echo [STEP 5] Checking running processes...
echo --------------------------------------------------------
tasklist | findstr /I "emulator qemu-system adb"
echo.

echo [STEP 6] Checking available emulators...
echo --------------------------------------------------------
emulator -list-avds 2>nul
if %errorlevel% neq 0 (
    echo ⚠ WARNING: emulator command not found in PATH
    echo   You need to start emulator from Android Studio
)
echo.

echo [STEP 7] Checking installed apps on device...
echo --------------------------------------------------------
"%ADB%" shell pm list packages 2>nul | findstr rally
if %errorlevel% neq 0 (
    echo ℹ Rally app not installed yet
)
echo.

echo ════════════════════════════════════════════════════════════
echo                     DIAGNOSTIC RESULT
echo ════════════════════════════════════════════════════════════
echo.

"%ADB%" devices | findstr "emulator" >nul
if %errorlevel% equ 0 (
    echo ✓ STATUS: Emulator terdeteksi!
    echo.
    echo [NEXT STEP] Uninstall app lama dan install yang baru...
    echo --------------------------------------------------------
    "%ADB%" uninstall com.example.compose.rally 2>nul
    if %errorlevel% equ 0 (
        echo ✓ Old app uninstalled
    ) else (
        echo ℹ No old app to uninstall
    )
    echo.
    echo Installing new app...
    cd /d "%~dp0"
    call gradlew installDebug
    echo.
    echo ════════════════════════════════════════════════════════════
    echo ✓ SELESAI! App sudah diinstall ke emulator
    echo ════════════════════════════════════════════════════════════
) else (
    echo ✗ STATUS: Tidak ada emulator terdeteksi
    echo.
    echo SOLUSI:
    echo 1. Buka Android Studio
    echo 2. Klik menu: Tools ^> Device Manager
    echo 3. Klik tombol Play ▶ pada emulator Anda
    echo 4. Tunggu 2-5 menit sampai emulator selesai boot
    echo 5. Setelah emulator running, jalankan script ini lagi:
    echo.
    echo    INSTALL_APP.bat
    echo.
    echo ════════════════════════════════════════════════════════════
)

echo.
pause

