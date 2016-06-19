#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.2.12.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

#include <GUIConstants.au3>
#include <EditConstants.au3>

;#include <memory2.au3>
;#include <string.au3>

Opt("WinTitleMatchMode", 4)

$title = "Pinball, Space Cadet | Trainer by kris"
$title_a = 0
$title_b = "Pinball, Space Cadet | Trainer by kris"
$Process = WinGetProcess($title_b, "")
$Score_p1 = 0
$freeze_score_p1 = 0
$Score_p1_freeze_on = 0
$Score_p1_freeze_c1 = 0
$Balls_p1 = 0
$Players = 0

$Score_p1_Read = 0
$CheatMode = 0
$Not_running = 1
$loop = 0

$Mem_Players = "01028234"

$Mem_Balls_p1 = "00C4AE9E"
$Mem_Balls_p1_offset = 0

$Mem_Score_p1 = "00C4AEBA"

GUICreate("Pinball Space Cadet Trainer", 390, 335, -1, -1)
Opt("GUIOnEventMode", 1)
GUISetOnEvent($GUI_EVENT_CLOSE, "Quit")

;GUISetOnEvent($GUI_EVENT_MINIMIZE, "SpecialEvents")
;GUISetOnEvent($GUI_EVENT_RESTORE, "SpecialEvents")

;Options
;Opt("GUICoordMode",1)
;Opt("GUIResizeMode", 1)


$menu1 = GUICtrlCreateMenu("Start")
$menu1_item1 = GUICtrlCreateMenuitem("Launch game", $menu1)
GUICtrlSetOnEvent(-1, "game")
$menu1_item1 = GUICtrlCreateMenuitem("Exit", $menu1)
GUICtrlSetOnEvent(-1, "Quit")

GUICtrlCreateButton("Enable/Disable Cheat Mode", 12, 290, 160, 20)
GUICtrlSetOnEvent(-1, "CheatMode")
GUICtrlCreateButton("About", 184, 290, 90, 20)
GUICtrlSetOnEvent(-1, "About")
GUICtrlCreateButton("Exit", 290, 290, 90, 20)
GUICtrlSetOnEvent(-1, "Quit")

GUICtrlCreateLabel("players:", 10, 10, 40, 15)
GUICtrlCreateGroup("Player 1", 10, 30, 370, 70)
GUICtrlCreateLabel("ball nr:", 20, 70, 50, 15)
GUICtrlCreateLabel("score:", 20, 50, 40, 15)
$label_Players = GUICtrlCreateLabel($Players, 60, 10, 50, 15)
$Label_p1_Score = GUICtrlCreateLabel($Score_p1, 65, 50, 140, 15)
$Label_p1_Balls = GUICtrlCreateLabel($Balls_p1, 65, 70, 140, 15)

$Input_p1_Score_edit = GUICtrlCreateInput($Score_p1, 200, 38, 140, 20, $ES_NUMBER)
$Button_p1_Score_set = GUICtrlCreateButton("Set", 345, 58, 30, 15)
GUICtrlSetOnEvent(-1, "Score_p1_Write")
$Button_p1_Score_freeze = GUICtrlCreateButton("Freeze", 325, 50, 30, 15)
GUICtrlDelete($Input_p1_Score_edit)
GUICtrlDelete($Button_p1_Score_set)
GUICtrlDelete($Button_p1_Score_freeze)

$Input_p1_Balls_edit = GUICtrlCreateInput($Balls_p1, 200, 58, 140, 20, $ES_NUMBER)
$Button_p1_Balls_set = GUICtrlCreateButton("Set", 345, 78, 30, 15)
GUICtrlSetOnEvent(-1, "Balls_p1_Write")
$Button_p1_Balls_freeze = GUICtrlCreateButton("Freeze", 325, 50, 30, 15)
GUICtrlDelete($Input_p1_Balls_edit)
GUICtrlDelete($Button_p1_Balls_set)
GUICtrlDelete($Button_p1_Balls_freeze)

Func game()
   If $Process = -1 Then
      Run(@HomeDrive & "\Program Files\Windows NT\Pinball\PINBALL.EXE", @HomeDrive & "\Program Files\Windows NT\Pinball")
   EndIf
EndFunc   ;==>game

Func Quit()

   ;Select
   ;Case @GUI_CTRLID = $GUI_EVENT_CLOSE
   If WinExists($title_b) Then WinSetTitle($title_b, "", $title)
   Exit
   ;Case @GUI_CTRLID = $GUI_EVENT_MINIMIZE
   ;Case @GUI_CTRLID = $GUI_EVENT_RESTORE
   ;EndSelect

