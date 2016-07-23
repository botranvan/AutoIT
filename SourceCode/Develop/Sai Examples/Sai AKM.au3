#cs ==========================================================
- Chương trình
- Thiết kế: Trần Minh Đức
- AutoIT: v3.2.12.1
#ce ==========================================================

;-- Cấu Trúc Trương Trình -------------------------------------------------------------------------------------------------------------
;~ Các Include
;~ Phím nóng cố định
;~ Biến cố định
;~ Những lệnh cần chạy trước
;~ Các Hàm Hoàn Chỉnh
;~ Các Hàm Đang Tạo
;-- Hết Cấu Trúc Trương Trình ---------------------------------------------------------------------------------------------------------

;-- Các Include và Option -------------------------------------------------------------------------------------------------------------
#include <WindowsConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <ComboConstants.au3>
#include <ButtonConstants.au3>
#Include <Array.au3>

AutoItSetOption("GUIOnEventMode",1)		;GUI hoạt động dựa trên Hàm
AutoItSetOption("SendCapslockMode",0)	;Hiệu chỉ chế độ Caplock
AutoItSetOption("SendKeyDownDelay",2)	;Hiệu chỉ bấm xuống của 1 nút
AutoItSetOption("SendKeyDelay",2)		;Hiệu chỉ thời gian giữa 2 lần bấm
AutoItSetOption("SendAttachMode",0)
;------- Hết Các Include --------------------------------------------------------------------------------------------------------------

;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("{F1}","AutoSendKeys1")					;F1					- Tự send các phím thứ nhất
HotKeySet ("{F2}","AutoSendKeys2")					;F2					- Tự send các phím thứ hai
HotKeySet ("^+h","HiddenShow")						;Ctrl+Shilf+h		- Ẩn chuong trình
HotKeySet ("^+i","ShowInfoAuto")					;Ctrl+Shilf+i		- Xem thông tin chương trình
HotKeySet ("^+k","ShowHotKey")						;Ctrl+Shilf+k		- Xem phím Nóng
HotKeySet ("{PAUSE}","ActivePauseAuto")				;Pause				- Tạm Dừng Auto
HotKeySet ("^+{DEl}","DelTooltip")					;Ctrl+Shilf+Delete 	- Xóa Thông báo
HotKeySet ("^+{END}","ExitAuto")					;Ctrl+Shilf+End 	- Thoát Auto

;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

;-- Biến cố định ----------------------------------------------------------------------------------------------------------------------
;~ Biến Mô Tả Chương Trình
Global $AutoName="Sai"								;Tên Chương Trình
Global $AutoClass="AutoIt v3 GUI"					;Mã phân loại Chương Trình
Global $AutoHandle=""								;Mã Chương Trình khi chạy
Global $AutoVersion="1.0"							;Phiên Bản
Global $Author="Trần Minh Đức"						;Tên Lập Trình Viện
Global $AutoTitle=$AutoName&" v"&$AutoVersion&" "
Global Const $ProcessNumber=1						;Số lượng Chương Trình được phép chạy cùng 1 lúc

Global $Functions=@CRLF								;Các chức năng của Chương Trình
$Functions=$Functions&""

;~ Biến Thời Gian
Global $TimeSplit=" - " 	;Phân Cách Thời Gian
Global $1s=1000				;Số Mili Giây trên 1 Giây	(1000/1)
Global Const $spm=60		;Số Giây trên 1 Phút		(60/1)
Global Const $mph=60		;Số Phút trên 1 Giờ			(60/1)
Global Const $hpd=24		;Số Giờ trên 1 Ngày			(60/1)

;~ Biến chương trình
Global $ShowToolTip=False			;True 	- Đang hiển thị bằng ToolTip
Global $ShowHotKey=False			;True 	- Hiển thị danh sách phím nóng
Global $ShowInfoAuto=False			;True 	- Hiển thị thông tin chương trình
Global $Hidden=False				;True 	- Trang thái Thu Gọn Auto
Global $Pause=False					;True 	- Tạm ngưng chương trình
Global $ShowPauseNum=1				;1 		- Cách hiện thị thứ nhất của trạng thái Pause
Global $RunningI=1					;1 		- Cách hiện thị thứ nhất của trạng thái hoạt động
Global $AuutoClickRunningI=1		;1 		- Cách hiện thị thứ nhất của trạng thái hoạt động
Global $Clicking=False				;True 	- Tự Click liên tục
Global $AutoClickCurrenHotKey=""	;Phím nóng hiện tại của chức năng AutoClick

Global $AutoSend1=False				;True	- Tự động bấm các phím thứ nhất
Global $ArrayKey1[4]=[3,"d","s","a"];Mảng danh sách phím sẽ được bấm thứ nhất
Global $NumberKeys1=4				;Số lượng chữ sẽ bấm trong danh sách thứ nhất
Global $Keys1I=1					;Số tứ thự chữ sẽ bấm trong dãy thứ nhất

Global $AutoSend2=False				;True	- Tự động bấm các phím thứ hai
Global $ArrayKey2[4]=[3,"1","2","3"];Mảng danh sách phím sẽ được bấm thứ nhất
Global $NumberKeys2=4				;Số lượng chữ sẽ bấm trong danh sách thứ hai
Global $Keys2I=1					;Số tứ thự chữ sẽ bấm trong dãy thứ hai
;------- Hết Biến Cố Định -------------------------------------------------------------------------------------------------------------

;-- Những lệnh cần chạy trước ---------------------------------------------------------------------------------------------------------
SetLanguage()
CreateMainGUI()
CheckAuto()
ShowMainGUI()

;~ Tạo phím nóng AutoClick
HotKeySet4AutoCLick()

