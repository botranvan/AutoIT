#include <7Zip.au3>

;Exampe #1
$ArcFile = FileSaveDialog("Create a new archive", "", "Archive Files (*.7z;*.zip;*.gzip;*.bzip2;*.tar)")
If @error Then Exit

$FileName = FileSelectFolder("Select a folder", "")
If @error Then Exit

$retResult = _7ZipAdd(0, $ArcFile, $FileName)
If @error Then
	MsgBox(64, "_7ZipAdd", "Error occurred")
Else
	MsgBox(64, "_7ZipAdd", "Archive created successfully" & @LF & _
		   $retResult)
EndIf

;Exampe #2
$ArcFile = FileSaveDialog("Create a new archive", "", "Archive Files (*.7z;*.zip;*.gzip;*.bzip2;*.tar)")
If @error Then Exit

$FileName = FileOpenDialog("Select a file", "", "All (*.*)")
If @error Then Exit

$retResult = _7ZipAdd(0, $ArcFile, $FileName)
If @error Then
	MsgBox(64, "_7ZipAdd", "Error occurred")
Else
	MsgBox(64, "_7ZipAdd", "Archive created successfully" & @LF & _
		   $retResult)
EndIf

;Exampe #3
$ArcFile = FileSaveDialog("Create a new archive", "", "Archive Files (*.7z;*.zip;*.gzip;*.bzip2;*.tar)")
If @error Then Exit

$FileName = FileSelectFolder("Select a folder", "")
If @error Then Exit

$sInclude = "c:\Program Files\AutoIt3\Examples\GUI\*.*"
$sExclude = "c:\Program Files\AutoIt3\Examples\GUI\*.au3"

$retResult = _7ZipAdd(0, $ArcFile, $FileName, 0, 5, 1, $sInclude, $sExclude)
If @error Then
	MsgBox(64, "_7ZipAdd", "Error occurred")
Else
	MsgBox(64, "_7ZipAdd", "Archive created successfully" & @LF & _
		   $retResult)
EndIf