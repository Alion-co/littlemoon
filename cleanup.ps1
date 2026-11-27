# Run once from the project root (next to pubspec.yaml), after extracting the zip.
Remove-Item -Recurse -Force fix -ErrorAction SilentlyContinue
Remove-Item assets\avatars\anime_*.webp, assets\avatars\gold_*.webp -ErrorAction SilentlyContinue
Write-Host "Done. Now run: flutter analyze ; flutter test"
