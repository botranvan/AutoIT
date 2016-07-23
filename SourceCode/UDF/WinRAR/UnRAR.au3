#include-once

Global Const $RAR_OM_LIST 	 = 0
Global Const $RAR_OM_EXTRACT = 1

Global Const $RAR_SKIP 		 = 0
Global Const $RAR_TEST 		 = 1
Global Const $RAR_EXTRACT	 = 2

Global Const $ERAR_NO_MEMORY      = 11
Global Const $ERAR_BAD_DATA       = 12
Global Const $ERAR_BAD_ARCHIVE    = 13
Global Const $ERAR_UNKNOWN_FORMAT = 14
Global Const $ERAR_EOPEN          = 15
Global Const $ERAR_SMALL_BUF      = 20

Global Const $UCM_CHANGEVOLUME = 0
Global Const $UCM_PROCESSDATA  = 1
Global Const $UCM_NEEDPASSWORD = 2

Global Const $RAR_VOL_ASK    = 0
Global Const $RAR_VOL_NOTIFY = 1

Global $hDll = DllOpen("unrar.dll")

; #FUNCTION# =============================================================
; Name............: _RAR_OpenArchive
; Description.....: Open RAR archive and allocate memory structures
; Syntax..........: _RAR_OpenArchive($sFile)
; Parameter(s)....: $sFile - Archive filename
; Return value(s).: Success - Returns a archive handle
;					Failure - Sets @error to 1 and returns 0 in case of error
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Tested on Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _RAR_OpenArchive($sFile)
	Local $hArcData = _OpenArchive($sFile)
	If $hArcData = 0 Then
		Return SetError(1, 0, 0)
	Else
		Return $hArcData
	EndIf
EndFunc   ;==>_RAR_OpenArchive

; #FUNCTION# =============================================================
; Name............: _Rar_GetComment
; Description.....: Retrieve comment from archive file
; Syntax..........: _Rar_GetComment($sFile)
; Parameter(s)....: $sFile - Archive filename
; Return value(s).: Success - Returns a string contains a archive comment
;					Failure - Returns 0 if archive not contains a comment
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Tested on Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _Rar_GetComment($sFile)
	$iComment = _OpenArchive($sFile, 1, $RAR_OM_LIST)
	Return $iComment
EndFunc

