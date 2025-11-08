@echo off
chcp 65001 >nul
echo.
echo ════════════════════════════════════════════════════════════
echo    INSTALL APP - Safe Version (Tidak Kill Emulator!)
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

echo [STEP 1] Checking ADB status...
echo --------------------------------------------------------
echo ⚠️ TIDAK akan kill emulator yang sudah running!
echo.

echo [STEP 2] Restart ADB server (tanpa kill emulator)...
echo --------------------------------------------------------
"%ADB%" kill-server
timeout /t 1 >nul
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
tasklist | findstr /I "emulator qemu-system"
echo.

echo [STEP 6] Checking installed apps on device...
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
    echo ⏳ Ini akan memakan waktu beberapa menit...
    echo.
    cd /d "%~dp0"
    call gradlew installDebug
    echo.
    if %errorlevel% equ 0 (
        echo ════════════════════════════════════════════════════════════
        echo ✓ SELESAI! App sudah diinstall ke emulator
        echo ════════════════════════════════════════════════════════════
        echo.
        echo Emulator Anda masih running dan app sudah terinstall!
        echo.
        echo NEXT STEP: Test deep link dengan:
        echo    test-deep-link.bat
        echo.
    ) else (
        echo ════════════════════════════════════════════════════════════
        echo ✗ ERROR: Install gagal!
        echo ════════════════════════════════════════════════════════════
        echo.
        echo Lihat error di atas untuk detail.
        echo.
    )
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
    echo    INSTALL_SAFE.bat
    echo.
    echo ════════════════════════════════════════════════════════════
)

echo.
pause

