#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail
GHIDRA_DIR="${GHIDRA_DIR:-$HOME/opt/ghidra_12.2_PUBLIC}"
EXPECTED_DIR="$HOME/opt/ghidra_12.2_PUBLIC"
if [[ "$GHIDRA_DIR" != "$EXPECTED_DIR" ]]; then
  echo "ERROR: Refusing to remove unexpected path: $GHIDRA_DIR" >&2
  exit 1
fi

echo "This will remove: $GHIDRA_DIR"
echo "It will not remove Gradle caches, Java, or Termux packages."
read -r -p "Type DELETE to continue: " answer
[[ "$answer" == "DELETE" ]] || { echo "Cancelled."; exit 0; }
rm -rf -- "$GHIDRA_DIR"
echo "Removed $GHIDRA_DIR"
