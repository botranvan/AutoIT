#cs ==========================================================
- Chương trình
- Thiết kế: Trần Minh Đức
- AutoIT: v3.2.12.0
#ce ==========================================================

;-- Cấu Trúc Trương Trình -----------------------------------------------------------------------------------------------------------
;~ Các Include
;~ Phím nóng cố định
;~ Biến cố định 
;~ Những lệnh cần chạy trước
;~ Các Hàm Hoàn Chỉnh
;~ Các Hàm Đang Tạo
;-- Hết Cấu Trúc Trương Trình -------------------------------------------------------------------------------------------------------

;-- Các Include -----------------------------------------------------------------------------------------------------------------------

;------- Hết Các Include --------------------------------------------------------------------------------------------------------------

;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+k","ShowHotKey")					;Ctrl+Shilf+End		- Xem phím Nóng
HotKeySet ("{F7}","AutoAttack")					;Ctrl+Shilf+F7		- Bắt đầu
HotKeySet ("{F8}","SetFindMod")					;Ctrl+Shilf+F8		- Tự tìm Mod
;~ HotKeySet ("1","Skill1")						;1		- Sử dụng Skill của Char bên trái Sai
;~ HotKeySet ("2","Skill2")						;2		- Sử dụng Skill của Sai
;~ HotKeySet ("3","Skill3")						;3		- Sử dụng Skill của Char bên phải Sai
HotKeySet ("{PAUSE}","PauseAuto")				;Pause				- Di chuyển Auto
HotKeySet ("^+{DEl}","DelTooltip")				;Ctrl+Shilf+Delete 	- Xóa Thông báo
HotKeySet ("^+{END}","ExitAuto")				;Ctrl+Shilf+End 	- Thoát Auto
HotKeySet ("m","GetColor")
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

;-- Biến cố định ----------------------------------------------------------------------------------------------------------------------
;~ Biến Mô Tả Chương Trình
Global $AutoName="Sai AMW"						;Tên Chương Trình
Global $AutoClass="AutoIt v3 GUI"					;Mã phân loại Chương Trình		
Global $AutoVersion="1.0"							;Phiên Bản
Global $Author="Trần Minh Đức"						;Tên (các) Lập Trình Viện
Global $ProcessName=$AutoName&".exe"				;Dùng khi xuất thành EXE
Global Const $ProcessNumber=1						;Số lượng Chương Trình được phép chạy cùng 1 lúc

Global $Functions=@CRLF								;Các chức năng của Chương Trình
$Functions=$Functions&"   +Tự Đánh Mods"&@CRLF
$Functions=$Functions&"   +Tự Tìm Mods"

;~ Biến Thời Gian
Global $TimeSplit=" - " 	;Phân Cách Thời Gian
Global $1s=1000				;Số Mili Giây trên 1 Giây	(1000/1)
Global Const $spm=60		;Số Giây trên 1 Phút		(60/1)
Global Const $mph=60		;Số Phút trên 1 Giờ			(60/1)	
Global Const $hpd=24		;Số Giờ trên 1 Ngày			(60/1)

;~ Biến dùng chung
Global $Status="attack"
Global $Skill1=False
Global $Skill2=False
Global $Skill3=False
Global $Running=False
Global $Attack=False
Global $FindMod=False
Global $Pause=False
Global $ModStatus[6]			;Trạng thái Mod
$ModStatus[1]=-1
$ModStatus[2]=-1
$ModStatus[3]=-1
$ModStatus[4]=-1
$ModStatus[5]=-1
Global $InfoPos[2]			;Vị trí thông báo
$InfoPos[0]=@DesktopWidth/2
$InfoPos[1]=610
Global $SaiEPPos[2]			;Vị trí EP của Sai
$SaiEPPos[0]=871
$SaiEPPos[1]=565
Global $RightEPPos[2]		;Vị trí EP Bên Phải Sai
$RightEPPos[0]=871
$RightEPPos[1]=615.2
Global $LeftEPPos[2]		;Vị trí EP Bên Trái Sai
$LeftEPPos[0]=871
$LeftEPPos[1]=517.3


;------- Hết Biến Cố Định -------------------------------------------------------------------------------------------------------------

;-- Những lệnh cần chạy trước ---------------------------------------------------------------------------------------------------------
CheckAuto()
ShowInfoAuto()
;~ AutoAttack()
While 1
	Sleep(777)
WEnd 
;------- Hết những lệnh cần chạy trước ------------------------------------------------------------------------------------------------

