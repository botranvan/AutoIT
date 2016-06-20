#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <WindowsConstants.au3>

FileInstall("TAHOMA.ttf",@WindowsDir & "\Fonts\")
FileInstall("tahomabd.ttf",@WindowsDir & "\Fonts\")



Opt("TrayMenuMode", 1) ; hien icon nhung khong hien hien Pause khi nhay chuot phai
;; FORM 1
MsgBox(64,"Thông báo","Bạn không được nhập kí tự" & @CRLF & "Ấn ESC để thoát chương trình")

Global $csa,$csb,$csc,$delta,$delta_phay,$bbinh,$bphay

#Region ### START Koda GUI section ### Form=D:\Hoc Tap\My autoit\PROJECT\GPT\Form1.kxf
$Form1 = GUICreate("Giai phuong trinh v1.0", 308, 255, 192, 114)
GUISetFont(10, 400, 0, "Tahoma")
$Tab1 = GUICtrlCreateTab(8, 32, 289, 193)
GUICtrlSetResizing(-1, $GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$TabSheet1 = GUICtrlCreateTabItem("Bậc nhất 1 ẩn")
$Label3 = GUICtrlCreateLabel("Phương trình có dạng : ax + b = 0 (a#0)", 24, 64, 235, 20)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$Label4 = GUICtrlCreateLabel("Hệ số A :", 24, 88, 57, 20)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$bn1aA = GUICtrlCreateInput("", 88, 88, 193, 24)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$Label5 = GUICtrlCreateLabel("Hệ số B :", 24, 120, 56, 20)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$bn1aB = GUICtrlCreateInput("", 88, 120, 193, 24)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$gbn1a = GUICtrlCreateButton("Giải phương trình", 56, 152, 123, 25, $WS_GROUP)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$Label6 = GUICtrlCreateLabel("x = ", 16, 192, 27, 20)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$kqbn1a = GUICtrlCreateInput("", 56, 192, 225, 24)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$round_bn1a = GUICtrlCreateLabel("Làm tròn kết quả", 184, 160, 101, 20)
GUICtrlSetFont(-1, 10, 400, 2, "Tahoma")

$TabSheet2 = GUICtrlCreateTabItem("Bậc 2 một ẩn")
GUICtrlSetState(-1,$GUI_SHOW)
$Label7 = GUICtrlCreateLabel("Phương trình có dạng : ax^2 + bx + c = 0", 16, 64, 242, 20)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$Label8 = GUICtrlCreateLabel("Hệ số A :", 16, 88, 57, 20)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$b21aA = GUICtrlCreateInput("", 80, 88, 201, 24)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$Label9 = GUICtrlCreateLabel("Hệ số B : ", 16, 120, 60, 20)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$b21aB = GUICtrlCreateInput("", 80, 120, 201, 24)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$Label10 = GUICtrlCreateLabel("Hệ số C :", 16, 152, 57, 20)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$b21aC = GUICtrlCreateInput("", 80, 152, 201, 24)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$gpt2 = GUICtrlCreateButton("Giải phương trình", 96, 184, 107, 25, $WS_GROUP)
GUICtrlSetFont(-1, 10, 400, 0, "Tahoma")
$TabSheet3 = GUICtrlCreateTabItem("Hệ PT bậc nhất 1 ẩn")
GUICtrlCreateTabItem("")
$Label1 = GUICtrlCreateLabel("Giải phương trình :", 8, 8, 110, 20)
$Label2 = GUICtrlCreateLabel("© Autoboy195 - Giải phương trình v1.0", 32, 232, 225, 20)
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
;; FORM 2 - Result of PTB2
#Region ### START Koda GUI section ### Form=D:\Hoc Tap\My autoit\PROJECT\GPT\Form2.kxf
$Form2 = GUICreate("Ket qua phuong trinh bac 2 ", 259, 132, 192, 114)
GUISetFont(11, 400, 0, "Tahoma")
$Label1 = GUICtrlCreateLabel("x1 =", 8, 8, 36, 22)
$b21ax1 = GUICtrlCreateInput("", 48, 8, 201, 26)
$Label2 = GUICtrlCreateLabel("x2 =", 8, 48, 36, 22)
$b21ax2 = GUICtrlCreateInput("", 48, 48, 201, 26)
$DongPTB2 = GUICtrlCreateButton("Đóng", 96, 80, 75, 25, $WS_GROUP)
$xem_phanso = GUICtrlCreateLabel("Xem ở dạng phân số", 64, 104, 141, 22)
GUICtrlSetTip(-1,"Không áp dụng cho phương trình khuyết hệ số C","Thông tin")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
;; FORM 3 - xem o dang phan so
#Region ### START Koda GUI section ### Form=D:\Hoc Tap\My autoit\PROJECT\GPT\Form3.kxf
$Form3 = GUICreate("Ket qua o dang phan so", 334, 140, 192, 114)
GUISetFont(12, 400, 0, "Tahoma")
$Label1 = GUICtrlCreateLabel("x1 = ", 8, 40, 43, 23)
$Graphic1 = GUICtrlCreateGraphic(48, 48, 96, 2, BitOR($SS_ETCHEDHORZ,$SS_NOTIFY))
GUICtrlSetColor(-1, 0x000000)
$x1_tuso = GUICtrlCreateInput("", 56, 8, 89, 27)
$x1_mauso = GUICtrlCreateInput("", 56, 64, 89, 27, BitOR($ES_CENTER,$ES_AUTOHSCROLL))
$Label2 = GUICtrlCreateLabel(";", 160, 40, 10, 23)
$Label3 = GUICtrlCreateLabel("x2 =", 176, 40, 38, 23)
$Graphic2 = GUICtrlCreateGraphic(216, 48, 102, 2, BitOR($SS_ETCHEDHORZ,$SS_NOTIFY))
GUICtrlSetColor(-1, 0x000000)
$x2_tuso = GUICtrlCreateInput("", 216, 8, 97, 27)
$x2_mauso = GUICtrlCreateInput("", 216, 64, 97, 27, BitOR($ES_CENTER,$ES_AUTOHSCROLL))
$dong_phanso = GUICtrlCreateButton("Dong", 128, 104, 75, 25, $WS_GROUP)
#EndRegion ### END Koda GUI section ###
GUISetState(@SW_HIDE,$Form2)
GUISetState(@SW_HIDE,$Form3)
GUISetState(@SW_SHOW,$Form1)

While 1
HotKeySet("{ESC}","thaot")
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case -3
			GUISetState(@SW_MINIMIZE,$Form1)
		Case $gbn1a
			PTBN()
		Case $gpt2
			if StringIsAlpha(GUICtrlRead($b21aA)) or StringIsAlpha(GUICtrlRead($b21aB)) or StringIsAlpha(GUICtrlRead($b21aC))  Then
				GUISetState(@SW_HIDE,$Form2)
				MsgBox(64,"^ ^","Nhập linh tinh gì vậy cha !")
			Else
				PT2()
			EndIf
		case $DongPTB2
			GUISetState(@SW_HIDE,$Form2)
		case $xem_phanso
			GUISetState(@SW_HIDE,$Form2)
			MsgBox(64,"","Kí hiệu : √ là căn bậc hai")
			GUISetState(@SW_SHOW,$Form3)
			xemphanso()
		case $dong_phanso
			GUISetState(@SW_HIDE,$Form3)
		case $round_bn1a
			$bn1a_x = (GUICtrlRead($bn1aB) * -1)/GUICtrlRead($bn1aA) ; Tinh x
			if StringIsFloat(GUICtrlRead($kqbn1a)) then ; nếu kết quả là số thập phân
				GUICtrlSetData($kqbn1a,Round($bn1a_x,3)) ; làm tròn
			Else
			MsgBox(64,"^^","Không phải là số thập phân sao làm tròn được cha ^^")
			EndIf

			if StringIsAlpha(guictrlread($kqbn1a)) Then
				MsgBox(64,"^ ^","Nhập linh tinh gì vậy cha !")
			Else
			EndIf
	EndSwitch
WEnd

;; Func giai PT
Func PTBN()
$bn1a_x = (GUICtrlRead($bn1aB) * -1)/GUICtrlRead($bn1aA) ; Tinh x
if guictrlread($bn1aA) = 0 or guictrlread($bn1aA) = "" then
GUICtrlSetData($kqbn1a,"Lỗi nhập liệu")
MsgBox(0,"","Hệ số A phải khác 0")
Elseif GUICtrlRead($bn1aB) = "" then
MsgBox(0,"","Bạn chưa nhập hệ số B")
GUICtrlSetData($kqbn1a,"Lỗi nhập liệu")
Else
EndIf
GUICtrlSetData($kqbn1a,$bn1a_x)
EndFunc

Func PT2()
$csa = GUICtrlRead($b21aA)
$csb = GUICtrlRead($b21aB)
$csc = GUICtrlRead($b21aC)
;; TINH TOAN
GUISetState(@SW_SHOW,$Form2)
if $csa = "" or $csb = "" or $csc = "" Then
MsgBox(0,"","Bạn chưa nhập đủ các hệ số!") ; Kiem tra du lieu
GUISetState(@SW_HIDE,$Form2)
Else
EndIf
if Mod($csb,2) = 0 Then ; Neu he so b chan thi tinh theo delta phay
	deltaphay_b2()
Else ; khong thi tinh theo delta
	delta_b2()
EndIf
EndFunc

Func delta_b2()
; [Khai bao]
; Delta
$bbinh = $csb * $csb
$delta = $bbinh - (4*$csa*$csc)
; [Result]
; Delta
$delta_x1 = (-$csb +Sqrt($delta))/($csa+$csa)
$delta_x2 = (-$csb -Sqrt($delta))/($csa+$csa)
$nghiemkep = -$csb/($csa+$csa)
; Kiem tra
if $delta > 0 then
GUICtrlSetData($b21ax1,$delta_x1)
Guictrlsetdata($b21ax2,$delta_x2)
Elseif $delta = 0 Then
;MsgBox(0,"","Phuong trinh co nghiem kep x1 = x2 =" & Round($nghiemkep,2))
GUICtrlSetData($b21ax1,$nghiemkep)
Guictrlsetdata($b21ax2,$nghiemkep)
Elseif $delta < 0 Then
GUISetState(@SW_HIDE,$Form2)
MsgBox(0,"","Phương trình Vô nghiệm!")
EndIf
EndFunc

Func deltaphay_b2()
; Delta phay
$bphay = $csb / 2
$bphay_binh = $bphay * $bphay
$deltaphay_ac = $csa * $csc
$delta_phay = $bphay_binh - $deltaphay_ac
; Deltaphay
$deltaphay_x1 = (-$bphay + Sqrt($delta_phay)) /$csa
$deltaphay_x2 = (-$bphay - Sqrt($delta_phay)) /$csa
$nghiemkep_delta_phay = -$bphay/$csa
; Kiem tra
if $delta_phay > 0 then
GUICtrlSetData($b21ax1,$deltaphay_x1)
Guictrlsetdata($b21ax2,$deltaphay_x2)
Elseif $delta_phay = 0 Then
;MsgBox(0,"","Phuong trinh co nghiem kep x1 = x2 =" & Round($nghiemkep,3))
GUICtrlSetData($b21ax1,$nghiemkep_delta_phay)
Guictrlsetdata($b21ax2,$nghiemkep_delta_phay)
Elseif $delta_phay < 0 Then
MsgBox(0,"","Phương trình Vô nghiệm!")
GUISetState(@SW_HIDE,$Form2)
EndIf
EndFunc

Func xemphanso()
$deltaps = (GUICtrlRead($b21aB)*GUICtrlRead($b21aB))-(4 * GUICtrlRead($b21aA) * GUICtrlRead($b21aC))
$can2 = "√"
GUICtrlSetData($x1_tuso,-$csb & " + " & $can2 & $deltaps)
GUICtrlSetData($x1_mauso,$csa + $csa)

GUICtrlSetData($x2_tuso,-$csb & " - " & $can2 & $deltaps)
GUICtrlSetData($x2_mauso,$csa + $csa)
EndFunc

Func thaot()
	MsgBox(64,"© autoboy195","Cảm ơn bạn đã sử dụng chương trình ^^",1)
	Exit
EndFunc
