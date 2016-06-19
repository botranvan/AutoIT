#include-once
#include "GUI\GUIFunctions.au3"


#cs >> Danh sách hàm ===============================================================================================


Func FAutoStart()			;~ Nạp các thông số của Auto khi khởi động
Func FAutoEnd()				;~ Kết thúc chương trình
Func FAutoCheckUpdate()		;~ Kiểm tra phiên bản mới của Auto
Func FSaveSetting()			;~ Lưu các thông số trên GUI
Func FSaveGUIPos()			;~ Lưu vị trí GUI
Func FLoadGUIPos()			;~ Nạp vị trí GUI
Func FToolTipDel()			;~ Xóa ToolTip
Func FPercent()				;~ Tính phần trăm giữa 2 số
Func FNumberCheckSum()		;~ Kiểm tra xem 2 số có gần bằng nhau hay không


#ce << Danh sách hàm ===============================================================================================

;~ Nạp các thông số của Auto khi khởi động
Func FAutoStart()
	FProcessGetList()
	FDataLoad()
	
	FLoadGUIPos()
	MainGUIFix()
	;~ AutoCheckUpdate()
EndFunc

;~ Kết thúc chương trình
Func FAutoEnd()
	MainGUIClose()
EndFunc

;~ Tạm dừng chương trình
Func FAutoPause()
	$Pause = Not $Pause
	While $Pause
		LNoticeSet("Pause "&@SEC,0)
		Sleep(500)
	WEnd
	LNoticeSet()
EndFunc

;~ Kiểm tra phiên bản mới của Auto
Func FAutoCheckUpdate()
	ToolTip("Checking for updates...",0,0)

	Local $HTML = _INetGetSource($HomePage)
	Local $start = StringInStr($HTML,"[Auto] Lineage 2 - Scan Monsters") + 53
	Local $len = StringInStr($HTML," |") - $start
	$HTML = StringMid($HTML,$start,$len)

	If $AutoVersion == $HTML Then
		FToolTipDel()
	Else
		ToolTip("A newer version is available: v"&$HTML&" "&@LF&"Click [ Option ] => [ HomePage ] to download",0,0)
		AdlibRegister("DelTooltip",9000)
	EndIf

EndFunc

;~ Lưu các thông số trên GUI
Func FSaveSetting()
	FSaveGUIPos()
EndFunc

;~ Lưu vị trí GUI
Func FSaveGUIPos()
	Local $Pos = WinGetPos($MainGUI)
	If $Pos[0] < 0 Or $Pos[1] < 0 Then Return
	IniWrite($DataFileName,"AutoPos","x",$Pos[0])
	IniWrite($DataFileName,"AutoPos","y",$Pos[1])
	Return $Pos
EndFunc


;~ Nạp vị trí GUI
Func FLoadGUIPos()
	$AutoPos[0] = IniRead($DataFileName,"AutoPos","x",$AutoPos[0])
	$AutoPos[1] = IniRead($DataFileName,"AutoPos","y",$AutoPos[1])
EndFunc

;~ Xóa ToolTip
Func FToolTipDel()
	ToolTip("")
EndFunc

;~ Tính phần trăm giữa 2 số
Func FPercent($a,$b)
	local $percent = (( $a / $b )*100)
	return $percent
EndFunc
	
;~ Kiểm tra xem 2 điểm có gần nhau hay kg
Func FIsNear($X1,$Y1,$X2,$Y2,$Area = 2)
   Local $IsNear = 0
   Local $Distance = FDistance($X1,$Y1,$X2,$Y2)
   If $Distance <= $Area Then $IsNear = 1
   Return $IsNear
EndFunc

;~ Tính khoãn cách 2 điểm
Func FDistance($X1,$Y1,$X2,$Y2)
   Local $Distance = -99
   Local $AC,$AB,$BC
   $AC = Abs($X1 - $X2)
   $BC = Abs($Y1 - $Y2)
   $AB = Sqrt($AC*$AC + $BC*$BC)
   $Distance = Round($AB)
   Return $Distance
EndFunc

;~ Tính toán xem 2 số có lệch nhau nhiều kg
Func FNumIsNear($a,$b,$near = 3)
	Local $n
	$n = Abs($a-$b)
	If $n > $near Then Return 0
	If $n <= $near Then Return 1