;~ Focus nút thu gọn chương trình
FocusAButton()

;~ Vòng lặp chính
While 1
;~ 	If Not $AutoSend1 and Not $AutoSend2 And Not $Clicking Then Sleep(77)
	Sleep(77)

;~ 	Kiểm tra xem chuột có ở trong chương trình không
	CheckMouseOnAuto()

;~ 	Tạm dừng
	If PauseAuto() Then
		ShowPauseAuto()
		Sleep(25)
		ContinueLoop
	EndIf

;~ 	Thực hiện chức năng tự Click liên tục
	AutoClickMode1()

;~ 	Tự send các phím thứ nhất
	If $AutoSend1 Then AutoSend1Mode1()

;~ 	Tự send các phím thứ hai
	If $AutoSend2 Then AutoSend2Mode1()

	If Mod(@SEC,7)=0 Then ToolTip("")
WEnd
;------- Hết những lệnh cần chạy trước ------------------------------------------------------------------------------------------------



;-- Các Hàm Hoàn Chỉnh ----------------------------------------------------------------------------------------------------------------
;~ Kiểm Tra xem Auto đã chạy chưa
Func CheckAuto()
	Local $l = WinList("[TITLE:"&$AutoTitle&"; CLASS:AutoIt v3 GUI;]")
	Local $CountProcess=$ProcessNumber

	If $l[0][0]>$ProcessNumber Then
		MsgBox(0,$AutoName,$EnoughAutoT)
		ExitAuto()
	EndIf
EndFunc


;~ Xem phím nóng
Func ShowHotKey()
	If $ShowToolTip And $ShowHotKey Then
		DelTooltip()
	Else
		DelTooltip()
		$ShowHotKey=True
		$ShowToolTip=True
		Local $text=@TAB&"DANH SÁCH PHÍM NÓNG"&@LF
		$text=$text&"F1"&@TAB&@TAB&@TAB&"- Tự send thứ nhất"&@LF
		$text=$text&"F2"&@TAB&@TAB&@TAB&"- Tự send thứ hai"&@LF
		$text=$text&"Space,???"&@TAB&@TAB&"- Tự Click chuột"&@LF
		$text=$text&"Ctrl+Shilf+H"&@TAB&@TAB&"- Ẩn chuong trình"&@LF
		$text=$text&"Ctrl+Shilf+I"&@TAB&@TAB&"- Xem thông tin chương trình"&@LF
		$text=$text&"Ctrl+Shilf+K"&@TAB&@TAB&"- Xem phím Nóng"&@LF
		$text=$text&"Ctrl+Shilf+Delete"&@TAB&"- Xóa Thông Báo"&@LF
		$text=$text&"Ctrl+Shilf+End"&@TAB&@TAB&"- Thoát Auto"&@LF
		$text=$text&"Pause"&@TAB&""&@TAB&@TAB&"- Tạm Dừng Auto"&@LF
		ToolTip($text,0,0)
	EndIf
EndFunc


;~ Hàm xuất thông tin chương trình
Func ShowInfoAuto()
	If $ShowToolTip And $ShowInfoAuto Then
		DelTooltip()
	Else
		DelTooltip()
		$ShowInfoAuto=True
		$ShowToolTip=True
		Local $text=@TAB&"THÔNG TIN"&@LF
		$text=$text&"- Chương Trình: "&$AutoName&@LF
		$text=$text&"- Phiên Bản: "&$AutoVersion&@LF
		$text=$text&"- Thiết kế: "&$Author&@LF
		$text=$text&"- Chức năng: "&$Functions
		ToolTip($text,0,0)
	EndIf
EndFunc


;~ Hàm xóa Thông Báo
Func DelTooltip()
	$ShowToolTip=False
	$ShowHotKey=False
	$ShowInfoAuto=False
	ToolTip("")
EndFunc


;~ Hàm cho biết chức năng tự bơm đang hoạt động
Func RunningCheck($Running_Lable,$RunningI=1)
;~ 	Nếu tạm dừng, không tìm thấy PetHP, thì không hiển thị tiếp, nhưng không xóa
	If $Pause Then Return False

	Select
		Case $RunningI=1
			GUICtrlSetData($Running_Lable,"|")
		Case $RunningI=2
			GUICtrlSetData($Running_Lable,"/")
		Case $RunningI=3
			GUICtrlSetData($Running_Lable,"__")
		Case $RunningI=4
			GUICtrlSetData($Running_Lable,"\")
		Case $RunningI=5
			GUICtrlSetData($Running_Lable,"|")
		Case $RunningI=6
			GUICtrlSetData($Running_Lable,"\")
		Case $RunningI=7
			GUICtrlSetData($Running_Lable,"__")
		Case $RunningI=8
			GUICtrlSetData($Running_Lable,"/")
		Case $RunningI=9
			GUICtrlSetData($Running_Lable,"S")
	EndSelect
EndFunc


;~ Hàm ẩn hiện chương trình
Func HiddenShow()
	Local $Pos=WinGetPos($MainGUI)
	If $Pos[1]=0 Then
		GUICtrlSetData($Hidden_Button,$Button_ShowT)
		WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1]-$MainGUI_Size[1]+$Hidden_Button_Size[1]+$Horizontally,Default,Default,2)
		$Hidden=True
	Else
		GUICtrlSetData($Hidden_Button,$Hidden_ButtonT)
		WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1],Default,Default,2)
		$Hidden=False
	EndIf
EndFunc


;~ Tạm dừng Auto
Func ActivePauseAuto()
	$Pause = Not $Pause
	If $Pause Then
		ShowWarningGUI()
		GUICtrlSetData($Pause_Button,$Pause_ButtonT2)
	Else
		HiddenWarningGUI()
		GUICtrlSetData($Pause_Button,$Pause_ButtonT1)
		GUICtrlSetData($Warning_Lable,"")
		Sleep($1s)
	EndIf

