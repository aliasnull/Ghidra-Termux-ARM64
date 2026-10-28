# Troubleshooting

## `decompile does not exist`

Build native components using the Ghidra-provided Gradle wrapper, then verify that the generated `decompile` binary has been copied into the Decompiler module's `os/linux_arm_64/` directory.

## Gradle restricted-method warnings

Recent Java versions may print warnings about restricted native access. A warning alone does not prove the build failed. Check the final Gradle result.

## CA certificate bundle warning

Ghidra may report that it cannot find an OS CA bundle in expected Linux/BSD locations, then load certificates from Java's trust store. If the final operation succeeds, this warning may not be blocking. Do not suppress it without understanding the implications.

## Decompiler warnings

Warnings such as an unrecovered jump table can occur for particular functions. They do not automatically mean the entire decompiler is broken.

## Build or runtime failure

Capture the full error output and include:
- Android version
- Termux version
- `uname -m`
- `java -version`
- Ghidra version
- The exact command and final error
