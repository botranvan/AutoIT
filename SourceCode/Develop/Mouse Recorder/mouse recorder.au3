#NoTrayIcon
#RequireAdmin
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=E:\Soft\Download\optical_mouse.ico
#AutoIt3Wrapper_Res_Comment=Mouse Recorder
#AutoIt3Wrapper_Res_Description=Mouse Recorder
#AutoIt3Wrapper_Res_Fileversion=1.2.0.0
#AutoIt3Wrapper_Res_LegalCopyright=Opdo.top
#AutoIt3Wrapper_Res_Field=Email|imopdo@opdo.top
#AutoIt3Wrapper_Res_Field=Website|http://opdo.top
#AutoIt3Wrapper_Run_Au3Stripper=y
#Au3Stripper_Parameters=/so
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------

	MOUSE RECORDER
	http://opdo.top
	Coded by opdo.top
	Chương trình có sử dụng thư viện _ControlHover() (https://www.autoitscript.com/forum/topic/33230-_controlhover-udf/) của Valuater

#ce ----------------------------------------------------------------------------

#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <GuiButton.au3>
#include <Misc.au3>
#include <File.au3>
#include <Crypt.au3>
#include <EditConstants.au3>
#include "_ControlHover\_ControlHover.au3"; tks to Valuater (AutoIT Forum)

Opt("GUIOnEventMode", 1) ; chuyển về chế độ event
Global $fo, $time_recoder, $time_init ; tính thời gian
Global $RECORD_MODE = 0 ; 0: no record, 1 record, 2 pause record, 3 ready to record (setting mode)
Global $REPLAY_MODE = 0, $REPLAY_I, $REPLAY_LINE, $REPLAY_TIMES ; chạy replay
Global $time_delay, $RECORD_LAST_POS ; tính thời gian khi chuột dừng ở 1 vị trí nào đó
Global $HOTKEY[4] ; hotkey
Global $RECORD_PASSWORD
$HOTKEY[3] = 'F1,F2,F3,F4,F5,F6,F7,F8,F9,F10,F11,F12,70,71,72,73,74,75,76,77,78,79,7A,7B'
Global $COLOR = '0x0063B1|0x000000|0x800080|0xFF9900|0x008000|0x808080'
Global $GUI_COLOR = RegRead('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Color') = '' ? '0x0063B1' : RegRead('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Color')
Local $pos_x = RegRead('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'GUI_POS_X') = '' ? -1 : Number(RegRead('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'GUI_POS_X'))
Local $pos_y = RegRead('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'GUI_POS_Y') = '' ? -1 : Number(RegRead('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'GUI_POS_Y'))
Global $GUI = GUICreate("AutoIT Mouse Recorder", 353,177, $pos_x, $pos_y, BitOR($WS_POPUP, $WS_BORDER), -1)
GUISetBkColor($GUI_COLOR, $GUI)
GUISetFont(10,400,0,"Segoe UI")
; title
$title = GUICtrlCreateLabel("Mouse Recorder", 10, 10, 336, 46, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetFont(-1, 24, 300, 0, "Segoe UI Light")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "-2")
GUICtrlSetResizing ( -1, $GUI_DOCKAUTO )

