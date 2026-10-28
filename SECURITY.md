# Security Policy

## Scope

This repository contains helper scripts and documentation for building Ghidra native components on native Termux / Android ARM64. It is not an official Ghidra distribution.

## Reporting a concern

Please open a GitHub Security Advisory if enabled for the repository, or report the issue privately to the maintainer through the contact method listed on the GitHub profile. Avoid publishing exploit details before maintainers have had a chance to respond.

## Safe-use guidance

- Inspect scripts before running them.
- Downloads should come from the official Ghidra release repository or this project's explicitly documented GitHub Releases.
- Release archives should include SHA-256 checksums.
- Do not run this project with elevated/root privileges unless a documented step genuinely requires it. The standard workflow should run as the Termux app user.
- Report unexpected network connections, unexplained file changes, or undocumented payloads.
