#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Auto Hỗ Trợ Game Kiếm Tiên
#ce ==========================================================

;~ == Các hàm của GUI ================================================================
;~ Hiệu chỉnh lại thông số GUI
Func GUISetInfo()
	WinMove($MainGUI,"",$AutoPos[0],$AutoPos[1])
	WinSetTitle($MainGUI,"",$AutoTitle)
	StartAuto_B_Set("Đánh")
	CharSkillOn_CB_Set("Luôn dùng")
	Mod_T_Set("Quái")
	Char_T_Set("Nhân")
	GameAuto_CB_Set("Kết hợp với Auto trong Game")
	CharListReload_B_Set("Nạp Lại Nhận Vật")
	SetSkill()
	SetStatusSkill()
	SetSkillNeed()
	CreateAttGif()
	GUITraySet()
	GUISetState(@SW_SHOW,$MainGUI)
EndFunc

;~ Chỉnh lại Tray System
Func GUITraySet()
	TrayCreateItem("Thoát "&$AutoTitle)
	TrayItemSetOnEvent(-1,"ExitAuto")

	TrayCreateItem("Thông Tin Của Tác Giả")
	TrayItemSetOnEvent(-1,"AutoAbout")

	TrayCreateItem("")
	
	TrayCreateItem("Bấm Vô Đây Để Chạy Tiếp")
EndFunc

;~ Hiện thông tin tác giả
Func AutoAbout()
	$Text = "Tool này được phát triển bởi:"&@LF&@LF
	$Text&= "               TRẦN MINH ĐỨC"&@LF
	$Text&= " - Nick: LeeSai"&@LF
	$Text&= " - E-Mail: tranminhduc18116@yahoo.com"&@LF
	$Text&= " - G-Mail: tranminhduc18116@gmail.com"&@LF
	$Text&= " - Chức Danh: Admin Forum AutoIT Việt"&@LF&@LF
	$Text&= "Bạn có muốn thăm Website và Forum của tớ không?"&@LF
	If MsgBox(4,"72ls.NET",$Text) == 6 Then 
		_IECreate("http://72ls.net",1,1,0)
		_IECreate("http://autoit.72ls.net",1,1,0)
	EndIf
EndFunc

;~ Lấy danh sách các Char đang được login
Func GUISetCharList()
	Local $Pid 
	Local $Mem 
	For $i = 1 To $GameCharList[0][0]
		$Pid = WinGetProcess($GameCharList[$i][1])
		$Mem = _MemoryOpen($Pid)
		$GameCharList[$i][0] = _MemoryRead(0x00E5808C,$Mem,"char[24]")
	Next
	
	CharList_C_Set()
EndFunc

;~ 	Tạo Gif báo hiệu trạng thái Train
Func CreateAttGif()
	Local $aArrayOfHandlesAndTimes
	Global $hGIFThread
	Local $iTransparent
	Local $tCurrentFrame
	Global $AttGif = _GUICtrlCreateGIF($AttGifFile, 2, 237,$aArrayOfHandlesAndTimes,$hGIFThread,$iTransparent,$tCurrentFrame)
	_StopGIFAnimation($hGIFThread)
	GUICtrlSetOnEvent($AttGif,"StartAuto_BClick")
	GUICtrlSetCursor ($AttGif, 0)
EndFunc

;~ Cài đặt lại tùy chọn skill
Func SetSkill()
	For $i = 1 To $SkillNumber
		Call("Skill"&$i&"_C_Set",$Skill[$i-1])
	Next
EndFunc

;~ Cài đặt lại tùy chọn skill
Func SetSkillNeed()
	Local $After = ""
	For $i = 1 To $SkillNumber
		If $i > 5 And $i < 14 Then $After = "%"
		If $i > 13 Then $After = ""
		Call("SkillNeed"&$i&"_Set",$SkillNeed[$i-1]&$After)
	Next
EndFunc

;~ Cài đặt lại trạng thái kích hoạt skill
Func SetStatusSkill()
	For $i = 1 To $SkillNumber
		If $SkillOn[$i-1] Then
			Call("Skill"&$i&"_CB_SetState",$GUI_CHECKED)
		Else
			Call("Skill"&$i&"_CB_SetState",$GUI_UNCHECKED)
		EndIf
	Next
	
	If $CharHeal Then
		CharSkillOn_CB_State($GUI_CHECKED)
	Else
		CharSkillOn_CB_State($GUI_UNCHECKED)
	EndIf
EndFunc
	
;~ Thoát khỏi chương trình
Func ExitAuto()
	GameAutoOn(0)
	SaveSetting()
	Exit
EndFunc

;~ Mở trang tải Auto
Func AutoHelpClick()
	_IECreate($URL,1,1,0)
EndFunc

;~ Hiệu chỉnh Target Lable
Func Target_L_Set($Data = "")
	Local $Old = Target_L_Get()
	If $Old <> $Data Then GUICtrlSetData($Target_L,$Data)
EndFunc
;~ Lấy thông tin từ Target Lable
Func Target_L_Get()
	Return GUICtrlRead($Target_L)
EndFunc

;~ Hiệu chỉnh Tab Mod Title
Func Mod_T_Set($Data = "")
	Local $Old = Mod_T_Get()
	If $Old <> $Data Then GUICtrlSetData($Mod_T,$Data)
EndFunc
;~ Lấy Text từ Tab Mod Title
Func Mod_T_Get()
	Return GUICtrlRead($Mod_T)