;-- Các Hàm Hoàn Chỉnh ----------------------------------------------------------------------------------------------------------------
;Kiểm Tra xem Auto đã chạy chưa
Func CheckAuto()
	$l = ProcessList()
	$CountProcess=$ProcessNumber
	For $i = 1 to $l[0][0] Step 1
		If $l[$i][0]=$ProcessName And $CountProcess=0 then
			MsgBox(0,$AutoName,$AutoName&" đã chạy."&@LF&"Không thể mở thêm!!!")
			Exit
		EndIf
 		If $l[$i][0]=$ProcessName then $CountProcess-=1
	Next
	TraySetState(1)
EndFunc

;~ Xem phím nóng
Func ShowHotKey()
	Local $text=@TAB&"DANH SÁCH PHÍM NÓNG"&@LF
	$text=$text&"  Ctrl+Shilf+K"&@TAB&@TAB&"- Xem phím Nóng"&@LF
	$text=$text&"  Ctrl+Shilf+Delete"&@TAB&"- Xóa Thông Báo"&@LF
	$text=$text&"  Ctrl+Shilf+End"&@TAB&@TAB&"- Thoát Auto"&@LF
	$text=$text&"  Ctrl+Shilf+F7"&@TAB&@TAB&"- Tự động đánh"&@LF
	$text=$text&"  Ctrl+Shilf+F8"&@TAB&@TAB&"- Tự tìm Quái Vật"&@LF
	$text=$text&"  Pause"&@TAB&""&@TAB&@TAB&"- Tạm Ngưng"
	ToolTip($text,0,0)
EndFunc

;~ Di chuyển Auto
Func PauseAuto()
	$Pause=Not $Pause
	Local $i=1
	While $Pause
		Select 
			Case $i=1
				ToolTip("Tạm dừng >     ",@DesktopWidth/2,0)
			Case $i=2
				ToolTip("Tạm dừng  >    ",@DesktopWidth/2,0)
			Case $i=3
				ToolTip("Tạm dừng   >   ",@DesktopWidth/2,0)
			Case $i=4
				ToolTip("Tạm dừng    >  ",@DesktopWidth/2,0)
			Case $i=5
				ToolTip("Tạm dừng    >  ",@DesktopWidth/2,0)
			Case $i=6
				ToolTip("Tạm dừng     > ",@DesktopWidth/2,0)
			Case $i=7
				ToolTip("Tạm dừng      >",@DesktopWidth/2,0)
			Case $i=8
				ToolTip("Tạm dừng     < ",@DesktopWidth/2,0)
			Case $i=9
				ToolTip("Tạm dừng    <  ",@DesktopWidth/2,0)
			Case $i=10
				ToolTip("Tạm dừng   <   ",@DesktopWidth/2,0)
			Case $i=11
				ToolTip("Tạm dừng  <    ",@DesktopWidth/2,0)
			Case $i=12
				ToolTip("Tạm dừng <     ",@DesktopWidth/2,0)
		EndSelect
		
		If $i=12 Then 
			$i=1
		Else
			$i=$i+1
		EndIf
		
		Sleep(77)
	WEnd
	ToolTip("")
EndFunc

;~ Hàm xóa Thông Báo
Func DelTooltip()
	ToolTip("")
EndFunc

;~ Hàm thoát Auto
Func ExitAuto()
	Exit
EndFunc

;~ Hàm xuất thông tin chương trình
Func ShowInfoAuto()
	Local $text="THÔNG TIN CHƯƠNG TRÌNH"&@LF
	$text=$text&" - Chương Trình: "&$AutoName&@LF
	$text=$text&" - Phiên Bản: "&$AutoVersion&@LF
	$text=$text&" - Thiết kế: "&$Author&@LF
	$text=$text&" - Chức năng: "&$Functions&@LF&@LF
	$text=$text&"(Ctrl+Shilf+K - Trợ Giúp)"
	ToolTip($text,0,0)
EndFunc

;Hàm kiểm tra EP	
Func CheckEPPos()
	$SaiEPColor=PixelGetColor($SaiEPPos[0]-90,$SaiEPPos[1])
;~ 	ToolTip($SaiEPColor,$SaiEPPos[0]-90,$SaiEPPos[1])
	If (($SaiEPColor>12000000)And($SaiEPColor<13000000)) Then 
		For $i=$SaiEPPos[0] To $SaiEPPos[0]+7 Step 1
			$LeftEPColor=PixelGetColor($i,$LeftEPPos[1])
			$SaiEPColor=PixelGetColor($i,$SaiEPPos[1])
			$RightEPColor=PixelGetColor($i,$RightEPPos[1])
			If (($LeftEPColor>16000000)And($LeftEPColor<16700000)) Then 
				If $Skill1 Then
