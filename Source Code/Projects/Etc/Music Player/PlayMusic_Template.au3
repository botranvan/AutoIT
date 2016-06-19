; coded by opdo.vn
; VinhPham with <3

#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiButton.au3>
#include <StaticConstants.au3>
#include <Sound.au3>
#include <File.au3>
#include "../../../UDF/Icons.au3" ; https://www.autoitscript.com/forum/topic/92675-icons-udf/
#include "../../../UDF/_ControlHover.au3" ; https://www.autoitscript.com/forum/topic/33230-_controlhover-udf/

Global $GUI, $Music_Image, $Music_Pos, $Music_Lyric[300][2], $Music_Lyric_POS, $button[3], $Music_Text1, $Music_Text2
Global $Music_ID
Global $Music_PlayMode = False ; false la pause, true la play
Global $TimerInit ; để tính toán thời gian, giảm xử lý gui

_ShowGUI() ; gọi hàm này

#Region ======================================== CODE ========================================
Func _ShowGUI()
	$GUI = GUICreate("GUI", 500, 200, -1, -1, $WS_POPUP, -1)
	GUISetBkColor(0x000000)
	$Music_Image = GUICtrlCreatePic('', 0, 0, 500, 200, -1, -1) ; nền
	GUICtrlSetState(-1, $GUI_DISABLE)
	GUICtrlCreatePic('', 0, 0, 500, 200, -1, -1)
	GUICtrlSetState(-1, $GUI_DISABLE)
	_Setimage(-1, @ScriptDir & "\nen.png")

	GUICtrlCreateLabel("", 0, 195, 500, 5, -1, -1) ; nền 1
	GUICtrlSetBkColor(-1, "0x5E5E5E")
	$Music_Pos = GUICtrlCreateLabel("", 0, 195, 500, 5, -1, -1) ; nền 2
	GUICtrlSetBkColor(-1, "0x298FEF")
	$Music_Exit = GUICtrlCreateLabel("", 480, 0, 21, 19, -1, -1) ; nút exit
	GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI Symbol")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, "-2")
	$Music_Mini = GUICtrlCreateLabel("", 480 - 20, 0, 21, 19, -1, -1) ; nút mini
	GUICtrlSetFont(-1, 12, 400, 0, "Segoe UI Symbol")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, "-2")

	$Music_Text1 = GUICtrlCreateLabel("Gun Lae Gun", 20, 37, 472, 40, $SS_CENTER + $SS_CENTERIMAGE, -1) ; lyric 1
	GUICtrlSetFont(-1, 15, 400, 0, "Segoe UI")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, "-2")
	$Music_Text2 = GUICtrlCreateLabel("Witwisit Hirunwongkul", 20, 80, 472, 40, $SS_CENTER + $SS_CENTERIMAGE, -1) ; lyric 2
	GUICtrlSetFont(-1, 15, 400, 0, "Segoe UI")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, "-2")


	$button[0] = _GUICtrl_CreateButton('', 224, 133)
	$button[1] = _GUICtrl_CreateButton('', 224 + 55, 133)
	$button[2] = _GUICtrl_CreateButton('', 224 - 55, 133)
	_ControlHover(2, $GUI, ($button[0])[1])
	_ControlHover(2, $GUI, ($button[1])[1])
	_ControlHover(2, $GUI, ($button[2])[1])
	_ControlHover(2, $GUI, $Music_Exit)
	_ControlHover(2, $GUI, $Music_Mini)
	GUISetState(@SW_SHOW, $GUI)
	_PlayMusic(@ScriptDir & '\test.mp3', @ScriptDir & '\nen.jpg', @ScriptDir & '\opdo.txt')
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case ($button[0])[1], ($button[0])[0]
				If $Music_PlayMode Then
					$Music_PlayMode = False
					_SoundPause($Music_ID)
					GUICtrlSetData(($button[0])[1], '')
				Else
					$Music_PlayMode = True
					If _SoundStatus($Music_ID) = 'paused' Then
						_SoundResume($Music_ID)
					Else
						_SoundPlay($Music_ID)
					EndIf
					GUICtrlSetData(($button[0])[1], '')
				EndIf
			Case $Music_Mini
				GUISetState(@SW_MINIMIZE, $GUI)
			Case $GUI_EVENT_CLOSE, $Music_Exit
				Exit

		EndSwitch
		If $Music_PlayMode Then
			If TimerDiff($TimerInit) >= 1000 Then
				$TimerInit = TimerInit()
				If _SoundStatus($Music_ID) <> 'playing' Then
					$Music_PlayMode = False
					GUICtrlSetData(($button[0])[1], '')
				Else
					GUICtrlSetPos($Music_Pos, Default, Default, Int((_SoundPos($Music_ID, 2) / _SoundLength($Music_ID, 2)) * 500))
					_Music_Lyric(Int(_SoundPos($Music_ID, 2) / 1000))
				EndIf

			EndIf
		EndIf
		If _ControlHover(0, $GUI) Then
			$control = @extended
			For $i = 0 To 2
				If $control = ($button[$i])[1] Then
					GUICtrlSetColor(($button[$i])[1], "0x298FEF")
					GUICtrlSetColor(($button[$i])[0], "0x298FEF")
					ExitLoop
				EndIf
			Next
			If $control = $Music_Exit Then GUICtrlSetColor($control, 0xC90E0E)
			If $control = $Music_Mini Then GUICtrlSetColor($control, 0x298FEF)
		Else
			
			$control = @extended
			For $i = 0 To 2
				If $control = ($button[$i])[1] Then
					GUICtrlSetColor(($button[$i])[1], "0xFFFFFF")
					GUICtrlSetColor(($button[$i])[0], "0xFFFFFF")
					ExitLoop
				EndIf
			Next
			If $control = $Music_Exit Then GUICtrlSetColor($control, 0xFFFFFF)
			If $control = $Music_Mini Then GUICtrlSetColor($control, 0xFFFFFF)
		EndIf
	WEnd
