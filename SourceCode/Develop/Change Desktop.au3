#cs ----------------------------------------------------------------------------

Soft Version: 3.2.12.1
 Author:         Let me see


#ce ----------------------------------------------------------------------------
#include <GUIConstants.au3>
#include <Constants.au3>
#Include <GuiTab.au3>
#include <ScreenCapture.au3>
#include <Math.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
#include <String.au3>
#include <GuiButton.au3>
#include <File.au3>
#include <IE.au3>
#include <Misc.au3>
#include <Color.au3>
#include <Array.au3>
#include <String.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>

;--------------------------
Global Const $SPI_SETDESKWALLPAPER = 20
Global Const $SPIF_SENDCHANGE      = 2

Global $GetPics[20]
Global $PathBrowser, $SelectAll, $BTNLoadPic, $BTNPlayPic, $BTNStopPic, $MainWin, $DiSelectAll, $BTNSendE, $BTNExit, $InputTime
Global $Pic[11], $Cur[11]
Global $Pic_Name[11]
Global	$ListName[11]
Global $Pic_Check[11]
Global $BChecked[11]
Global $HP_F = 0, $WPos_HP, $DiSelectAll, $InputPath, $GetPathPic, $Time, $InputTime
Global $BTNUpdate, $BTNSendE, $BTNMedia, $BTNAbout, $BTNHelp
Global $PathConfig = @ScriptDir &'\Config.ini'
Global $Count = 0
;--------------------------------
_CheckConfig()
_MainWin()
;--------------------------------
;===================================================== Func Win Main Gui =======================================================================
Func _MainWin()
	$MainWin = GUICreate("Main GUI", 600, 500)
;-------------
	GUICtrlCreateGroup("Menu", 505, 0, 90, 400)
	$BTNUpdate = GUICtrlCreateButton("Update", 515, 35, 70, 60)
	$BTNSendE = GUICtrlCreateButton('Send M!Y', 515, 105, 70, 60)
	$BTNMedia = GUICtrlCreateButton('Meida Player', 515, 175, 70, 60)
	$BTNAbout = GUICtrlCreateButton('About', 515, 245, 70, 60)
	$BTNExit = GUICtrlCreateButton('Exit', 515, 315, 70, 60)
