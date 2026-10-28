#!/data/data/com.termux/files/usr/bin/bash
set -Eeuo pipefail

GHIDRA_DIR="${GHIDRA_DIR:-$HOME/opt/ghidra_12.2_PUBLIC}"
HEADLESS="$GHIDRA_DIR/support/analyzeHeadless"
TEST_SCRIPT_DIR="$(cd "$(dirname "$0")/../tests" && pwd)"
PROJECT_DIR="$HOME/opt/ghidra-termux-smoke"
BINARY="$(readlink -f "$PREFIX/bin/ls")"
LOG_FILE="$PROJECT_DIR/verify.log"

if [[ ! -x "$HEADLESS" ]]; then
  echo "ERROR: analyzeHeadless not found: $HEADLESS" >&2
  exit 1
fi

if [[ ! -f "$TEST_SCRIPT_DIR/DecompileSmokeTest.java" ]]; then
  echo "ERROR: Decompilation test script is missing." >&2
  exit 1
fi

if [[ ! -f "$BINARY" ]]; then
  echo "ERROR: Test binary not found: $BINARY" >&2
  exit 1
fi

echo "Architecture: $(uname -m)"
java -version
mkdir -p "$PROJECT_DIR"

set +e
"$HEADLESS" "$PROJECT_DIR" VerifyProject \
  -import "$BINARY" -overwrite \
  -scriptPath "$TEST_SCRIPT_DIR" \
  -postScript DecompileSmokeTest.java 2>&1 | tee "$LOG_FILE"
status=${PIPESTATUS[0]}
set -e

if [[ "$status" -ne 0 ]] || ! grep -q 'DECOMPILE_SMOKE_TEST=PASS' "$LOG_FILE"; then
  echo "ERROR: Headless analysis or pseudocode verification failed." >&2
  echo "See log: $LOG_FILE" >&2
  exit 1
fi

echo
echo "PASS: Headless analysis and pseudocode generation verified."