; #FUNCTION# =============================================================
; Name............: _OpenArchive
; Description.....: Open RAR archive and allocate memory structures
; Syntax..........: _OpenArchive($sFile[, $sGetComment = 0[, $sOpenMode = $RAR_OM_EXTRACT]])
; Parameter(s)....: $sFile - Archive filename
;					$sGetComment [optional] 0 = (default) don`t retrieve archive comment, 1 = retrieve archive comment
;					$sOpenMode [optional] $RAR_OM_EXTRACT = (default) Open archive for testing and extracting files,
;					+RAR_OM_LIST = Open archive for reading file headers only
; Return value(s).: Success - Returns a archive handle
;					Failure - Returns 0 and sets: @error to -1 if archive file not exist, 
;					+@error to 1 if archive opening in case of error, @error to 2 if "unrar.dll" not exist in the current directory
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: For internal use
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _OpenArchive($sFile, $sGetComment = 0, $sOpenMode = $RAR_OM_EXTRACT)
	If FileExists($sFile) = 0 Then Return SetError(-1, 0, 0)
	
	If $hDll = -1 Then Return SetError(2, 0, 0)
	
	Local $iFileName, $iArcNameBuf, $tRAROpenArchiveData, $aRet
	
	$iFileName = $sFile & Chr(0)
	$iFileName = StringToBinary($iFileName)
	
	$iArcNameBuf = DllStructCreate("byte[" & BinaryLen($iFileName) & "]")
	DllStructSetData($iArcNameBuf, 1, $iFileName)
	
	$iArcNameBufW = DllStructCreate("wchar[256]")
	DllStructSetData($iArcNameBufW, 1, $sFile)
	
	$tRAROpenArchiveData = DllStructCreate("ptr ArcName;ptr ArcNameW;uint OpenMode;uint OpenResult;ptr CmtBuf;uint CmtBufSize;" & _
										   "uint CmtSize;uint CmtState;uint Flags;uint Reserved[32]")
	
	DllStructSetData($tRAROpenArchiveData, "ArcName", DllStructGetPtr($iArcNameBuf))
	DllStructSetData($tRAROpenArchiveData, "ArcNamW", DllStructGetPtr($iArcNameBufW))
	DllStructSetData($tRAROpenArchiveData, "OpenMode", $sOpenMode)
	DllStructSetData($tRAROpenArchiveData, "Reserved", 0)
	
	If $sGetComment = 1 Then
		Local $CmtBuf = DllStructCreate("char[16384]") ;16 KB
		DllStructSetData($tRAROpenArchiveData, "CmtBuf", DllStructGetptr($CmtBuf))
		DllStructSetData($tRAROpenArchiveData, "CmtBufSize", DllStructGetSize($CmtBuf))
	Else
		DllStructSetData($tRAROpenArchiveData, "CmtBuf", 0)
	EndIf
	
	$aRet = DllCall($hDll, "hwnd", "RAROpenArchiveEx", "ptr", DllStructGetPtr($tRAROpenArchiveData))
	If $aRet[0] = 0 Then Return SetError(1, 0, 0)
	
	If DllStructGetData($tRAROpenArchiveData, "OpenResult") <> 0 Then
		DllCall($hDll, "int", "RARCloseArchive", "hwnd", $aRet[0])
		Return SetError(1, 0, 0)
	EndIf
	
	If $sGetComment = 1 Then
		DllCall($hDll, "int", "RARCloseArchive", "hwnd", $aRet[0])
		Return DllStructGetData($CmtBuf, 1)
	EndIf
	
	Return $aRet[0]
EndFunc

; #FUNCTION# =============================================================
; Name............: _RAR_SetCallback
; Description.....: Set a user-defined callback function to process Unrar events.
; Syntax..........: _RAR_SetCallback($hArcData, $hCallBack)
; Parameter(s)....: $hArcData - Archive handle
;					$hCallBack - dll "handle"
; Return value(s).: None
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Tested on Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _RAR_SetCallback($hArcData, $hCallBack)
	DllCall($hDll, "int", "RARSetCallback", "hwnd", $hArcData, "ptr", DllCallbackGetPtr($hCallBack), "int", 0)
EndFunc

; #FUNCTION# =============================================================
; Name............: _Rar_TestArchive
; Description.....: Test the current archive file
; Syntax..........: _Rar_TestArchive($hArcData)
; Parameter(s)....: $hArcData - Archive handle
; Return value(s).: Success - Returns a 1
;					Failure - Returns 0 and sets @error to 1
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Tested on Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _Rar_TestArchive($hArcData)
	Return _RAR_ReadHeader($hArcData, @ScriptDir, $RAR_TEST)
EndFunc

; #FUNCTION# =============================================================
; Name............: _Rar_UnpackArchive
; Description.....: Unpack the current archive file
; Syntax..........: _Rar_UnpackArchive($hArcData, $sDestPath = @ScriptDir)
; Parameter(s)....: $hArcData - Archive handle
;					$sDestPath - [optional] Destination directory to which to extract files to,
;					+if omitted, it means extract to the current directory
; Return value(s).: Success - Returns a 1
;					Failure - Returns 0 and sets @error to 1
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Tested on Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _Rar_UnpackArchive($hArcData, $sDestPath = @ScriptDir)
	_RAR_ReadHeader($hArcData, $sDestPath)
EndFunc

; #FUNCTION# =============================================================
; Name............: _RAR_ReadHeader
; Description.....: Read header of file in archive
; Syntax..........: _RAR_ReadHeader($hArcData, $sDestPath, $sFileOper = $RAR_EXTRACT)
; Parameter(s)....: $hArcData - Archive handle
;					$sDestPath - Destination directory to which to extract files to
;					$sFileOper [optional] File operation: $RAR_EXTRACT = (default) Extract the current file and move to 
;					+the next file, $RAR_SKIP = Move to the next file in the archive, $RAR_TEST - Test the current file 
;					+and move to the next file in the archive
; Return value(s).: Success - Returns a 1
;					Failure - Returns 0 and sets @error to 1
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: For internal use
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _RAR_ReadHeader($hArcData, $sDestPath, $sFileOper = $RAR_EXTRACT)
	Local $DestPathBuf, $RARHeaderData, $DestPathBuf
	
	$DestPathBuf = DllStructCreate("wchar[260]")
	DllStructSetData($DestPathBuf, 1, $sDestPath)
	
	$RARHeaderData = DllStructCreate("char ArcName[260];char FileName[260];uint Flags;uint PackSize;uint UnpSize;uint HostOS;" & _
									 "uint FileCRC;uint FileTime;uint UnpVer;uint Method;uint FileAttr;char CmtBuf;" & _
									 "uint CmtBufSize;uint CmtSize;uint CmtState")

	Do
		$aRet = DllCall($hDll, "int", "RARReadHeader", "hwnd", $hArcData, "ptr", DllStructGetPtr($RARHeaderData))
		
		If DllStructGetData($RARHeaderData, "CmtState") > 1 Then
			DllCall($hDll, "int", "RARCloseArchive", "hwnd", $hArcData)
			Return SetError(1, 0, 0)
		EndIf
		
		_RAR_ProcessFile($hArcData, $DestPathBuf, $sFileOper)
	Until $aRet[0] <> 0
	Return 1
EndFunc

; #FUNCTION# =============================================================
; Name............: _RAR_ProcessFile
; Description.....: Performs action and moves the current position in the archive to the next file
; Syntax..........: _RAR_ProcessFile($hArcData, $sDestPath, $sFileOper)
; Parameter(s)....: $hArcData - Archive handle
;					$sDestPath - Destination directory to which to extract files to
;					$sFileOper File operation: $RAR_EXTRACT = (default) Extract the current file and move to 
;					+the next file, $RAR_SKIP = Move to the next file in the archive, $RAR_TEST - Test the current file 
;					+and move to the next file in the archive
; Return value(s).: None
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: For internal use
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _RAR_ProcessFile($hArcData, $sDestPath, $sFileOper)
	DllCall($hDll, "int", "RARProcessFileW", "hwnd", $hArcData, "int", $sFileOper, _
			"ptr", DllStructGetPtr($sDestPath), "ptr", 0)
EndFunc

; #FUNCTION# =============================================================
; Name............: _RAR_SetPassword
; Description.....: Set a password to decrypt files
; Syntax..........: _RAR_SetPassword($hArcData, $sPass)
; Parameter(s)....: $hArcData - Archive handle
;					$sPass - string containing a password
; Return value(s).: None
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Tested on Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _RAR_SetPassword($hArcData, $sPass)
	DllCall($hDll, "int", "RARSetPassword", "hwnd", $hArcData, "str", $sPass)
EndFunc

; #FUNCTION# =============================================================
; Name............: _RAR_CloseArchive
; Description.....: Close RAR archive and release allocated memory
; Syntax..........: _RAR_CloseArchive($hArcData)
; Parameter(s)....: $hArcData - Archive handle
; Return value(s).: Success - Returns a 1
;					Failure - Returns 0 and sets @error to 1
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Tested on Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _RAR_CloseArchive($hArcData)
	Local $aRet = DllCall($hDll, "int", "RARCloseArchive", "hwnd", $hArcData)
	
	If $aRet[0] = 0 Then
		Return 1
	Else
		Return SetError(1, 0, 0)
	EndIf
EndFunc

; #FUNCTION# =============================================================
; Name............: _RAR_GetDllVersion
; Description.....: Returns API version
; Syntax..........: _RAR_GetDllVersion()
; Parameter(s)....: None
; Return value(s).: Returns an integer value denoting UnRAR.dll API version
; Requirement(s)..: AutoIt 3.2.12.0
; Note(s).........: Tested on Windows XP SP2
; Author(s).......: R.Gilman (a.k.a. rasim)
; ========================================================================
Func _RAR_GetDllVersion()
	$aRet = DllCall($hDll, "int", "RARGetDllVersion")
	Return $aRet[0]
EndFunc

Func OnAutoItExit()
	If $hDll <> -1 Then DllClose($hDll)
EndFunc