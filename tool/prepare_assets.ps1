<#
Little Moon - one-time asset preparation (phase 6).

What it does (safe to run twice; a second run changes nothing):
  1. Moves the design-only files out of the APK folder into design\:
       littlemoon_icon_full.png        (1024 px original, used by flutter_launcher_icons)
       littlemoon_icon_foreground.png  (launcher icon foreground)
       alion_badge.png                 (256 px original)
  2. Writes the small runtime copies the app really shows:
       assets\images\logo\littlemoon_icon_full.png   256 x 256
       assets\images\logo\alion_badge.png            128 x 128
  3. Deletes the two files nothing uses: littlemoon_icon.png and lmicon.jpg
     (only if no file under lib\ mentions them).
  4. Removes the empty folder assets\icons.

Run from the project root:
  powershell -ExecutionPolicy Bypass -File tool\prepare_assets.ps1 -DryRun
  powershell -ExecutionPolicy Bypass -File tool\prepare_assets.ps1

Then: dart run flutter_launcher_icons   (only if the icon art changed)
#>
param([switch]$DryRun)

$ErrorActionPreference = 'Stop'
Add-Type -AssemblyName System.Drawing

$root   = Split-Path -Parent $PSScriptRoot
$logo   = Join-Path $root 'assets\images\logo'
$design = Join-Path $root 'design'

function Say([string]$text) { Write-Host $text }

function Get-Width([string]$path) {
    $img = [System.Drawing.Image]::FromFile($path)
    try { return $img.Width } finally { $img.Dispose() }
}

function Save-Resized([string]$src, [string]$dst, [int]$size) {
    $img = [System.Drawing.Image]::FromFile($src)
    try {
        $bmp = New-Object System.Drawing.Bitmap $size, $size, ([System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
        try {
            $g = [System.Drawing.Graphics]::FromImage($bmp)
            try {
                $g.Clear([System.Drawing.Color]::Transparent)
                $g.InterpolationMode  = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
                $g.SmoothingMode      = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
                $g.PixelOffsetMode    = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
                $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality
                $attrs = New-Object System.Drawing.Imaging.ImageAttributes
                $attrs.SetWrapMode([System.Drawing.Drawing2D.WrapMode]::TileFlipXY)
                $rect = New-Object System.Drawing.Rectangle 0, 0, $size, $size
                $g.DrawImage($img, $rect, 0, 0, $img.Width, $img.Height, [System.Drawing.GraphicsUnit]::Pixel, $attrs)
            } finally { $g.Dispose() }
            $bmp.Save($dst, [System.Drawing.Imaging.ImageFormat]::Png)
        } finally { $bmp.Dispose() }
    } finally { $img.Dispose() }
}

function Shrink-Runtime([string]$name, [int]$size) {
    $live = Join-Path $logo $name
    $orig = Join-Path $design $name
    if (-not (Test-Path $live)) { Say "skip   $name (not found in assets\images\logo)"; return }
    if ((Get-Width $live) -le $size) { Say "ok     $name is already $size px or smaller"; return }
    Say "shrink $name -> $size px (original kept in design\)"
    if ($DryRun) { return }
    if (Test-Path $orig) { Remove-Item $live -Force } else { Move-Item $live $orig }
    Save-Resized $orig $live $size
}

if (-not (Test-Path $logo)) { throw "Not found: $logo . Run this from the project that has assets\images\logo." }
if (-not $DryRun) { New-Item -ItemType Directory -Force $design | Out-Null }

$before = (Get-ChildItem $logo -File | Measure-Object Length -Sum).Sum

# 1 + 2: shrink what the app shows, keep the originals in design\
Shrink-Runtime 'littlemoon_icon_full.png' 256
Shrink-Runtime 'alion_badge.png' 128

# 1: design-only file (launcher icon foreground)
$fg = Join-Path $logo 'littlemoon_icon_foreground.png'
if (Test-Path $fg) {
    Say 'move   littlemoon_icon_foreground.png -> design\'
    if (-not $DryRun) { Move-Item $fg (Join-Path $design 'littlemoon_icon_foreground.png') -Force }
}

# 3: files nothing uses
foreach ($name in 'littlemoon_icon.png', 'lmicon.jpg') {
    $file = Join-Path $logo $name
    if (-not (Test-Path $file)) { continue }
    $used = Get-ChildItem (Join-Path $root 'lib') -Recurse -Filter *.dart |
        Select-String -SimpleMatch $name -List
    if ($used) { Say "KEEP   $name (mentioned in: $($used[0].Path))"; continue }
    Say "delete $name (unused)"
    if (-not $DryRun) { Remove-Item $file -Force }
}

# 4: empty folder
$icons = Join-Path $root 'assets\icons'
if ((Test-Path $icons) -and -not (Get-ChildItem $icons -Force)) {
    Say 'remove assets\icons (empty)'
    if (-not $DryRun) { Remove-Item $icons -Force }
}

$after = (Get-ChildItem $logo -File | Measure-Object Length -Sum).Sum
Say ''
Say ('assets\images\logo: {0:N0} KB -> {1:N0} KB' -f ($before / 1KB), ($after / 1KB))
if ($DryRun) { Say '(dry run: nothing was changed)' }