EndFunc   ;==>Quit

Func About()
   GUISetState(@SW_HIDE)
   MsgBox(0, "3D Pinball Space Cadet Trainer", "A creation by Kris" & @CRLF & "Tested on Windows XP Media Center" & @CRLF & "For more information or help e-mail:" & @CRLF & "dellairion@hotmail.com")
   GUISetState(@SW_SHOW)
EndFunc   ;==>About

Func CheatMode()
   If $CheatMode = 0 Then

      If $Process = -1 Then
         MsgBox(0, "3D Pinball Space Cadet Trainer", "      Please start the game")
      Else
         $CheatMode = 1
      EndIf

      If $CheatMode = 1 Then
         $Not_running = 0
         $Input_p1_Score_edit = GUICtrlCreateInput($Score_p1, 170, 48, 120, 20, $ES_NUMBER)
         $Button_p1_Score_set = GUICtrlCreateButton("Set", 295, 50, 30, 15)
         GUICtrlSetOnEvent(-1, "Score_p1_Write")
         $Button_p1_Score_freeze = GUICtrlCreateButton("Freeze", 325, 50, 50, 15)
         GUICtrlSetOnEvent(-1, "Score_p1_Freeze")

         $Input_p1_Balls_edit = GUICtrlCreateInput("Not working yet", 170, 68, 120, 20, $ES_NUMBER) ;$Balls_p1
         $Button_p1_Balls_set = GUICtrlCreateButton("Set", 295, 70, 30, 15)
         GUICtrlSetOnEvent(-1, "Balls_p1_Write")
         $Button_p1_Balls_freeze = GUICtrlCreateButton("Freeze", 325, 70, 50, 15)
      EndIf

   ElseIf $CheatMode = 1 Then
      GUICtrlDelete($Input_p1_Score_edit)
      GUICtrlDelete($Button_p1_Score_set)
      GUICtrlDelete($Button_p1_Score_freeze)
      GUICtrlDelete($Input_p1_Balls_edit)
      GUICtrlDelete($Button_p1_Balls_set)
      GUICtrlDelete($Button_p1_Balls_freeze)
      $CheatMode = 0
   EndIf
EndFunc   ;==>CheatMode

Func Read()
   $M_open = _MemoryOpen($Process)
   $Players = _MemoryRead($M_open, "0x" & $Mem_Players)
   $Score_p1 = _MemoryRead($M_open, "0x" & $Mem_Score_p1)
   ;$Balls_p1 = _MemoryPointerRead($M_open, "0x" & "00C4AE9E", 0)
   ;$Balls_p1 = _MemoryRead($M_open, $Mem_Balls_p1)


   $Balls_p1a = _MemoryRead($M_open, "0x" & $Mem_Balls_p1)
   $Balls_p1b = '0x' & Hex($Balls_p1a + $Mem_Balls_p1_offset)
   $Balls_p1 = _MemoryRead($M_open, $Balls_p1b)
   _MemoryClose($M_open)

   ;$Players = Asc($Playersa)
   ;$Balls_p1 = Abs(Asc($Balls_p1a) - 3)
   ;$Score_p1 = Dec($Score_p1a)

   ;If StringLen ($Score_p1a) > 6 Then
   ;   $Score_p1 = _StringInsert ($Score_p1a, "___", 2)
   ;Else
   ;   $Score_p1 = $Score_p1a
   ;EndIf
EndFunc   ;==>Read

Func Score_p1_Write()
   If $Score_p1_freeze_c1 = 1 Then
      $Score_p1_Read = $freeze_score_p1
      $Score_p1_freeze_c1 = 0
      ConsoleWrite($freeze_score_p1 & @CR)
   Else
      $Score_p1_Read = GUICtrlRead($Input_p1_Score_edit)
   EndIf

   $M_open = _MemoryOpen($Process)
   _MemoryWrite($M_open, "0x" & $Mem_Score_p1, "0x" & Hex($Score_p1_Read))
   _MemoryClose($M_open)
   $freeze_score_p1 = $Score_p1_Read
EndFunc   ;==>Score_p1_Write

Func Balls_p1_Write()
   $Balls_p1_Read = GUICtrlRead($Input_p1_Balls_edit)
   $M_open = _MemoryOpen($Process)
   $Balls_p1a = _MemoryRead($M_open, "0x" & $Mem_Balls_p1)
   $Balls_p1b = '0x' & Hex($Balls_p1a + $Mem_Balls_p1_offset)
   _MemoryWrite($M_open, $Balls_p1b, "0x" & Hex($Balls_p1_Read))

   ;_MemoryWrite($M_open, "0x" & $Mem_Balls_p1, "0x" & Hex($Balls_p1_Read))
   _MemoryClose($M_open)