;~ 					Send("t")
					ToolTip("Dùng kỹ năng",$i,$LeftEPPos[1])
;~ 					Send("m")
				Else
					ToolTip("Đánh",$i,$LeftEPPos[1])
				EndIf
			EndIf
			
			If (($SaiEPColor>16000000)And($SaiEPColor<16700000)) Then 
				If $Skill2 Then
;~ 					Send("t")
					ToolTip("Dùng kỹ năng",$i,$SaiEPPos[1])
;~ 					Send("m")
				Else
					ToolTip("Đánh",$i,$SaiEPPos[1])
				EndIf
			EndIf
			
			If (($RightEPColor>16000000)And($RightEPColor<16700000)) Then 
				If $Skill3 Then
;~ 					Send("t")
					ToolTip("Dùng kỹ năng",$i,$RightEPPos[1])
;~ 					Send("m")
				Else
					ToolTip("Đánh",$i,$RightEPPos[1])
				EndIf
			EndIf
				
			If (($SaiEPColor>16000000)And($SaiEPColor<16700000))or(($RightEPColor>16000000)And($RightEPColor<16700000))or(($LeftEPColor>16000000)And($LeftEPColor<16700000))Then Return True
			ToolTip("Gồng... ",$i,$SaiEPPos[1])
			GetModStatus()
		Next
	Else
		If $FindMod Then 
			If $Status="attack" Then MouseMove(@DesktopWidth/2-16,@DesktopHeight/2-7,1)
			FindMod()
		Else
 			ToolTip("Di chuyển",$InfoPos[0]+Random(-2,2),$InfoPos[1])
			Sleep(7)
		EndIf
	EndIf
EndFunc

;Hàm tự động Tìm và đánh Mod
Func AutoAttack()
	$Running=Not $Running
	While $Running
		If CheckEPPos() Then
			$Status="attack"
			GetModStatus()
			Sleep(77)
			Send("a")
			ClickMod()
			MouseClick("left")
			MouseClick("left")
		EndIf
	WEnd 
	ToolTip("Ngưng đánh",$InfoPos[0],$InfoPos[1])
EndFunc

;~ Hàm tìm Mod
Func FindMod()
;~ 	If $Status="attack" Then MouseMove(@DesktopWidth/2.@DesktopHeight/2,1)
	$Status="find"
	Local $MousePos=MouseGetPos()
	MouseClick("left",$MousePos[0],$MousePos[1],1,1)
	Sleep(77)
	AutoItSetOption("SendKeyDownDelay",340)
;~ 	Sleep(7)
	ToolTip("Tìm quái <    >",$InfoPos[0],$InfoPos[1])
	Send("{Down}")
;~ 	Sleep(7)
	ToolTip("Tìm quái  <  >",$InfoPos[0],$InfoPos[1])
	Send("{Right}")
;~ 	Sleep(7)
	ToolTip("Tìm quái   <>",$InfoPos[0],$InfoPos[1])
	Send("{Up}")
;~ 	Sleep(7)
	ToolTip("Tìm quái  <  >",$InfoPos[0],$InfoPos[1])
	Send("{Left}")
	AutoItSetOption("SendKeyDownDelay",5)
EndFunc

;~ Hàm chọn Mod
Func ClickMod()
		If $ModStatus[1]>0 Then 
;~ 			ToolTip("1:"&$ModStatus[1]&" -- "&$ModStatus[0]&" / "&$ModStatus[1]&" / "&$ModStatus[2]&" / "&$ModStatus[3]&" / "&$ModStatus[4],@DesktopWidth/2,0)
			MouseMove(196,322,1) 	;Vị trí 1
			Return
		EndIf
		If $ModStatus[2]>0 Then 
;~ 			ToolTip("2:"&$ModStatus[2]&" -- "&$ModStatus[0]&" / "&$ModStatus[1]&" / "&$ModStatus[2]&" / "&$ModStatus[3]&" / "&$ModStatus[4],@DesktopWidth/2,0)
			MouseMove(275,295,1)	;Vị trí 2
			Return
		EndIf
		If $ModStatus[3]>0 Then 
;~ 			ToolTip("3:"&$ModStatus[3]&" -- "&$ModStatus[0]&" / "&$ModStatus[1]&" / "&$ModStatus[2]&" / "&$ModStatus[3]&" / "&$ModStatus[4],@DesktopWidth/2,0)
			MouseMove(357,247,1)	;Vị trí 3
			Return
		EndIf
		If $ModStatus[4]>0 Then 
