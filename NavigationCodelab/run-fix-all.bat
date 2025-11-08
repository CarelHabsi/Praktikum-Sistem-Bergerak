@echo off
chcp 65001 >nul
echo.
echo ╔════════════════════════════════════════════════════════════╗
echo ║       EMULATOR FIX - ALL IN ONE SOLUTION                   ║
echo ╚════════════════════════════════════════════════════════════╝
echo.

REM Auto-detect ADB location
set ADB=adb
set ADB_FOUND=0

REM Check if adb is in PATH
adb version >nul 2>&1
if %errorlevel% equ 0 (
    set ADB_FOUND=1
    goto adb_ready
)

REM Try to find ADB in common locations
if exist "C:\Users\%USERNAME%\AppData\Local\Android\Sdk\platform-tools\adb.exe" (
    set "ADB=C:\Users\%USERNAME%\AppData\Local\Android\Sdk\platform-tools\adb.exe"
    set ADB_FOUND=1
    echo ℹ ADB found at: %ADB%
    goto adb_ready
)

if exist "%ANDROID_HOME%\platform-tools\adb.exe" (
    set "ADB=%ANDROID_HOME%\platform-tools\adb.exe"
    set ADB_FOUND=1
    echo ℹ ADB found at: %ADB%
    goto adb_ready
)

REM ADB not found
echo.
echo ✗ ERROR: ADB tidak ditemukan!
echo.
echo SOLUSI:
echo 1. Buka Android Studio
echo 2. Klik: View → Tool Windows → Terminal
echo 3. Di Terminal Android Studio, jalankan: gradlew installDebug
echo.
echo ATAU gunakan Run button ▶ di Android Studio untuk install app
echo.
pause
exit /b 1

:adb_ready
if not "%ADB%"=="adb" echo ℹ Using ADB: %ADB%
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
"%ADB%" devices | findstr "emulator" >nul
echo --------------------------------------------------------
adb kill-server
adb start-server
echo ✓ ADB server restarted
echo.
    "%ADB%" uninstall com.example.compose.rally 2>nul
echo [STEP 3] Checking ADB version...
echo --------------------------------------------------------
adb version
echo.

echo [STEP 4] Checking connected devices...
echo --------------------------------------------------------
adb devices -l
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
adb shell pm list packages 2>nul | findstr rally
if %errorlevel% neq 0 (
    echo ℹ Rally app not installed yet
)
echo.

echo ════════════════════════════════════════════════════════════
echo                     DIAGNOSTIC RESULT
echo ════════════════════════════════════════════════════════════
echo.

adb devices | findstr "emulator" >nul
if %errorlevel% equ 0 (
    echo ✓ STATUS: Emulator terdeteksi!
    echo.
    echo [NEXT STEP] Uninstall app lama dan install yang baru...
    echo --------------------------------------------------------
    adb uninstall com.example.compose.rally 2>nul
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
    echo    run-fix-all.bat
    echo.
    echo ════════════════════════════════════════════════════════════
)

echo.
pause


