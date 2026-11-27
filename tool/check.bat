@echo off
rem Little Moon: restore packages, check formatting, analyze and test.
rem It never changes pubspec.yaml. The output goes to tool\check_log.txt
rem and the script stops at the first step that fails.
chcp 65001 >nul
cd /d "%~dp0.."
set LOG=tool\check_log.txt

rem pub.dev answers 403 to connections from Iran, so use the public mirror
rem unless another package server is already configured.
if not defined PUB_HOSTED_URL set PUB_HOSTED_URL=https://pub.flutter-io.cn
if not defined FLUTTER_STORAGE_BASE_URL set FLUTTER_STORAGE_BASE_URL=https://storage.flutter-io.cn

echo Package server: %PUB_HOSTED_URL% > %LOG%
echo Working... this can take a few minutes.

echo ===== pub get ===== >> %LOG%
call flutter pub get >> %LOG% 2>&1
if errorlevel 1 goto fail

rem Generated localization files (lib\l10n\generated) are left out on purpose.
echo ===== format ===== >> %LOG%
call dart format --output=none --set-exit-if-changed lib\core lib\data lib\domain lib\features lib\shared lib\main.dart test tool >> %LOG% 2>&1
if errorlevel 1 goto fail

echo ===== analyze ===== >> %LOG%
call flutter analyze >> %LOG% 2>&1
if errorlevel 1 goto fail

echo ===== test ===== >> %LOG%
call flutter test >> %LOG% 2>&1
if errorlevel 1 goto fail

echo ===== DONE: all steps passed ===== >> %LOG%
echo.
echo OK. All steps passed.
pause
exit /b 0

:fail
echo ===== FAILED: see the last lines above ===== >> %LOG%
echo.
echo A step failed. Open tool\check_log.txt for details.
pause
exit /b 1
