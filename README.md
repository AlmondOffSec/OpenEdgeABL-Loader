# OpenEdgeABL-Loader

A super basic shellcode loader written in "OpenEdge Advanced Business Language", for when somehow the only method for code execution you found is through a niche business-oriented programming language.

This language offers a native construct to call functions exported from DLLs, so it is pretty trivial to run shellcode.

## Features

* Basic decoupling : memory protection and thread execution performed in different processes.
* The l33test form of IPC : the person running the program having to hardcode the target PID and address in the code.
* Zero (0) error handling.
* Zero (0) OPSEC: your shellcode is loaded unencrypted, base64-encoded, from a file directly on the filesystem.
* 64 bits only, for 32 bits just change all `INT64` to `UNSIGNED LONG`, it should work.

## How

1. Edit `local.p`, set the decoded shellcode size in bytes to `dwScSz` and the path to the shellcode in the string below.
2. Edit `remote.p`, set the decoded shellcode size in bytes to `dwScSz`.
3. Run `local.p`, it outputs a PID and a memory address.
4. Type the PID and address in `dwProcessId` and `pRemoteAddress` of `remote.p` (yes you have to type that long address manually, there's no copy there).
5. Run `remote.p` in a second OpenEdge process.
6. Press any key in the `local.p` window, your shellcode is running, congratulations.
