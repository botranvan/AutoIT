#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <ProgressConstants.au3>
#include <WindowsConstants.au3>
#include <NomadMemory.au3>
;~ #include "Talisman-auto.au3"

Global $botauto
Global $Programe = "ThucSon"
Global $Process = WinGetProcess($Programe)
Global $game = _MemoryOpen($Process)
;~ Global $pointer =  0x00EB7EE0 ; Base address US ver: 0x00eb2c3c 0x10C
Global $pointer =  0x00EC53E0 ; Base address US ver: 0x00eb2c3c
Global $CurHp = 0x740 ; Current HP
Global $CurMp = 0x744 ; Current MP
Global $MaxHp = 0x47C ; Max HP in this lvl
Global $MaxMp = 0x6ec ; Max MP in this lvl
Global $level = 0x74C ; Current Character Level
Global $CurEXP = 0x750
Global $CurX = 0x5c

Global $run = 1
Global $msg
Global $logs ; Log all what i do

Global $restkey[2]
Global $skillkey[3]
Global $Restper[2]
HotKeySet("{PAUSE}", "stopbot")



TraySetIcon("C:\Program Files\TalismanOnline\game.exe")

$Form1 = GUICreate("Talisman Auto V0.1", 265, 270, 304, 186)
GUISetIcon("C:\Program Files\TalismanOnline\game.exe")
$Talisman = GUICtrlCreateTab(8, 8, 252, 256)
GUICtrlSetResizing(-1, $GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$Attack = GUICtrlCreateTabItem("Thiết lập")
$Skill1 = GUICtrlCreateLabel("Kĩ năng 1", 24, 58, 55, 18, $SS_CENTER)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
;GUICtrlSetBkColor(-1, 0x008080)
$Skill2 = GUICtrlCreateLabel("Kĩ năng 2", 24, 90, 55, 18, $SS_CENTER)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
;GUICtrlSetBkColor(-1, 0x008000)
$Skill3 = GUICtrlCreateLabel("Kĩ năng 3", 24, 122, 55, 18, $SS_CENTER)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
;GUICtrlSetBkColor(-1, 0xA6CAF0)

GUICtrlCreateLabel("Dùng:", 24, 168, 50, 18, $SS_CENTER)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
GUICtrlCreateLabel("khi HP <", 118, 170, 70, 18)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
GUICtrlCreateLabel("%", 218, 170, 14, 18)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")

GUICtrlCreateLabel("Dùng:", 24, 198, 50, 18, $SS_CENTER)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
GUICtrlCreateLabel("khi MP <", 118, 200, 70, 18)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
GUICtrlCreateLabel("%", 218, 200, 14, 18)
GUICtrlSetFont(-1, 10, 400, 0, "Arial")

$skillkey[0] = GUICtrlCreateCombo("1", 88, 56, 97, 25)
GUICtrlSetData(-1, "2|3|4|5|6|7|8|9|0", "1")
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
$skillkey[1] = GUICtrlCreateCombo("2", 88, 88, 97, 25)
GUICtrlSetData(-1, "3|4|5|6|7|8|9|0", "0")
GUICtrlSetFont(-1, 10, 400, 0, "Arial")
$skillkey[2] = GUICtrlCreateCombo("3", 88, 120, 97, 25)
GUICtrlSetData(-1, "4|5|6|7|8|9|0", "0")
GUICtrlSetFont(-1, 10, 400, 0, "Arial")

; 0 = HP ;; 1 = MP
$restkey[0] = GUICtrlCreateCombo("0", 74, 166, 40, 20)
GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9", "0")
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
$restkey[1] = GUICtrlCreateCombo("0", 74, 196, 40, 20)
GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9", "7")
GUICtrlSetFont(-1, 8, 400, 0, "Arial")

$Restper[0] = GUICtrlCreateInput("90", 184, 168, 30, 20)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
$Restper[1] = GUICtrlCreateInput("40", 184, 198, 30, 20)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")

$Info = GUICtrlCreateTabItem("Nhân vật")
GUICtrlCreateLabel("Nhân vật:", 24, 48, 60, 18)
GUICtrlSetFont(-1, 8, 800, 0, "Arial")
$Character = GUICtrlCreateLabel("Chưa xác định", 86, 48, 200, 18)
GUICtrlSetFont(-1, 8, 800, 0, "Arial")

$Lvl = GUICtrlCreateLabel("Level:", 24, 72, 50, 18)
GUICtrlSetFont(-1, 8, 800, 0, "Arial")
$Levelinfo = GUICtrlCreateLabel("0", 80, 72, 120, 14)
GUICtrlSetFont(-1, 9, 800, 0, "Arial")

GUICtrlCreateLabel("Sinh lực:", 24, 96, 49, 18)
GUICtrlSetFont(-1, 8, 1000, 0, "Arial")

$HPpro = GUICtrlCreateProgress(80, 96, 154, 18, $PBS_SMOOTH)
GUICtrlSetColor(-1, 0xF03B26)
$HPinfo = GUICtrlCreateLabel("0 / 0", 80, 98, 154, 18, $SS_CENTER)
GUICtrlSetFont(-1, 8, 10000, 0, "Arial")


GUICtrlCreateLabel("Thể lực:", 24, 120, 50, 18)
GUICtrlSetFont(-1, 8, 1000, 0, "Arial")

$MPpro = GUICtrlCreateProgress(80, 120, 154, 18, $PBS_SMOOTH)
GUICtrlSetColor(-1, 0x49B0F5)
$MPinfo = GUICtrlCreateLabel("0 / 0", 80, 122, 154, 18, $SS_CENTER)
GUICtrlSetColor( $MPinfo, 0x000000)
GUICtrlSetFont(-1, 8, 10000, 0, "Arial")


$History = GUICtrlCreateTabItem("Thông Tin")
GUICtrlSetState(-1,$GUI_SHOW)
$Log = GUICtrlCreateEdit("", 16, 40, 233, 185, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_WANTRETURN))