; ô trang trí
$o1 = GUICtrlCreateLabel("", 12, 74, 101, 63, $SS_WHITEFRAME, -1)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetResizing ( -1, $GUI_DOCKAUTO )
$o2 = GUICtrlCreateLabel("", 125, 74, 101, 63, $SS_WHITEFRAME, -1)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetResizing ( -1, $GUI_DOCKAUTO )
$o3 = GUICtrlCreateLabel("", 238, 74, 101, 63, $SS_WHITEFRAME, -1)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetResizing ( -1, $GUI_DOCKAUTO )
; các button
$button1 = GUICtrlCreateLabel("🔴 Record", 12, 74, 101, 63, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "-2")
GUICtrlSetResizing ( -1, $GUI_DOCKAUTO )
$button2 = GUICtrlCreateLabel("▶ Replay", 125, 74, 101, 63, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "-2")
GUICtrlSetResizing ( -1, $GUI_DOCKAUTO )
$button3 = GUICtrlCreateLabel("❌ Exit", 238, 74, 101, 63, BitOR($SS_CENTER, $SS_CENTERIMAGE), -1)
GUICtrlSetFont(-1, 14, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "-2")
GUICtrlSetResizing ( -1, $GUI_DOCKAUTO )
; credit
$credit = GUICtrlCreateLabel("© Coded by http://opdo.top", 12,147,200,23, $SS_CENTERIMAGE, -1)
GUICtrlSetFont(-1, 10, 300, 0, "Segoe UI Light")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor(-1, "-2")
GUICtrlSetCursor(-1,0)
GUICtrlSetResizing ( -1, $GUI_DOCKAUTO )
$next_setting = GUICtrlCreateLabel("More",281,147,58,23,BitOr($SS_CENTER,$SS_CENTERIMAGE),-1)
GUICtrlSetFont(-1,11,600,0,"Segoe UI Semibold")
GUICtrlSetColor(-1,"0xFFFFFF")
GUICtrlSetBkColor(-1,"-2")
GUICtrlSetCursor(-1,0)
GUICtrlSetResizing ( -1, $GUI_DOCKAUTO )
; setting
$o_setting = GUICtrlCreateLabel("", 20, 131, 203, 2)
GUICtrlSetBkColor(-1, "0xFFFFFF")
GUICtrlSetResizing ( -1, $GUI_DOCKAUTO )
$input_setting = GUICtrlCreateInput("F10", 20, 74, 203, 45, $ES_CENTER, 0)
GUICtrlSetFont(-1, 25, 400, 0, "Segoe UI")
GUICtrlSetColor(-1, "0xFFFFFF")
GUICtrlSetBkColor($input_setting, $GUI_COLOR)
GUICtrlSetResizing ( -1, $GUI_DOCKAUTO )
; add control hover
_ControlHover(2, $GUI, $button1)
_ControlHover(2, $GUI, $button2)
_ControlHover(2, $GUI, $button3)
_ControlHover(2, $GUI, $next_setting)

; set deffault control
_SetDeffaultGUI()
GUISetState(@SW_SHOW, $GUI)
_Change_Size(Number(RegRead('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Size')))