EndFunc

;~ Hiệu chỉnh Mod HPCur Lable
Func Mod_HPCur_L_Set($Data = "")
	Local $Old = Mod_HPCur_L_Get()
	If $Old <> $Data Then GUICtrlSetData($Mod_HPCur_L,$Data)
EndFunc
;~ Lấy thông tin từ Mod HPCur Lable
Func Mod_HPCur_L_Get()
	Return GUICtrlRead($Mod_HPCur_L)
EndFunc

;~ Hiệu chỉnh Mod HPMax Lable
Func Mod_HPMax_L_Set($Data = "")
;~ 	Local $Old = Mod_HPMax_L_Get()
;~ 	If $Old <> $Data Then GUICtrlSetData($Mod_HPMax_L,$Data)
EndFunc
;~ Lấy thông tin từ Mod HPMax Lable
Func Mod_HPMax_L_Get()
;~ 	Return GUICtrlRead($Mod_HPMax_L)
EndFunc

;~ Hiệu chỉnh StartAuto Button Text
Func StartAuto_B_Set($Data = "")
	Local $Old = StartAuto_B_L_Get()
	If $Old <> $Data Then GUICtrlSetData($StartAuto_B,$Data)
EndFunc
;~ Lấy Text từ StartAuto Button
Func StartAuto_B_L_Get()
	Return GUICtrlRead($StartAuto_B)
EndFunc
;~ Kích hoạt tự đánh
Func StartAuto_BClick()
	$Training = Not $Training
	If $Training Then
		StartAuto_B_Set("Ngưng")
		AdlibRegister("TargetMod",900)
		_ResumeGIFAnimation($hGIFThread)
	Else
		StartAuto_B_Set("Đánh")
		AdlibUnRegister("TargetMod")
		_StopGIFAnimation($hGIFThread)
		GameAutoOn(0)
	EndIf
EndFunc