EndFunc
;~ Tạm dừng Auto
Func PauseAuto()
	If $Pause Then
		Return True
	EndIf
	Return False
EndFunc
;~ Hiển thị thông báo tạm dừng Auto
Func ShowPauseAuto()
	Select
		Case $ShowPauseNum=1
			GUICtrlSetData($Warning_Lable," >    "&$PauseAutoT&"    < ")
		Case $ShowPauseNum=2
			GUICtrlSetData($Warning_Lable,"  >   "&$PauseAutoT&"   <  ")
		Case $ShowPauseNum=3
			GUICtrlSetData($Warning_Lable,"   >  "&$PauseAutoT&"  <   ")
		Case $ShowPauseNum=4
			GUICtrlSetData($Warning_Lable,"    > "&$PauseAutoT&" <    ")
		Case $ShowPauseNum=5
			GUICtrlSetData($Warning_Lable,"     >"&$PauseAutoT&"<     ")
	EndSelect

	If $ShowPauseNum=5 Then
		$ShowPauseNum=0
	EndIf
	$ShowPauseNum+=1
EndFunc


;~ Hàm Focus một nút
Func FocusAButton()
	GUICtrlSetState($Hidden_Button,$GUI_FOCUS)
EndFunc

;~ Hàm kiểm tra xem chuột có ở trong chương trình không
Func CheckMouseOnAuto()
;~ 	Lấy vị trí chuột
	$Mouse_Pos=MouseGetPos()

;~ 	Lấy vị trí hiện tại của chương trình
	Local $MainGUI_Pos=WinGetPos($MainGUI)

	If $Clicking or $AutoSend1 or $AutoSend2 and $Mouse_Pos[0]>$MainGUI_Pos[0] And $Mouse_Pos[0]< $MainGUI_Pos[0]+$MainGUI_Size[0] _
		And Not $Pause and	$Mouse_Pos[1]>$MainGUI_Pos[1] And $Mouse_Pos[1]< $MainGUI_Pos[1]+$MainGUI_Size[1] Then ActivePauseAuto()
EndFunc


;~ Hàm tự động Click
Func AutoClick()
	AutoItSetOption("MouseClickDownDelay",10)
	Local $Key=GUICtrlRead($AutoCLick_ComboBox_HotKey)
	Local $Mode=GUICtrlRead($AutoClick_ComboBox_Mode)

;~ 	Liên tục
	If $Mode=$AutoClick_ComboBox_ModeT1 Then
		$Clicking = Not $Clicking
	Else
		$Clicking=False
	EndIf

;~ 	Giữ luôn
	If $Mode=$AutoClick_ComboBox_ModeT2 Then
		AutoItSetOption("MouseClickDownDelay",$1s*$spm*$mph)
		MouseDown("left")
	EndIf

;~ 	Một cái
	If $Mode=$AutoClick_ComboBox_ModeT3 Then MouseClick("left")
EndFunc


;~ Hàm tạo phím nóng cho chức năng AutoClick
Func HotKeySet4AutoCLick()
;~ 	Reset phím nóng
	HotKeySet("{"&$AutoClickCurrenHotKey&"}")

;~ 	Lấy giá trị phím nóng
	$AutoClickCurrenHotKey=GUICtrlRead($AutoClick_ComboBox_HotKey)
	If $AutoClickCurrenHotKey="???" Then
		$AutoClickCurrenHotKey=InputBox($AutoCLick_LableT1,$AutoCLick_Lable2T1,$AutoClickCurrenHotKey,"",106,124)
		GUICtrlSetData($AutoClick_ComboBox_HotKey,$AutoClickCurrenHotKey,$AutoClickCurrenHotKey)
	EndIf

;~ 	Tạo phím tắt cho AutoClick
	If GUICtrlRead($AutoClick_CheckBox)=1 Then HotKeySet("{"&$AutoClickCurrenHotKey&"}","AutoClick")
	FocusAButton()
EndFunc


;~ Hàm tự nhấn các phím thứ nhất
Func AutoSendKeys1()
	If GUICtrlRead($AutoSend1_CheckBox)=4 Then
		$AutoSend1=False
		Return
	EndIf

	Local $Mode=GUICtrlRead($AutoSend1_ComboBox_Mode)
	Local $Keys=_ArrayToStringBySai($ArrayKey1,"")

;~ 	Nhấn liên tục
	If $Mode=$AutoSend1_ComboBox_ModeT1 Then $AutoSend1= Not $AutoSend1

;~ 	Nhấn 1 cái
	If $Mode=$AutoSend1_ComboBox_ModeT3 Then Send("{"&$Keys&"}")

;~ 	Đóng/Mở check box
	If $AutoSend1 Then
		GUICtrlSetState($Autosend1_CheckBox,$GUI_DISABLE)
		ToolTip("1",0,0)
	Else
		GUICtrlSetState($Autosend1_CheckBox,$GUI_ENABLE)
		ToolTip("2",0,0)
	EndIf
EndFunc


;~ Hàm tự nhấn các phím thứ hai
Func AutoSendKeys2()
	If GUICtrlRead($AutoSend2_CheckBox)=4 Then
		$AutoSend2=False
		Return
	EndIf

	Local $Mode=GUICtrlRead($AutoSend2_ComboBox_Mode)
	Local $Keys=_ArrayToStringBySai($ArrayKey2,"")

;~ 	Nhấn liên tục
	If $Mode=$AutoSend2_ComboBox_ModeT1 Then $AutoSend2= Not $AutoSend2