While 1
	Sleep(1)
	If $REPLAY_MODE > 0 Or $RECORD_MODE > 0 Then
		; check hotkey
		For $i = 0 To 2
			If _IsPressed($HOTKEY[$i]) Then
				Do
					Sleep(1)
				Until Not _IsPressed($HOTKEY[$i])
				If $i = 0 Then _Button1()
				If $i = 1 Then _Button2()
				If $i = 2 Then _Button3()
			EndIf
		Next
	EndIf
	If $REPLAY_MODE = 1 Or $REPLAY_MODE = 2 Then
		;replay
		If $REPLAY_MODE = 1 Then
			$REPLAY_I += 1
			If Number($REPLAY_I) > Number($REPLAY_LINE) Then ; nếu đã chạy hết dòng file replay thì
				$REPLAY_TIMES -= 1 ; giảm replay times
				$REPLAY_I = 2
				If $REPLAY_TIMES <= 0 Then _StopReplay() ; nếu đã hết replay times thì ngưng replay
			EndIf
			Local $REPLAY_LINE_PRE = $REPLAY_I - 1 <= 1 ? 2 : $REPLAY_I - 1
			$file_read_pre = FileReadLine($fo, $REPLAY_LINE_PRE)
			$mouse_pos_pre = StringSplit($file_read_pre, ',')

			$file_read = FileReadLine($fo, $REPLAY_I)
			$mouse_pos = StringSplit($file_read, ',')

			If $file_read_pre = $file_read Then ContinueLoop
			If @error Then ContinueLoop
			If $mouse_pos[0] < 4 Then ContinueLoop
			If Number($time_delay) >= Number($mouse_pos[4]) Then
				MouseMove(Number($mouse_pos[1]), Number($mouse_pos[2]), 0)
				If Number($mouse_pos[3]) = 1 Then
					MouseDown('left')
				ElseIf Number($mouse_pos[3]) = 2 Then
					MouseDown('right')
				Else
					If $mouse_pos_pre[0] < 4 Then
						MouseUp('right')
						MouseUp('left')
					EndIf
					If Number($mouse_pos_pre[3]) = 2 Then MouseUp('right')
					If Number($mouse_pos_pre[3]) = 1 Then MouseUp('left')
				EndIf
				$time_delay = 1
			Else
				$time_delay += 1
				$REPLAY_I -= 1
			EndIf
			; set time
			If TimerDiff($time_init) >= 1000 Then
				$time_init = TimerInit()
				$time_recoder += 1
				Local $time_text_min = Int($time_recoder / 60) < 10 ? '0' & Int($time_recoder / 60) : Int($time_recoder / 60)
				Local $time_text_sec = Mod($time_recoder, 60) < 10 ? '0' & Mod($time_recoder, 60) : Mod($time_recoder, 60)
				GUICtrlSetData($title, "Replay ["&$REPLAY_TIMES&"] (" & $time_text_min & ":" & $time_text_sec & ")")
			EndIf
		EndIf
	EndIf

	If $RECORD_MODE = 1 Or $RECORD_MODE = 2 Then

		If $RECORD_MODE = 1 Then
			$mouse_pos = MouseGetPos()
			Local $text = ''
			If _IsPressed("01") Then
				$text = $mouse_pos[0] & ',' & $mouse_pos[1] & ',1'
			ElseIf _IsPressed("02") Then
				$text = $mouse_pos[0] & ',' & $mouse_pos[1] & ',2'
			Else
				$text = $mouse_pos[0] & ',' & $mouse_pos[1] & ',0'
			EndIf
			If $RECORD_LAST_POS <> $text Then
				$RECORD_LAST_POS = $text
				FileWriteLine($fo, $text & ',' & $time_delay)
				$time_delay = 1
			Else
				$time_delay += 1
			EndIf
			; set time
			If TimerDiff($time_init) >= 1000 Then
				$time_init = TimerInit()
				$time_recoder += 1
				Local $time_text_min = Int($time_recoder / 60) < 10 ? '0' & Int($time_recoder / 60) : Int($time_recoder / 60)
				Local $time_text_sec = Mod($time_recoder, 60) < 10 ? '0' & Mod($time_recoder, 60) : Mod($time_recoder, 60)
				GUICtrlSetData($title, "Recording (" & $time_text_min & ":" & $time_text_sec & ")")
			EndIf
		EndIf
	EndIf

	; control hover event
	$Over = _ControlHover(0, $GUI)
	If $Over = 1 Then
		$control = @extended
				GUICtrlSetBkColor($control, "0xFFFFFF")
				GUICtrlSetColor($control, $GUI_COLOR)
	Else
		$control = @extended
				GUICtrlSetBkColor($control, "-2")
				GUICtrlSetColor($control, "0xFFFFFF")
	EndIf
WEnd


#Region Button Event
Func _Button2()
if GUICtrlRead($button1) <> '🎨 Color' Then
	If $RECORD_MODE = 0 Then
		If $REPLAY_MODE = 0 Then
			$fo = FileOpenDialog('Choose file', "", "Mouse Record File (*.mrecord)")
			If Not @error Then
				$RECORD_MODE = 0
				_StartSetting()
			EndIf
		ElseIf $REPLAY_MODE = 1 Then
			GUICtrlSetData($button2, '▶ Resume')
			$REPLAY_MODE = 2
			GUICtrlSetData($title, "Pause")
		ElseIf $REPLAY_MODE = 2 Then
			GUICtrlSetData($button2, '❚❚ Pause')
			$REPLAY_MODE = 1
			$time_init = TimerInit()
			Local $time_text_min = Int($time_recoder / 60) < 10 ? '0' & Int($time_recoder / 60) : Int($time_recoder / 60)
			Local $time_text_sec = Mod($time_recoder, 60) < 10 ? '0' & Mod($time_recoder, 60) : Mod($time_recoder, 60)
			GUICtrlSetData($title, "Replay (" & $time_text_min & ":" & $time_text_sec & ")")
		EndIf
	ElseIf $RECORD_MODE = 1 Then
		GUICtrlSetData($button2, '▶ Resume')
		$RECORD_MODE = 2
		GUICtrlSetData($title, "Pause")
	ElseIf $RECORD_MODE = 2 Then
		GUICtrlSetData($button2, '❚❚ Pause')
		$RECORD_MODE = 1
		$time_init = TimerInit()
		Local $time_text_min = Int($time_recoder / 60) < 10 ? '0' & Int($time_recoder / 60) : Int($time_recoder / 60)
		Local $time_text_sec = Mod($time_recoder, 60) < 10 ? '0' & Mod($time_recoder, 60) : Mod($time_recoder, 60)
		GUICtrlSetData($title, "Recording (" & $time_text_min & ":" & $time_text_sec & ")")
	EndIf
	Else
	_Change_Size()
