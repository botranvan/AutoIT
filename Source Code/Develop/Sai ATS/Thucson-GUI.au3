#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <StaticConstants.au3>
#include <TabConstants.au3>
#include <ProgressConstants.au3>
#include <WindowsConstants.au3>
Global $botinfo = "Hello we are the world, but how can we dare to die!! Die hard pepole";
Global $Skill[4] ; Combo box for skill
Global $buff[4] ; 0->1:Buff skill; 2->3: rest
Global $delay[8] ; 0->3: skill delay; 4->5: buff delay

GUICreate("Thục Sơn Auto", 336, 296, 800, 100)
GUICtrlCreateTab(0, 0, 337, 297)
GUICtrlSetResizing(-1, $GUI_DOCKWIDTH+$GUI_DOCKHEIGHT)
$Tab1 = GUICtrlCreateTabItem("Thiết lập")
GUICtrlCreateGroup("Tấn công", 16, 25, 305, 145)
GUICtrlCreateLabel("Skill 1", 22, 48, 36, 17)
GUICtrlCreateLabel("Skill 2", 22, 78, 36, 17)
GUICtrlCreateLabel("Skill 3", 22, 108, 36, 17)
GUICtrlCreateLabel("Skill 4", 22, 138, 36, 17)
$Skill[0] = GUICtrlCreateCombo("none", 70, 48, 145, 25)
$Skill[1] = GUICtrlCreateCombo("none", 70, 78, 145, 25)
$Skill[2] = GUICtrlCreateCombo("none", 70, 108, 145, 25)
$Skill[3]= GUICtrlCreateCombo("none", 70, 138, 145, 25)
$delay[0] = GUICtrlCreateInput("0", 230, 48, 33, 21)
$delay[1] = GUICtrlCreateInput("0", 230, 78, 33, 21)
$delay[2] = GUICtrlCreateInput("0", 230, 108, 33, 21)
$delay[3] = GUICtrlCreateInput("0", 230, 138, 33, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Tự Buff", 16, 185, 305, 97)
GUICtrlCreateLabel("Buff 1", 25, 208, 36, 17)
GUICtrlCreateLabel("Buff 2", 25, 233, 36, 17)
$buff[0] = GUICtrlCreateCombo("none", 70, 205, 145, 25)
$buff[1] = GUICtrlCreateCombo("none", 70, 228, 145, 25)
$delay[4] = GUICtrlCreateInput("0", 230, 205 , 33, 21)
$delay[5] = GUICtrlCreateInput("0", 230, 228 , 33, 21)
GUICtrlCreateGroup("", -99, -99, 1, 1)
;==> End basic attack setting

$Tab2 = GUICtrlCreateTabItem("Nghỉ ngơi")
GUICtrlCreateGroup("Ngồi thiền", 16, 25, 305, 145)
GUICtrlCreateLabel("Di chuyển X:", 24, 50, 70, 18)
GUICtrlSetFont(-1, 8, 800, 0, "Arial")
$moveX = GUICtrlCreateInput("", 104, 48, 40, 20)
GUICtrlSetFont(-1, 8, 800, 0, "Arial")
GUICtrlCreateLabel("Di chuyển Y:", 154, 50, 70, 18)
GUICtrlSetFont(-1, 8, 800, 0, "Arial")
$moveY = GUICtrlCreateInput("", 224, 50, 40, 20)
GUICtrlSetFont(-1, 8, 800, 0, "Arial")
$getXY = GUICtrlCreateButton("Đọc tọa độ", 174, 78, 75, 20)
$checkCN = GUICtrlCreateCheckbox("Vận công để phục hồi?", 24, 78, 130, 20)
GUICtrlCreateLabel("Ngồi thiền:", 24, 118, 60, 18, $SS_CENTER)
GUICtrlCreateLabel("khi HP nhỏ hơn", 138, 118, 80, 18)
GUICtrlCreateLabel("%", 245, 118, 14, 18)

$buff[2] = GUICtrlCreateCombo("none", 80, 115, 55, 20) ; Rest up key
GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|0", "none")
GUICtrlSetFont(-1, 8, 400, 0, "Arial")

$delay[6] = GUICtrlCreateInput("40", 220, 115, 20, 20, $SS_CENTER)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")

GUICtrlCreateLabel("Ngồi thiền:", 24, 138, 60, 22, $SS_CENTER)
GUICtrlCreateLabel("khi MP nhỏ hơn", 138, 138, 80, 18)
GUICtrlCreateLabel("%", 245, 138, 14, 18)

$buff[3] = GUICtrlCreateCombo("none", 80, 135, 55, 20) ; Rest up key
GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|0", "none")
GUICtrlSetFont(-1, 8, 400, 0, "Arial")

$delay[7] = GUICtrlCreateInput("40", 220, 135, 20, 20, $SS_CENTER)
GUICtrlSetFont(-1, 8, 400, 0, "Arial")
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Thú nuôi", 16, 185, 305, 97)
#comments-start
Phan pet setting chua co viet cho phien ban free hehe
#comments-end
GUICtrlCreateGroup("", -99, -99, 1, 1)
;==> End resting system

$TabSheet3 = GUICtrlCreateTabItem("Nhân vật")
GUICtrlCreateGroup("Nhân vật", 16, 25, 305, 145)

GUICtrlCreateLabel("Tên nhân vật:", 22, 48, 70, 17)
$nickname = GUICtrlCreateLabel("Chưa biết", 92, 48, 70, 17) ; character's name 
GUICtrlSetFont(-1, 9, 10000, 0, "Arial")

GUICtrlCreateLabel("Level:", 225, 48, 30, 17)
$level = GUICtrlCreateLabel("0", 260, 48, 30, 17) ; character's level
GUICtrlSetFont(-1, 9, 10000, 0, "Arial")

GUICtrlCreateLabel("Sinh lực:", 22, 68, 70, 17)
$HPpro = GUICtrlCreateProgress(120, 65, 154, 18, $PBS_SMOOTH) ; build HP process bar
GUICtrlSetColor(-1, 0xF03B26)
$HPinfo = GUICtrlCreateLabel("0 / 0", 120, 68, 154, 18, $SS_CENTER) ; HP info
GUICtrlSetFont(-1, 8, 10000, 0, "Arial")

GUICtrlCreateLabel("Thể lực:", 22, 90, 70, 17)
$MPpro = GUICtrlCreateProgress(120, 88, 154, 18, $PBS_SMOOTH) ; build MP process bar
GUICtrlSetColor(-1, 0x49B0F5)
$MPinfo = GUICtrlCreateLabel("0 / 0", 120, 90, 154, 18, $SS_CENTER) ; MP info
GUICtrlSetFont(-1, 8, 10000, 0, "Arial")

GUICtrlCreateLabel("Kinh nghiệm:", 22, 112, 70, 17)
$EXPpro = GUICtrlCreateProgress(120, 110, 154, 18, $PBS_SMOOTH) ; build EXP process bar
GUICtrlSetColor(-1, 0xFFEE11)
$EXPinfo = GUICtrlCreateLabel("0 / 0", 120, 112, 154, 18, $SS_CENTER) ; EXP info
GUICtrlSetFont(-1, 8, 10000, 0, "Arial")

GUICtrlCreateLabel("Linh lực:", 22, 134, 70, 17)
$XPpro = GUICtrlCreateProgress(120, 132, 154, 18, $PBS_SMOOTH) ; build linh lực process bar
GUICtrlSetColor(-1, 0x6611AA)
$XPinfo = GUICtrlCreateLabel("0 / 0", 120, 134, 154, 18, $SS_CENTER) ; linh lực info
GUICtrlSetFont(-1, 8, 10000, 0, "Arial")

GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Thú nuôi", 16, 185, 305, 97)
#comments-start
Phan pet setting chua co viet cho phien ban free hehe tai cung chua co choi nhan vat hunter
#comments-end
GUICtrlCreateGroup("", -99, -99, 1, 1)
;==> End resting system


$TabSheet4 = GUICtrlCreateTabItem("Trợ giúp")
GUICtrlCreateEdit($botinfo, 22, 40, 293, 175, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_WANTRETURN))