;~ Thu gọn Auto
Func AutoMini_BClick()
	$AutoMini = Not $AutoMini
	If $AutoMini Then
		SaveSetting()
		$AutoPos = WinGetPos($MaingUI)
		GUICtrlSetData($AutoMini_B,"\/")
		WinMove($MaingUI,"",$AutoPos[0],0-$AutoPos[3]+27,Default,Default,2)
	Else
		GUICtrlSetData($AutoMini_B,"/\")
		WinMove($MaingUI,"",$AutoPos[0],$AutoPos[1])
	EndIf
EndFunc

;~ Bật tắt các Skill Buff
Func BuffOn_BClick()
	$Buffing = Not $Buffing
	If $Buffing Then
		BuffSkillEnable()
		GUICtrlSetColor($BuffOn_B, 0x0000FF)
	Else
		BuffSkillDisable()
		GUICtrlSetColor($BuffOn_B, 0x727272)
	EndIf
EndFunc

;~ Khóa tất cả CheckBox của Skill Buff
Func BuffSkillDisable()
	Buff14Disable()
	Buff15Disable()
	Buff16Disable()
EndFunc

;~ Khóa CheckBox của Skill Buff 14
Func Buff14Disable()
	GUICtrlSetState($Skill14_CB,$GUI_DISABLE)
EndFunc
;~ Khóa CheckBox của Skill Buff 15
Func Buff15Disable()
	GUICtrlSetState($Skill15_CB,$GUI_DISABLE)
EndFunc
;~ Khóa CheckBox của Skill Buff 16
Func Buff16Disable()
	GUICtrlSetState($Skill16_CB,$GUI_DISABLE)
EndFunc

;~ Mở Khóa tất cả CheckBox của Skill Buff
Func BuffSkillEnable()
	Buff14Enable()
	Buff15Enable()
	Buff16Enable()
EndFunc
;~ Mở Khóa CheckBox của Skill Buff 14
Func Buff14Enable()
	GUICtrlSetState($Skill14_CB,$GUI_Enable)
EndFunc
;~ Mở Khóa CheckBox của Skill Buff 15
Func Buff15Enable()
	GUICtrlSetState($Skill15_CB,$GUI_Enable)
EndFunc
;~ Mở Khóa CheckBox của Skill Buff 16
Func Buff16Enable()
	GUICtrlSetState($Skill16_CB,$GUI_Enable)
EndFunc

;~ Thay đổi màu nền của HealCharStatet_L
Func HealCharState_L_Color($Color)
	GUICtrlSetColor($HealCharState_L, $Color)
EndFunc

;~ Bật tắt kết hợp với Auto trong game
Func GameAuto_CBClick()
	$AutoWithGame = Not $AutoWithGame
	If $AutoWithGame Then
		If $Training Then GameAutoOn()
		GameAuto_CB_State($GUI_CHECKED)
	Else
		GameAutoOn(0)
		GameAuto_CB_State($GUI_UNCHECKED)
	EndIf
	
EndFunc
;~ Hiệu chỉnh trạng thái của GameAuto_CB
Func GameAuto_CB_State($State)
	GUICtrlSetState($GameAuto_CB,$State)
EndFunc

;~ Hiệu chỉnh GameAuto_CB
Func GameAuto_CB_Set($Data = "")
	Local $Old = Char_T_Get()
	If $Old <> $Data Then GUICtrlSetData($GameAuto_CB,$Data)
EndFunc
;~ Lấy Text từ GameAuto_CB
Func GameAuto_CB_Get()
	Return GUICtrlRead($GameAuto_CB)
EndFunc

;~ Hiệu chỉnh Tab Mod Title
Func Char_T_Set($Data = "")
	Local $Old = Char_T_Get()
	If $Old <> $Data Then GUICtrlSetData($Char_T,$Data)
EndFunc
;~ Lấy Text từ Tab Mod Title
Func Char_T_Get()
	Return GUICtrlRead($Char_T)
EndFunc

;~ Hiểu chỉnh Text từ CharListReload
Func CharListReload_B_Set($Data = "")
	Local $Old = CharListReload_B_Get()
	If $Old <> $Data Then GUICtrlSetData($CharListReload_B,$Data)	
EndFunc
;~ Lấy Text từ CharListReload
Func CharListReload_B_Get()
	Return GUICtrlRead($CharListReload_B)
EndFunc

;~ Hiệu chỉnh Char HP Lable
Func Char_HP_L_Set($Data = "")
	Local $Old = Char_HP_L_Get()
	If $Old <> $Data Then GUICtrlSetData($CharHP_L,$Data)
EndFunc
;~ Lấy thông tin từ Char HP Lable
Func Char_HP_L_Get()
	Return GUICtrlRead($CharHP_L)
EndFunc

;~ Hiệu chỉnh Char MP Lable
Func Char_MP_L_Set($Data = "")
	Local $Old = Char_MP_L_Get()
	If $Old <> $Data Then GUICtrlSetData($CharMP_L,$Data)
EndFunc
;~ Lấy thông tin từ Char MP Lable
Func Char_MP_L_Get()
	Return GUICtrlRead($CharMP_L)
EndFunc

;~ Lấy Text CharSkillOn Title
Func CharSkillOn_CB_Get()
	Return GUICtrlRead($CharSkillOn_CB)
EndFunc
;~ Hiệu chỉnh Title của CharSkillOn
Func CharSkillOn_CB_Set($Data = "")
	Local $Old = CharSkillOn_CB_Get()
	If $Old <> $Data Then GUICtrlSetData($CharSkillOn_CB,$Data)
EndFunc
;~ Hiệu chỉnh trạng thái của CharSkillOn
Func CharSkillOn_CB_State($State)
	GUICtrlSetState($CharSkillOn_CB,$State)
EndFunc
;~ Thay dổi trạng thái của danh sách Skill Heal Char
Func CharSkillOn_CBClick()
	$CharHeal = Not $CharHeal
	If $CharHeal Then
		CharSkillOn_CB_State($GUI_CHECKED)
		HealCharState_L_Color(0xFF0000)
	Else
		CharSkillOn_CB_State($GUI_UNCHECKED)
		HealCharState_L_Color(0x727272)
	EndIf
EndFunc

;~ Nút nạp lại danh sách Charlist
Func CharListReload_BClick()
	$GameCharList = WinList($GameClass)
	If $GameCharList[0][0] Then
		$GameHandle = $GameCharList[1][1]
		$GamePid = WinGetProcess($GameHandle) 
		GUISetCharList()
		CharList_C_Set()
		$Char_Name = CharList_C_Get()
		LoadSetting()
	EndIf
		GUISetInfo()
EndFunc

;~ Xóa trắng danh sách Char
Func CharList_CClear()
	GUICtrlSetData($CharList_C,"","")
EndFunc
;~ Lấy tên của Char đang được chọn
Func CharList_C_Get()
	Return GUICtrlRead($CharList_C)
EndFunc
;~ Đưa danh sách Char vào ComboBox
Func CharList_C_Set()
	CharList_CClear()
	Local $Data
	For $i = 1 To $GameCharList[0][0]
		$Data &= $GameCharList[$i][0]&"|"
	Next
	GUICtrlSetData($CharList_C,$Data,$GameCharList[1][0])
EndFunc

;~ Thực hiện khi thay đổi char
Func CharList_CChange()
	SaveSetting()
	$Char_Name = CharList_C_Get()
	For $i = 1 To $GameCharList[0][0]
		If $Char_Name == $GameCharList[$i][0] Then
			$GameHandle = $GameCharList[$i][1]
			$GamePid = WinGetProcess($GameHandle) 
			GameOpenMemory()
			LoadSetting()
			GUISetInfo()
			Return
		EndIf
	Next
EndFunc


;~ Lấy thông tin %HP cho Skill 6
Func CharHP1_C_Get()
	Return GUICtrlRead($CharHP1_C)
EndFunc
;~ Thay đổi % sẽ Heal HP
Func CharHP1_CChange()
	$SkillNeed[5] = StringReplace(CharHP1_C_Get(),"%","")
EndFunc

;~ Lấy thông tin %HP cho Skill 7
Func CharHP2_C_Get()
	Return GUICtrlRead($CharHP2_C)
EndFunc
;~ Thay đổi % sẽ Heal HP
Func CharHP2_CChange()
	$SkillNeed[6] = StringReplace(CharHP2_C_Get(),"%","")
EndFunc

;~ Lấy thông tin %MP cho Skill 8
Func CharMP1_C_Get()
	Return GUICtrlRead($CharMP1_C)
EndFunc
;~ Thay đổi % sẽ Heal MP
Func CharMP1_CChange()
	$SkillNeed[7] = StringReplace(CharMP1_C_Get(),"%","")
EndFunc

;~ Lấy thông tin %MP cho Skill 9
Func CharMP2_C_Get()
	Return GUICtrlRead($CharMP2_C)
EndFunc
;~ Thay đổi % sẽ Heal MP
Func CharMP2_CChange()
	$SkillNeed[8] = StringReplace(CharMP2_C_Get(),"%","")
EndFunc

;~ Lấy thông tin XP cho Skill 10
Func CharXP1_C_Get()
	Return GUICtrlRead($CharXP1_C)
EndFunc
;~ Thay đổi số lượng sẽ dùng skill MP
Func CharXP1_CChange()
	$SkillNeed[9] = StringReplace(CharXP1_C_Get(),"%","")
EndFunc

;~ Thay đổi giới hạn heal pet
Func PetHPClick()
	Local $Data = InputBox("72ls.NET","Khi HP của Pet nhỏ hơn số bên dưới (Tính theo %) Auto sẽ tự cho ăn. "& _
									  "Hãy nhập giới hạn mà bạn muốn vào, chỉ nhập số, không nhập ký tự %.",$SkillNeed[10]," M2", 106)
	If @error Then Return
	$SkillNeed[10] = $Data *1
	If $SkillNeed[10] < 0 Then $SkillNeed[10] = 0
	
	SkillNeed11_Set($SkillNeed[10]&"%")
EndFunc

;~ Thay đổi giới hạn heal pet
Func PetMPClick()
	Local $Data = InputBox("72ls.NET","Khi MP của Pet nhỏ hơn số bên dưới (Tính theo %) Auto sẽ tự cho ăn. "& _
										  "Hãy nhập giới hạn mà bạn muốn vào, chỉ nhập số, không nhập ký tự %.",$SkillNeed[11]," M2", 106)
	If @error Then Return
	$SkillNeed[11] = $Data *1
	If $SkillNeed[11] < 0 Then $SkillNeed[11] = 0
	
	SkillNeed12_Set($SkillNeed[11]&"%")
EndFunc

;~ Hiệu chỉnh Pet HP Lable
Func Pet_HP_L_Set($Data = "")
	Local $Old = Pet_HP_L_Get()
	If $Old <> $Data Then GUICtrlSetData($PetHP_L,$Data)
EndFunc
;~ Lấy thông tin từ Pet HP Lable
Func Pet_HP_L_Get()
	Return GUICtrlRead($PetHP_L)
EndFunc

;~ Hiệu chỉnh Pet MP Lable
Func Pet_MP_L_Set($Data = "")
	Local $Old = Pet_MP_L_Get()
	If $Old <> $Data Then GUICtrlSetData($PetMP_L,$Data)
EndFunc
;~ Lấy thông tin từ Pet MP Lable
Func Pet_MP_L_Get()
	Return GUICtrlRead($PetMP_L)
EndFunc

;~ Lấy thông tin Skill 1 ComboBox
Func Skill1_C_Get()
	Return GUICtrlRead($Skill1_C)
EndFunc
;~ Chọn nội dung cho Skill 1 ComboBox
Func Skill1_C_Set($Data)
	Local $Old = Skill1_C_Get()
	If $Old <> $Data Then GUICtrlSetData($Skill1_C,$SkillList,$Data)
EndFunc
;~ Thay đổi skill tấng công
Func Skill1_CChange()
	$Skill[0] = Skill1_C_Get()
EndFunc
;~ Thay đổi trạng thái bật tắt của Skill 1
Func Skill1_CB_SetState($State)
	GUICtrlSetState($Skill1_CB,$State)
EndFunc
;~ Thay đổi trạng thái bật tắt của Skill 1
Func Skill1_CBClick()
	$SkillOn[0] = Not $SkillOn[0]
EndFunc

;~ Thay đổi thời gian đợi của Skill 1
Func Skill1DelayClick()
	Local $Data = InputBox("72ls.NET",$DelayHelp,$SkillNeed[0]/1000," M27")
	If @error Then Return
	$Data=Round(Execute($Data),2)
	$SkillNeed[0] = $Data * 1000
	If $SkillNeed[0] < 0 Then $SkillNeed[0] = 0
	SkillNeed1_Set($SkillNeed[0])
EndFunc

;~ Chỉnh thời gian Delay của skill 1
Func SkillNeed1_Set($Data)
	Local $After = " giây"
	Local $Title = "Thời gian"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" Phút"	
	GUICtrlSetTip($Skill1Delay,$Data&" Mili Giây",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = " phút"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	GUICtrlSetData($Skill1Delay,$Data&$After)
EndFunc
	
;~ Lấy thông tin Skill 2 ComboBox
Func Skill2_C_Get()
	Return GUICtrlRead($Skill2_C)
EndFunc
;~ Chọn nội dung cho Skill 2 ComboBox
Func Skill2_C_Set($Data)
	Local $Old = Skill2_C_Get()
	If $Old <> $Data Then GUICtrlSetData($Skill2_C,$SkillList,$Data)
EndFunc
;~ Thay đổi skill tấng công
Func Skill2_CChange()
	$Skill[1] = Skill2_C_Get()
EndFunc
;~ Thay đổi trạng thái bật tắt của Skill 2
Func Skill2_CB_SetState($State)
	GUICtrlSetState($Skill2_CB,$State)
EndFunc
;~ Kiểm tra trạng thái bật tắt của Skill 2
Func Skill2_CBClick()
	$SkillOn[1] = Not $SkillOn[1]
EndFunc

;~ Thay đổi thời gian đợi của Skill 2
Func Skill2DelayClick()
	Local $Data = InputBox("72ls.NET",$DelayHelp,$SkillNeed[1]/1000," M27")
	If @error Then Return
	$Data=Round(Execute($Data),2)
	$SkillNeed[1] = $Data * 1000
	If $SkillNeed[1] < 0 Then $SkillNeed[1] = 0
	SkillNeed2_Set($SkillNeed[1])
EndFunc

;~ Chỉnh thời gian Delay của skill 2
Func SkillNeed2_Set($Data)
	Local $After = " giây"
	Local $Title = "Thời gian"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" Phút"	
	GUICtrlSetTip($Skill2Delay,$Data&" Mili Giây",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = " phút"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	GUICtrlSetData($Skill2Delay,$Data&$After)
EndFunc
	
;~ Lấy thông tin Skill 3 ComboBox
Func Skill3_C_Get()
	Return GUICtrlRead($Skill3_C)
EndFunc
;~ Chọn nội dung cho Skill 3 ComboBox
Func Skill3_C_Set($Data)
	Local $Old = Skill3_C_Get()
	If $Old <> $Data Then GUICtrlSetData($Skill3_C,$SkillList,$Data)
EndFunc
;~ Thay đổi skill tấng công
Func Skill3_CChange()
	$Skill[2] = Skill3_C_Get()
EndFunc
;~ Thay đổi trạng thái bật tắt của Skill 3
Func Skill3_CB_SetState($State)
	GUICtrlSetState($Skill3_CB,$State)
EndFunc
;~ Kiểm tra trạng thái bật tắt của Skill 3
Func Skill3_CBClick()
	$SkillOn[2] = Not $SkillOn[2]
EndFunc

;~ Thay đổi thời gian đợi của Skill 3
Func Skill3DelayClick()
	Local $Data = InputBox("72ls.NET",$DelayHelp,$SkillNeed[2]/1000," M27")
	If @error Then Return
	$Data=Round(Execute($Data),2)
	$SkillNeed[2] = $Data * 1000
	If $SkillNeed[2] < 0 Then $SkillNeed[2] = 0
	SkillNeed3_Set($SkillNeed[2])
EndFunc

;~ Chỉnh thời gian Delay của skill 3
Func SkillNeed3_Set($Data)
	Local $After = " giây"
	Local $Title = "Thời gian"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" Phút"	
	GUICtrlSetTip($Skill3Delay,$Data&" Mili Giây",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = " phút"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	GUICtrlSetData($Skill3Delay,$Data&$After)
EndFunc

;~ Lấy thông tin Skill 4 ComboBox
Func Skill4_C_Get()
	Return GUICtrlRead($Skill4_C)
EndFunc
;~ Chọn nội dung cho Skill 4 ComboBox
Func Skill4_C_Set($Data)
	Local $Old = Skill4_C_Get()
	If $Old <> $Data Then GUICtrlSetData($Skill4_C,$SkillList,$Data)
EndFunc
;~ Thay đổi skill tấng công
Func Skill4_CChange()
	$Skill[3] = Skill4_C_Get()
EndFunc
;~ Thay đổi trạng thái bật tắt của Skill 4
Func Skill4_CB_SetState($State)
	GUICtrlSetState($Skill4_CB,$State)
EndFunc
;~ Kiểm tra trạng thái bật tắt của Skill 4
Func Skill4_CBClick()
	$SkillOn[3] = Not $SkillOn[3]
EndFunc

;~ Thay đổi thời gian đợi của Skill 4
Func Skill4DelayClick()
	Local $Data = InputBox("72ls.NET",$DelayHelp,$SkillNeed[3]/1000," M27")
	If @error Then Return
	$Data=Round(Execute($Data),2)
	$SkillNeed[3] = $Data * 1000
	If $SkillNeed[3] < 0 Then $SkillNeed[3] = 0
	SkillNeed4_Set($SkillNeed[3])
EndFunc

;~ Chỉnh thời gian Delay của skill 4
Func SkillNeed4_Set($Data)
	Local $After = " giây"
	Local $Title = "Thời gian"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" Phút"	
	GUICtrlSetTip($Skill4Delay,$Data&" Mili Giây",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = " phút"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	GUICtrlSetData($Skill4Delay,$Data&$After)
EndFunc

;~ Lấy thông tin Skill 5 ComboBox
Func Skill5_C_Get()
	Return GUICtrlRead($Skill5_C)
EndFunc
;~ Chọn nội dung cho Skill 5 ComboBox
Func Skill5_C_Set($Data)
	Local $Old = Skill5_C_Get()
	If $Old <> $Data Then GUICtrlSetData($Skill5_C,$SkillList,$Data)
EndFunc
;~ Thay đổi skill tấng công
Func Skill5_CChange()
	$Skill[4] = Skill5_C_Get()
EndFunc
;~ Thay đổi trạng thái bật tắt của Skill 5
Func Skill5_CB_SetState($State)
	GUICtrlSetState($Skill5_CB,$State)
EndFunc
;~ Kiểm tra trạng thái bật tắt của Skill 5
Func Skill5_CBClick()
	$SkillOn[4] = Not $SkillOn[4]
EndFunc

;~ Thay đổi thời gian đợi của Skill 5
Func Skill5DelayClick()
	Local $Data = InputBox("72ls.NET",$DelayHelp,$SkillNeed[4]/1000," M27")
	If @error Then Return
	$Data=Round(Execute($Data),2)
	$SkillNeed[4] = $Data * 1000
	If $SkillNeed[4] < 0 Then $SkillNeed[4] = 0
	SkillNeed5_Set($SkillNeed[4])
EndFunc

;~ Chỉnh thời gian Delay của skill 5
Func SkillNeed5_Set($Data)
	Local $After = " giây"
	Local $Title = "Thời gian"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" Phút"	
	GUICtrlSetTip($Skill5Delay,$Data&" Mili Giây",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = " phút"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	GUICtrlSetData($Skill5Delay,$Data&$After)
EndFunc

;~ Lấy thông tin Skill 6 ComboBox
Func Skill6_C_Get()
	Return GUICtrlRead($Skill6_C)
EndFunc
;~ Chọn nội dung cho Skill 6 ComboBox
Func Skill6_C_Set($Data)
	Local $Old = Skill6_C_Get()
	If $Old <> $Data Then GUICtrlSetData($Skill6_C,$SkillList,$Data)
EndFunc
;~ Thay đổi skill tấng công
Func Skill6_CChange()
	$Skill[5] = Skill6_C_Get()
EndFunc

;~ Lấy thông tin Skill 6 ComboBox
Func SkillNeed6_CB_Get()
	Return GUICtrlRead($CharHP1_C)
EndFunc
;~ Chọn nội dung cho Skill 8 ComboBox
Func SkillNeed6_Set($Data)
	Local $Old = SkillNeed6_CB_Get()
	If $Old <> $Data Then GUICtrlSetData($CharHP1_C,$PercentList,$Data)
EndFunc
	
;~ Thay đổi trạng thái bật tắt của Skill 6
Func Skill6_CB_SetState($State)
	GUICtrlSetState($Skill6_CB,$State)
EndFunc
;~ Kiểm tra trạng thái bật tắt của Skill 6
Func Skill6_CBClick()
	$SkillOn[5] = Not $SkillOn[5]
EndFunc

;~ Lấy thông tin Skill 7 ComboBox
Func Skill7_C_Get()
	Return GUICtrlRead($Skill7_C)
EndFunc
;~ Chọn nội dung cho Skill 7 ComboBox
Func Skill7_C_Set($Data)
	Local $Old = Skill7_C_Get()
	If $Old <> $Data Then GUICtrlSetData($Skill7_C,$SkillList,$Data)
EndFunc
;~ Thay đổi skill tấng công
Func Skill7_CChange()
	$Skill[6] = Skill7_C_Get()
EndFunc

;~ Lấy thông tin Skill 7 ComboBox
Func SkillNeed7_CB_Get()
	Return GUICtrlRead($CharHP2_C)
EndFunc
;~ Chọn nội dung cho Skill 7 ComboBox
Func SkillNeed7_Set($Data)
	Local $Old = SkillNeed7_CB_Get()
	If $Old <> $Data Then GUICtrlSetData($CharHP2_C,$PercentList,$Data)
EndFunc
	
	;~ Thay đổi trạng thái bật tắt của Skill 7
Func Skill7_CB_SetState($State)
	GUICtrlSetState($Skill7_CB,$State)
EndFunc
;~ Kiểm tra trạng thái bật tắt của Skill 7
Func Skill7_CBClick()
	$SkillOn[6] = Not $SkillOn[6]
EndFunc

;~ Lấy thông tin Skill 8 ComboBox
Func Skill8_C_Get()
	Return GUICtrlRead($Skill8_C)
EndFunc
;~ Chọn nội dung cho Skill 8 ComboBox
Func Skill8_C_Set($Data)
	Local $Old = Skill8_C_Get()
	If $Old <> $Data Then GUICtrlSetData($Skill8_C,$SkillList,$Data)
EndFunc
;~ Thay đổi skill tấng công
Func Skill8_CChange()
	$Skill[7] = Skill8_C_Get()
EndFunc

;~ Lấy thông tin Skill 8 ComboBox
Func Skill18_CB_Get()
	Return GUICtrlRead($CharMP1_C)
EndFunc
;~ Chọn nội dung cho Skill 8 ComboBox
Func Skill18_CB_Set($Data)
	Local $Old = Skill18_CB_Get()
	If $Old <> $Data Then GUICtrlSetData($CharMP1_C,$PercentList,$Data)
EndFunc

;~ Lấy thông tin Skill 8 ComboBox
Func SkillNeed8_CB_Get()
	Return GUICtrlRead($CharMP1_C)
EndFunc
;~ Chọn nội dung cho Skill 8 ComboBox
Func SkillNeed8_Set($Data)
	Local $Old = SkillNeed8_CB_Get()
	If $Old <> $Data Then GUICtrlSetData($CharMP1_C,$PercentList,$Data)
EndFunc
	
;~ Thay đổi trạng thái bật tắt của Skill 8
Func Skill8_CB_SetState($State)
	GUICtrlSetState($Skill8_CB,$State)
EndFunc
;~ Kiểm tra trạng thái bật tắt của Skill 8
Func Skill8_CBClick()
	$SkillOn[7] = Not $SkillOn[7]
EndFunc

;~ Lấy thông tin Skill 9 ComboBox
Func Skill9_C_Get()
	Return GUICtrlRead($Skill9_C)
EndFunc
;~ Chọn nội dung cho Skill 9 ComboBox
Func Skill9_C_Set($Data)
	Local $Old = Skill9_C_Get()
	If $Old <> $Data Then GUICtrlSetData($Skill9_C,$SkillList,$Data)
EndFunc
;~ Thay đổi skill tấng công
Func Skill9_CChange()
	$Skill[8] = Skill9_C_Get()
EndFunc

;~ Lấy thông tin Skill 9 ComboBox
Func SkillNeed9_CB_Get()
	Return GUICtrlRead($CharMP2_C)
EndFunc
;~ Chọn nội dung cho Skill 10 ComboBox
Func SkillNeed9_Set($Data)
	Local $Old = SkillNeed9_CB_Get()
	If $Old <> $Data Then GUICtrlSetData($CharMP2_C,$PercentList,$Data)
EndFunc
	
	
;~ Thay đổi trạng thái bật tắt của Skill 9
Func Skill9_CB_SetState($State)
	GUICtrlSetState($Skill9_CB,$State)
EndFunc
;~ Kiểm tra trạng thái bật tắt của Skill 9
Func Skill9_CBClick()
	$SkillOn[8] = Not $SkillOn[8]
EndFunc

;~ Lấy thông tin Skill 10 ComboBox
Func Skill10_C_Get()
	Return GUICtrlRead($Skill10_C)
EndFunc
;~ Chọn nội dung cho Skill 10 ComboBox
Func Skill10_C_Set($Data)
	Local $Old = Skill10_C_Get()
	If $Old <> $Data Then GUICtrlSetData($Skill10_C,$SkillList,$Data)
EndFunc
;~ Thay đổi skill tấng công
Func Skill10_CChange()
	$Skill[9] = Skill10_C_Get()
EndFunc

;~ Lấy thông tin Skill 10 ComboBox
Func SkillNeed10_C_Get()
	Return GUICtrlRead($CharXP1_C)
EndFunc
;~ Chọn nội dung cho Skill 10 ComboBox
Func SkillNeed10_Set($Data)
	Local $Old = SkillNeed10_C_Get()
	If $Old <> $Data Then GUICtrlSetData($CharXP1_C,$PercentList,$Data)
EndFunc
	
;~ Thay đổi trạng thái bật tắt của Skill 10
Func Skill10_CB_SetState($State)
	GUICtrlSetState($Skill10_CB,$State)
EndFunc
;~ Kiểm tra trạng thái bật tắt của Skill 10
Func Skill10_CBClick()
	$SkillOn[9] = Not $SkillOn[9]
EndFunc

;~ Lấy thông tin Skill 11 ComboBox
Func Skill11_C_Get()
	Return GUICtrlRead($Skill11_C)
EndFunc
;~ Chọn nội dung cho Skill 11 ComboBox
Func Skill11_C_Set($Data)
	Local $Old = Skill11_C_Get()
	If $Old <> $Data Then GUICtrlSetData($Skill11_C,$SkillList,$Data)
EndFunc
;~ Thay đổi ô tấng công của skill 11
Func Skill11_CChange()
	$Skill[10] = Skill11_C_Get()
EndFunc

;~ Lấy thông tin Skill 11 ComboBox
Func SkillNeed11_L_Get()
	Return GUICtrlRead($PetHP)
EndFunc
;~ Chọn nội dung cho Skill 11 ComboBox
Func SkillNeed11_Set($Data)
	Local $Old = SkillNeed11_L_Get()
	If $Old <> $Data Then GUICtrlSetData($PetHP,$Data)
EndFunc
	
;~ Thay đổi trạng thái bật tắt của Skill 11
Func Skill11_CB_SetState($State)
	GUICtrlSetState($Skill11_CB,$State)
EndFunc
;~ Kiểm tra trạng thái bật tắt của Skill 11
Func Skill11_CBClick()
	$SkillOn[10] = Not $SkillOn[10]
EndFunc

;~ Lấy thông tin Skill 12 ComboBox
Func Skill12_C_Get()
	Return GUICtrlRead($Skill12_C)
EndFunc
;~ Chọn nội dung cho Skill 12 ComboBox
Func Skill12_C_Set($Data)
	Local $Old = Skill12_C_Get()
	If $Old <> $Data Then GUICtrlSetData($Skill12_C,$SkillList,$Data)
EndFunc
;~ Thay đổi ô tấng công của skill 12
Func Skill12_CChange()
	$Skill[11] = Skill12_C_Get()
EndFunc

;~ Lấy thông tin Skill 12 ComboBox
Func SkillNeed12_L_Get()
	Return GUICtrlRead($PetMP)
EndFunc
;~ Chọn nội dung cho Skill 12 ComboBox
Func SkillNeed12_Set($Data)
	Local $Old = SkillNeed12_L_Get()
	If $Old <> $Data Then GUICtrlSetData($PetMP,$Data)
EndFunc
	
;~ Thay đổi trạng thái bật tắt của Skill 12
Func Skill12_CB_SetState($State)
	GUICtrlSetState($Skill12_CB,$State)
EndFunc
;~ Kiểm tra trạng thái bật tắt của Skill 12
Func Skill12_CBClick()
	$SkillOn[11] = Not $SkillOn[11]
EndFunc

;~ Lấy thông tin Skill 14 ComboBox
Func Skill14_C_Get()
	Return GUICtrlRead($Skill14_C)
EndFunc
;~ Chọn nội dung cho Skill 14 ComboBox
Func Skill14_C_Set($Data)
	Local $Old = Skill14_C_Get()
	If $Old <> $Data Then GUICtrlSetData($Skill14_C,$SkillList,$Data)
EndFunc
;~ Thay đổi skill tấng công 14
Func Skill14_CChange()
	$Skill[13] = Skill14_C_Get()
EndFunc
;~ Thay đổi trạng thái bật tắt của Skill 14
Func Skill14_CB_SetState($State)
	GUICtrlSetState($Skill14_CB,$State)
EndFunc
;~ Kiểm tra trạng thái bật tắt của Skill 14
Func Skill14_CBClick()
	$SkillOn[13] = Not $SkillOn[13]
EndFunc

;~ Thay đổi thời gian đợi của Skill 14
Func Skill14DelayClick()
	Local $Data = InputBox("72ls.NET",$DelayHelp,$SkillNeed[13]/1000," M27")
	If @error Then Return
	$Data=Round(Execute($Data),2)
	$SkillNeed[13] = $Data * 1000
	If $SkillNeed[13] < 0 Then $SkillNeed[13] = 0
	SkillNeed14_Set($SkillNeed[13])
EndFunc

;~ Chỉnh thời gian Delay của skill 14
Func SkillNeed14_Set($Data)
	Local $After = " giây"
	Local $Title = "Thời gian"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" Phút"	
	GUICtrlSetTip($Skill14Delay,$Data&" Mili Giây",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = " phút"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	GUICtrlSetData($Skill14Delay,$Data&$After)
EndFunc

;~ Lấy thông tin Skill 15 ComboBox
Func Skill15_C_Get()
	Return GUICtrlRead($Skill15_C)
EndFunc
;~ Chọn nội dung cho Skill 15 ComboBox
Func Skill15_C_Set($Data)
	Local $Old = Skill15_C_Get()
	If $Old <> $Data Then GUICtrlSetData($Skill15_C,$SkillList,$Data)
EndFunc
;~ Thay đổi skill tấng công 15
Func Skill15_CChange()
	$Skill[14] = Skill15_C_Get()
EndFunc
;~ Thay đổi trạng thái bật tắt của Skill 15
Func Skill15_CB_SetState($State)
	GUICtrlSetState($Skill15_CB,$State)
EndFunc
;~ Kiểm tra trạng thái bật tắt của Skill 15
Func Skill15_CBClick()
	$SkillOn[14] = Not $SkillOn[14]
EndFunc

;~ Thay đổi thời gian đợi của Skill 15
Func Skill15DelayClick()
	Local $Data = InputBox("72ls.NET",$DelayHelp,$SkillNeed[14]/1000," M27")
	If @error Then Return
	$Data=Round(Execute($Data),2)
	$SkillNeed[14] = $Data * 1000
	If $SkillNeed[14] < 0 Then $SkillNeed[14] = 0
	SkillNeed15_Set($SkillNeed[14])
EndFunc

;~ Chỉnh thời gian Delay của skill 15
Func SkillNeed15_Set($Data)
	Local $After = " giây"
	Local $Title = "Thời gian"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" Phút"	
	GUICtrlSetTip($Skill15Delay,$Data&" Mili Giây",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = " phút"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	GUICtrlSetData($Skill15Delay,$Data&$After)
EndFunc

;~ Lấy thông tin Skill 16 ComboBox
Func Skill16_C_Get()
	Return GUICtrlRead($Skill16_C)
EndFunc
;~ Chọn nội dung cho Skill 16 ComboBox
Func Skill16_C_Set($Data)
	Local $Old = Skill16_C_Get()
	If $Old <> $Data Then GUICtrlSetData($Skill16_C,$SkillList,$Data)
EndFunc
;~ Thay đổi skill tấng công 16
Func Skill16_CChange()
	$Skill[15] = Skill16_C_Get()
EndFunc
;~ Thay đổi trạng thái bật tắt của Skill 16
Func Skill16_CB_SetState($State)
	GUICtrlSetState($Skill16_CB,$State)
EndFunc
;~ Kiểm tra trạng thái bật tắt của Skill 16
Func Skill16_CBClick()
	$SkillOn[15] = Not $SkillOn[15]
EndFunc

;~ Thay đổi thời gian đợi của Skill 16
Func Skill16DelayClick()
	Local $Data = InputBox("72ls.NET",$DelayHelp,$SkillNeed[15]/1000," M27")
	If @error Then Return
	$Data=Round(Execute($Data),2)
	$SkillNeed[15] = $Data * 1000
	If $SkillNeed[15] < 0 Then $SkillNeed[15] = 0
	SkillNeed16_Set($SkillNeed[15])
EndFunc

;~ Chỉnh thời gian Delay của skill 16
Func SkillNeed16_Set($Data)
	Local $After = " giây"
	Local $Title = "Thời gian"
	
	Local $i = $Data/(1000*60)
	If Round($i,1) Then $Title&= ": "&Round($i,2)&" Phút"	
	GUICtrlSetTip($Skill16Delay,$Data&" Mili Giây",$Title)
	If $i >= 1 Then
		$Data = Round($i,1)
		$After = " phút"
	Else
		$Data = Round($Data/1000,1)
	EndIf
	GUICtrlSetData($Skill16Delay,$Data&$After)
EndFunc