EndIf
EndFunc   ;==>_Button2
Func _Button1()
if GUICtrlRead($button1) <> '🎨 Color' Then
	If $RECORD_MODE = 0 Then
		If $REPLAY_MODE = 0 Then
			Local $temp_file = @TempDir & '\AutoIT_Mouse_Record.txt'
			FileDelete($temp_file)
			If Not @error Then
				$fo = FileOpen($temp_file, 2)
				If Not @error Then
					FileWriteLine($fo, 'MOUSE_RECORDER_BY_OPDO.TOP')
					$RECORD_MODE = 3
					_StartSetting()
				Else
					MsgBox(16, 'Error', "I'm sorry :'(, the program can't start record your mouse now.")
				EndIf
			Else
				MsgBox(16, 'Error', "I'm sorry :'(, the program can't start record your mouse now.")
			EndIf
		Else
			_StopReplay()
		EndIf
	Else
		_StopRecord()
	EndIf
	Else
		_Change_Color()
EndIf
EndFunc   ;==>_Button1
Func _Button3()
	If $RECORD_MODE = 0 Then
		If $REPLAY_MODE <> 0 Then _Button1()
		_SaveSetting()
		Exit
	Else
		FileClose($fo)
		GUICtrlSetData($button1, '🔴 Record')
		GUICtrlSetData($button2, '▶ Replay')
		GUICtrlSetData($button3, '❌ Exit')
		GUICtrlSetData($title, 'Mouse Recorder')
		$RECORD_MODE = 0
	EndIf
EndFunc   ;==>_Button3
#EndRegion Button Event

#Region Record and Replay Func
Func _LoadSetting()
	if GUICtrlRead($button1) == '🔴 Record' Then
		GUICtrlSetData($button1,'🎨 Color')
		GUICtrlSetData($button2,'📐 Size')
		Else
		GUICtrlSetData($button1, '🔴 Record')
		GUICtrlSetData($button2, '▶ Replay')
	EndIf
EndFunc

Func _StopRecord()
	; trả về trạng thái mặc định
	_SetDeffaultGUI()
	Do
		$save = FileSaveDialog('Save File', "", "Mouse Record File (*.mrecord)")
	Until Not @error
	FileClose($fo)
	If $RECORD_PASSWORD = '' Then
		FileCopy(@TempDir & '\AutoIT_Mouse_Record.txt', $save, 1)
	Else
		_Crypt_EncryptFile(@TempDir & '\AutoIT_Mouse_Record.txt', $save, $RECORD_PASSWORD, $CALG_RC4)
	EndIf
	FileDelete(@TempDir & '\AutoIT_Mouse_Record.txt')
	$RECORD_MODE = 0
EndFunc   ;==>_StopRecord
Func _StopReplay()
	FileClose($fo)
	; trả về trạng thái mặc định
	_SetDeffaultGUI()
	If _IsPressed(02) Then MouseUp('right')
	If _IsPressed(01) Then MouseUp('left')
	$REPLAY_MODE = 0
