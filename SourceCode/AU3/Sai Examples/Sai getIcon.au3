;~ Các Include cần
#include <array.au3>

;~ Các biến chương trình
Dim $SearchPath = @DesktopDir&'\*.lnk'	;Địa chỉ cần tìm
Dim $ArrayIcon[1] = [0] 						;Mảng chứa tên của các Icon

;~ Phím nóng của chương trình
HotKeySet("{ESC}","ExitAuto")
Func ExitAuto()
	Exit
EndFunc


;~ Vòng lặp chính
While 1
	Sleep(77)
	$ArrayIcon = GetIconName($SearchPath)
	Tooltip(ListIconName($ArrayIcon)&"  Bấm ESC để thoát",0,0) 
WEnd


;~ Các hàm chương trình ========================================================

;~ Lấy IconName
Func GetIconName($Path)
	Local $Array[1] = [0]
	; Lấy tất cả các Icon Name
	$IconNames = FileFindFirstFile($Path)  

	; Kiểm tra xem có cái Icon nào không
	If $IconNames = -1 Then
		Return $Array
	EndIf

	While 1 ;Lấy tất cả tên trong danh sách
		$IconName = FileFindNextFile($IconNames) 
		If @error Then ExitLoop
		_ArrayAdd($Array,$IconName)
		$Array[0]+=1
	WEnd
	
	; Đóng danh sách tìm kiếm
	FileClose($IconNames)
	
	Return $Array
EndFunc

;~ Hiển thị IconName
Func ListIconName($Array)
	Local $Text = '   DANH SÁCH SHORTCUT'&@LF
	
	If $Array[0] = 0 Then 
		$Text&='Không tìm thấy Icon nào'
		tooltip($Text,0,0)
		Return
	EndIf
	
	For $i = 1 to $Array[0] Step 1
		$Text&= $i&': '&$Array[$i]&@LF
	Next
	Return $Text
EndFunc

