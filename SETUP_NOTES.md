# Feudalism 2 Repository Setup Notes

This repository has been converted from the Feudalism repository to support Feudalism 2 as a separate project.

## What Was Changed

All files and references have been renamed from "Feudalism" to "Feudalism2":

### Files Renamed:
- `Feudalism.swf` → `Feudalism2.swf`
- `play_feudalism.html` → `play_feudalism2.html`
- `run_feudalism.ps1` → `run_feudalism2.ps1`
- `Feudalism_files.xml` → `Feudalism2_files.xml`
- `Feudalism_meta.xml` → `Feudalism2_meta.xml`
- `Feudalism_meta.sqlite` → `Feudalism2_meta.sqlite`
- `feudalism.png` → `feudalism2.png`
- `feudalism_thumb.jpg` → `feudalism2_thumb.jpg`

### Content Updated:
- README.md - Updated to describe Feudalism 2
- package.json - Changed package name to "feudalism2"
- GitHub Actions workflow - Updated to deploy Feudalism 2
- All HTML, PowerShell, and documentation references

## Next Steps

To use this repository for Feudalism 2:

1. **Replace the SWF file**: The current `Feudalism2.swf` is actually the Feudalism 1 game file (just renamed). You need to replace it with the actual Feudalism 2 SWF file.

2. **Update the repository name on GitHub**: If you want the repository URL to match, rename it from "Feudalism" to "Feudalism2" in GitHub settings.

3. **Update GitHub Pages**: The GitHub Pages URL in the README badge currently points to `gustavogmoraes.github.io/Feudalism/`. After renaming the repo, update it to `gustavogmoraes.github.io/Feudalism2/`.

4. **Test the game**: Once you have the actual Feudalism 2 SWF file:
   ```bash
   npm install
   npm start
   ```
   This will open the game in your browser at http://localhost:8080/play_feudalism2.html

## Repository Structure

This is now a standalone Feudalism 2 repository with:
- Complete Ruffle Flash emulator integration
- Save backup/restore functionality
- Local server options (Node.js and PowerShell)
- GitHub Pages auto-deployment
- Preservation documentation

The original Feudalism repository remains unchanged at https://github.com/gustavogmoraes/Feudalism