EndFunc   ;==>_StopReplay
Func _StartRecord()
	; đặt các giá trị hotkey theo setting cũ
	For $i = 0 To 2
		$HOTKEY[$i] = RegRead('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Record_Hotkey' & $i) = '' ? 'F' & 10 - $i : RegRead('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Record_Hotkey' & $i)
		If Not _CheckHotKey($HOTKEY[$i]) Then $HOTKEY[$i] = 'F' & 10 - $i
	Next
	; trả về trạng thái mặc định
	_SetDeffaultGUI()

	; đổi các text label
	GUICtrlSetState($next_setting,$GUI_HIDE)
	GUICtrlSetData($button1, '🔲 Stop')
	GUICtrlSetData($button2, '❚❚ Pause')
	GUICtrlSetData($button3, '❌ Cancel')
	; lấy hex hotkey
	Local $tach = StringSplit($HOTKEY[3], ',')
	For $i = 0 To 2
		For $j = 1 To Int($tach[0] / 2)
			If $HOTKEY[$i] = $tach[$j] Then $HOTKEY[$i] = $tach[$j + 12]
		Next
	Next
	; chạy đếm ngược
	For $i = 1 To 3
		GUICtrlSetData($title, 'Record in ' & 4 - $i)
		Sleep(1000)
	Next
	; set các giá trị record
	$RECORD_MODE = 1 ; bật chế độ record
	$RECORD_LAST_POS = 0 ; lấy thông tin trước của lần record hiện tại
	$time_delay = 1 ; số lần delay đứng yên của chuột
	$time_init = TimerInit() ; tính giờ
	$time_recoder = 0 ; tính giờ
EndFunc   ;==>_StartRecord
Func _StartReplay()
	; đặt các giá trị hotkey theo setting cũ
	For $i = 0 To 2
		$HOTKEY[$i] = RegRead('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Replay_Hotkey' & $i) = '' ? 'F' & 10 - $i : RegRead('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Replay_Hotkey' & $i)
		If Not _CheckHotKey($HOTKEY[$i]) Then $HOTKEY[$i] = 'F' & 10 - $i
	Next
	; lấy hex hotkey
	Local $tach = StringSplit($HOTKEY[3], ',')
	For $i = 0 To 2
		For $j = 1 To Int($tach[0] / 2)
			If $HOTKEY[$i] = $tach[$j] Then $HOTKEY[$i] = $tach[$j + 12]
		Next
	Next
	; trả về trạng thái mặc định
	_SetDeffaultGUI()

	; đổi các text label
	GUICtrlSetState($next_setting,$GUI_HIDE)
	GUICtrlSetData($button1, '🔲 Stop')
	GUICtrlSetData($button2, '❚❚ Pause')
	GUICtrlSetData($button3, '❌ Exit')
	; bắt đầu replay

	$REPLAY_LINE = _FileCountLines($fo)
	$fo = FileOpen($fo)
	If Not @error Then
		For $i = 1 To 3
			GUICtrlSetData($title, 'Replay in ' & 4 - $i)
			Sleep(1000)
		Next
		$REPLAY_I = 2 ; số dòng
		$REPLAY_MODE = 1 ; bật chế độ replay
		$time_delay = 1 ; delay chuột như record
		$time_init = TimerInit() ; tính giờ
		$time_recoder = 0 ; tính giờ
	Else
		MsgBox(16, 'Error', "I'm sorry :'(, the program can't replay this record file.")
	EndIf

EndFunc   ;==>_StartReplay
#EndRegion Record and Replay Func

#Region Setting Record and Replay Event
Func _StartSetting()
	GUICtrlSetState($next_setting,$GUI_SHOW)
	GUICtrlSetData($next_setting,'Cancel')
	GUICtrlSetOnEvent($next_setting,'_StopReplay')
	; set text label
	GUICtrlSetData($title, $RECORD_MODE = 3 ? "Setting Recorder?" : "Setting Replay?")
	; hide button 1
	GUICtrlSetState($button1, $GUI_HIDE)
	GUICtrlSetState($o1, $GUI_HIDE)
	; set yes and no button
	GUICtrlSetData($button2, '✔ YES')
	GUICtrlSetOnEvent($button2, '_SettingHotKey1')
	GUICtrlSetData($button3, '❌ NO')

	; set event button no
	If $RECORD_MODE = 3 Then
		GUICtrlSetOnEvent($button3, '_StartRecord')
	Else
		GUICtrlSetOnEvent($button3, '_SettingPass')
		GUICtrlSetData($input_setting, 1) ; set setting replay time nếu replay chọn no setting
	EndIf

	; set deffault value
	$RECORD_PASSWORD = '' ; pass to replay or record
	$REPLAY_TIMES = 1 ; replay times

	; đặt các giá trị hotkey theo setting cũ
	If $RECORD_MODE = 3 Then
		For $i = 0 To 2
			$HOTKEY[$i] = RegRead('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Record_Hotkey' & $i) = '' ? 'F' & 10 - $i : RegRead('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Record_Hotkey' & $i)
			If Not _CheckHotKey($HOTKEY[$i]) Then $HOTKEY[$i] = 'F' & 10 - $i
		Next
	Else
		For $i = 0 To 2
			$HOTKEY[$i] = RegRead('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Replay_Hotkey' & $i) = '' ? 'F' & 10 - $i : RegRead('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Replay_Hotkey' & $i)
			If Not _CheckHotKey($HOTKEY[$i]) Then $HOTKEY[$i] = 'F' & 10 - $i
		Next
	EndIf

