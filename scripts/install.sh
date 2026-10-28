#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail

GHIDRA_VERSION="${GHIDRA_VERSION:-12.2}"
GHIDRA_BUILD="${GHIDRA_BUILD:-Ghidra_12.2_build}"
GHIDRA_ASSET="${GHIDRA_ASSET:-ghidra_12.2_PUBLIC_20261016.zip}"
INSTALL_PARENT="${INSTALL_PARENT:-$HOME/opt}"
GHIDRA_DIR="$INSTALL_PARENT/ghidra_12.2_PUBLIC"
RELEASE_URL="https://github.com/NationalSecurityAgency/ghidra/releases/download/${GHIDRA_BUILD}/${GHIDRA_ASSET}"

if [[ "$(uname -m)" != "aarch64" ]]; then
  echo "ERROR: This installer targets ARM64 Termux (aarch64); found $(uname -m)." >&2
  exit 1
fi

echo "This installer downloads the official Ghidra release and builds native components."
echo "Target: $GHIDRA_DIR"
echo "GUI support is not verified by this project."
echo
read -r -p "Continue? [y/N] " answer
[[ "$answer" == "y" || "$answer" == "Y" ]] || { echo "Cancelled."; exit 0; }

pkg install -y git wget unzip python clang make openjdk-25

if [[ -d "$GHIDRA_DIR" ]]; then
  echo "ERROR: $GHIDRA_DIR already exists. Move it aside or set INSTALL_PARENT to another directory." >&2
  exit 1
fi

mkdir -p "$INSTALL_PARENT"
tmpdir="$(mktemp -d)"
cleanup() { rm -rf "$tmpdir"; }
trap cleanup EXIT

echo "Downloading official Ghidra archive..."
wget --https-only --show-progress -O "$tmpdir/ghidra.zip" "$RELEASE_URL"

echo "Extracting..."
unzip -q "$tmpdir/ghidra.zip" -d "$tmpdir/extracted"
extracted="$tmpdir/extracted/ghidra_${GHIDRA_VERSION}_PUBLIC"
if [[ ! -d "$extracted" ]]; then
  echo "ERROR: Expected extracted directory not found: $extracted" >&2
  echo "Inspect the archive contents and update the version variables if the upstream naming changed." >&2
  exit 1
fi

mv "$extracted" "$GHIDRA_DIR"
export JAVA_HOME="${JAVA_HOME:-$PREFIX/lib/jvm/java-25-openjdk}"
export PATH="$JAVA_HOME/bin:$PATH"

echo "Building upstream native components..."
GHIDRA_DIR="$GHIDRA_DIR" bash "$(dirname "$0")/build-natives.sh"

echo "Installing native outputs into module runtime directories..."
modules=(Decompiler)
for module in "${modules[@]}"; do
  source_dir="$GHIDRA_DIR/Ghidra/Features/$module/build/os/linux_arm_64"
  target_dir="$GHIDRA_DIR/Ghidra/Features/$module/os/linux_arm_64"
  if [[ ! -d "$source_dir" ]]; then
    echo "NOTE: No build output for $module at $source_dir; skipping."
    continue
  fi
  mkdir -p "$target_dir"
  while IFS= read -r -d '' source_file; do
    base="$(basename "$source_file")"
    if [[ -x "$source_file" && ! -d "$source_file" ]]; then
      install -m 755 "$source_file" "$target_dir/$base"
      echo "Installed $module/$base"
    fi
  done < <(find "$source_dir" -maxdepth 1 -type f -print0)
done

echo
echo "Installation/build steps completed."
echo "Next: run scripts/verify.sh or the smoke-test command in docs/INSTALLATION.md."
echo "Note: this script has not yet been validated on a clean device; inspect and test before public release."