;~ 	Nhấn 1 cái
	If $Mode=$AutoSend2_ComboBox_ModeT3 Then Send("{"&$Keys&"}")

;~ 	Đóng/Mở check box
	If $AutoSend2 Then
		GUICtrlSetState($Autosend2_CheckBox,$GUI_DISABLE)
	Else
		GUICtrlSetState($Autosend2_CheckBox,$GUI_ENABLE)
	EndIf
EndFunc


;~ Hàm thực hiện chức năng Click liên tục
Func AutoClickMode1()
	If GUICtrlRead($AutoClick_CheckBox)=1 And $Clicking Then
		MouseClick("left")
		;Hiển thị thông báo tình trạng đang hoạt động của AutoClick
		RunningCheck($AutoCLick_Lable3,$AuutoClickRunningI)
		If $AuutoClickRunningI=9 Then
			$AuutoClickRunningI=0
		EndIf
		$AuutoClickRunningI+=1
	Else
		GUICtrlSetData($AutoCLick_Lable3,"")
	EndIf
EndFunc


;~ 	Tự send các phím thứ nhất
Func AutoSend1Mode1()
	Send($ArrayKey1[$Keys1I])
	ToolTip($ArrayKey1[$Keys1I],0,0)
	$Keys1I+=1
	If $Keys1I>$ArrayKey1[0] Then $Keys1I=1
EndFunc


;~ 	Tự send các phím thứ hai
Func AutoSend2Mode1()
	Send($ArrayKey2[$Keys2I])
	ToolTip($ArrayKey2[$Keys2I],0,0)
	$Keys2I+=1
	If $Keys2I>$ArrayKey2[0] Then $Keys2I=1
EndFunc


;~ Hàm thay đổi danh sách phím sẽ bấm thứ nhất
Func ChangeKeys1()
	Local $Keys1=_ArrayToStringBySai($ArrayKey1,"")
	$Keys1=InputBox($AutoSend1_CheckBoxT1,$AutoSend1_Lable1T1,$Keys1,"",106,124)
	If $Keys1<>"" Then $Keys1=CheckKeys($Keys1)
	GUICtrlSetData($AutoSend1_Lable3,$Keys1)
	$ArrayKey1=StringSplit($Keys1," ")
	$Keys1I=1
EndFunc


;~ Hàm thay đổi danh sách phím sẽ bấm thứ hai
Func ChangeKeys2()
	Local $Keys2=_ArrayToStringBySai($ArrayKey2,"")
	$Keys2=InputBox($AutoSend1_CheckBoxT1,$AutoSend2_Lable1T1,$Keys2,"",106,124)
	If $Keys2<>"" Then $Keys2=CheckKeys($Keys2)
	GUICtrlSetData($AutoSend2_Lable3,$Keys2)
	$ArrayKey2=StringSplit($Keys2," ")
	$Keys2I=1
EndFunc


;~ Hàm kiểm tra xem danh sách phím sẽ bấm có đúng định dạng không
Func CheckKeys($Keys)

;~ 	Phân tích chuối
	Local $ArrayKey=StringSplit($Keys,",")

;~ 	Chia nhỏ phần tử dài
	For $i=$ArrayKey[0] To 1 Step -1
 		If StringLen($ArrayKey[$i])>1 Then
 			$ArraySplit=StringSplit($ArrayKey[$i],"")

;~ 			Loại bỏ phần tử dài
			_ArrayDelete($ArrayKey,$i)
			$ArrayKey[0]-=1

;~ 			Thêm vào các phần đã chia nhỏ
 			For $j=$ArraySplit[0] to 1 Step -1
 				_ArrayInsert($ArrayKey,$i,$ArraySplit[$j])
 				$ArrayKey[0]+=1
 			Next
 		EndIf
	Next

;~ 	Gộp chuỗi lại
	$Keys=""
	For $i=1 To $ArrayKey[0] Step 1
		If $i=$ArrayKey[0] Then
			$Keys&=$ArrayKey[$i]
		Else
			$Keys&=$ArrayKey[$i]&" "
		EndIf
	Next

;~ 	Viết Hoa tất cả các ký tự
	$Keys=StringUpper($Keys)

	Return $Keys
EndFunc


;~ Hàm chuyển Mảng thành chuỗi
Func _ArrayToStringBySai($Array,$Delim)
	Local $String = _ArrayToString($Array,$Delim)
	$String = StringReplace($String,$Array[0]&"","",1)
	Return $String
EndFunc


;~ Hàm nạp ngôn ngữ hiển thị
Func SetLanguage()
;~ Biến Mô Tả Chương Trình
	Global $AutoName="Sai AKM"							;Tên Chương Trình
	Global $AutoClass="AutoIt v3 GUI"				;Mã phân loại Chương Trình
	Global $AutoVersion="1.0"						;Phiên Bản
	Global $AutoVersionCode="1802"					;Mã số Phiên Bản
	Global $FindNewVersionT=""
	Global $Author="Trần Minh Đức"					;Tên (các) Lập Trình Viện
	Global $BlogName="http://www.LeeSai.co.cc"		;Địa chỉ Blog
	Global $BlogNameFull="http://my.opera.com/saihukaru/blog/"
	Global $LinkDown="http://my.opera.com/saihukaru/blog/auto-saiatlbb"
	Global $AutoTitle=$AutoName&" v"&$AutoVersion

;~ 	Các chức năng của Chương Trình
	Global $Functions=@LF
	$Functions&="  +Tự bấm chuột"&@LF
	$Functions&="  +Tự bấm ký tự"&@LF

