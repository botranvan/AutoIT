#include <UnRAR.au3>

Global $Cancel = False

HotKeySet("{Esc}", "_CancelUnpack")

;Creates a user-defined DLL Callback function to process Unrar events
$hUnRAR_CallBack = DllCallbackRegister("_UnRARProc", "int", "uint;int;int;int")

$ArchiveFile = FileOpenDialog("Select the archive file", @MyDocumentsDir, "Archive files (*.rar)")

$OutputFolder = FileSelectFolder("Browse for output path", "", 1)
If $OutputFolder = "" Then Exit

;Retrieve comment from archive file
$comment = _Rar_GetComment($ArchiveFile)
ConsoleWrite("!> Archive comment: " & $comment & @LF)

;Open RAR archive and allocate memory structures
$hArchive = _RAR_OpenArchive($ArchiveFile)
If @error Then
	MsgBox(16, @error, "Archive open error")
	Exit
EndIf

;Test the current archive file
_Rar_TestArchive($hArchive)
If @error Then
	MsgBox(16, "UnRAR", "Archive testing error")
	Exit
Else
	MsgBox(64, "UnRAR", "Archive testing successful")
EndIf

;Close RAR archive and release allocated memory
_RAR_CloseArchive($hArchive)

 ;Set a password to decrypt files
;_RAR_SetPassword($hArchive, "MyPassword")

;Returns an integer value denoting UnRAR.dll API version
;_RAR_GetDllVersion()

$hArchive = _RAR_OpenArchive($ArchiveFile)
If @error Then
	MsgBox(16, "UnRAR", "Archive open error")
	Exit
EndIf

;Set a user-defined callback function to process Unrar events 
_RAR_SetCallback($hArchive, $hUnRAR_CallBack)

;Read header of file in archive, performs action and moves the current position in the archive to the next file
;Also extract or test the current file from the archive
_Rar_UnpackArchive($hArchive, $OutputFolder)
If @error Then
	MsgBox(16, "UnRAR", "Archive unpacking error")
	Exit
EndIf

If $Cancel = True Then
	MsgBox(64, "UnRAR", "Unpacking cancelled")
Else
	MsgBox(64, "Done", "Archive unpacked")
EndIf

DllCallbackFree($hUnRAR_CallBack)

Func _CancelUnpack()
	$Cancel = True
EndFunc

Func _UnRARProc($Msg, $UserData, $P1, $P2)
	Switch $Msg
		Case $UCM_PROCESSDATA ;Return a positive value to continue process or -1 to cancel the archive operation
			If $Cancel = True Then Return -1
		Case $UCM_NEEDPASSWORD ;DLL needs a password to process archive
			Local $iPassGet = InputBox("Password required", "Please type a password", "", "*", 300, 120)
			If $iPassGet = "" Then Return -1 ;If user cancelled password entering
			Local $PassBuffer = DllStructCreate("char[256]", $P1)
			DllStructSetData($PassBuffer, 1, $iPassGet)
			Return 1
		Case $UCM_CHANGEVOLUME ;Process volume change
			If $P2 = $RAR_VOL_ASK Then ;Required volume is absent
				Local $iVolGet = InputBox("Next volume required", "Please type a path to the next volume", "", "", 300, 120)
				If $iVolGet = "" Then Return -1 ;If user cancelled path entering
				Local $VolBuffer = DllStructCreate("char[256]", $P1)
				DllStructSetData($VolBuffer, 1, $iVolGet)
				Return 1
			EndIf
	EndSwitch
EndFunc