;-----------------------------------------------------------------------------------------------------------------
	$Tab = GUICtrlCreateTab(0, 0, 500, 400)
	$WallTab = GUICtrlCreateTabItem('Change Desktop Wallpaper')
	GUICtrlCreateGroup('List Img', 5, 25, 490, 280)
	$Pic[1] = GUICtrlCreatePic('', 15, 45, 90, 80, BitOR($SS_NOTIFY,$WS_GROUP,$WS_BORDER), $WS_EX_STATICEDGE)
	$Cur[1] = GUICtrlCreateLabel("Show", 40, 75)
	GUICtrlSetFont( $Cur[1], 10)
	GUICtrlSetColor( $Cur[1], 0x00ffff)
	GUICtrlSetState( $Cur[1], $GUI_HIDE)
	$Pic_Name[1] = GUICtrlCreateLabel(' ', 15, 130, 90)
	$Pic_Check[1] = GUICtrlCreateCheckbox('', 53,  145, 20,15)
	;----
	$Pic[2] = GUICtrlCreatePic('', 110, 45, 90, 80, BitOR($SS_NOTIFY,$WS_GROUP,$WS_BORDER), $WS_EX_STATICEDGE)
	$Cur[2] = GUICtrlCreateLabel("Show", 135, 75)
	GUICtrlSetFont( $Cur[2], 10)
	GUICtrlSetColor( $Cur[2], 0x00ffff)
	GUICtrlSetState( $Cur[2], $GUI_HIDE)
	$Pic_Name[2] = GUICtrlCreateLabel(' ', 110, 130, 90)
	$Pic_Check[2] = GUICtrlCreateCheckbox('', 145,  145, 20,15)
	;----
	$Pic[3] = GUICtrlCreatePic('', 205, 45, 90, 80, BitOR($SS_NOTIFY,$WS_GROUP,$WS_BORDER), $WS_EX_STATICEDGE)
	$Cur[3] = GUICtrlCreateLabel("Show", 230, 75)
	GUICtrlSetFont( $Cur[3], 10)
	GUICtrlSetColor( $Cur[3], 0x00ffff)
	GUICtrlSetState( $Cur[3], $GUI_HIDE)
	$Pic_Name[3] = GUICtrlCreateLabel(' ', 205, 130, 90)
	$Pic_Check[3] = GUICtrlCreateCheckbox('', 245,  145, 20,15)
	;----
	$Pic[4] = GUICtrlCreatePic('', 300, 45, 90, 80, BitOR($SS_NOTIFY,$WS_GROUP,$WS_BORDER), $WS_EX_STATICEDGE)
	$Cur[4] = GUICtrlCreateLabel("Show", 325, 75)
	GUICtrlSetFont( $Cur[4], 10)
	GUICtrlSetColor( $Cur[4], 0x00ffff)
	GUICtrlSetState( $Cur[4], $GUI_HIDE)
	$Pic_Name[4] = GUICtrlCreateLabel(' ', 300, 130, 90)
	$Pic_Check[4] = GUICtrlCreateCheckbox('', 337,  145, 20,15)
	;----
	$Pic[5] = GUICtrlCreatePic('', 395, 45, 90, 80, BitOR($SS_NOTIFY,$WS_GROUP,$WS_BORDER), $WS_EX_STATICEDGE)
	$Cur[5] = GUICtrlCreateLabel("Show", 420, 75)
	GUICtrlSetFont( $Cur[5], 10)
	GUICtrlSetColor( $Cur[5], 0x00ffff)
	GUICtrlSetState( $Cur[5], $GUI_HIDE)
	$Pic_Name[5] = GUICtrlCreateLabel(' ', 395, 130, 90)
	$Pic_Check[5] = GUICtrlCreateCheckbox('', 432,  145, 20,15)
	;------
	$Pic[6] = GUICtrlCreatePic('', 15, 180, 90, 80, BitOR($SS_NOTIFY,$WS_GROUP,$WS_BORDER), $WS_EX_STATICEDGE)
	$Pic_Name[6] = GUICtrlCreateLabel(' ', 15, 265, 90)
	$Pic_Check[6] = GUICtrlCreateCheckbox('', 53,  280, 20,15)
	$Cur[6] = GUICtrlCreateLabel("Show", 40, 210)
	GUICtrlSetFont( $Cur[6], 10)
	GUICtrlSetColor( $Cur[6], 0x00ffff)
	GUICtrlSetState( $Cur[6], $GUI_HIDE)
	;----
	$Pic[7] = GUICtrlCreatePic('', 110, 180, 90, 80, BitOR($SS_NOTIFY,$WS_GROUP,$WS_BORDER), $WS_EX_STATICEDGE)
	$Pic_Name[7] = GUICtrlCreateLabel(' ', 110, 265, 90)
	$Pic_Check[7] = GUICtrlCreateCheckbox('', 145,  280, 20,15)
	$Cur[7] = GUICtrlCreateLabel("Show", 135, 210)
	GUICtrlSetFont( $Cur[7], 10)
	GUICtrlSetColor( $Cur[7], 0x00ffff)
	GUICtrlSetState( $Cur[7], $GUI_HIDE)
	;----
	$Pic[8] = GUICtrlCreatePic('', 205, 180, 90, 80, BitOR($SS_NOTIFY,$WS_GROUP,$WS_BORDER), $WS_EX_STATICEDGE)
	$Cur[8] = GUICtrlCreateLabel("Show", 230, 210)
	GUICtrlSetFont( $Cur[8], 10)
	GUICtrlSetColor( $Cur[8], 0x00ffff)
	GUICtrlSetState( $Cur[8], $GUI_HIDE)
	$Pic_Name[8] = GUICtrlCreateLabel(' ', 205, 265, 90)
	$Pic_Check[8] = GUICtrlCreateCheckbox('', 245,  280, 20,15)
	;----
	$Pic[9] = GUICtrlCreatePic('', 300, 180, 90, 80, BitOR($SS_NOTIFY,$WS_GROUP,$WS_BORDER), $WS_EX_STATICEDGE)
	$Cur[9] = GUICtrlCreateLabel("Show", 325, 210)
	GUICtrlSetFont( $Cur[9], 10)
	GUICtrlSetColor( $Cur[9], 0x00ffff)
	GUICtrlSetState( $Cur[9], $GUI_HIDE)
	$Pic_Name[9] = GUICtrlCreateLabel(' ', 300, 265, 90)
	$Pic_Check[9] = GUICtrlCreateCheckbox("", 337,  280, 20,15)
	;----
	$Pic[10] = GUICtrlCreatePic('', 395, 180, 90, 80, BitOR($SS_NOTIFY,$WS_GROUP,$WS_BORDER), $WS_EX_STATICEDGE)
	$Cur[10] = GUICtrlCreateLabel("Show", 420, 210)
	GUICtrlSetFont( $Cur[10], 10)
	GUICtrlSetColor( $Cur[10], 0x00ffff)
	GUICtrlSetState( $Cur[10], $GUI_HIDE)
	$Pic_Name[10] = GUICtrlCreateLabel(' ', 395, 265, 90)
	$Pic_Check[10] = GUICtrlCreateCheckbox('', 432,  280, 20,15)
	;------------------
	GUICtrlCreateGroup('Control', 5, 305, 490,90)
	GUICtrlCreateLabel('Path Img:', 10, 330)
	$GetPathBrowser = IniRead($Pathconfig, 'PathPic','P', '')
	$InputPath = GUICtrlCreateInput($GetPathBrowser, 65, 330, 250, 20)
	$PathBrowser = GUICtrlCreateButton('Browser', 320, 330, 50,20)
	GUICtrlCreateLabel('Set Time:', 10, 365)
	$GetTimeFIni = IniRead($Pathconfig, 'SetTime','T', '')
	$InputTime = GUICtrlCreateInput($GetTimeFIni, 65, 365, 150, 20)
	;-------------------
	$SelectAll = GUICtrlCreateButton('Select All', 220, 365, 80, 20)
	$DiSelectAll = GUICtrlCreateButton('DiSelect', 305, 365, 80, 20)
	$BTNLoadPic = GUICtrlCreateButton('Load Img', 390, 315, 100, 22)
	$BTNPlayPic = GUICtrlCreateButton('Apply', 390, 343, 100, 22)
	$BTNStopPic = GUICtrlCreateButton('Stop', 390, 370, 100, 22)
	GUISetState(@SW_SHOW)
	;--------------------------------------------------------------------------------------------
	While 1

	$Msg = GUIGetMsg()
	Switch($Msg)
	Case $GUI_EVENT_CLOSE
		_Exit()
	Case $PathBrowser
	$SelectPath=FileSelectFolder('Choose a directory', '')
	If $SelectPath <> '' Then
			_GetPic($SelectPath)
			IniWrite($PathConfig, 'PathPic','P', $SelectPath)
			GUICtrlSetData($InputPath, $SelectPath)
		EndIf
	Case $SelectAll
		_SetSelectAll()
	Case $DiSelectAll
		_DiSelectAll()
	Case $BTNLoadPic
		$GetPathPic = IniRead($PathConfig, 'PathPic','P', '')
		_GetPic($GetPathPic)
	Case $BTNPlayPic
		$GetPathPic = IniRead($PathConfig, 'PathPic','P', '')
		_GetListImg()
		$T = _TimeLoad()
		AdlibEnable('_ChangeWallpaper', ($T * 1000))
	Case $BTNStopPic
		AdlibDisable()
	Case $BTNSendE
		_sendYahoo("lenggiauit","My OS SysTem: "&@OSVersion&".Ban Da Send Vao Luc: "&@HOUR&":"&@MIN)
	Case $BTNExit
		_Exit()
	Case $Pic[1]
		GUICtrlSetState($Pic_Check[1] ,$GUI_CHECKED)
	Case $Pic[2]
		GUICtrlSetState($Pic_Check[2] ,$GUI_CHECKED)
	Case $Pic[3]
		GUICtrlSetState($Pic_Check[3] ,$GUI_CHECKED)
	Case $Pic[4]
		GUICtrlSetState($Pic_Check[4] ,$GUI_CHECKED)
	Case $Pic[5]
		GUICtrlSetState($Pic_Check[5] ,$GUI_CHECKED)
	Case $Pic[6]
		GUICtrlSetState($Pic_Check[6] ,$GUI_CHECKED)
	Case $Pic[7]
		GUICtrlSetState($Pic_Check[7] ,$GUI_CHECKED)
	Case $Pic[8]
		GUICtrlSetState($Pic_Check[8] ,$GUI_CHECKED)
	Case $Pic[9]
		GUICtrlSetState($Pic_Check[9] ,$GUI_CHECKED)
	Case $Pic[10]
		GUICtrlSetState($Pic_Check[10] ,$GUI_CHECKED)
		EndSwitch
