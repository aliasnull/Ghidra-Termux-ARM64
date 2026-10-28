<div align="center">

# Ghidra-Termux-ARM64

### Ghidra Headless Analysis & Native Decompiler on Android

**Build and run Ghidra's ARM64 native decompiler on native Termux — without a Linux proot environment.**

<br>

[![Platform](https://img.shields.io/badge/Platform-Native%20Termux-009688?style=for-the-badge&logo=android&logoColor=white)](https://termux.dev/)
[![Architecture](https://img.shields.io/badge/Architecture-ARM64-2563EB?style=for-the-badge&logo=arm&logoColor=white)](https://github.com/aliasnull/Ghidra-Termux-ARM64)
[![Status](https://img.shields.io/badge/Status-Experimental-EA580C?style=for-the-badge)](https://github.com/aliasnull/Ghidra-Termux-ARM64)
[![License](https://img.shields.io/badge/License-Apache--2.0-7C3AED?style=for-the-badge)](LICENSE)

</div>

---

## About

**Ghidra-Termux-ARM64** documents and automates an experimental approach to building Ghidra's native components for ARM64 on native Termux.

It downloads the official Ghidra release from the National Security Agency (NSA), uses Ghidra's supplied Gradle build, and installs the generated native components. This repository contains helper scripts and documentation—not the Ghidra application itself.

> **Experimental:** Tested so far on one rooted Android ARM64 device running native Termux, Ghidra 12.2, OpenJDK 25, and Gradle 9.8. Compatibility with other devices and configurations is not guaranteed.

## Verified so far

- Ghidra's headless launcher starts in native Termux.
- ARM64 ELF binaries can be imported and analyzed.
- Native ARM64 decompiler components compile using Ghidra's supplied Gradle build.
- A smoke test successfully generated C-like pseudocode for a function.

## Limitations

- **GUI support is untested and unverified.** This project focuses on headless workflows.
- Compatibility with other Android devices, Termux versions, Java versions, and Ghidra releases is not guaranteed.
- Decompilation quality varies by binary; warnings and imperfect pseudocode are normal.
- The workflow has not yet been independently audited or validated through a clean-device installation.
- This is a community project and is not affiliated with or endorsed by the NSA or the official Ghidra project.

## Installation

### Requirements

- Android device using **ARM64 / AArch64**
- Native Termux environment (not a proot Linux distribution)
- Internet connection and sufficient free storage
- OpenJDK, Clang, Make, Python, Git, Wget, and Unzip (the installer attempts to install these packages)

### Method A — Build on your device

Review the installer scripts before executing them.

```bash
git clone https://github.com/aliasnull/Ghidra-Termux-ARM64.git
cd Ghidra-Termux-ARM64
bash scripts/install.sh
```

### Verify the installation

Run the verification script to test headless analysis and pseudocode generation:

```bash
bash scripts/verify.sh
```

A successful test prints `DECOMPILE_SMOKE_TEST=PASS`.

For more details, see the [Installation Guide](docs/INSTALLATION.md).

### Method B — Prebuilt native components

A prebuilt installation option may be added later. **No prebuilt archive is currently published or promised.** For now, use Method A.

## Uninstallation

Before removing an installation, read the [Uninstallation Guide](docs/UNINSTALLATION.md). It will explain what the removal script deletes and how to protect existing files.

## Manual build overview

1. Install the required Termux packages.
2. Install a compatible OpenJDK version.
3. Download the official Ghidra release.
4. Run Ghidra's `support/gradle/gradlew buildNatives` task.
5. Copy the generated ARM64 native outputs into their corresponding runtime directories.
6. Run `support/analyzeHeadless` and verify pseudocode generation.

See the [Building Guide](docs/BUILDING.md) for details.

## Troubleshooting

Encountering an error? Start with the [Troubleshooting Guide](docs/TROUBLESHOOTING.md). When reporting an issue, include your Android version, Termux version, architecture, Java version, Ghidra version, and the relevant error output.

## Security and transparency

- Ghidra is downloaded from the official `NationalSecurityAgency/ghidra` GitHub releases.
- Review scripts before running them; do not run them with root privileges unless explicitly required.
- The project does not intentionally collect credentials or telemetry.
- SHA-256 checksums should accompany project-built release archives. Do not treat an unverified checksum as official.

For reporting security concerns, see [SECURITY.md](SECURITY.md).

## License

The helper scripts and documentation in this repository are licensed under [Apache-2.0](LICENSE). Ghidra is a separate upstream project and remains subject to its own license and notices. This repository does not relicense Ghidra.

---

<div align="center">

**Built for the Termux community · Experimental · Community-maintained**

</div>
