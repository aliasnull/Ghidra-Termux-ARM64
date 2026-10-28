#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail

GHIDRA_DIR="${GHIDRA_DIR:-$HOME/opt/ghidra_12.2_PUBLIC}"
GRADLE_DIR="$GHIDRA_DIR/support/gradle"

if [[ ! -x "$GRADLE_DIR/gradlew" ]]; then
  echo "ERROR: Ghidra Gradle wrapper not found: $GRADLE_DIR/gradlew" >&2
  echo "Set GHIDRA_DIR to the extracted Ghidra installation directory." >&2
  exit 1
fi

if [[ "$(uname -m)" != "aarch64" ]]; then
  echo "ERROR: This script targets Termux ARM64 (aarch64); found $(uname -m)." >&2
  exit 1
fi

echo "Ghidra directory: $GHIDRA_DIR"
echo "Java:"
java -version
echo
echo "Building native components with the upstream Gradle wrapper..."
cd "$GRADLE_DIR"
./gradlew buildNatives

echo
echo "Build finished. Outputs are expected under each module's build/os/linux_arm_64/ directory."
echo "Run the installer/copy step and then verify with scripts/verify.sh."
