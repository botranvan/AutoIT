#include <GUIConstants.au3>
#include <StaticConstants.au3>
#include <NomadMemory.au3>
#include <string.au3>

Opt("GUIOnEventMode", 1)
Opt("GUIDataSeparatorChar", "/")
GUICreate("Tool debug", 465, 161, 191, 124)
GUICtrlCreateLabel("Địa chỉ bộ nhớ", 30, 32, 137, 17)
$Add_Mem_D = GUICtrlCreateInput("", 144, 32, 113, 21)
GUICtrlCreateLabel("Hex", 272, 8, 23, 17)
GUICtrlCreateLabel("Dec", 302, 10, 24, 17)
GUICtrlCreateLabel("Hex/Dec output", 346, 2, 103, 25)
$Hex1_D = GUICtrlCreateRadio("", 272, 32, 17, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Dec1_D = GUICtrlCreateRadio("", 304, 32, 17, 17)
$Group1 = GUICtrlCreateGroup("", 264, 24, 65, 33)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Read1_D = GUICtrlCreateButton("Đọc", 408, 32, 41, 25, 0)
	GUICtrlSetOnEvent(-1, "Read1")
GUICtrlCreateLabel("Offset", 49, 66, 32, 17)
$Add_Offset_D = GUICtrlCreateInput("", 144, 61, 113, 21)
$Group2 = GUICtrlCreateGroup("", 264, 58, 65, 33)
$Hex2_d = GUICtrlCreateRadio("Radio1", 272, 68, 17, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Dec2_d = GUICtrlCreateRadio("Radio2", 304, 69, 17, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Group4 = GUICtrlCreateGroup("", 340, 60, 65, 33)
$Hex4_D = GUICtrlCreateRadio("", 347, 70, 17, 17)
$Dec4_D = GUICtrlCreateRadio("", 376, 71, 17, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Value_Type_D = GUICtrlCreateCombo("", 344, 32, 57, 25)
	GUICtrlSetData(-1,"Binary/Byte/2 Bytes/4 Bytes/8 Bytes/Float/Double/Text","4 Bytes")
$Read2_D = GUICtrlCreateButton("Đọc", 408, 72, 41, 25)
	GUICtrlSetOnEvent(-1,"Read2")
GUICtrlCreateLabel("Offset từ", 8, 96, 44, 17)
$From_D = GUICtrlCreateInput("0", 64, 96, 57, 21)
GUICtrlCreateLabel("Offset đến", 141, 102, 53, 17)
$To_D = GUICtrlCreateInput("FFF", 196, 100, 57, 21)
$Group3 = GUICtrlCreateGroup("", 267, 93, 65, 33)
$Hex3_d = GUICtrlCreateRadio("", 277, 103, 17, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
$Dec3_D = GUICtrlCreateRadio("", 306, 104, 17, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$Write_D = GUICtrlCreateButton("Ghi", 408, 104, 43, 25)
	GUICtrlSetOnEvent(-1,"Write")
$Exit_D = GUICtrlCreateButton("Exit", 349, 105, 43, 25)
	GUICtrlSetOnEvent(-1,"Quit")
GUICtrlCreateLabel("Đọc từ chương trình", 8, 136, 98, 17)
$List_Process_D = GUICtrlCreateCombo("", 112, 136, 129, 25)
	GUICtrlSetData(-1,List_Process(),"ThucSon | Bбt Quбi Mфn | 1.00.02")
GUICtrlCreateLabel("Tên file ghi ra destop", 264, 136, 103, 17)
$Name_D = GUICtrlCreateInput("Diachi.txt", 376, 136, 73, 21)
GUISetState(@SW_SHOW)
Dim $Pid,$MemId,$Value_Type,$Name,$Add_Mem,$Write_Hex,$Value,$Add_Mem_Hex,$Add_Offset

While 1
$nMsg = GUIGetMsg()
If $nMsg= $GUI_EVENT_CLOSE Then Exit
Sleep(20)
WEnd
Func Read1()
	GetProcess()
	$Value = _memoryread($Add_Mem,$MemId,$Value_Type)
	if $Write_Hex Then $Value = Hex($Value)
	Msgbox(0,"Kết quả","Process :"& GUICtrlRead($List_Process_D)&@CRLF & _
	"Value type "& $Value_Type &@CRLF & _
	"Địa chỉ " & $Add_Mem &"  "& $Value )
EndFunc	
Func Read2()
	$Add_Offset = GUICtrlRead($Add_Offset_D)
	if GUICtrlRead($Hex2_d) = $GUI_CHECKED Then $Add_Offset = StringtoHex($Add_Offset)   ; nếu offset là hex thì đổi thành số hex
	GetProcess()
	$Add_Mem += $Add_Offset  ;tăng giá trị bộ nhớ với offset
	$Value = _memoryread($Add_Mem,$MemId,$Value_Type)
	if $Write_Hex Then $Value = Hex($Value)
	$Add_Offset = GUICtrlRead($Add_Offset_D)
	if GUICtrlRead($Hex2_d) = $GUI_CHECKED Then $Add_Offset = StringtoHex($Add_Offset)   ; nếu offset là hex thì đổi thành số hex
	Msgbox(0,"Kết quả","Process :"& GUICtrlRead($List_Process_D)&@CRLF & _
	"Value type "& $Value_Type &@CRLF & _
	"Địa chỉ " & $Add_Mem &" + " & $Add_Offset &"  "& $Value )
EndFunc
Func Write()
	Local $i,$f,$t,$File
	$Name = GUICtrlRead($Name_D)
	$File = FileOpen($Name,1)
	$f=GUICtrlRead($From_D)  ;đọc từ gui 2 offset 
	$t=GUICtrlRead($To_D)
	If GUICtrlRead($Hex3_d) = $GUI_CHECKED Then ;nếu offset là số hex thì đổi thành số dec
		$t=StringtoHex($t)
		$f=StringtoHex($f)
	EndIf	
	GetProcess()
	For $i= $f to $t
		$Value  = _memoryread($Add_Mem+$i,$MemId,$Value_Type)
		if $Write_Hex Then $Value = Hex($Value)

				
		If $Hex1_D Then 
			$Add_Mem_Hex = Hex($Add_Mem+$i) ;ghi số hex lưu vào + i là số hex
		Else 
			$Add_Mem_Hex = $Add_Mem+$i	
		EndIf	
		FileWriteLine(@DesktopDir &"/" & $Name,"Address memory " & $Add_Mem_Hex & "   " & $Value)
	Next
	FileClose($File)
	MsgBox(0,"Thông báo","Đã ghi xong")	
EndFunc
Func List_Process()
	Local $List=""
	Local $t
	Local $List
	$aWinList=WinList()
	For $t = 1 To UBound($aWinList) - 1
		$List &= $aWinList[$t][0] & "/"
	Next
	Return StringStripWS($List, 3)
EndFunc
Func GetProcess()
	$Pid=WinGetProcess(GUICtrlRead($List_Process_D))
	$MemId=_MemoryOpen($Pid)
	$Add_Mem=GUICtrlRead($Add_Mem_D)
	If GUICtrlRead($Hex1_D) = $GUI_CHECKED Then 
		$Add_Mem=StringtoHex($Add_Mem)
	EndIf	
	Switch GUICtrlRead($Value_Type_D)
		Case "Binary"
			$Value_Type ="none"
		Case "Byte"
			$Value_Type ="Byte"		
		Case "2 Bytes"
			$Value_Type ="short"	
		Case "4 Bytes"
			$Value_Type ="dword"	
		Case "8 Bytes"
			$Value_Type ="int"	
		Case "Float"
			$Value_Type ="float"	
		Case "Double"
			$Value_Type ="double"	
		Case "Text"
			$Value_Type ="char"	
	EndSwitch
	If GUICtrlRead($Hex4_D)=$GUI_CHECKED Then
		$Write_Hex = True
	Else
		$Write_Hex = False
	EndIf	
EndFunc	
Func  StringtoHex($string)
	Local $int,$sum,$i,$key
	$string= StringStripWS($string,8)
	$leng = StringLen($string)
	For $i=1 to $leng 
		$key =  StringMid($string,$leng-$i+1,1)
		Select 
			Case $key= "0"
				$int = 0	
			Case $key= "1"
				$int = 1	
			Case $key="2"
				$int = 2	
			Case $key="3"
				$int = 3	
			Case $key="4"
				$int = 4	
			Case $key="5"
				$int = 5	
			Case $key="6"
				$int = 6	
			Case $key="7"
				$int = 7	
			Case $key="8"
				$int = 8	
			Case $key="9"
				$int = 9					
			Case $key="A" Or $key="a"
				$int = 10
			Case $key="B" Or $key="b"
				$int = 11
			Case $key="C" Or $key="c"
				$int = 12
			Case $key="D" Or $key="d"
				$int = 13
			Case $key="E" Or $key="e"
				$int = 14
			Case $key="F" Or $key="f"
				$int = 15	
			Case Else
				MsgBox(0,"","Co loi khi vao du lieu")	
		EndSelect
		$sum += $int* 16^($i-1)
	Next	
		Return Int($sum)
EndFunc
Func Quit()
	Exit
EndFunc	