EndFunc   ;==>_StartSetting
Func _SettingHotKey1()
	GUICtrlSendMsg($input_setting, $EM_SETPASSWORDCHAR, Asc(''), 0) ; set input not password

	GUICtrlSetState($button2, $GUI_HIDE)
	GUICtrlSetState($o2, $GUI_HIDE)
	GUICtrlSetState($o_setting, $GUI_SHOW)
	GUICtrlSetState($input_setting, $GUI_SHOW)

	GUICtrlSetData($title, 'Hotkey to stop')
	GUICtrlSetData($input_setting, $HOTKEY[0])
	GUICtrlSetData($button3, '✔ OK')
	GUICtrlSetOnEvent($button3, '_SettingHotKey2')
EndFunc   ;==>_SettingHotKey1
Func _SettingHotKey2()
	If Not _CheckHotKey(GUICtrlRead($input_setting)) Then
		MsgBox(16, 'Error', "You can't use this hotkey. The hotkey must be F1 to F12")
		Return 0
	EndIf
	If $RECORD_MODE = 3 Then
		RegWrite('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Record_Hotkey0', 'REG_SZ', GUICtrlRead($input_setting))
	Else
		RegWrite('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Replay_Hotkey0', 'REG_SZ', GUICtrlRead($input_setting))
	EndIf

	GUICtrlSetData($title, 'Pause and Resume')
	GUICtrlSetData($input_setting, $HOTKEY[1])
	GUICtrlSetData($button3, '✔ OK')
	GUICtrlSetOnEvent($button3, '_SettingHotKey3')
EndFunc   ;==>_SettingHotKey2
Func _SettingHotKey3()
	If Not _CheckHotKey(GUICtrlRead($input_setting)) Then
		MsgBox(16, 'Error', "You can't use this hotkey. The hotkey must be F1 to F12")
		Return 0
	EndIf
	If $RECORD_MODE = 3 Then
		RegWrite('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Record_Hotkey1', 'REG_SZ', GUICtrlRead($input_setting))
	Else
		RegWrite('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Replay_Hotkey1', 'REG_SZ', GUICtrlRead($input_setting))
	EndIf

	GUICtrlSetData($title, $RECORD_MODE = 3 ? 'Hotkey to cancel' : 'Hotkey to Exit')
	GUICtrlSetData($input_setting, $HOTKEY[2])
	GUICtrlSetData($button3, '✔ OK')

	if $RECORD_MODE = 3  Then
		GUICtrlSetOnEvent($button3, '_SettingPass')
		Else
		GUICtrlSetOnEvent($button3, '_SettingTimesToReplay')
	EndIf
EndFunc   ;==>_SettingHotKey3
Func _Finish_SettingHotKey()
	$RECORD_PASSWORD = GUICtrlRead($input_setting)
	If $RECORD_MODE = 3 Then
		_StartRecord()
	Else
		Local $temp = $fo
		If $RECORD_PASSWORD <> '' Then
			FileDelete(@TempDir & '\AutoIT_Mouse_Record.txt')
			_Crypt_DecryptFile($fo, @TempDir & '\AutoIT_Mouse_Record.txt', $RECORD_PASSWORD, $CALG_RC4)
			$fo = @TempDir & '\AutoIT_Mouse_Record.txt'
		EndIf
		If FileReadLine($fo, 1) <> 'MOUSE_RECORDER_BY_OPDO.TOP' Then
			MsgBox(16, 'Error', 'Wrong password or the file is incorrupt')
			$fo = $temp
			_StopReplay()
			Return 0
		EndIf
		_StartReplay()
	EndIf
