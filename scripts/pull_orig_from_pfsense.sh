#!/usr/bin/env bash
# Pull the exact 2.9.0 base files from a running pfSense box as .orig sources.
#
# Purpose: store the pristine /usr/local/www and /etc/inc files from THIS
# pfSense instance so repo patches diff cleanly against byte-exact 2.9.0 files.
#
# Usage:
#   ./pull_orig_from_pfsense.sh <host> [ssh_key]
#     <host>    pfSense hostname or IP (SSH reachable, passwordless or key set)
#     ssh_key   optional path to SSH private key (default: ~/.ssh/id_ed25519)
#
# Examples:
#   ./pull_orig_from_pfsense.sh 192.168.1.1
#   ./pull_orig_from_pfsense.sh pfsense.local ~/.ssh/pfsense_key
#
# The script copies the files listed in FILES below from the remote box,
# verifies each as a non-empty text file, and writes them into the repo
# alongside their .orig names. Run from the repo root (Pfsense-VXLAN/).

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

HOST="${1:-}"
if [[ -z "$HOST" ]]; then
  echo "ERROR: pfSense host required." >&2
  echo "Usage: $0 <host> [ssh_key]" >&2
  exit 2
fi

SSH_KEY="${2:-}"
SSH_OPTS=(-o BatchMode=yes -o ConnectTimeout=15)
if [[ -n "$SSH_KEY" ]]; then
  SSH_OPTS+=(-i "$SSH_KEY")
fi

# Files to pull from the remote box, relative to the pfSense root.
# NOTE: these are absolute remote paths (leading slash) — scp interprets
# root@host:path with a leading slash as an absolute path on the remote.
FILES=(
  "/usr/local/www/interfaces_assign.php"
  "/usr/local/www/interfaces_bridge.php"
  "/usr/local/www/interfaces_gif.php"
  "/usr/local/www/interfaces_gre.php"
  "/usr/local/www/interfaces_groups.php"
  "/usr/local/www/interfaces_lagg.php"
  "/usr/local/www/interfaces_ppps.php"
  "/usr/local/www/interfaces_qinq.php"
  "/usr/local/www/interfaces_vlan.php"
  "/usr/local/www/interfaces_vlan_edit.php"
  "/usr/local/www/interfaces_wireless.php"
  "/etc/inc/interfaces.inc"
  "/etc/inc/util.inc"
)

echo ">> Pulling ${#FILES[@]} base files from pfSense at '$HOST'..."

ok=0
fail=0
for rel in "${FILES[@]}"; do
  base="$(basename "$rel")"

  # Fetch the remote file to a temp file.
  tmp="$(mktemp)"
  if ! scp "${SSH_OPTS[@]}" "root@${HOST}:${rel}" "$tmp" >/dev/null 2>&1; then
    echo "  [FAIL] $rel (scp failed)" >&2
    rm -f "$tmp"
    fail=$((fail + 1))
    continue
  fi

  # Sanity: must be non-empty and look like text.
  if [[ ! -s "$tmp" ]]; then
    echo "  [FAIL] $rel (empty file)" >&2
    rm -f "$tmp"
    fail=$((fail + 1))
    continue
  fi
  if command -v file >/dev/null 2>&1; then
    if ! file "$tmp" | grep -qiE 'text'; then
      echo "  [WARN] $rel (not plain text: $(file -b "$tmp"))" >&2
    fi
  fi

  # Write alongside the .orig name (strip leading slash for repo path).
  rel_noslash="${rel#/}"
  dest="$REPO_DIR/${rel_noslash}.orig"
  mkdir -p "$(dirname "$dest")"
  mv "$tmp" "$dest"
  echo "  [OK]   $rel -> ${rel}.orig ($(wc -c < "$dest") bytes)"
  ok=$((ok + 1))
done

echo ""
echo ">> Done: $ok OK, $fail failed."
if [[ "$fail" -gt 0 ]]; then
  echo ">> Review the errors above and re-run if needed." >&2
  exit 1
fi
