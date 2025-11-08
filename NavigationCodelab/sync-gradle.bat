@echo off
echo ========================================
echo  Gradle Clean dan Rebuild Script
echo  Rally Navigation Codelab
echo ========================================
echo.

cd /d "%~dp0"

echo [1/2] Membersihkan build cache...
call gradlew.bat clean

echo.
echo [2/2] Building project...
call gradlew.bat build --refresh-dependencies

echo.
echo ========================================
echo  Selesai!
echo ========================================
echo.
echo Silakan kembali ke IntelliJ IDEA dan:
echo 1. Klik File -^> Invalidate Caches -^> Invalidate and Restart
echo 2. Setelah restart, klik File -^> Sync Project with Gradle Files
echo.
pause

