#include-once

Global $StartTest = False
Global $LocalPath = @ScriptDir&'\files\'
Global $TempPath = @ScriptDir&'\files\temp\'
Global $FilesUpload = [0]
Global $FilesUploadTemp = [0]
Global $TypeSpeed = 200
Global $RunTime = _NowCalc()

Global $stdOutId = '[CLASS:ConsoleWindowClass; REGEXPTITLE:ftp.exe]'