;~ Biến ngôn ngữ
	Global $Menu_FileT="&Quản Lý"
	Global $Menu_File_ExitT="&Thoát"

	Global $Menu_HelpT="&Hỗ Trợ"
	Global $Menu_Help_HotKeyT="&Phím Nóng"
	Global $Menu_Help_AboutT="&Thông Tin"

	Global $AutoCLick_LableT1="Tự Click:"
	Global $AutoClick_ComboBox_ModeT1="Liên tục"
	Global $AutoClick_ComboBox_ModeT2="Giữ luôn"
	Global $AutoClick_ComboBox_ModeT3="Một cái"
	Global $AutoCLick_Lable2T1="bằng"

	Global $AutoSend1_CheckBoxT1="Tự nhấn:"
	Global $AutoSend1_ComboBox_ModeT1="Liên tục"
;~ 	Global $AutoSend1_ComboBox_ModeT2="Giữ luôn"
	Global $AutoSend1_ComboBox_ModeT3="Một cái"
	Global $AutoSend1_Lable1T1="bằng F1"
	Global $AutoSend1_Lable2T1="Các phím thứ nhất:"
	Global $AutoSend1_Lable2_Tip1="Các phím sẽ được tự nhấn bằng F1."
	Global $AutoSend1_Lable3T1="  <= Bấm vào đây"

	Global $AutoSend2_CheckBoxT1="Tự nhấn:"
	Global $AutoSend2_ComboBox_ModeT1="Liên tục"
;~ 	Global $AutoSend2_ComboBox_ModeT2="Giữ luôn"
	Global $AutoSend2_ComboBox_ModeT3="Một cái"
	Global $AutoSend2_Lable1T1="bằng F2"
	Global $AutoSend2_Lable2T1="Các phím thứ hai:"
	Global $AutoSend2_Lable2_Tip1="Các phím sẽ được tự nhấn bằng F2."
	Global $AutoSend2_Lable3T1="  <= Bấm vào đây"

	Global $Hidden_ButtonT="/\"
	Global $Button_ShowT="\/"
	Global $Hidden_Button_TipT="Thu gọn chương trình"
	Global $Pause_ButtonT1="<  >"
	Global $Pause_ButtonT2="<>"
	Global $Pause_Button_TipT="Tạm ngưng hoạt động"
	Global $Exit_ButtonT="X"
	Global $Exit_Button_TipT="Thoát chương trình"

	Global $EnoughAutoT=$AutoName&" đã chạy đủ."&@LF&"Không thể mở thêm!!!"
	Global $PauseAutoT="Tạm dừng"
	Return True
EndFunc


;~ Hàm tạo giao diện
Func CreateMainGUI()
	Global $Vertically=7 ;Cách khoảng từ trái sang phải
	Global $Horizontally=5 ;Cách khoảng từ trên xuống dưới

;~ 	Khởi tạo Giao Diện
	Global $MainGUI_Size[2] = [275,223] ;Kích thước
	Global $MainGUI_Pos[2] = [@DesktopWidth/2-$MainGUI_Size[1]/2,0] ;Vị trí
	Global $MainGUI=GUICreate($AutoTitle,$MainGUI_Size[0],$MainGUI_Size[1],$MainGUI_Pos[0],$MainGUI_Pos[1],$WS_BORDER,$WS_EX_TOPMOST+$WS_EX_TOOLWINDOW)
	GUISetBkColor(0xFFFFFF,$MainGUI)

	$MenuTittle_Size=38.5
;~ 	Menu Quản Lý
	$Menu_File=GUICtrlCreateMenu($Menu_FileT)
;~ 	Items của Quản Lý - Thoat
	$Menu_File_Exit=GUICtrlCreateMenuItem($Menu_File_ExitT,$Menu_File)
	GUICtrlSetOnEvent($Menu_File_Exit,"ExitAuto")

;~ 	Menu Help
	$Menu_Help=GUICtrlCreateMenu($Menu_HelpT)
	$Menu_Help_HotKey=GUICtrlCreateMenuItem($Menu_Help_HotKeyT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_HotKey,"ShowHotKey")
	$Menu_Help_About=GUICtrlCreateMenuItem($Menu_Help_AboutT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_About,"ShowInfoAuto")

;~ 	Nút thoát
	Global $Exit_Button_Size[2]=[25,22]
	Global $Exit_Button_Pos[2]=[$MainGUI_Size[0]-$Exit_Button_Size[0]-$Vertically,$MainGUI_Size[1]-$Exit_Button_Size[1]-$MenuTittle_Size-$Horizontally]
	Global $Exit_Button=GUICtrlCreateButton($Exit_ButtonT,$Exit_Button_Pos[0],$Exit_Button_Pos[1],$Exit_Button_Size[0],$Exit_Button_Size[1])
	GUICtrlSetOnEvent($Exit_Button,"ExitAuto")
	GUICtrlSetTip($Exit_Button,$Exit_Button_TipT)
;~ 	Nút tạm ngưng
	Global $Pause_Button_Size[2]=[$Exit_Button_Size[0],$Exit_Button_Size[1]]
	Global $Pause_Button_Pos[2]=[$Exit_Button_Pos[0]-$Pause_Button_Size[0],$Exit_Button_Pos[1]]
	Global $Pause_Button=GUICtrlCreateButton($Pause_ButtonT1,$Pause_Button_Pos[0],$Pause_Button_Pos[1],$Pause_Button_Size[0],$Pause_Button_Size[1])
	GUICtrlSetOnEvent($Pause_Button,"ActivePauseAuto")
	GUICtrlSetTip($Pause_Button,$Pause_Button_TipT)