;~ 			ToolTip("4:"&$ModStatus[4]&" -- "&$ModStatus[0]&" / "&$ModStatus[1]&" / "&$ModStatus[2]&" / "&$ModStatus[3]&" / "&$ModStatus[4],@DesktopWidth/2,0)
			MouseMove(448,214,1)	;Vị trí 4
			Return
		EndIf
		If $ModStatus[5]>0 Then 
;~ 			ToolTip("5:"&$ModStatus[4]&" -- "&$ModStatus[0]&" / "&$ModStatus[1]&" / "&$ModStatus[2]&" / "&$ModStatus[3]&" / "&$ModStatus[4],@DesktopWidth/2,0)
			MouseMove(511,169,1)	;Vị trí 5
			Return
		EndIf
$ModStatus[1]=-1
$ModStatus[2]=-1
$ModStatus[3]=-1
$ModStatus[4]=-1		
$ModStatus[5]=-1		
EndFunc
	
;Hàm thay đổi trạng thái tìm Mod
Func SetFindMod()
	$FindMod=Not $FindMod
EndFunc

;~ Hàm kiểm tra trạng thái của Mod
Func GetModStatus()
	$Times=2
	$ModStatus[0]=4
	If $ModStatus[1]<>0 Then 
		MouseMove(196,322,1) 	;Vị trí 1	
		If MouseGetCursor()=0 Then 
			$ModStatus[1]=$Times
		Else
			$ModStatus[1]=$ModStatus[1]-1
			If $ModStatus[1]<0 Then $ModStatus[1]=0
			If $ModStatus[1]=0 Then $ModStatus[0]=$ModStatus[0]-1
		EndIf
	EndIf
	
	If $ModStatus[2]<>0 Then 
		MouseMove(275,295,1)	;Vị trí 2
		If MouseGetCursor()=0 Then 
			$ModStatus[2]=$Times
		Else
			$ModStatus[2]=$ModStatus[2]-1
			If $ModStatus[2]<0 Then $ModStatus[2]=0
			If $ModStatus[2]=0 Then $ModStatus[0]=$ModStatus[0]-1
		EndIf
	EndIf
	
	If $ModStatus[3]<>0 Then 
		MouseMove(357,247,1)	;Vị trí 3
		If MouseGetCursor()=0 Then 
			$ModStatus[3]=$Times
		Else
			$ModStatus[3]=$ModStatus[3]-1
			If $ModStatus[3]<0 Then $ModStatus[3]=0
			If $ModStatus[3]=0 Then $ModStatus[0]=$ModStatus[0]-1
		EndIf
	EndIf
		
	If $ModStatus[4]<>0 Then 
		MouseMove(448,214,1)	;Vị trí 4
		If MouseGetCursor()=0 Then
			$ModStatus[4]=$Times
		Else
			$ModStatus[4]=$ModStatus[4]-1
			If $ModStatus[4]<0 Then $ModStatus[4]=0
			If $ModStatus[4]=0 Then $ModStatus[0]=$ModStatus[0]-1
		EndIf
	EndIf

	If $ModStatus[5]<>0 Then 
		MouseMove(511,169,1)	;Vị trí 5
		If MouseGetCursor()=0 Then
			$ModStatus[5]=$Times
		Else
			$ModStatus[5]=$ModStatus[5]-1
			If $ModStatus[5]<0 Then $ModStatus[5]=0
			If $ModStatus[5]=0 Then $ModStatus[0]=$ModStatus[0]-1
		EndIf
	EndIf
EndFunc	
;-- Các Hàm Đang Tạo ------------------------------------------------------------------------------------------------------------------
;Hàm lấy màu
Func GetColor()
$Pos=MouseGetPos()
ToolTip(PixelGetColor($Pos[0],$Pos[1]),$Pos[0],$Pos[1]-16)
;~ 		ToolTip($SaiEPColor,$i,$SaiEPPos[1])
EndFunc

;~ Hàm kích hoạt skill của char bên trái Sai
Func Skill1()
	$Skill1=Not $Skill1
EndFunc
;~ Hàm kích hoạt skill của Sai
Func Skill2()
	$Skill2=Not $Skill2
EndFunc
;~ Hàm kích hoạt skill của char bên phải Sai
Func Skill3()
	$Skill3=Not $Skill3
EndFunc

;------- Hết Các Hàm Đang Tạo ---------------------------------------------------------------------------------------------------------