WEnd ;==========

EndFunc ;===

;==========================================================================================================================
Func _SetSelectAll()
	For $i = 1 To 10
	GUICtrlSetState($Pic_Check[$i] ,$GUI_CHECKED)
	Next
EndFunc
;-------------------------------------------------------------
Func _DiSelectAll()
	For $i = 1 To 10
	GUICtrlSetState($Pic_Check[$i] ,$GUI_UNCHECKED)
	Next
EndFunc
;===========================================================================================================================
;======================================================  Func Get PIc ======================================================
Func _GetPic($PathPic)

	Local $Type[2] = ['JPG', 'BMP']
	$TypePic1 = FileFindFirstFile($PathPic &'\*.'&$Type[0])
	$TypePic2 = FileFindFirstFile($PathPic &'\*.'&$Type[1])
	If $TypePic1 = '' And $TypePic2 = '' Then
		MsgBox(0, 'Error', 'Please Choose Forder Containt File : *.JPG Or *.BMP ')
		EndIf
	If $TypePic1 = 1 And $TypePic2 <> 1 Then
		$GetPics = _FileListToArray($PathPic&'\', '*.'&$Type[0], 1)

	Else
		If  $TypePic2 = 1 Then
		$GetPics = _FileListToArray($PathPic&'\', '*.'&$Type[1], 1)
	EndIf
EndIf
	$Num = UBound($GetPics)
	If $Num < 10 Then
		For $i = 1 To $Num -1
			GUICtrlSetData($Pic_Name[$i], $GetPics[$i])
			GUICtrlSetImage($Pic[$i], $PathPic&'\'&$GetPics[$i])
		Next
	Else
		For $i = 1 To 10
			GUICtrlSetData($Pic_Name[$i], $GetPics[$i])
			GUICtrlSetImage($Pic[$i], $PathPic&'\'&$GetPics[$i])
		Next
		EndIf
EndFunc
;============================================= Func Change desktop Wallpaper =================================================
Func _GetListImg()
;---------------------------
	For $i =1 To 10
		$BChecked[$i] = GUICtrlRead($Pic_Check[$i])
		If $BChecked[$i] = 1 Then
			$ListName[$i] = GUICtrlRead($Pic_Name[$i])
			;	$Count = $Count + 1
			EndIf
		Next
EndFunc
;======================================================= Chang Wallpaper  Func -====================================================================
Func _ChangeWallpaper()
	Local $Ran
	$Ran = Random(1, 10, 1)
	If $ListName[$Ran] <> '' Then
		_SetDesktopWallpaper($GetPathPic&'\'&$ListName[$Ran], True)
		_CurrentPic($Ran)
	EndIf
EndFunc
;==================================================== Func Current Show Pic on Desktop ===================================
Func _CurrentPic($CurPic)
	GUICtrlSetState( $Cur[$CurPic], $GUI_SHOW)
		Sleep(1500)
		GUICtrlSetState( $Cur[$CurPic], $GUI_HIDE)
EndFunc

; ========================================================================================================================
; Description ..: Sets the desktop wallpaper to the BMP file passed in.
; Parameters ...: $sBMPFile     - Full path to the BMP file
;                 $bUpdate      - Specifies whether the user profile is to be updated. If True, the
;                   WM_SETTINGCHANGE message is broadcast to all top level windows to  notify  them
;                   of change.
; Return values : True
;                 False
; ==========================================================================================================================
Func _SetDesktopWallpaper($sBMPFile, $bUpdate=True)
  Local $aResult
  Local $iWinIni = 0

  if $bUpdate then $iWinIni = $SPIF_SENDCHANGE
	  $Dll =DllOpen("user32.dll")
  $aResult = DllCall("user32.dll", "int", "SystemParametersInfo", "int", $SPI_SETDESKWALLPAPER, _
                     "int", 0, "str", $sBMPFile, "int", $iWinIni)
	DllClose($Dll)
  Return $aResult[0] <> 0
EndFunc
;================================================== Time Load  Pic ==========================================================
Func _TimeLoad()
	$Time = GUICtrlRead($InputTime)
	If $Time <> 0 Then
	IniWrite($PathConfig, 'SetTime','T', $Time)
	Return $Time
	EndIf
EndFunc
;================================================= Send Mail to lenggiauit====================================================
Func _sendYahoo($user, $text)
		Local $send, $Check_SendText
		$send = _IECreate ("ymsgr:sendim?"&$user&"&m="&$text, 0, 0, 0)

EndFunc
;============================================================================================================================
;=========================================================== Func Config ============================================
Func _CheckConfig()
	Local $FE
	$FE = FileExists(@ScriptDir &'\Config.ini')
	If $FE = 0 Then
		_FileCreate(@ScriptDir &'\Config.ini')
		IniWrite($PathConfig, 'PathPic','P', @WindowsDir&'\Web\Wallpaper')
		IniWrite($PathConfig, 'SetTime','T', '10')
	EndIf
;----------------------------------------------------------------------------------------------------
EndFunc
;============================================== Func Exit ================================================================
Func _Exit()
	_TimeLoad()
	Exit
EndFunc
;==========================================================================================================