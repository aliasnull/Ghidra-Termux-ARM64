# Uninstallation Guide

This guide removes the Ghidra installation created by this project's installer.

## Before you begin

- Back up any scripts, settings, projects, or other files you added **inside** the Ghidra installation directory.
- The uninstall script only targets `~/opt/ghidra_12.2_PUBLIC`.
- Review `scripts/uninstall.sh` before running it.

## Run the uninstall script

From the repository root in native Termux:

```bash
bash scripts/uninstall.sh
```

Read the paths shown by the script. To proceed, type `DELETE` when prompted. Any other response cancels the operation.

The script refuses to proceed if the target is a symbolic link, if `~/opt` is a symbolic link, or if the target does not look like the expected Ghidra installation.

## What is removed?

- `~/opt/ghidra_12.2_PUBLIC` — the Ghidra installation directory, including native components built for this setup.
- The marked `GHIDRA_INSTALL_DIR` block added by this installer to `~/.bashrc`

## What is not removed?

- Java/OpenJDK or other Termux packages
- Gradle caches
- `~/opt/ghidra-termux-smoke`, including `verify.log`
- This Git repository or its documentation
- Other lines and settings in `~/.bashrc`

These items are left in place so that unrelated tools, logs, and project files are not deleted. Remove them separately only if you are sure you no longer need them.

## If you installed Ghidra somewhere else

The provided script intentionally refuses to delete alternate paths. If you used a custom installation location, inspect that location carefully and remove it manually only after confirming it contains the intended Ghidra installation. Do not run `rm -rf` on a path unless you have verified it.

## Verify removal

After the script finishes, run:

```bash
test ! -e "$HOME/opt/ghidra_12.2_PUBLIC" && echo "Ghidra installation removed"
```