EndFunc   ;==>_Finish_SettingHotKey
Func _SettingTimesToReplay()
	; save old setting
	If Not _CheckHotKey(GUICtrlRead($input_setting)) Then
		MsgBox(16, 'Error', "You can't use this hotkey. The hotkey must be F1 to F12")
		Return 0
	EndIf
	If $RECORD_MODE = 3 Then
		RegWrite('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Record_Hotkey2', 'REG_SZ', GUICtrlRead($input_setting))
	Else
		RegWrite('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Replay_Hotkey2', 'REG_SZ', GUICtrlRead($input_setting))
	EndIf

	GUICtrlSetData($input_setting,1)
	GUICtrlSetData($title, 'Replay times')
	GUICtrlSetData($button3, '✔ OK')
	GUICtrlSetOnEvent($button3, '_SettingPass')
EndFunc
Func _SettingPass()
	if $RECORD_MODE = 3  Then
		If Not _CheckHotKey(GUICtrlRead($input_setting)) Then
			MsgBox(16, 'Error', "You can't use this hotkey. The hotkey must be F1 to F12")
			Return 0
		EndIf
		RegWrite('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Record_Hotkey2', 'REG_SZ', GUICtrlRead($input_setting))
	Else
		If Number(GUICtrlRead($input_setting)) < 1 Then
			MsgBox(16,'Errror','Replay times must be greater than 0')
			Return 0
		EndIf
	EndIf
	$REPLAY_TIMES = Number(GUICtrlRead($input_setting))
	GUICtrlSetData($input_setting, '')
	If $RECORD_MODE = 0 Then
		If FileReadLine($fo) == 'MOUSE_RECORDER_BY_OPDO.TOP' Then
			_Finish_SettingHotKey()
			Return 0
		EndIf
	EndIf

	GUICtrlSendMsg($input_setting, $EM_SETPASSWORDCHAR, Asc('*'), 0)  ; set input password

	GUICtrlSetState($button2, $GUI_HIDE)
	GUICtrlSetState($o2, $GUI_HIDE)
	GUICtrlSetState($o_setting, $GUI_SHOW)
	GUICtrlSetState($input_setting, $GUI_SHOW)
	GUICtrlSetState($next_setting,$GUI_SHOW)
	GUICtrlSetData($next_setting,'Cancel')
	GUICtrlSetOnEvent($next_setting,'_StopReplay')


	ControlFocus($GUI, "", $input_setting)

	GUICtrlSetData($title, $RECORD_MODE = 3 ? 'Password (if needed)' : 'Password to replay')
	GUICtrlSetData($button3, '✔ OK')
	GUICtrlSetOnEvent($button3, '_Finish_SettingHotKey')
EndFunc   ;==>_SettingPass
#EndRegion Setting Record and Replay Event

#Region Other func
Func _Change_Size($i_size = -1)
		Local $gui_pos = WinGetPos($GUI)
		Local $size[6] = [353,177,300,150,250,125]
		if $i_size = -1 Then
			For $i = 0 to 5
				if Number($size[$i]) >= Number($gui_pos[2])-5 and Number($size[$i]) <= Number($gui_pos[2])+5  Then
					If $i > 3 Then $i = -2
					WinMove($GUI,'',$gui_pos[0],$gui_pos[1],$size[$i+2],$size[$i+3])
					_SetSizeFont(-($i+2)*2)
					RegWrite('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Size', 'REG_SZ', $i+2)
					Return 0
				EndIf
			Next
			WinMove($GUI,'',$gui_pos[0],$gui_pos[1],$size[0],$size[1])
			_SetSizeFont(0)
			RegWrite('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Size', 'REG_SZ', 0)
		Else
			WinMove($GUI,'',$gui_pos[0],$gui_pos[1],$size[$i_size],$size[$i_size+1])
			_SetSizeFont(-$i_size*2)
		EndIf
EndFunc