;~ 	Nút ẩn hiện
	Global $Hidden_Button_Size[2]=[$Exit_Button_Size[0],$Exit_Button_Size[1]]
	Global $Hidden_Button_Pos[2]=[$Pause_Button_Pos[0]-$Hidden_Button_Size[0],$Pause_Button_Pos[1]]
	Global $Hidden_Button=GUICtrlCreateButton($Hidden_ButtonT,$Hidden_Button_Pos[0],$Hidden_Button_Pos[1],$Hidden_Button_Size[0],$Hidden_Button_Size[1])
	GUICtrlSetOnEvent($Hidden_Button,"HiddenShow")
	GUICtrlSetTip($Hidden_Button,$Hidden_Button_TipT)

;~ 	Nơi hiển thị thông báo
	Global $Warning_Lable_Size[2]=[$MainGUI_Size[0],16]
	Global $Warning_Lable_Pos[2]=[0,$Exit_Button_Pos[1]-$Warning_Lable_Size[1]]
	Global $Warning_Lable=GUICtrlCreateLabel("",$Warning_Lable_Pos[0],$Warning_Lable_Pos[1],$Warning_Lable_Size[0],$Warning_Lable_Size[1],$SS_CENTER)
	GUICtrlSetColor($Warning_Lable,0x0077FF)
	GUICtrlSetFont($Warning_Lable,9,777)

;~ 	Nơi hiển thị tình trạng hoạt động
	Global $Running_Lable_Size[2]=[9,13.3]
	Global $Running_Lable_Pos[2]=[$Vertically,$Hidden_Button_Pos[1]+$Horizontally]
	Global $Running_Lable=GUICtrlCreateLabel("",$Running_Lable_Pos[0],$Running_Lable_Pos[1],$Running_Lable_Size[0],$Running_Lable_Size[1])
	GUICtrlSetColor($Running_Lable,0x0077FF)

;~ 	CheckBox tự động Click
	Global $AutoCLick_CheckBox_Size[2]=[77,16]
	Global $AutoCLick_CheckBox_Pos[2]=[$Vertically,$Horizontally]
	Global $AutoCLick_CheckBox=GUICtrlCreateCheckbox($AutoCLick_LableT1,$AutoCLick_CheckBox_Pos[0],$AutoCLick_CheckBox_Pos[1],$AutoCLick_CheckBox_Size[0],$AutoCLick_CheckBox_Size[1])
	GUICtrlSetOnEvent($AutoCLick_CheckBox,"HotKeySet4AutoCLick")
;~ 	GUICtrlSetState($AutoClick_CheckBox,$GUI_CHECKED)
	GUICtrlSetFont($AutoClick_CheckBox,9,572)
	GUICtrlSetColor($AutoCLick_CheckBox,0x858DFF)
;~ 	ComboBox chọn chế độ Click
	Global $AutoClick_ComboBox_Mode_Size[2]=[70,27]
	Global $AutoClick_ComboBox_Mode_Pos[2]=[$AutoCLick_CheckBox_Pos[0]+$AutoCLick_CheckBox_Size[0],$AutoCLick_CheckBox_Pos[0]-2.5]
	Global $AutoClick_ComboBox_Mode=GUICtrlCreateCombo($AutoClick_ComboBox_ModeT1,$AutoClick_ComboBox_Mode_Pos[0],$AutoClick_ComboBox_Mode_Pos[1],$AutoClick_ComboBox_Mode_Size[0],$AutoClick_ComboBox_Mode_Size[1],$CBS_DROPDOWNLIST)
	GUICtrlSetData($AutoClick_ComboBox_Mode,$AutoClick_ComboBox_ModeT2&"|"&$AutoClick_ComboBox_ModeT3,$AutoClick_ComboBox_ModeT1)
	GUICtrlSetOnEvent($AutoClick_ComboBox_Mode,"HotKeySet4AutoCLick")
;~ 	Lable tự động Click 2 (bằng)
	Global $AutoCLick_Lable2_Size[2]=[34,16]
	Global $AutoCLick_Lable2_Pos[2]=[$AutoClick_ComboBox_Mode_Pos[0]+$AutoClick_ComboBox_Mode_Size[0],$AutoCLick_CheckBox_Pos[1]+2.5]
	Global $AutoCLick_Lable2=GUICtrlCreateLabel($AutoCLick_Lable2T1,$AutoCLick_Lable2_Pos[0],$AutoCLick_Lable2_Pos[1],$AutoCLick_Lable2_Size[0],$AutoCLick_Lable2_Size[1],$SS_CENTER)
	GUICtrlSetColor($AutoClick_Lable2,0x0077FF)
;~ 	Chỗ nhập phím nóng của chế độ Click
	Global $AutoClick_ComboBox_HotKey_Size[2]=[61,27]
	Global $AutoClick_ComboBox_HotKey_Pos[2]=[$AutoCLick_Lable2_Pos[0]+$AutoCLick_Lable2_Size[0],$AutoClick_ComboBox_Mode_Pos[1]]
	Global $AutoClick_ComboBox_HotKey=GUICtrlCreateCombo("Space",$AutoClick_ComboBox_HotKey_Pos[0],$AutoClick_ComboBox_HotKey_Pos[1],$AutoClick_ComboBox_HotKey_Size[0],$AutoClick_ComboBox_HotKey_Size[1],$CBS_DROPDOWNLIST)
	GUICtrlSetData($AutoClick_ComboBox_HotKey,"F7|F8|F9|???")
	GUICtrlSetOnEvent($AutoClick_ComboBox_HotKey,"HotKeySet4AutoCLick")
;~ 	Lable tự động Click 3
	Global $AutoCLick_Lable3_Size[2]=[16,16]
	Global $AutoSend_Lable1_Size[2]=[$AutoClick_ComboBox_HotKey_Pos[0]+$AutoClick_ComboBox_HotKey_Size[0],$AutoCLick_CheckBox_Pos[1]+2.5]
	Global $AutoCLick_Lable3=GUICtrlCreateLabel("",$AutoSend_Lable1_Size[0],$AutoSend_Lable1_Size[1],$AutoCLick_Lable3_Size[0],$AutoCLick_Lable3_Size[1],$SS_CENTER)
	GUICtrlSetColor($AutoCLick_Lable3,0x0077FF)