EndFunc   ;==>_ShowGUI
Func _GUICtrl_CreateButton($icon, $left, $top)
	Local $control[2]
	$control[1] = GUICtrlCreateLabel($icon, $left + 1, $top + 12, 55, 36, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
	GUICtrlSetFont(-1, 13, 400, 0, "Segoe UI Symbol")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, "-2")
	$control[0] = GUICtrlCreateLabel("◯", $left, $top, 59, 55, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
	GUICtrlSetFont(-1, 30, 400, 0, "Segoe UI Symbol")
	GUICtrlSetColor(-1, "0xFFFFFF")
	GUICtrlSetBkColor(-1, "-2")


	Return $control
EndFunc   ;==>_GUICtrl_CreateButton
Func _Music_Lyric($sec)
	If $sec >= $Music_Lyric[$Music_Lyric_POS][0] And $Music_Lyric[$Music_Lyric_POS][0] <> '' Then
		
		If Mod($Music_Lyric_POS, 2) = 0 Then
			GUICtrlSetData($Music_Text1, $Music_Lyric[$Music_Lyric_POS + 1][1])
			GUICtrlSetColor($Music_Text1, "0xFFFFFF")
			GUICtrlSetColor($Music_Text2, "0x298FEF")
			
		Else
			GUICtrlSetData($Music_Text2, $Music_Lyric[$Music_Lyric_POS + 1][1])
			GUICtrlSetColor($Music_Text1, "0x298FEF")
			GUICtrlSetColor($Music_Text2, "0xFFFFFF")
		EndIf
		$Music_Lyric_POS += 1
	ElseIf $Music_Lyric[$Music_Lyric_POS][0] == '' Then
		GUICtrlSetData($Music_Text1, $Music_Lyric[1][1])
		GUICtrlSetData($Music_Text2, $Music_Lyric[2][1])
		GUICtrlSetColor($Music_Text1, "0xFFFFFF")
		GUICtrlSetColor($Music_Text2, "0xFFFFFF")
	EndIf

EndFunc   ;==>_Music_Lyric
Func _PlayMusic($file, $file_image, $file_lyric)
	ReDim $Music_Lyric[300][2]
	Local $k = 0
	For $i = 1 To _FileCountLines($file_lyric)
		Local $data = FileReadLine($file_lyric, $i)
		Local $tach = StringSplit($data, '=')
		
		If Not @error Then
			If $tach[0] = 2 Then
				$tach2 = StringSplit($tach[1], ',')
				For $j = 1 To $tach2[0]
					$k += 1
					
					$Music_Lyric[$k][0] = Number($tach2[$j])
					$Music_Lyric[$k][1] = $tach[2]
				Next
			EndIf
		EndIf
		
	Next
	For $i = $k - 1 To 1 Step -1
		For $j = 1 To $i
			If $Music_Lyric[$j][0] > $Music_Lyric[$j + 1][0] Then
				Local $temp = $Music_Lyric[$j][0]
				$Music_Lyric[$j][0] = $Music_Lyric[$j + 1][0]
				$Music_Lyric[$j + 1][0] = $temp
				Local $temp = $Music_Lyric[$j][1]
				$Music_Lyric[$j][1] = $Music_Lyric[$j + 1][1]
				$Music_Lyric[$j + 1][1] = $temp
				
			EndIf
		Next
	Next
	$Music_Lyric[0][0] = $k
	$Music_Lyric_POS = 2
	GUICtrlSetData($Music_Text1, $Music_Lyric[1][1])
	GUICtrlSetData($Music_Text2, $Music_Lyric[2][1])
	GUICtrlSetColor($Music_Text1, "0xFFFFFF")
	GUICtrlSetColor($Music_Text2, "0xFFFFFF")
	GUICtrlSetImage($Music_Image, $file_image)
	GUICtrlSetPos($Music_Pos, Default, Default, 0)
	$Music_ID = _SoundOpen($file)
	If Not @error Then
		_SoundPlay($Music_ID)
		$Music_PlayMode = True
		$TimerInit = TimerInit()
		GUICtrlSetData(($button[0])[1], '')
	Else
		GUICtrlSetData(($button[0])[1], '')
		$Music_PlayMode = False
	EndIf
EndFunc   ;==>_PlayMusic
#EndRegion ======================================== CODE ========================================
