# Ghidra-Termux-ARM64

**Run Ghidra's headless analysis and decompiler on native Termux (Android ARM64).**

This project documents and automates a community-tested approach for building Ghidra native components in Termux. It uses the official Ghidra release from the National Security Agency (NSA); this repository does not contain the Ghidra application itself.

> **Status: experimental.** Tested so far on one rooted Android ARM64 / native Termux environment with Ghidra 12.2, OpenJDK 25, and Gradle 9.8. This is not yet a general compatibility guarantee.

## What works so far

- Ghidra headless launcher starts in native Termux.
- ARM64 ELF binaries can be imported and analyzed.
- Native ARM64 decompiler components compiled with Ghidra's supplied Gradle build.
- A test script successfully generated C-like pseudocode for a function.

## Limitations

- **GUI: not tested / not verified.** This project targets headless workflows; GUI support is not a goal.
- Compatibility with other Android devices, Termux versions, Java versions, and Ghidra releases is not guaranteed.
- Decompilation quality depends on the binary; warnings and imperfect pseudocode are normal.
- This is not an official NSA or Ghidra project.
- This repository's scripts have not yet been independently audited or tested on a clean device. Treat the current workflow as experimental.

## Installation methods

### Method A — Build native components on your device

This is the intended initial workflow. It downloads the official Ghidra release, runs its provided `buildNatives` Gradle task, and installs the generated ARM64 native components into the corresponding Ghidra module directories.

Review `scripts/install.sh` and `scripts/build-natives.sh` before running them.

```bash
git clone https://github.com/aliasnull/Ghidra-Termux-ARM64.git
cd Ghidra-Termux-ARM64
bash scripts/install.sh
```

The repository URL above is a placeholder until the project is published.

### Method B — Prebuilt native components

A prebuilt installation path is planned. It will only be usable after a maintainer publishes a versioned native-components archive in GitHub Releases and records its checksum. **No prebuilt archive is currently included or promised.** Until then, use Method A.

## Manual build overview

1. Install Termux packages required by the build (`git`, `wget`, `unzip`, `python`, `clang`, `make`).
2. Install a supported OpenJDK package.
3. Download the official Ghidra release from the NSA's official GitHub release page.
4. Run `support/gradle/gradlew buildNatives`.
5. Copy the generated `linux_arm_64` native outputs into the matching Ghidra module `os/linux_arm_64` directories.
6. Run `support/analyzeHeadless` against a test binary and inspect the logs.

See [BUILDING.md](docs/BUILDING.md), [INSTALLATION.md](docs/INSTALLATION.md), and [TROUBLESHOOTING.md](docs/TROUBLESHOOTING.md).

## Security and transparency

- Ghidra is downloaded from the official `NationalSecurityAgency/ghidra` GitHub releases.
- The scripts are public and should be reviewed before execution.
- No credentials, telemetry, or hidden payloads are intentionally collected or installed.
- Never run a script you do not understand. Inspect the source first.
- SHA-256 checksums should be published for project-built release archives. Do not claim an official checksum unless it is obtained from an authoritative release source.

## License

The helper scripts and documentation in this repository are licensed under Apache-2.0; see [LICENSE](LICENSE). Ghidra itself is a separate upstream project and remains subject to its own license and notices. This repository does not relicense Ghidra.
