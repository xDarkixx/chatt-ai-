Set shell = CreateObject("WScript.Shell")
shell.Run Chr(34) & CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName) & "\run_windows.bat" & Chr(34), 0, False
Set shell = Nothing