GUICtrlSetData(-1, "")
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateTabItem("")
$Bot = GUICtrlCreateButton("&Chạy", 14, 232, 75, 25, 0)
$Exit = GUICtrlCreateButton("&Thoát", 94, 232, 75, 25, 0)
$Help = GUICtrlCreateButton("&Help", 176, 232, 75, 25, 0)
Call("set_data")	


GUISetState(@SW_SHOW)

Do
	set_data()
	$msg = GUIGetMsg()	
	If $msg == $Exit Or $msg == $Exit Then
		Exit 0
	If $msg == $Help Then
		Help()
	EndIf		
	Else
		If $msg == $Bot And $run == 1 Then
			GUICtrlSetData($BOT, "&Dừng")
			$run = 0
			;Call("SelectBot")
		ElseIf $msg == $Bot And $run == 0 Then
			GUICtrlSetData($BOT, "&Chạy")
			$run = 1
			;Call("stopbot")
		EndIf			
	EndIf		
Until $msg = $GUI_EVENT_CLOSE Or $msg = $Exit

Func stopbot()
	While $botauto
		Sleep(100)
		ToolTip('Auto is "Paused"',0,0)
	WEnd
	ToolTip('')
EndFunc


Func set_data()	
	
	GUICtrlSetData($Levelinfo, Char_data($level))
	GUICtrlSetData($HPpro, Round((Char_data($CurHp)	 * 100) / Char_data($MaxHp)))	
	GUICtrlSetData($MPpro, Round((Char_data($CurMp)	 * 100) / Char_data($MaxMp)))
	GUICtrlSetData($Hpinfo, Char_data($CurHp) & " / " & Char_data($MaxHp))
	GUICtrlSetData($Mpinfo, Char_data($CurMp) & " / " & Char_data($MaxMp))
	
EndFunc

Func _FindNewAddress($Pointer, $Oset)
Return '0x' & Hex(_MemoryRead($Pointer,$game) + $Oset, 8)
EndFunc

Func Char_data($ofset,$type=0)
;~ 	$readpointer = '0x' & Hex(_MemoryRead($Pointer, $game) + 0x10C,8)
	$readpointer = $Pointer
	$readinfo = _FindNewAddress($readpointer, $ofset)
	Return _MemoryRead($readinfo, $game)
	If $type == "float" Then
	Return Floor(_MemoryRead($readinfo, $game, $type))
	Elseif $type == "char" Then
	Return _MemoryRead($readinfo, $game, "char[24]")
	Else
	Return _MemoryRead($readinfo, $game)
	EndIf
EndFunc

Func Addlog($text)
	$count += 1
		$logs &= $text & @LF 
			$logs = StringAddCR($logs)
	GUICtrlSetData($Log, $logs )
		If $count > 8 Then
				$count = 0
			$logs = ""		
		EndIf
EndFunc

Func Help()
	MsgBox("","Bot is still writng","Please wait")
EndFunc