Func _SetSizeFont($i)
	Local $size[7] = [24,14,14,14,10,10,25]
	GUICtrlSetFont($title,Number($size[0]+$i), 300, 0, "Segoe UI Light")
	GUICtrlSetFont($button1,Number($size[1]+$i) < 9 ? 9 : Number($size[1]+$i))
	GUICtrlSetFont($button2,Number($size[2]+$i) < 9 ? 9 : Number($size[2]+$i))
	GUICtrlSetFont($button3,Number($size[3]+$i) < 9 ? 9 : Number($size[3]+$i))
	GUICtrlSetFont($credit,Number($size[4]+$i) < 9 ? 9 : Number($size[4]+$i), 300, 0, "Segoe UI Light")
	GUICtrlSetFont($next_setting,Number($size[5]+$i) < 9 ? 9 : Number($size[5]+$i),600,0,"Segoe UI Semibold")
	GUICtrlSetFont($input_setting,Number($size[6]+$i))
EndFunc
Func _SetDeffaultGUI()
	GUICtrlSetState($button1, $GUI_SHOW)
	GUICtrlSetState($o1, $GUI_SHOW)
	GUICtrlSetState($button2, $GUI_SHOW)
	GUICtrlSetState($o2, $GUI_SHOW)
	GUICtrlSetState($button3, $GUI_SHOW)
	GUICtrlSetState($o3, $GUI_SHOW)
	GUICtrlSetState($next_setting, $GUI_SHOW)
	GUICtrlSetState($o_setting, $GUI_HIDE)
	GUICtrlSetState($input_setting, $GUI_HIDE)
	GUICtrlSetOnEvent($button3, '_Button3')
	GUICtrlSetOnEvent($button1, '_Button1')
	GUICtrlSetOnEvent($button2, '_Button2')
	GUICtrlSetOnEvent($next_setting,'_LoadSetting')
	GUICtrlSetOnEvent($credit,'_Credit')
	GUICtrlSetBkColor($button1, "-2")
	GUICtrlSetColor($button1, "0xFFFFFF")
	GUICtrlSetBkColor($button3, "-2")
	GUICtrlSetColor($button3, "0xFFFFFF")
	GUICtrlSetBkColor($button2, "-2")
	GUICtrlSetColor($button2, "0xFFFFFF")
	GUICtrlSetData($next_setting,'More')
	GUICtrlSetData($button1, '🔴 Record')
	GUICtrlSetData($button2, '▶ Replay')
	GUICtrlSetData($button3, '❌ Exit')
	GUICtrlSetData($title, 'Mouse Recorder')
	$RECORD_MODE = 0
	$REPLAY_MODE = 0
EndFunc

Func _CheckHotKey($hotkey_input) ; kiểm tra hotkey có đúng yêu cầu hay ko
	If $hotkey_input = '' Then Return False
	Local $tach = StringSplit($HOTKEY[3], ',')
	For $j = 1 To Int($tach[0] / 2)
		If $hotkey_input = $tach[$j] Then Return True
	Next
	Return False
EndFunc   ;==>_CheckHotKey
Func _Credit()
	MsgBox(64,'AutoIT Mouse Recorder v1.2','The program coded by VinhPham'&@CRLF&'Blog: http://opdo.top'&@CRLF&'Email: imopdo@opdo.top'&@CRLF&'Visit my blog to download lastest version and other my program'&@CRLF&'Tks to Valuater because _ControlHover UDF')
EndFunc   ;==>_Credit
Func _Change_Color()
	Local $tach = StringSplit($COLOR, '|')
	For $i = 1 To $tach[0]
		If String($GUI_COLOR) = String($tach[$i]) Then
			If $i = $tach[0] Then $i = 0
			$GUI_COLOR = String($tach[$i + 1])
			ExitLoop
		EndIf
	Next
	GUICtrlSetColor($button1,$GUI_COLOR)
	GUISetBkColor($GUI_COLOR, $GUI)
	GUICtrlSetBkColor($input_setting, $GUI_COLOR)
	RegWrite('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Color', 'REG_SZ', $GUI_COLOR)
EndFunc   ;==>_Change_Color
Func _SaveSetting()
	RegWrite('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'Color', 'REG_SZ', $GUI_COLOR)
	$gui_pos = WinGetPos($GUI)
	If @error Then Return 0
	RegWrite('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'GUI_POS_X', 'REG_SZ', $gui_pos[0])
	RegWrite('HKEY_CURRENT_USER\SOFTWARE\opdo\Mouse Recorder', 'GUI_POS_Y', 'REG_SZ', $gui_pos[1])
EndFunc   ;==>_SaveSetting
#EndRegion Other func
