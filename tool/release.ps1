# Usage (from the project root):
#   .\tool\release.ps1            -> build number +1 (2.0.0+3 -> 2.0.0+4), then APK + AAB
#   .\tool\release.ps1 -Patch     -> 2.0.0+3 -> 2.0.1+4
#   .\tool\release.ps1 -Minor     -> 2.0.0+3 -> 2.1.0+4
#   .\tool\release.ps1 -Major     -> 2.0.0+3 -> 3.0.0+4
#   .\tool\release.ps1 -NoBuild   -> only bump the version, no build
# It updates pubspec.yaml and AppInfo.version (About page) together.
# If the build fails, both files are restored to their previous content.
param(
    [switch]$Major,
    [switch]$Minor,
    [switch]$Patch,
    [switch]$NoBuild
)

$ErrorActionPreference = 'Stop'
$root = Split-Path $PSScriptRoot -Parent
Set-Location $root

$pubPath = Join-Path $root 'pubspec.yaml'
$infoPath = Join-Path $root 'lib\core\constants\app_info.dart'
$utf8 = New-Object System.Text.UTF8Encoding($false)

$pubOld = [System.IO.File]::ReadAllText($pubPath)
$infoOld = [System.IO.File]::ReadAllText($infoPath)

$verRegex = '(?m)^version:[ \t]*(\d+)\.(\d+)\.(\d+)\+(\d+)[ \t]*(?=\r?$)'
$m = [regex]::Match($pubOld, $verRegex)
if (-not $m.Success) { throw 'Could not find a "version: X.Y.Z+N" line in pubspec.yaml' }

$maj = [int]$m.Groups[1].Value
$min = [int]$m.Groups[2].Value
$pat = [int]$m.Groups[3].Value
$bld = [int]$m.Groups[4].Value + 1

if ($Major) { $maj++; $min = 0; $pat = 0 }
elseif ($Minor) { $min++; $pat = 0 }
elseif ($Patch) { $pat++ }

$name = "$maj.$min.$pat"
$full = "$name+$bld"
$oldFull = "$($m.Groups[1].Value).$($m.Groups[2].Value).$($m.Groups[3].Value)+$($m.Groups[4].Value)"

$pubNew = [regex]::Replace($pubOld, $verRegex, "version: $full", 1)

$infoRegex = "static const version = '[^']*';"
if (-not [regex]::IsMatch($infoOld, $infoRegex)) { throw 'Could not find "static const version" in app_info.dart' }
$infoNew = [regex]::Replace($infoOld, $infoRegex, "static const version = '$name';", 1)

[System.IO.File]::WriteAllText($pubPath, $pubNew, $utf8)
[System.IO.File]::WriteAllText($infoPath, $infoNew, $utf8)
Write-Host "Version: $oldFull -> $full" -ForegroundColor Green

if ($NoBuild) { return }

try {
    flutter build apk --release
    if ($LASTEXITCODE -ne 0) { throw 'APK build failed' }
    flutter build appbundle --release
    if ($LASTEXITCODE -ne 0) { throw 'AAB build failed' }
}
catch {
    [System.IO.File]::WriteAllText($pubPath, $pubOld, $utf8)
    [System.IO.File]::WriteAllText($infoPath, $infoOld, $utf8)
    Write-Host "Build failed, version restored to $oldFull" -ForegroundColor Red
    throw
}

Write-Host ''
Write-Host "Done: $full" -ForegroundColor Green
Write-Host 'APK: build\app\outputs\flutter-apk\app-release.apk'
Write-Host 'AAB: build\app\outputs\bundle\release\app-release.aab'
