# Installation

## Current status

The workflow is experimental and has been tested only on one native Termux ARM64 device. GUI mode is not verified.

## Requirements

- Android device with native Termux (not a proot Linux distribution)
- AArch64 / ARM64 CPU
- Enough free storage for the Ghidra release archive, extracted application, Gradle cache, and build output
- Network access to the official Ghidra release host and Gradle distribution host
- A supported OpenJDK package, Clang, and Make

## Recommended initial approach

Review the scripts before running them. Install dependencies using Termux's package manager, then run `scripts/install.sh`.

The installer is intentionally designed to avoid root operations and does not install a GUI launcher. It should use the official Ghidra release and compile native components locally.

## Verification

Run the project verification script after installation:

```bash
bash scripts/verify.sh
```

It imports the Termux `ls` binary, runs headless analysis, and invokes `tests/DecompileSmokeTest.java` to verify C-like pseudocode generation. Success prints `DECOMPILE_SMOKE_TEST=PASS`. The log is saved to `~/opt/ghidra-termux-smoke/verify.log`.

## GUI

GUI mode is **not tested and not verified**. This project currently targets headless analysis only.
