# Building native components

Ghidra's release archive includes the Gradle wrapper and native build scripts. The project uses those upstream build scripts rather than replacing them.

From the extracted Ghidra directory:

```bash
cd "$HOME/opt/ghidra_12.2_PUBLIC/support/gradle"
./gradlew buildNatives
```

The build observed on the initial test device detected `linux_arm_64` and generated native binaries under each module's `build/os/linux_arm_64/` directory.

The build step alone does not necessarily install the outputs into the runtime `os/linux_arm_64/` directories. The helper script should copy only expected native outputs and report each copy. Check the upstream Ghidra release's license and notices before redistributing any generated binaries.

## Important Android note

Termux is Android/Bionic, not a conventional glibc-based Linux distribution. The observed binaries were linked with `/system/bin/linker64` and targeted Android API 24, which worked on the tested device. Do not assume every Android version or device behaves the same way.