EndFunc	
	
;Lấy danh sách Process đang chạy
Func FProcessGetList()
	$ProcessList = ProcessList()
	For $i = 1 To $ProcessList[0][0]
		CBProcessListAdd($ProcessList[$i][0])
	Next
EndFunc

;~ Nạp dữ liệu từ file lên
Func FDataLoad()
	$AddressReview = IniRead($DataFileName,"GUI","$AddressReview",$AddressReview)
	$AddressStart = IniRead($DataFileName,"GUI","$AddressStart",$AddressStart)
	$ProcessName = IniRead($DataFileName,"GUI","$ProcessName",$ProcessName)
EndFunc

;~ Hiển thị giá trị của $AddressReview
Func FShowReview()
	Local $Address
	
	If Not $IsOpen Then Return
	
	$Address = IAddressReviewGet()
	$Address = "0x"&$Address
	LReviewValueSet(FRead($Address))
EndFunc

;~ Hiển thị giá trị của $AddressReview
Func FShowAddressList()
	Local $Text,$Offset,$Span,$Address,$Address2
	
	If Not $IsOpen Then Return
	
	$Offset = Dec(IOffsetGet())
	$Span = IAddressSpanGet()
	$Address = Dec(IAddressStartGet())

	$Text&= " =00|"&Hex($Address)&": "&FRead($Address)&@CRLF
	For $i = 1 To $Span
		$Text&= "+"
		If $i < 10 Then $Text&= "0"
		$Text&= $i&"|"&Hex($Address+$Offset*$i)&": "&FRead($Address+$Offset*$i)&@CRLF
	Next

	For $i = 1 To $Span
		$Text = $i&"|"&Hex($Address-$Offset*$i)&": "&FRead($Address-$Offset*$i)&@CRLF & $Text 
		If $i < 10 Then $Text = "0" & $Text
		$Text = " -" & $Text
	Next
	
	$Text = "|Value: "&$DataType&" "&$Span&" "&$Offset&@CRLF & $Text 
	ToolTip(@sec&" "&$Text,0,0)
EndFunc

;~ Read data from memory
Func FRead($Address)
   Local $Data
   If Not $IsOpen Then Return "??"
   
   $Data = _MemoryRead($Address,$ProcessMem,$DataType)
   Return $Data	
EndFunc

;~ Hiển thị giá trị của $AddressReview
Func FShowPointer()
	Local $Text,$Offset,$Span,$BaseAddress,$Pointer1Offset,$Address,$Pointer1,$hp
	
	If Not $IsOpen Then Return
	
	$Offset = Dec(IOffsetGet())
	$Span = IAddressSpanGet()
	$Address = IAddressStartGet()
	$Address = StringSplit($Address,"+",1)
	$BaseAddress = Dec($Address[1])
	$Pointer1Offset = Dec($Address[2])
	
	$Pointer1 = _MemoryRead($BaseAddress,$ProcessMem)
	
	$Text&= "=00|"&Hex($Pointer1+$Pointer1Offset)&" (0): "&FRead($Pointer1+$Pointer1Offset)&@CRLF
	
	For $i = 1 To $Span
		$Text&= "+"
		If $i < 10 Then $Text&= "0"
		$Text&= $i&"|"&Hex($Pointer1+$Pointer1Offset+$Offset*$i)&" ("&Hex($Offset*$i,2)&")"&": "&FRead($Pointer1+$Pointer1Offset+$Offset*$i)&@CRLF
	Next

	For $i = 1 To $Span
		$Text = $i&"|"&Hex($Pointer1+$Pointer1Offset-$Offset*$i)&" ("&Hex($Offset*$i,2)&")"&": "&FRead($Pointer1+$Pointer1Offset-$Offset*$i)&@CRLF & $Text 
		If $i < 10 Then $Text = "0" & $Text
		$Text = " -" & $Text
	Next

	$Text = "|Value: "&$DataType&" "&$Span&" "&$Offset&" "&$Pointer1Offset&@CRLF & $Text 
	ToolTip(@sec&" "&$Text,0,0)	
EndFunc