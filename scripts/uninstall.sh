#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail

EXPECTED_DIR="$HOME/opt/ghidra_12.2_PUBLIC"
GHIDRA_DIR="${GHIDRA_DIR:-$EXPECTED_DIR}"

# Only allow removal of the exact installation path managed by this project.
if [[ "$GHIDRA_DIR" != "$EXPECTED_DIR" ]]; then
  echo "ERROR: Refusing to remove unexpected path: $GHIDRA_DIR" >&2
  exit 1
fi

# Refuse symlinks so a redirected path is never treated as the installation.
if [[ -L "$HOME/opt" ]]; then
  echo "ERROR: Refusing to continue because $HOME/opt is a symbolic link." >&2
  exit 1
fi

if [[ -L "$GHIDRA_DIR" ]]; then
  echo "ERROR: Refusing to remove a symbolic link: $GHIDRA_DIR" >&2
  exit 1
fi

if [[ ! -d "$GHIDRA_DIR" ]]; then
  echo "ERROR: Ghidra installation directory not found: $GHIDRA_DIR" >&2
  exit 1
fi

# Check for expected Ghidra files before offering deletion.
if [[ ! -f "$GHIDRA_DIR/support/analyzeHeadless" ||
      ! -d "$GHIDRA_DIR/Ghidra" ]]; then
  echo "ERROR: The target does not look like the expected Ghidra installation." >&2
  echo "Nothing was removed." >&2
  exit 1
fi

echo "This will permanently remove only:"
echo "  $GHIDRA_DIR"
echo
echo "It will NOT remove:"
echo "  - Java or other Termux packages"
echo "  - Gradle caches"
echo "  - $HOME/opt/ghidra-termux-smoke and its verification log"
echo
echo "Back up any files you added inside the Ghidra directory before continuing."
read -r -p 'Type DELETE to continue: ' answer
if [[ "$answer" != "DELETE" ]]; then
  echo "Cancelled. Nothing was removed."
  exit 0
fi

rm -rf -- "$EXPECTED_DIR"

# Remove only the marked environment block installed by this project.
if command -v python3 >/dev/null 2>&1; then
  python3 - <<'PY'
from pathlib import Path

rc = Path.home() / ".bashrc"
start = "# >>> Ghidra-Termux-ARM64 managed environment >>>"
end = "# <<< Ghidra-Termux-ARM64 managed environment <<<"

if rc.exists():
    text = rc.read_text(encoding="utf-8")
    if start in text and end in text:
        before, rest = text.split(start, 1)
        _, after = rest.split(end, 1)
        text = before.rstrip() + ("\n\n" if before.strip() else "") + after.lstrip("\n")
        rc.write_text(text, encoding="utf-8")
        print("Removed managed GHIDRA_INSTALL_DIR block from ~/.bashrc.")
PY
else
  echo "NOTE: Python 3 unavailable; remove the marked Ghidra block from ~/.bashrc manually."
fi

echo "Removed: $EXPECTED_DIR"