$TabSheet5 = GUICtrlCreateTabItem("Thông tin")
GUICtrlCreateGroup("Logs", 16, 25, 305, 200)

$Log = GUICtrlCreateEdit("", 22, 40, 293, 175, BitOR($ES_AUTOVSCROLL,$ES_AUTOHSCROLL,$ES_WANTRETURN))

GUICtrlSetData(-1, "")
GUICtrlSetFont(-1, 8, 400, 0, "Arial")

GUICtrlCreateGroup("", -99, -99, 1, 1)

$Save = GUICtrlCreateButton("Lưu thiết lập", 252, 231, 75, 25, 0)
$Bot = GUICtrlCreateButton("&Chạy", 82, 261, 75, 25, 0)
$Exit = GUICtrlCreateButton("&Thoát", 167, 261, 75, 25, 0)
$Help = GUICtrlCreateButton("&Help", 252, 261, 75, 25, 0)

GUISetState(@SW_SHOW)

While 1
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit

		Case $Tab2
	EndSwitch
WEnd

#comments-start
Build 1 func cho phép cập nhật lại thông tin của nhan vật trong tab nhân vật.
Build 1 func khi nhất vào nút đọc tọa độ hiện tại của nhân vật, trong phần tab nghỉ ngơi.
Hiện tại cái giao diện này có một số thứ chúng ta chưa tìm đc info nhưng tạm thời cứ để đó chưa cần cập nhật vội.
Tab trợ giúp: có thể chứa info của auto như là author basic info của nhóm chúng ta, hướng đẫn cách sử dụng auto như thế nào, term, lisence...
Tab thông tin: chứa log của auto nó chạy như thế nào dùng để debug cũng dễ hơn.
#comments-end