EndFunc   ;==>Balls_p1_Write

Func Score_p1_Freeze()
   If $Score_p1_freeze_on = 0 Then
      $freeze_score_p1 = $Score_p1
      $Score_p1_freeze_on = 1
   Else
      $Score_p1_freeze_on = 0
   EndIf
   ConsoleWrite($Score_p1_freeze_on & @CR)
EndFunc   ;==>Score_p1_Freeze

GUISetState(@SW_SHOW)
While 1
   $Process = WinGetProcess($title_b, "")
   If WinExists("3D Pinball") Then
      $title = WinGetTitle("3D Pinball")
      WinSetTitle($title, "", $title_b)
   EndIf
   ;$loop += 1
   ;If $loop = 10 Then
   Read()
   ;   $loop = 0
   ;EndIf
   GUICtrlSetData($label_Players, $Players)
   GUICtrlSetData($Label_p1_Score, $Score_p1)
   GUICtrlSetData($Label_p1_Balls, $Balls_p1)

   If $Process = -1 And $Not_running = 0 Then
      CheatMode()
      $Not_running = 1
   EndIf

   If $Score_p1_freeze_on = 1 Then
      If $CheatMode = 0 Then $Score_p1_freeze_on = 0
      If $Score_p1 <> $freeze_score_p1 Then
         $Score_p1_freeze_c1 = 1
         Score_p1_Write()
      EndIf
   EndIf

   Sleep(300)
WEnd

#Region MEM

Func _MemoryOpen($iv_Pid, $iv_DesiredAccess = 0x1F0FFF, $if_InheritHandle = 1)

   If Not ProcessExists($iv_Pid) Then
      SetError(1)
      Return 0
   EndIf

   Local $ah_Handle[2] = [DllOpen('kernel32.dll') ]

   If @error Then
      SetError(2)
      Return 0
   EndIf

   Local $av_OpenProcess = DllCall($ah_Handle[0], 'int', 'OpenProcess', 'int', $iv_DesiredAccess, 'int', $if_InheritHandle, 'int', $iv_Pid)

   If @error Then
      DllClose($ah_Handle[0])
      SetError(3)
      Return 0
   EndIf

   $ah_Handle[1] = $av_OpenProcess[0]

   Return $ah_Handle

EndFunc   ;==>_MemoryOpen


Func _MemoryRead($ah_Handle, $iv_Address, $sv_Type = 'dword')

   If Not IsArray($ah_Handle) Then
      SetError(1)
      Return 0
   EndIf

   Local $v_Buffer = DllStructCreate($sv_Type)

   If @error Then
      SetError(@error + 1)
      Return 0
   EndIf

   DllCall($ah_Handle[0], 'int', 'ReadProcessMemory', 'int', $ah_Handle[1], 'int', $iv_Address, 'ptr', DllStructGetPtr($v_Buffer), 'int', DllStructGetSize($v_Buffer), 'int', '')

   If Not @error Then
      Local $v_Value = DllStructGetData($v_Buffer, 1)
      Return $v_Value
   Else
      SetError(6)
      Return 0
   EndIf

EndFunc   ;==>_MemoryRead


Func _MemoryWrite($ah_Handle, $iv_Address, $v_Data, $sv_Type = 'dword')

   If Not IsArray($ah_Handle) Then
      SetError(1)
      Return 0
   EndIf

   Local $v_Buffer = DllStructCreate($sv_Type)

   If @error Then
      SetError(@error + 1)
      Return 0
   Else
      DllStructSetData($v_Buffer, 1, $v_Data)
      If @error Then
         SetError(6)
         Return 0
      EndIf
   EndIf

   DllCall($ah_Handle[0], 'int', 'WriteProcessMemory', 'int', $ah_Handle[1], 'int', $iv_Address, 'ptr', DllStructGetPtr($v_Buffer), 'int', DllStructGetSize($v_Buffer), 'int', '')

   If Not @error Then
      Return 1
   Else
      SetError(7)
      Return 0
   EndIf

EndFunc   ;==>_MemoryWrite


Func _MemoryClose($ah_Handle)

   If Not IsArray($ah_Handle) Then
      SetError(1)
      Return 0
   EndIf

   DllCall($ah_Handle[0], 'int', 'CloseHandle', 'int', $ah_Handle[1])
   If Not @error Then
      DllClose($ah_Handle[0])
      Return 1
   Else
      DllClose($ah_Handle[0])
      SetError(2)
      Return 0
   EndIf

EndFunc   ;==>_MemoryClose

#endregion 