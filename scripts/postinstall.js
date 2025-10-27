/*
  Postinstall script: copies the Ruffle web bundle from node_modules
  into vendor/ so play_feudalism.html can use a local copy when offline.
*/
const fs = require('fs');
const path = require('path');

const src = path.join(__dirname, '..', 'node_modules', '@ruffle-rs', 'ruffle', 'ruffle.js');
const destDir = path.join(__dirname, '..', 'vendor', 'ruffle');
const dest = path.join(destDir, 'ruffle.js');

function ensureDir(p) {
  if (!fs.existsSync(p)) fs.mkdirSync(p, { recursive: true });
}

function copy() {
  if (!fs.existsSync(src)) {
    console.warn('[postinstall] Ruffle not found at', src);
    console.warn('[postinstall] The page will fall back to the CDN. This is fine.');
    return;
  }
  ensureDir(destDir);
  fs.copyFileSync(src, dest);
  console.log('[postinstall] Copied Ruffle to', dest);
}

try {
  copy();
} catch (e) {
  console.warn('[postinstall] Failed to copy Ruffle:', e.message);
}