;~ 	CheckBox tự động bấm nút (1)
	Global $AutoSend1_CheckBox_Size[2]=[77,16]
	Global $AutoSend1_CheckBox_Pos[2]=[$AutoCLick_CheckBox_Pos[0],$AutoClick_ComboBox_Mode_Size[1]+$Horizontally+16]
	Global $AutoSend1_CheckBox=GUICtrlCreateCheckbox($AutoSend1_CheckBoxT1,$AutoSend1_CheckBox_Pos[0],$AutoSend1_CheckBox_Pos[1],$AutoSend1_CheckBox_Size[0],$AutoSend1_CheckBox_Size[1])
	GUICtrlSetOnEvent($AutoSend1_CheckBox,"")
;~ 	GUICtrlSetState($AutoSend1_CheckBox,$GUI_CHECKED)
	GUICtrlSetFont($AutoSend1_CheckBox,9,610)
;~ 	ComboBox chọn chế độ nhấn (1)
	Global $AutoSend1_ComboBox_Mode_Size[2]=[70,20]
	Global $AutoSend1_ComboBox_Mode_Pos[2]=[$AutoSend1_CheckBox_Pos[0]+$AutoSend1_CheckBox_Size[0],$AutoSend1_CheckBox_Pos[1]-2.5]
	Global $AutoSend1_ComboBox_Mode=GUICtrlCreateCombo($AutoSend1_ComboBox_ModeT1,$AutoSend1_ComboBox_Mode_Pos[0],$AutoSend1_ComboBox_Mode_Pos[1],$AutoSend1_ComboBox_Mode_Size[0],$AutoSend1_ComboBox_Mode_Size[1],$CBS_DROPDOWNLIST)
	GUICtrlSetData($AutoSend1_ComboBox_Mode,$AutoSend1_ComboBox_ModeT3,$AutoSend1_ComboBox_ModeT1)
	GUICtrlSetOnEvent($AutoSend1_ComboBox_Mode,"HotKeySet4AutoCLick")
;~ 	Lable1 tự nhấn (Chữ bằng) (1)
	Global $AutoSend1_Lable1_Size[2]=[52,16]
	Global $AutoSend1_Lable1_Pos[2]=[$AutoSend1_ComboBox_Mode_Pos[0]+$AutoSend1_ComboBox_Mode_Size[0],$AutoSend1_CheckBox_Pos[1]]
	Global $AutoSend1_Lable1=GUICtrlCreateLabel($AutoSend1_Lable1T1,$AutoSend1_Lable1_Pos[0],$AutoSend1_Lable1_Pos[1],$AutoSend1_Lable1_Size[0],$AutoSend1_Lable1_Size[1],$SS_CENTER)
	GUICtrlSetColor($AutoSend1_Lable1,0x0077FF)
;~ 	Lable2 tự nhấn (Chữ Các Phím...) (1)
	Global $AutoSend1_Lable2_Size[2]=[115,16]
	Global $AutoSend1_Lable2_Pos[2]=[$AutoSend1_CheckBox_Pos[0],$AutoSend1_CheckBox_Pos[1]+$AutoSend1_ComboBox_Mode_Size[1]]
	Global $AutoSend1_Lable2=GUICtrlCreateLabel($AutoSend1_Lable2T1,$AutoSend1_Lable2_Pos[0],$AutoSend1_Lable2_Pos[1],$AutoSend1_Lable2_Size[0],$AutoSend1_Lable2_Size[1],$SS_CENTER)
	GUICtrlSetTip($AutoSend1_Lable2,$AutoSend1_Lable2_Tip1)
	GUICtrlSetOnEvent($AutoSend1_Lable2,"ChangeKeys1")
;~ 	GUICtrlSetColor($AutoSend1_Lable2,0x0077FF)
	GUICtrlSetFont($AutoSend1_Lable2,9,777)
;~ 	Lable3 tự nhấn (1)(chứa các phím sẽ nhấn)
	Global $AutoSend1_Lable3_Size[2]=[$MainGUI_Size[0],16]
	Global $AutoSend1_Lable3_Pos[2]=[$AutoSend1_Lable2_Pos[0]+$AutoSend1_Lable2_Size[0],$AutoSend1_Lable2_Pos[1]]
	Global $AutoSend1_Lable3=GUICtrlCreateLabel("d s a"&$AutoSend1_Lable3T1,$AutoSend1_Lable3_Pos[0],$AutoSend1_Lable3_Pos[1],$AutoSend1_Lable3_Size[0],$AutoSend1_Lable3_Size[1])
	GUICtrlSetTip($AutoSend1_Lable3,$AutoSend1_Lable2_Tip1)
	GUICtrlSetOnEvent($AutoSend1_Lable3,"ChangeKeys1")
	GUICtrlSetColor($AutoSend1_Lable3,0x0077FF)
	GUICtrlSetFont($AutoSend1_Lable3,9,777)

;~ 	CheckBox tự động bấm nút (2)
	Global $AutoSend2_CheckBox_Size[2]=[77,16]
	Global $AutoSend2_CheckBox_Pos[2]=[$AutoSend1_CheckBox_Pos[0],$AutoSend1_CheckBox_Pos[1]+$AutoSend1_ComboBox_Mode_Size[1]+$AutoSend1_Lable3_Size[1]+$Horizontally+16]
	Global $AutoSend2_CheckBox=GUICtrlCreateCheckbox($AutoSend2_CheckBoxT1,$AutoSend2_CheckBox_Pos[0],$AutoSend2_CheckBox_Pos[1],$AutoSend2_CheckBox_Size[0],$AutoSend2_CheckBox_Size[1])
	GUICtrlSetOnEvent($AutoSend2_CheckBox,"")
