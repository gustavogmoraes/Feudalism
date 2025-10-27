# Feudalism (Flash) – Play locally via Ruffle

This repo packages the classic Flash game Feudalism and makes it playable locally using the Ruffle emulator and a tiny static server.

## Ways to run

- Windows one-click (no installs): Use the VS Code task or the PowerShell script. This uses a built-in server and the Ruffle CDN.
- Cross‑platform with Node.js: Installs a local Ruffle copy and runs a dev server. Recommended if you want offline play.

### Option A: Windows Task/Script

In VS Code, run the task “Play Feudalism (Local Server)”; or from a terminal:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\run_feudalism.ps1
```

It opens your browser at <http://localhost:8080/play_feudalism.html>

### Option B: Node.js (offline‑friendly)

Requires Node.js 16+.

```powershell
npm install
npm start
```

- postinstall copies `@ruffle-rs/ruffle/ruffle.js` into `vendor/ruffle/` for offline use
- the page will fall back to the CDN if the local file isn’t present

## Files

- `Feudalism.swf` – the game
- `play_feudalism.html` – HTML wrapper using Ruffle
- `run_feudalism.ps1` – Windows PowerShell local server fallback (works without Python/Node)
- `scripts/postinstall.js` – copies Ruffle into `vendor/` after `npm install`

## Ruffle and licensing

Ruffle is included via npm as a dependency (`@ruffle-rs/ruffle`) and copied locally for offline play. Ruffle is licensed under MIT/Apache-2.0. See the Ruffle project at <https://ruffle.rs>.

This repository’s own content is MIT licensed. See LICENSE.

### Why no Flash Player EXE?

There used to be a standalone Adobe Flash “Projector” executable (`flashplayer_sa.exe`) that could run SWF files directly. It is not required here because the game runs via Ruffle in your browser. To avoid redistributing proprietary binaries and to keep the repo clean, we removed the EXE and added it to `.gitignore`.

If you still want the legacy projector for personal testing, search for “Adobe Flash Player projector content debugger” from official sources and use it at your own risk. Again, it’s not needed for this setup.

## GitHub

To publish this repo on GitHub using GitHub CLI:

```powershell
# One-time: authenticate if needed
# gh auth login

# Create a repo named Feudalism and push
gh repo create Feudalism --source . --public --push
```

If you don’t have the GitHub CLI, create a repo at <https://github.com/new>, then add it as remote and push:

```powershell
git remote add origin https://github.com/<your-user>/Feudalism.git
git branch -M main
git push -u origin main
```

## GitHub Pages (Play online)

This repository is configured to auto-deploy to GitHub Pages on every push to `main`.

- Workflow: `.github/workflows/pages.yml`
- Output URL (after the first successful run): `https://gustavogmoraes.github.io/Feudalism/`

What the workflow does:

- Runs `npm ci` to create a local copy of Ruffle assets under `vendor/ruffle/`
- Builds a minimal `dist/` with `index.html` (copied from `play_feudalism.html`), `Feudalism.swf`, and `vendor/ruffle/`
- Adds `.nojekyll` to prevent Jekyll processing
- Deploys `dist/` to GitHub Pages using official Actions

After it runs, you can share the link above so others can play right from the browser.

## Notes

- If your browser blocks local file features, always use the local server (scripts above) instead of double‑clicking the HTML file.
- On first load, Ruffle may take a second to initialize; if the game doesn’t appear, hard refresh the page.
