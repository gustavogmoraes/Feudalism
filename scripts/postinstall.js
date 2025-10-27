/*
  Postinstall script: copies the Ruffle web bundle from node_modules
  into vendor/ so play_feudalism.html can use a local copy when offline.
*/
const fs = require('fs');
const path = require('path');

const pkgDir = path.join(__dirname, '..', 'node_modules', '@ruffle-rs', 'ruffle');
const destDir = path.join(__dirname, '..', 'vendor', 'ruffle');

function ensureDir(p) {
  if (!fs.existsSync(p)) fs.mkdirSync(p, { recursive: true });
}

function copy() {
  if (!fs.existsSync(pkgDir)) {
    console.warn('[postinstall] Ruffle package not found at', pkgDir);
    console.warn('[postinstall] The page will fall back to the CDN. This is fine.');
    return;
  }
  ensureDir(destDir);
  const entries = fs.readdirSync(pkgDir);
  const wanted = /^(ruffle\.js(\.map)?|core\.ruffle\.[^.]+\.js(\.map)?|.*\.wasm)$/i;
  let copied = 0;
  for (const name of entries) {
    if (!wanted.test(name)) continue;
    const src = path.join(pkgDir, name);
    const dst = path.join(destDir, name);
    fs.copyFileSync(src, dst);
    copied++;
  }
  console.log(`[postinstall] Copied ${copied} Ruffle asset(s) to ${destDir}`);
}

try {
  copy();
} catch (e) {
  console.warn('[postinstall] Failed to copy Ruffle:', e.message);
}