;~ 	GUICtrlSetState($AutoSend2_CheckBox,$GUI_CHECKED)
	GUICtrlSetFont($AutoSend2_CheckBox,9,610)
;~ 	ComboBox chọn chế độ nhấn (2)
	Global $AutoSend2_ComboBox_Mode_Size[2]=[70,20]
	Global $AutoSend2_ComboBox_Mode_Pos[2]=[$AutoSend2_CheckBox_Pos[0]+$AutoSend2_CheckBox_Size[0],$AutoSend2_CheckBox_Pos[1]-2.5]
	Global $AutoSend2_ComboBox_Mode=GUICtrlCreateCombo($AutoClick_ComboBox_ModeT1,$AutoSend2_ComboBox_Mode_Pos[0],$AutoSend2_ComboBox_Mode_Pos[1],$AutoSend2_ComboBox_Mode_Size[0],$AutoSend2_ComboBox_Mode_Size[1],$CBS_DROPDOWNLIST)
	GUICtrlSetData($AutoSend2_ComboBox_Mode,$AutoSend2_ComboBox_ModeT3,$AutoClick_ComboBox_ModeT1)
	GUICtrlSetOnEvent($AutoSend2_ComboBox_Mode,"HotKeySet4AutoCLick")
;~ 	Lable1 tự động nhấn (2)
	Global $AutoSend2_Lable1_Size[2]=[52,16]
	Global $AutoSend2_Lable1_Pos[2]=[$AutoSend2_ComboBox_Mode_Pos[0]+$AutoSend2_ComboBox_Mode_Size[0],$AutoSend2_CheckBox_Pos[1]]
	Global $AutoSend2_Lable1=GUICtrlCreateLabel($AutoSend2_Lable1T1,$AutoSend2_Lable1_Pos[0],$AutoSend2_Lable1_Pos[1],$AutoSend2_Lable1_Size[0],$AutoSend2_Lable1_Size[1],$SS_CENTER)
	GUICtrlSetColor($AutoSend2_Lable1,0x0077FF)
;~ 	Lable2 tự nhấn (Chữ Các phím...)(2)
	Global $AutoSend2_Lable2_Size[2]=[115,16]
	Global $AutoSend2_Lable2_Pos[2]=[$AutoSend2_CheckBox_Pos[0],$AutoSend2_CheckBox_Pos[1]+$AutoSend2_ComboBox_Mode_Size[1]]
	Global $AutoSend2_Lable2=GUICtrlCreateLabel($AutoSend2_Lable2T1,$AutoSend2_Lable2_Pos[0],$AutoSend2_Lable2_Pos[1],$AutoSend2_Lable2_Size[0],$AutoSend2_Lable2_Size[1],$SS_CENTER)
	GUICtrlSetTip($AutoSend2_Lable2,$AutoSend2_Lable2_Tip1)
	GUICtrlSetOnEvent($AutoSend2_Lable2,"ChangeKeys2")
	GUICtrlSetFont($AutoSend2_Lable2,9,777)
;~ 	Lable3 tự nhấn (2)(chứa các phím sẽ nhấn)
	Global $AutoSend2_Lable3_Size[2]=[$MainGUI_Size[0],16]
	Global $AutoSend2_Lable3_Pos[2]=[$AutoSend2_Lable2_Pos[0]+$AutoSend2_Lable2_Size[0],$AutoSend2_Lable2_Pos[1]]
	Global $AutoSend2_Lable3=GUICtrlCreateLabel("1 2 3"&$AutoSend2_Lable3T1,$AutoSend2_Lable3_Pos[0],$AutoSend2_Lable3_Pos[1],$AutoSend2_Lable3_Size[0],$AutoSend2_Lable3_Size[1])
	GUICtrlSetTip($AutoSend2_Lable3,$AutoSend2_Lable2_Tip1)
	GUICtrlSetOnEvent($AutoSend2_Lable3,"ChangeKeys2")
	GUICtrlSetColor($AutoSend2_Lable3,0x0077FF)
	GUICtrlSetFont($AutoSend2_Lable3,9,777)

;~  	GUICtrlSetBkColor(-1,0xFFAA77)
EndFunc
;~ Hiển Thị Giao Diện
Func ShowMainGUI()
	GUISetState(@SW_SHOW,$MainGUI)
EndFunc
;~ Ẩn Giao Diện
Func HideMainGUI()
	GUISetState(@SW_HIDE,$MainGUI)
EndFunc
;~ 2 Hàm Ẩn/Hiện thông báo trong Gui
Func ShowWarningGUI()
	If $Hidden Then WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1]-$MainGUI_Size[1]+$Hidden_Button_Size[1]+$Warning_Lable_Size[1]+$Horizontally,Default,Default,2)
EndFunc
Func HiddenWarningGUI()
	If $Hidden Then WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1]-$MainGUI_Size[1]+$Hidden_Button_Size[1]+$Horizontally,Default,Default,2)
EndFunc


;~ Hàm thoát Auto
Func ExitAuto()
	GUIDelete($MainGUI)
	Exit
EndFunc
;------- Hết Các Hàm Hoàn Chỉnh -------------------------------------------------------------------------------------------------------

;-- Các Hàm Đang Tạo ------------------------------------------------------------------------------------------------------------------
;------- Hết Các Hàm Đang Tạo ---------------------------------------------------------------------------------------------------------