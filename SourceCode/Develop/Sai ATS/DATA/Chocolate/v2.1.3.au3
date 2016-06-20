#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=..\..\..\..\copiadikid7hf.ico
#AutoIt3Wrapper_Compression=4
#AutoIt3Wrapper_Res_Comment=chuc cac ban choi game vui ve va nhe nhang hon voi tien ich nay
#AutoIt3Wrapper_Au3Check_Stop_OnWarning=y
#AutoIt3Wrapper_Run_Tidy=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#cs ----------------------------------------------------------------------------
	AutoIt Version: 3.2.12.1
	Author:         Chocolate.buon
	Group :    autoitvn
	Script Function:
	Template AutoIt script.
	
#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here
#include <GUIConstants.au3>
#include <StaticConstants.au3>
#include <NomadMemory.au3>
Opt("GUIOnEventMode", 1)
Opt("SendKeyDelay", 10)
Opt("SendKeyDownDelay", 10)
Opt("SendCapslockMode", 0)
Opt('TrayIconHide', 1)
Opt("GUIDataSeparatorChar", "/") ;chuyển / thay vì dấu ngăn cách | vì Thực Sơn có cái title có chứa dấu |
GUICreate("Thucson auto v2.1", 267, 243, 278, 198)
GUICtrlCreateTab(0, 0, 265, 209)
;Tao gui tab main, QUY CÁCH ĐẶT KÝ HIỆU CỦA TỚ CÁC THAM SỐ CÓ DẤU _D Ở DƯỚI LÀ KÝ HIỆU THAM SỐ CỦA GUI VÀ THAM SỐ NÀY SẼ TRUYỀN CHO
;THAM SỐ CÙNG TÊN KHÔNG CÓ DẤU _D(VÍ DỤ $Die_Check_D LÀ 1 CHECKBOX SẼ TRUYỀN CHO THAM SỐ BOLEAN $Die_ChecK)
;TẤT CẢ CÁC THAM SỐ CÓ KÝ TỰ _OK ĐỀU LÀ THAM SỐ BOLEAN QUY ĐỊNH CÓ ĐƯỢC QUYỀN TRUYỀN THAM SỐ KHÔNG CỦA THAM SỐ TƯƠNG TỰ KHÔNG CÓ ĐUÔI _OK
$Tab1 = GUICtrlCreateTabItem("Main")
GUICtrlSetState(-1, $GUI_SHOW)
GUICtrlCreateGroup("Char info", 8, 27, 185, 121)
$Hp_Dislay = GUICtrlCreateLabel("", 12, 43, 180, 28)
$Mp_Dislay = GUICtrlCreateLabel("", 13, 77, 180, 28)
$Hp_Pet_Display = GUICtrlCreateLabel("", 12, 110, 180, 28)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateLabel("Alarm if die", 191, 31, 58, 18)
$Die_Check_D = GUICtrlCreateCheckbox("Die_D", 214, 53, 17, 17)
$Load_D = GUICtrlCreateButton("Load", 197, 79, 57, 25, 0)
GUICtrlSetOnEvent($Load_D, "Load")
$Save_D = GUICtrlCreateButton("Save", 197, 109, 57, 25, 0)
GUICtrlSetOnEvent($Save_D, "Save")
GUICtrlCreateLabel("Choose windown", 8, 152, 86, 18)
$Change_To_D = GUICtrlCreateButton("Change to", 8, 176, 60, 22)
GUICtrlSetOnEvent(-1, "Change_Title_To")
$Title_D = GUICtrlCreateCombo("", 104, 152, 145, 25)
$New_Title_D = GUICtrlCreateInput("ThucSon1", 104, 176, 145, 22)
$TabSheet2 = GUICtrlCreateTabItem("Skill") ;tao gui tab skill
GUICtrlCreateLabel("Skill 1", 7, 54, 36, 28)
GUICtrlCreateLabel("Skill 2", 7, 90, 36, 28)
GUICtrlCreateLabel("Skill 3", 7, 130, 36, 28)
GUICtrlCreateLabel("Key", 75, 27, 22, 17)
GUICtrlCreateLabel("Time delay", 119, 27, 55, 17)
GUICtrlCreateLabel("Repeat", 189, 27, 39, 17)
GUICtrlCreateLabel("Use", 232, 28, 31, 17)
$Skill1_Key_D = GUICtrlCreateCombo("", 50, 54, 60, 25)
GUICtrlSetData(-1, "1/2/3/4/5/6/7/8/9/0/{F2}/{F3}/{F4}/{F5}/{F6}/{F7}/{F8}", "1")
$Skill2_Key_D = GUICtrlCreateCombo("", 50, 90, 60, 25)
GUICtrlSetData(-1, "1/2/3/4/5/6/7/8/9/0/{F2}/{F3}/{F4}/{F5}/{F6}/{F7}/{F8}", "2")
$Skill3_Key_D = GUICtrlCreateCombo("", 50, 130, 60, 25)
GUICtrlSetData(-1, "1/2/3/4/5/6/7/8/9/0/{F2}/{F3}/{F4}/{F5}/{F6}/{F7}/{F8}", "3")
$Skill1_Repeat_D = GUICtrlCreateInput("1", 190, 54, 30, 22)
$Skill2_Repeat_D = GUICtrlCreateInput("4", 190, 90, 30, 22)
$Skill3_Repeat_D = GUICtrlCreateInput("1", 190, 130, 30, 22)
$Skill2_timer_D = GUICtrlCreateInput("1500", 128, 90, 49, 22)
$Skill1_Timer_D = GUICtrlCreateInput("1500", 128, 54, 49, 22)
$Skill3_Timer_D = GUICtrlCreateInput("3000", 128, 130, 49, 22)
$Skill1_Check_D = GUICtrlCreateCheckbox("", 235, 55, 17, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Skill2_Check_D = GUICtrlCreateCheckbox("", 235, 98, 17, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Skill3_Check_D = GUICtrlCreateCheckbox("", 235, 138, 17, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateLabel("Max sum skill times / 1 Mod", 8, 168, 133, 18)
$Max_Skill_D = GUICtrlCreateInput("20", 176, 168, 49, 22)
$TabSheet3 = GUICtrlCreateTabItem("Pet")
GUICtrlCreateLabel("Buff pet", 16, 48, 49, 17)
$Hp_Pet_Check_D = GUICtrlCreateCheckbox("", 29, 78, 17, 17)
GUICtrlCreateLabel("Buff key", 75, 48, 43, 17)
GUICtrlCreateLabel("Hp pet danger", 130, 48, 80, 17)
$Hp_Pet_Key_D = GUICtrlCreateCombo("", 74, 76, 41, 25)
GUICtrlSetData(-1, "1/2/3/4/5/6/7/8/9/0/{F2}/{F3}/{F4}/{F5}/{F6}/{F7}/{F8}", "8")
$Hp_Pet_Danger_D = GUICtrlCreateInput("300", 143, 74, 41, 21)
GUICtrlCreateLabel("Pet attack before", 12, 116, 86, 25)
$Timer_Pet_A_D = GUICtrlCreateInput("600", 143, 119, 41, 21)
GUICtrlCreateLabel("Pet attack key", 17, 157, 73, 17)
$Pet_A_K_D = GUICtrlCreateInput("n", 143, 160, 41, 21)
$TabSheet4 = GUICtrlCreateTabItem("Hp / Mp") ;tao gui tab hoi phuc mau va mana
GUICtrlCreateLabel("Hp", 9, 53, 18, 17)
GUICtrlCreateLabel("Mp", 9, 82, 19, 17)
GUICtrlCreateLabel("Key", 43, 29, 39, 17)
GUICtrlCreateLabel("Danger", 97, 28, 47, 17)
GUICtrlCreateLabel("Times", 154, 29, 32, 17)
GUICtrlCreateLabel("Check", 198, 29, 36, 17)
$Hp_key_D = GUICtrlCreateCombo("", 41, 52, 41, 25)
GUICtrlSetData(-1, "1/2/3/4/5/6/7/8/9/0/{F2}/{F3}/{F4}/{F5}/{F6}/{F7}/{F8}", "9")
$Hp_Check_D = GUICtrlCreateCheckbox("", 206, 52, 17, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Mp_key_D = GUICtrlCreateCombo("", 41, 83, 41, 25)
GUICtrlSetData(-1, "1/2/3/4/5/6/7/8/9/0/{F2}/{F3}/{F4}/{F5}/{F6}/{F7}/{F8}", "0")
$Mp_Danger_D = GUICtrlCreateInput("200", 97, 83, 49, 21)
$Mp_Times_D = GUICtrlCreateInput("1", 159, 83, 33, 21)
$Hp_Times_D = GUICtrlCreateInput("1", 159, 52, 33, 21)
$Mp_Check_D = GUICtrlCreateCheckbox("", 206, 83, 17, 17)
GUICtrlSetState(-1, $GUI_CHECKED)
$Hp_Danger_D = GUICtrlCreateInput("200", 97, 52, 49, 21)
GUICtrlCreateLabel("Sit/Sit key", 9, 119, 70, 17)
$Sit_key_D = GUICtrlCreateCombo("", 97, 119, 49, 25)
GUICtrlSetData(-1, "1/2/3/4/5/6/7/8/9/0/{F2}/{F3}/{F4}/{F5}/{F6}/{F7}/{F8}", "7")
$Sit_Check_D = GUICtrlCreateCheckbox("", 206, 124, 17, 17)
GUICtrlCreateLabel("Sinh Tan Quyet", 8, 152, 85, 18)
$Skill7_Key_D = GUICtrlCreateCombo("", 97, 152, 49, 25)
GUICtrlSetData(-1, "1/2/3/4/5/6/7/8/9/0/{F2}/{F3}/{F4}/{F5}/{F6}/{F7}/{F8}", "5")
$Skill7_Repeat_D = GUICtrlCreateInput("1", 162, 152, 33, 22)
GUICtrlSetState(-1, $GUI_DISABLE)
$Skill7_Check_D = GUICtrlCreateCheckbox("", 206, 152, 17, 17)
GUICtrlCreateLabel("Ky Hoang Huyet", 9, 181, 80, 17)
$Skill8_Key_D = GUICtrlCreateCombo("", 97, 181, 49, 25)
GUICtrlSetData(-1, "1/2/3/4/5/6/7/8/9/0/{F2}/{F3}/{F4}/{F5}/{F6}/{F7}/{F8}", "6")
$Skill8_Repeat_D = GUICtrlCreateInput("1", 162, 181, 33, 22)
$Skill8_Check_D = GUICtrlCreateCheckbox("", 206, 181, 17, 17)
$TabSheet5 = GUICtrlCreateTabItem("Buff") ; tao gui tab tu buff
GUICtrlCreateLabel("Skill 4", 10, 57, 52, 28)
GUICtrlCreateLabel("Skill 5", 10, 97, 52, 28)
GUICtrlCreateLabel("Skill 6", 10, 133, 52, 28)
GUICtrlCreateLabel("Key", 101, 38, 22, 17)
GUICtrlCreateLabel("Time repeat", 157, 38, 63, 17)
GUICtrlCreateLabel("Use", 235, 38, 31, 17)
$Skill4_key_D = GUICtrlCreateCombo("", 80, 58, 60, 25)
GUICtrlSetData(-1, "1/2/3/4/5/6/7/8/9/0/{F2}/{F3}/{F4}/{F5}/{F6}/{F7}/{F8}", "4")
$SKill5_Key_D = GUICtrlCreateCombo("", 78, 97, 60, 25)
GUICtrlSetData(-1, "1/2/3/4/5/6/7/8/9/0/{F2}/{F3}/{F4}/{F5}/{F6}/{F7}/{F8}", "5")
$SKill6_Key_D = GUICtrlCreateCombo("", 79, 134, 60, 25)
GUICtrlSetData(-1, "1/2/3/4/5/6/7/8/9/0/{F2}/{F3}/{F4}/{F5}/{F6}/{F7}/{F8}", "6")
$SKill4_Timer_D = GUICtrlCreateInput("900000", 167, 56, 49, 21)
$Skill5_Timer_D = GUICtrlCreateInput("1200000", 167, 97, 49, 21)
$SKill6_Timer_D = GUICtrlCreateInput("1800000", 167, 132, 49, 21)
$Skill4_Check_d = GUICtrlCreateCheckbox("", 242, 57, 17, 17)
$Skill5_Check_D = GUICtrlCreateCheckbox("", 242, 97, 17, 17)
$SKill6_Check_D = GUICtrlCreateCheckbox("", 242, 134, 17, 17)
GUICtrlCreateLabel("Use buff when click Read button ", 8, 176, 165, 18)
$Buff_Check_D = GUICtrlCreateCheckbox("Buff_Check_D", 240, 176, 17, 17)
$TabSheet6 = GUICtrlCreateTabItem("Help") ;tao gui help
$Help = GUICtrlCreateEdit("", 0, 24, 257, 177)
GUICtrlSetData(-1, " Huong dan su dung auto" & @CRLF & @CRLF & @CRLF & @CRLF & "Vui long xem chi tiet tai dia chi:" & @CRLF & "http://my.opera.com/Chocolatebuon/blog/2008" & @CRLF & "/11/11/huong-dan-su-dung-auto-thuc-son-v2-0" _
		 & @CRLF & @CRLF & @CRLF & "Duoc thuc hien boi nhom autoitvngroup")
GUICtrlCreateTabItem("")
$Read_Dislay = GUICtrlCreateButton("Read", 5, 212, 41, 25)
GUICtrlSetOnEvent($Read_Dislay, "Read")
$Start_D = GUICtrlCreateButton("Start", 49, 212, 41, 25)
GUICtrlSetOnEvent($Start_D, "Start")
$Hide_Game_D = GUICtrlCreateButton("Hide game", 94, 212, 57, 25)
GUICtrlSetOnEvent($Hide_Game_D, "Hide_Game")
$Exit_D = GUICtrlCreateButton("Exit", 211, 212, 49, 25)
GUICtrlSetOnEvent($Exit_D, "AltQ")
$Hide_auto_D = GUICtrlCreateButton("Hide Auto", 156, 212, 51, 25, 0)
GUICtrlSetOnEvent($Hide_auto_D, "Hide_Auto")
GUISetState(@SW_SHOW)
Opt("GUIOnEventMode", 1)
Opt("SendKeyDelay", 10)
Opt("SendKeyDownDelay", 10)
Opt("SendCapslockMode", 0)
Opt('TrayIconHide', 1)
Opt("GUIDataSeparatorChar", "/")
Dim $Hide = False, $Hp_key, $Mp_key, $Pet_A_K, $Sit_Check, $Sit_key, $Hp_key, $Mp_key, $Hp_Pet_Key
Dim $BaseMod = 0x00e7d5bc, $Hp_Mod, $MEMID, $Pid, $Hp_Mod_Buffer, $Hp_Buffer, $traymsg, $Title, $Hp_Pet_Ok = True
Dim $Hp_Pet_Curren, $Hp_Pet_Max, $Hp_Pet_Check, $Hp_Pet_Danger, $Die_Check, $Name, $Lvl
Dim $Sum_timer, $Curren_timer, $TimerInfo, $TimerStamp, $Timer_Pet_Hp, $TimerSit, $Timer_Pet_A, $Curren_Min, $Hp_Compare
Dim $Hp_Curren, $Hp_Max, $Mp_Curren, $Mp_Max, $Sendok = False, $HP_Check, $MP_Check, $Hp_Danger, $Mp_Danger, $ReadOk = False, $Hp_Times = 2, $Mp_Times = 1
Dim $BaseAdd = 0x00EB7EE0, $FileOpen, $FileSave, $Change_Title_ok = False, $Hide_auto = False
Dim $Skill1_Check, $Skill2_Check, $Skill3_Check, $Skill1_Time, $Skill2_Time, $Skill3_Time, $Skill1_Repeat, $Skill3_Repeat, $Skill2_Repeat, $CurentSkill
Dim $Skill4_Check, $Skill5_Check, $Skill6_Check, $Skill7_Check, $Skill8_Check, $Skill4_Time, $Skill5_Time, $Skill6_Time
Dim $Skill1_Key, $Skill2_Key, $Skill3_Key, $Skill4_Key, $Skill5_Key, $Skill6_Key, $Skill7_Key, $Skill8_Key, $Skill8_Repeat, $Count_Skill, $Max_Skill
Dim $Skill4_Start, $Skill5_Start, $Skill6_Start, $Skill4_Send = False, $Skill5_Send = False, $Skill6_Send = False, $Buff_Check
GUICtrlSetData($Title_D, GetListTitle()) ;khi chạy trương trình thì tìm cửa sổ game dưa vào combo $Title_d ngay
HotKeySet("^!h", "Hide_Auto")   ;hotkey duy nhất để làm hiện auto khi đã ẩn(dùng để ẩn auto cũng được)
;tất cả các hàm tớ viết có lẽ cũng ổn,nếu phải chỉnh sửa thì có lẽ là phải chính sửa nhiều nhất ở vòng lặp chính này
;đang nghĩ đến phương án dùng select thay cho hàm if
While 1
	If $ReadOk Then ;- nếu nut read được bấm thì readok sẽ chuyển thành true
		If TimerDiff($TimerInfo) > 500 Then ;- hien thi thong tin voi 500ms/1lan
			info()
			$TimerInfo = TimerInit()
			If (Hp_Curren() = 0) And $Die_Check Then
				$Sendok = False
				GUICtrlSetData($Start_D, "Stop")
				MsgBox(0, "Thong bao", "Nhan vat hien dang chet")
			EndIf
		EndIf
	EndIf
	Hp_Mod();- tinh ch? s? mau mod 1 cach thu?ng xuyen,n?u khong c?n thi?t co th? cho ham nay len tren d? tinh mau mod 0.5s/1 l?n
	If $Sendok Then ;- = true nếu nút start được bấm
		If $Hp_Pet_Check Then Hp_Pet_Check() ;- ki?m tra mau pet n?u du?c dung
		If Hp_Mod() = 0 Then
			If $Skill4_Check Then Skill_4() ;Ki?m tra cac skill t? buff
			If $Skill5_Check Then Skill_5()
			If $Skill6_Check Then Skill_6()
			If $HP_Check Then Hp_Check() ;- ki?m tra hp n?u co s? d?ng ch?c nang ki?m tra mau
			If $MP_Check Then Mp_Check()
			If $Skill7_Check Or $Skill8_Check Then BH_Buff()
			If $Sit_Check Then Sit()
			ControlSend($Title, "", "", "{TAB}") ;- chuy?n target quai n?u th?y hp quai =0(quai da chit )
			$Count_Skill = 0
			Sleep(100)
			If $Hp_Pet_Check Then
				ControlSend($Title, "", "", $Pet_A_K & $Pet_A_K) ;- gui phim cho pet tan cong neu co pet
				Sleep($Timer_Pet_A / 2)
				ControlSend($Title, "", "", $Pet_A_K & $Pet_A_K) ;- pet nay t? check n?u g?i 1 l?n no khong ch?y nen g?i luon 3 l?n cho ch?c
				Sleep($Timer_Pet_A / 2)
				ControlSend($Title, "", "", $Pet_A_K & $Pet_A_K)
			EndIf
		EndIf
		If $Count_Skill > $Max_Skill Then
			ControlSend($Title, "", "", "{TAB}")
			If $Hp_Pet_Check Then
				ControlSend($Title, "", "", $Pet_A_K & $Pet_A_K) ;- gui phim cho pet tan cong neu co pet
				Sleep($Timer_Pet_A / 2)
				ControlSend($Title, "", "", $Pet_A_K & $Pet_A_K) ;- pet nay t? check n?u g?i 1 l?n no khong ch?y nen g?i luon 3 l?n cho ch?c
				Sleep($Timer_Pet_A / 2)
				ControlSend($Title, "", "", $Pet_A_K & $Pet_A_K)
			EndIf
			$Count_Skill = 0
		EndIf
		$Curren_timer = Int(TimerDiff($TimerStamp)) ;- tinh th?i gian hi?n t?i ham skill
		If $Skill1_Check Then Skill_1()
		If $Skill2_Check Then Skill_2()
		If $Skill3_Check Then Skill_3()
		If ($CurentSkill > ($Skill1_Repeat + $Skill2_Repeat + $Skill3_Repeat)) And ($Curren_timer >= $Sum_timer) Then ;- n?u da th?c hi?n xong 1 chu k? skill(t? skill 1 va ra xong c? skill 3)
			$TimerStamp = TimerInit() ;- kh?i t?o l?i b? d?m gi?
			$CurentSkill = 1 ;- kh?i t?o l?i bi?n d?m th?i gian
		EndIf
	EndIf
	$nMsg = GUIGetMsg() ;-hoi ghet nhin cai hinh tho k?ch ? autoit nen d?i bi?u tu?ng,phu phu xong rui,vi?t chu thich ma m?i tay qua
	If ($nMsg = $GUI_EVENT_CLOSE) Then Exit
WEnd
Func Hp_Mod()
	$Hp_Mod = _MemoryRead($Hp_Mod_Buffer + 0x538, $MEMID) ;- tinh hp của quái,tất cả các hàm hp_mod,Hp,mp của nhân vật _
	Return $Hp_Mod  										;đều được tính qua biến đệm Hp_buffer,biến buffer được đọc ngay từ khi ấn read,qua biến buffer nàyeu
EndFunc   ;==>Hp_Mod										;vòng lặp chính không phải read nhiều lần nữa
Func Hp_Curren()
	$Hp_Curren = _MemoryRead($Hp_Buffer + 0x740, $MEMID)
	Return $Hp_Curren
EndFunc   ;==>Hp_Curren
Func Hp_Max()
	$Hp_Max = _MemoryRead($Hp_Buffer + 0x47c, $MEMID)
	Return $Hp_Max
EndFunc   ;==>Hp_Max
Func Mp_Max()
	$Mp_Max = _MemoryRead($Hp_Buffer + 0x6ec, $MEMID)
	Return $Mp_Max
EndFunc   ;==>Mp_Max
Func Mp_Curren()
	$Mp_Curren = _MemoryRead($Hp_Buffer + 0x744, $MEMID)
	Return $Mp_Curren
EndFunc   ;==>Mp_Curren
Func Hp_Pet_Curren()
	$Hp_Pet_Curren = _MemoryRead($Hp_Buffer + 0x8f8, $MEMID) ;biến pet này là biến đặc biệt,nên không thể đọc 1 lần qua biến buffer được do nó có biến đổi khi đổi pet
	$Hp_Pet_Curren = _MemoryRead($Hp_Pet_Curren + 0xC, $MEMID)
	$Hp_Pet_Curren = _MemoryRead($Hp_Pet_Curren + 0x740, $MEMID)
	Return $Hp_Pet_Curren
EndFunc   ;==>Hp_Pet_Curren
Func Hp_Pet_Max()
	$Hp_Pet_Max = _MemoryRead($Hp_Buffer + 0x8f8, $MEMID)
	$Hp_Pet_Max = _MemoryRead($Hp_Pet_Max + 0xC, $MEMID)
	$Hp_Pet_Max = _MemoryRead($Hp_Pet_Max + 0x47C, $MEMID)
	Return $Hp_Pet_Max
EndFunc   ;==>Hp_Pet_Max
Func Read() ;- la nut bam Read Data,neu nut bam nay bam thi se doc tat ca du lieu cua gui
	$ReadOk = Not $ReadOk ;- đổi trạng thái của nút bấm,giống như công tắc đèn
	If $ReadOk Then ;khi ấn nút read thì bắt đầu đọc dữ liệu
		If $Change_Title_ok Then
			$Title = GUICtrlRead($New_Title_D) ; lay title cua cua so game can auto
		Else
			$Title = GUICtrlRead($Title_D)
		EndIf
		If $Title = "" Then ;- thong bao loi neu khong tim duoc cua so game
			MsgBox(0, "Thong bao", "Khong tim duoc cua so game")
			Exit
		EndIf
		$Pid = WinGetProcess($Title)
		$MEMID = _memoryopen($Pid)
		$Hp_Buffer = _MemoryRead($BaseAdd, $MEMID)
		$Hp_Buffer = _MemoryRead($Hp_Buffer + 0x10c, $MEMID) ;- Tinh gia tr? b? nh? d?m,khi ch?y game rui thi ch? s? Hp_buffer s? khong d?i n?a vi v?y ta tinh 1 l?n ? day thoi
		$Hp_Mod_Buffer = _MemoryRead($BaseMod, $MEMID) ;- ham tinh mau pet khong th? vi?t b? nh? d?m du?c vi no thay d?i sau offset 10c
		$Hp_Mod_Buffer = _MemoryRead($Hp_Mod_Buffer + 0xC, $MEMID)
		$Hp_Mod_Buffer = _MemoryRead($Hp_Mod_Buffer + 0x2AC, $MEMID)
		$Name = _MemoryRead($Hp_Buffer + 0x460, $MEMID, "char[15]")   ;đọc tên nhân vật
		$Lvl = _MemoryRead($Hp_Buffer + 0x74C, $MEMID, "short")
		GUICtrlSetData($Read_Dislay, "Reset")
		If GUICtrlRead($Die_Check_D) = $GUI_CHECKED Then  ;bắt đầu đọc tất cả các dữ liệu của gui nhập vào
			$Die_Check = True
		Else
			$Die_Check = False
		EndIf
		If GUICtrlRead($Mp_Check_D) = $GUI_CHECKED Then ;-  d?c d? li?u t? gui,va gan cho cac bi?n,tieu chi c?a t? la d?c t?t c? cac gia tr? t? gui ngay khi ?n read d? trong vong l?p chinh khong
			$MP_Check = True ;-ph?i d?c l?i 1 d? li?u nao t? gui n?a
			$Mp_key = GUICtrlRead($Mp_key_D)
			$Mp_Danger = GUICtrlRead($Mp_Danger_D)
			$Mp_Times = GUICtrlRead($Mp_Times_D)
		Else
			$MP_Check = False
		EndIf
		If GUICtrlRead($Hp_Check_D) = $GUI_CHECKED Then
			$HP_Check = True ;- day la bi?n t? dung d? ki?m xem co s? d?ng ch?c nang bom mau n?u mau thi?u khong
			$Hp_key = GUICtrlRead($Hp_key_D)
			$Hp_Danger = GUICtrlRead($Hp_Danger_D)
			$Hp_Times = GUICtrlRead($Hp_Times_D)
		Else
			$HP_Check = False
		EndIf
		If GUICtrlRead($Skill7_Check_D) = $GUI_CHECKED Then
			$Skill7_Check = True
			$Skill7_Key = GUICtrlRead($Skill7_Key_D)
			$HP_Check = False
		Else
			$Skill7_Check = False
		EndIf
		If GUICtrlRead($Skill8_Check_D) = $GUI_CHECKED Then
			$Skill8_Check = True
			$Skill8_Key = GUICtrlRead($Skill8_Key_D)
			$Skill8_Repeat = GUICtrlRead($Skill8_Repeat_D)
			$HP_Check = False
		Else
			$Skill8_Check = False
		EndIf
		If GUICtrlRead($Sit_Check_D) = $GUI_CHECKED Then
			$Sit_Check = True
			$Sit_key = GUICtrlRead($Sit_key_D)
			$HP_Check = False ;- ch? nay hoi vong vo 1 chut,n?u da danh d?u vao ng?i thi?n thi khong cho bom mau va mp n?a
			$MP_Check = False ;- nhung v?n ph?i danh d?u vao ki?m tra mau va mp d? chuong trinh con d?c ch? s? Mp_danger
		Else
			$Sit_Check = False
		EndIf

		If GUICtrlRead($Hp_Pet_Check_D) = $GUI_CHECKED Then
			$Hp_Pet_Check = True ;- bi?n nay la bi?n c?a pet,n?u true thi s? th?c hi?n t?t c? m?i th? lien quan d?n pet,con false thi khong lam lien quan d?n pet
			$Hp_Pet_Danger = GUICtrlRead($Hp_Pet_Danger_D)
			$Pet_A_K = GUICtrlRead($Pet_A_K_D)
			$Timer_Pet_A = GUICtrlRead($Timer_Pet_A_D)
			$Hp_Pet_Key = GUICtrlRead($Hp_Pet_Key_D)
		Else
			$Hp_Pet_Check = False
		EndIf
		If GUICtrlRead($Skill1_Check_D) = $GUI_CHECKED Then
			$Skill1_Check = True ;- co dung skill 1 khong
			$Skill1_Time = GUICtrlRead($Skill1_Timer_D) ;- th?i gian ra h?t skill 1(d?c ? b?ng skill c?a nhan v?t)
			$Skill1_Repeat = GUICtrlRead($Skill1_Repeat_D) ;- skill 1 du?c danh lien ti?p m?y l?n
			$Skill1_Key = GUICtrlRead($Skill1_Key_D) ;- d?c phim g?i skill 1
		Else
			$Skill1_Check = False
			$Skill1_Time = 0
			$Skill1_Repeat = 0
		EndIf
		If GUICtrlRead($Skill2_Check_D) = $GUI_CHECKED Then ;- thong thu?ng t? hay d?t skill 1 la skill gi?m phong th? v?t ly va skill 2 la skill danh chay v?i d? l?p l?i la 4
			$Skill2_Check = True ;- t?c la danh 1 skill 1 rui d?n 4 skill danh chay rui d?n skill 1........
			$Skill2_Time = GUICtrlRead($Skill2_timer_D)
			$Skill2_Repeat = GUICtrlRead($Skill2_Repeat_D)
			$Skill2_Key = GUICtrlRead($Skill2_Key_D)
		Else
			$Skill2_Check = False
			$Skill2_Time = 0
			$Skill2_Repeat = 0
		EndIf
		If GUICtrlRead($Skill3_Check_D) = $GUI_CHECKED Then
			$Skill3_Check = True
			$Skill3_Time = GUICtrlRead($Skill3_Timer_D)
			$Skill3_Repeat = GUICtrlRead($Skill3_Repeat_D)
			$Skill3_Key = GUICtrlRead($Skill3_Key_D)
		Else
			$Skill3_Check = False
			$Skill3_Time = 0
			$Skill3_Repeat = 0
		EndIf
		$Max_Skill = GUICtrlRead($Max_Skill_D)
		If GUICtrlRead($Skill4_Check_d) = $GUI_CHECKED Then
			$Skill4_Check = True
			$Skill4_Time = GUICtrlRead($SKill4_Timer_D)
			$Skill4_Key = GUICtrlRead($Skill4_key_D)
			$Skill4_Start = TimerInit()
		Else
			$Skill4_Check = False
		EndIf
		If GUICtrlRead($Skill5_Check_D) = $GUI_CHECKED Then
			$Skill5_Check = True
			$Skill5_Time = GUICtrlRead($Skill5_Timer_D)
			$Skill5_Key = GUICtrlRead($SKill5_Key_D)
			$Skill5_Start = TimerInit()
		Else
			$Skill5_Check = False
		EndIf
		If GUICtrlRead($SKill6_Check_D) = $GUI_CHECKED Then
			$Skill6_Check = True
			$Skill6_Time = GUICtrlRead($SKill6_Timer_D)
			$Skill6_Key = GUICtrlRead($SKill6_Key_D)
			$Skill6_Start = TimerInit()
		Else
			$Skill6_Check = False
		EndIf
		If GUICtrlRead($Buff_Check_D) = $GUI_CHECKED Then ;tu buff ban than neu co dau check yeu cau buff lan dau tien
			ControlSend($Title, "", "", "{F1}")
			Sleep(500)
			If $Skill4_Check Then
				ControlSend($Title, "", "", $Skill4_Key)
				Sleep(1500)
			EndIf
			If $Skill5_Check Then
				ControlSend($Title, "", "", $Skill5_Key)
				Sleep(1500)
			EndIf
			If $Skill6_Check Then ControlSend($Title, "", "", $Skill6_Key)
		EndIf
		$Sum_timer = Int($Skill1_Time * $Skill1_Repeat + $Skill2_Time * $Skill2_Repeat + $Skill3_Time * $Skill3_Repeat) ;- tổng thời gian ra hết  3 skill
	Else
		GUICtrlSetData($Read_Dislay, "Read")
	EndIf
EndFunc   ;==>Read
Func Start() ;- la nut bam cua Start,de bat dau auto sau khi da doc xong du lieu
	$Sendok = Not $Sendok
	If $Sendok Then
		GUICtrlSetData($Start_D, "Stop")
		$TimerStamp = TimerInit() ;-bat dau dem thoi gian(danh d?u th?i gian)
		$CurentSkill = 1 ;- la bi?n t? d? d?m s? skill
		$Count_Skill = 0 ;biến đếm skill hiện tại dùng để so sánh với số lần đánh trên 1 con quái
		WinActive($Title)
		ControlSend($Title, "", "", "{TAB}") ;-taget quai ngay tranh dung den vong lap
		GUICtrlSetState($Skill1_Key_D, $GUI_DISABLE) ;- lam cho nut bấm trở thanh disable
		GUICtrlSetState($Skill2_Key_D, $GUI_DISABLE)
		GUICtrlSetState($Skill3_Key_D, $GUI_DISABLE)
		GUICtrlSetState($Skill1_Timer_D, $GUI_DISABLE)
		GUICtrlSetState($Skill2_timer_D, $GUI_DISABLE)
		GUICtrlSetState($Skill3_Timer_D, $GUI_DISABLE)
		GUICtrlSetState($Skill1_Repeat_D, $GUI_DISABLE)
		GUICtrlSetState($Skill2_Repeat_D, $GUI_DISABLE)
		GUICtrlSetState($Skill3_Repeat_D, $GUI_DISABLE)
		GUICtrlSetState($Skill1_Check_D, $GUI_DISABLE)
		GUICtrlSetState($Skill2_Check_D, $GUI_DISABLE)
		GUICtrlSetState($Skill3_Check_D, $GUI_DISABLE)
		GUICtrlSetState($Max_Skill_D, $GUI_DISABLE)
		GUICtrlSetState($Hp_key_D, $GUI_DISABLE)
		GUICtrlSetState($Mp_key_D, $GUI_DISABLE)
		GUICtrlSetState($Hp_Pet_Check_D, $GUI_DISABLE)
		GUICtrlSetState($Hp_Pet_Key_D, $GUI_DISABLE)
		GUICtrlSetState($Hp_Pet_Danger_D, $GUI_DISABLE)
		GUICtrlSetState($Timer_Pet_A_D, $GUI_DISABLE)
		GUICtrlSetState($Pet_A_K_D, $GUI_DISABLE)
		GUICtrlSetState($Hp_key_D, $GUI_DISABLE)
		GUICtrlSetState($Hp_Danger_D, $GUI_DISABLE)
		GUICtrlSetState($Hp_Times_D, $GUI_DISABLE)
		GUICtrlSetState($Hp_Check_D, $GUI_DISABLE)
		GUICtrlSetState($Mp_key_D, $GUI_DISABLE)
		GUICtrlSetState($Mp_Danger_D, $GUI_DISABLE)
		GUICtrlSetState($Mp_Times_D, $GUI_DISABLE)
		GUICtrlSetState($Mp_Check_D, $GUI_DISABLE)
		GUICtrlSetState($Sit_key_D, $GUI_DISABLE)
		GUICtrlSetState($Sit_Check_D, $GUI_DISABLE)
		GUICtrlSetState($Skill7_Key_D, $GUI_DISABLE)
		GUICtrlSetState($Skill7_Check_D, $GUI_DISABLE)
		GUICtrlSetState($Skill8_Key_D, $GUI_DISABLE)
		GUICtrlSetState($Skill8_Repeat_D, $GUI_DISABLE)
		GUICtrlSetState($Skill8_Check_D, $GUI_DISABLE)
		GUICtrlSetState($Skill4_key_D, $GUI_DISABLE)
		GUICtrlSetState($SKill4_Timer_D, $GUI_DISABLE)
		GUICtrlSetState($Skill4_Check_d, $GUI_DISABLE)
		GUICtrlSetState($SKill5_Key_D, $GUI_DISABLE)
		GUICtrlSetState($Skill5_Timer_D, $GUI_DISABLE)
		GUICtrlSetState($Skill5_Check_D, $GUI_DISABLE)
		GUICtrlSetState($SKill6_Key_D, $GUI_DISABLE)
		GUICtrlSetState($SKill6_Timer_D, $GUI_DISABLE)
		GUICtrlSetState($SKill6_Check_D, $GUI_DISABLE)
		GUICtrlSetState($Buff_Check_D, $GUI_DISABLE)
		Sleep(1000)
	Else
		GUICtrlSetData($Start_D, "Start") ;- chuyển trạng thai nut bấm  stop thành start
		GUICtrlSetState($Skill1_Key_D, $GUI_ENABLE) ;- lam cho nut bấm trở về trạng thái enable
		GUICtrlSetState($Skill2_Key_D, $GUI_ENABLE)
		GUICtrlSetState($Skill3_Key_D, $GUI_ENABLE)
		GUICtrlSetState($Skill1_Timer_D, $GUI_ENABLE)
		GUICtrlSetState($Skill2_timer_D, $GUI_ENABLE)
		GUICtrlSetState($Skill3_Timer_D, $GUI_ENABLE)
		GUICtrlSetState($Skill1_Repeat_D, $GUI_ENABLE)
		GUICtrlSetState($Skill2_Repeat_D, $GUI_ENABLE)
		GUICtrlSetState($Skill3_Repeat_D, $GUI_ENABLE)
		GUICtrlSetState($Skill1_Check_D, $GUI_ENABLE)
		GUICtrlSetState($Skill2_Check_D, $GUI_ENABLE)
		GUICtrlSetState($Skill3_Check_D, $GUI_ENABLE)
		GUICtrlSetState($Max_Skill_D, $GUI_ENABLE)
		GUICtrlSetState($Hp_key_D, $GUI_ENABLE)
		GUICtrlSetState($Mp_key_D, $GUI_ENABLE)
		GUICtrlSetState($Hp_Pet_Check_D, $GUI_ENABLE)
		GUICtrlSetState($Hp_Pet_Key_D, $GUI_ENABLE)
		GUICtrlSetState($Hp_Pet_Danger_D, $GUI_ENABLE)
		GUICtrlSetState($Timer_Pet_A_D, $GUI_ENABLE)
		GUICtrlSetState($Pet_A_K_D, $GUI_ENABLE)
		GUICtrlSetState($Hp_key_D, $GUI_ENABLE)
		GUICtrlSetState($Hp_Danger_D, $GUI_ENABLE)
		GUICtrlSetState($Hp_Times_D, $GUI_ENABLE)
		GUICtrlSetState($Hp_Check_D, $GUI_ENABLE)
		GUICtrlSetState($Mp_key_D, $GUI_ENABLE)
		GUICtrlSetState($Mp_Danger_D, $GUI_ENABLE)
		GUICtrlSetState($Mp_Times_D, $GUI_ENABLE)
		GUICtrlSetState($Mp_Check_D, $GUI_ENABLE)
		GUICtrlSetState($Sit_key_D, $GUI_ENABLE)
		GUICtrlSetState($Sit_Check_D, $GUI_ENABLE)
		GUICtrlSetState($Skill7_Key_D, $GUI_ENABLE)
		GUICtrlSetState($Skill7_Check_D, $GUI_ENABLE)
		GUICtrlSetState($Skill8_Key_D, $GUI_ENABLE)
		GUICtrlSetState($Skill8_Repeat_D, $GUI_ENABLE)
		GUICtrlSetState($Skill8_Check_D, $GUI_ENABLE)
		GUICtrlSetState($Skill4_key_D, $GUI_ENABLE)
		GUICtrlSetState($SKill4_Timer_D, $GUI_ENABLE)
		GUICtrlSetState($Skill4_Check_d, $GUI_ENABLE)
		GUICtrlSetState($SKill5_Key_D, $GUI_ENABLE)
		GUICtrlSetState($Skill5_Timer_D, $GUI_ENABLE)
		GUICtrlSetState($Skill5_Check_D, $GUI_ENABLE)
		GUICtrlSetState($SKill6_Key_D, $GUI_ENABLE)
		GUICtrlSetState($SKill6_Timer_D, $GUI_ENABLE)
		GUICtrlSetState($SKill6_Check_D, $GUI_ENABLE)
		GUICtrlSetState($Buff_Check_D, $GUI_ENABLE)
	EndIf
EndFunc   ;==>Start
Func info() ;- ham hiện thỉ thông tin nhân vật nhu Hp_curren,Mp_curren
	GUICtrlSetData($Hp_Dislay, "Hp  " & Hp_Curren() & "/" & Hp_Max() & "  Mp  " & Mp_Curren() & "/" & Mp_Max())
	GUICtrlSetData($Mp_Dislay, "Name  " & $Name & "  Lv  " & $Lvl)
	If $Hp_Pet_Check Then GUICtrlSetData($Hp_Pet_Display, "PetHp  " & Hp_Pet_Curren() & "/" & Hp_Pet_Max()) ;- nếu có pet thì hiển thị hp pet
EndFunc   ;==>info
Func Hp_Pet_Check() ;- hàm kiểm tra máu pet nếu thấp hơn mức danger thì cho phép gửi phím
	If (Not $Hp_Pet_Ok) Then ;- khi d?u thi hp_pet_ok la true nen di?u ki?n nay la false
		If TimerDiff($Timer_Pet_Hp) >= 6000 Then ; chỉ cho bom mau cho pet 1 lần,lần 2 sau khi da bom máu cách lần 1 là 6s
			$Hp_Pet_Ok = True
		EndIf
	EndIf
	If (Hp_Pet_Curren() <> 0) And (Hp_Pet_Curren() < $Hp_Pet_Danger) And $Hp_Pet_Ok Then ;-hp-pet_ok luon true,ch? tr? khi ham bom mau nay kich ho?t
		ControlSend($Title, "", "", $Hp_Pet_Key) ;gủi phim
		Sleep(100)
		$Hp_Pet_Ok = False ;- d?i sang false d? khong cho g?i phim bom mau 2 l?n lien ti?p trong vong l?p chinh
		$Timer_Pet_Hp = TimerInit() ;- kh?i t?o b? d?m gi? sau khi da bom mau cho pet
	EndIf
EndFunc   ;==>Hp_Pet_Check
Func Hp_Check()
	Local $j
	If (Hp_Curren() <> 0) And (Hp_Curren() < $Hp_Danger) And Hp_Mod() = 0 Then
		$Hp_Compare = $Hp_Curren;Danh dau hp hien tai
		Sleep(3000) ;chuyển sang chế độ hồi thủ
		For $j = 1 To $Hp_Times ;số lần uống máu
			If Hp_Curren() < $Hp_Compare Then ExitLoop ;sau 3s mà máu hiện tại nhỏ hơn máu đánh dấu(bị quái đánh) thì thoát vòng lặp bơm máu
			ControlSend($Title, "", "", $Hp_key)
			$Hp_Compare = Hp_Curren()
			Sleep(3000) ;- nghi 15s de uong mau,chia lam 5 dot de kiem tra xem co bi quai tan cong hay khong
			If Hp_Curren() < $Hp_Compare Then ExitLoop ;so sanh hp hien tai voi hp 3s ve truoc
			$Hp_Compare = Hp_Curren()
			Sleep(3000)
			If Hp_Curren() < $Hp_Compare Then ExitLoop
			$Hp_Compare = Hp_Curren()
			Sleep(3000)
			If Hp_Curren() < $Hp_Compare Then ExitLoop
			$Hp_Compare = Hp_Curren()
			Sleep(3000)
			If Hp_Curren() < $Hp_Compare Then ExitLoop
			$Hp_Compare = Hp_Curren()
			Sleep(4000)
			If Hp_Curren() < $Hp_Compare Then ExitLoop
		Next
	EndIf
EndFunc   ;==>Hp_Check
Func Mp_Check() ;- tuong t? ham hp
	Local $i
	If (Mp_Curren() <> 0) And (Mp_Curren() < $Mp_Danger) And Hp_Mod() = 0 Then
		$Hp_Compare = Hp_Curren()
		Sleep(3000)
		For $i = 1 To $Mp_Times
			If Hp_Curren() < $Hp_Compare Then ExitLoop
			ControlSend($Title, "", "", $Mp_key)
			$Hp_Compare = Hp_Curren()
			Sleep(3000)
			If Hp_Curren() < $Hp_Compare Then ExitLoop
			$Hp_Compare = Hp_Curren()
			Sleep(3000)
			If Hp_Curren() < $Hp_Compare Then ExitLoop
			$Hp_Compare = Hp_Curren()
			Sleep(3000)
			If Hp_Curren() < $Hp_Compare Then ExitLoop
			$Hp_Compare = Hp_Curren()
			Sleep(3000)
			If Hp_Curren() < $Hp_Compare Then ExitLoop
			$Hp_Compare = Hp_Curren()
			Sleep(4000)
			If Hp_Curren() < $Hp_Compare Then ExitLoop
		Next
	EndIf
EndFunc   ;==>Mp_Check   ;==>Mp_Check
Func BH_Buff()
	Local $k
	If (Hp_Curren() <> 0) And (Hp_Curren() <= $Hp_Danger) Then
		ControlSend($Title, "", "", "{F1}")
		Sleep(100)
		If $Skill7_Check Then
			ControlSend($Title, "", "", $Skill7_Key)
			Sleep(1000)
		EndIf
		If $Skill8_Check Then
			For $k = 1 To $Skill8_Repeat
				ControlSend($Title, "", "", $Skill8_Key)
				Sleep(4000)
			Next
		EndIf
		
	EndIf
EndFunc   ;==>BH_Buff
Func Sit() ;hàm ngổi thiền 
	Local $Check_BH
	$Check_BH = ((Hp_Curren() <> 0) And (Hp_Curren() < $Hp_Danger)) ;dat bien buffer de check phai bach hoa
	If $Skill7_Check Or $Skill8_Check Then $Check_BH = False ;neu co dung bach hoa buff mau thi khi s? khong ng?i thi?n n?u hp qua gi?i h?n
	If $Check_BH Or ((Hp_Curren() <> 0) And (Mp_Curren() < $Mp_Danger)) Then
		Sleep(3000)
		$TimerSit = TimerInit()
		ControlSend($Title, "", "", $Sit_key)
		Do
			If TimerDiff($TimerSit) > 1000 Then ;- khi ngồi thiền thì 1s đọc bộ nhớ 1 lần để đọc dữ liệu 
				Hp_Mod()
				If Hp_Mod() <> 0 Then ExitLoop ;nếu có quái tấn công thì phải thoát vòng lặp ngay để đánh quái chứ không đợi hp đầy như điều kiện until
				Hp_Curren()
				Hp_Max()
				Mp_Curren()
				Mp_Max()
				$TimerSit = TimerInit()
			EndIf
		Until (Hp_Curren() = Hp_Max()) And (Mp_Curren() = Mp_Max()) ;ngoi thien cho toi khi mau va mana day binh
	EndIf
EndFunc   ;==>Sit
;- ham skill này tớ phải suy nghĩ 1 ngày mới thành công,tớ không dùng lệnh sleep vì lệnh sleep rất hạn chế tốc độ auto 
;- phim cần gửi vào game      1______2_____2_____2______2_______3_______
;- th?i gian	     0      1     2      3	    4       5
;- skill hi?n t?i  1     2     3     4      5      6        7
;-nhin vao so d? tren rui t? tinh toan di?u ki?n khi nao c?n g?i skill nao cho vong l?p d?u tien
Func Skill_1()
	If $CurentSkill <= $Skill1_Repeat Then ;- skill phụ thuộc vào số skill
		If ((Mod($Curren_timer, $Sum_timer) < ($Skill1_Time * $CurentSkill))) And ((Mod($Curren_timer, $Sum_timer) >= ($Skill1_Time * ($CurentSkill - 1)))) Then ;- gửi skill phụ thuộc vào thời gian hiệ tại
			ControlSend($Title, "", "", $Skill1_Key) ;- gửi skilll vao game
			Sleep(100)
			$CurentSkill = $CurentSkill + 1 ;- 1 lần ra 1 skill thi tăng số lần lên l
			$Count_Skill = $Count_Skill + 1 ; dem skill de tinh 1 con quai danh bao nhieu skill
		EndIf
	EndIf
EndFunc   ;==>Skill_1

Func Skill_2()
	If ($CurentSkill > $Skill1_Repeat) And ($CurentSkill <= ($Skill1_Repeat + $Skill2_Repeat)) Then
		If (Mod($Curren_timer, $Sum_timer) < ($Skill1_Time * $Skill1_Repeat + $Skill2_Time * ($CurentSkill - $Skill1_Repeat))) And (Mod($Curren_timer, $Sum_timer) >= ($Skill1_Time * $Skill1_Repeat + $Skill2_Time * ($CurentSkill - $Skill1_Repeat - 1))) Then
			ControlSend($Title, "", "", $Skill2_Key)
			Sleep(100)
			$CurentSkill = $CurentSkill + 1
			$Count_Skill = $Count_Skill + 1
		EndIf
	EndIf
EndFunc   ;==>Skill_2
Func Skill_3()
	If ($CurentSkill > $Skill1_Repeat + $Skill2_Repeat) And ($CurentSkill <= ($Skill1_Repeat + $Skill2_Repeat + $Skill3_Repeat)) Then
		If (Mod($Curren_timer, $Sum_timer) < ($Skill1_Time * $Skill1_Repeat + $Skill2_Time * $Skill2_Repeat + $Skill3_Time * ($CurentSkill - $Skill1_Repeat - $Skill2_Repeat))) And (Mod($Curren_timer, $Sum_timer) >= ($Skill1_Time * $Skill1_Repeat + $Skill2_Time * $Skill2_Repeat + $Skill3_Time * ($CurentSkill - $Skill1_Repeat - $Skill2_Repeat - 1))) Then
			ControlSend($Title, "", "", $Skill3_Key)
			Sleep(100)
			$CurentSkill = $CurentSkill + 1
			$Count_Skill = $Count_Skill + 1
		EndIf
	EndIf
EndFunc   ;==>Skill_3
Func Skill_4() ;skill tự buff 4,5,6
	If Not $Skill4_Send Then
		If (TimerDiff($Skill4_Start) > $Skill4_Time) Then  ;nếu thời gian vượt qua thời gian quy định thì sẽ cho gửi phím
			$Skill4_Send = True
		EndIf
	EndIf
	If $Skill4_Send Then
		If Not $Hp_Pet_Check Then ControlSend($Title, "", "", "{F1}") ;khi tự buff thì tự target bản thân
		Sleep(100)
		ControlSend($Title, "", "", $Skill4_Key)
		$Skill4_Start = TimerInit()
		$Skill4_Send = False
		Sleep(100)
	EndIf
EndFunc   ;==>Skill_4
Func Skill_5()
	If Not $Skill5_Send Then
		If (TimerDiff($Skill5_Start) > $Skill5_Time) Then
			$Skill5_Send = True
		EndIf
	EndIf
	If $Skill5_Send Then
		If Not $Hp_Pet_Check Then ControlSend($Title, "", "", "{F1}")
		Sleep(100)
		ControlSend($Title, "", "", $Skill5_Key)
		$Skill5_Start = TimerInit()
		$Skill5_Send = False
		Sleep(100)
	EndIf
EndFunc   ;==>Skill_5
Func Skill_6()
	If Not $Skill6_Send Then
		If (TimerDiff($Skill6_Start) > $Skill6_Time) Then
			$Skill6_Send = True
		EndIf
	EndIf
	If $Skill6_Send Then
		If Not $Hp_Pet_Check Then ControlSend($Title, "", "", "{F1}")
		Sleep(100)
		ControlSend($Title, "", "", $Skill6_Key)
		$Skill6_Start = TimerInit()
		$Skill6_Send = False
		Sleep(100)
	EndIf
EndFunc   ;==>Skill_6
Func GetListTitle()
	Local $aWinList = WinList("[CLASS:evWin32Wnd]") ;-liet ke cac cua so game
	Local $sWrite_List = ""
	Local $t
	For $t = 1 To UBound($aWinList) - 1
		$sWrite_List &= $aWinList[$t][0] & "/"
	Next
	Return StringStripWS($sWrite_List, 3) ;bỏ dấu cách ở cuối và ở đầu string
EndFunc   ;==>GetListTitle
Func Change_Title_To() ;đổi của sổ game
	WinSetTitle(GUICtrlRead($Title_D), "", GUICtrlRead($New_Title_D))
	$Change_Title_ok = True
EndFunc   ;==>Change_Title_To
Func Load()
	Local $MyFolder = "::{450D8FBA-AD25-11D0-98A8-0800361B1103}"
	$FileOpen = FileOpenDialog("Load Setting", $MyFolder, "ini file(*.ini)/All type(*.*)", 3, "thucson")
	GUICtrlSetData($Skill1_Key_D, IniRead($FileOpen, "Skill", "Skill1_Key", ""))
	GUICtrlSetData($Skill1_Timer_D, IniRead($FileOpen, "Skill", "Skill1_Timer", ""))
	GUICtrlSetData($Skill1_Repeat_D, IniRead($FileOpen, "Skill", "Skill1_Repeat", ""))
	GUICtrlSetState($Skill1_Check_D, IniRead($FileOpen, "Skill", "Skill1_Check", ""))
	GUICtrlSetData($Skill2_Key_D, IniRead($FileOpen, "Skill", "Skill2_Key", ""))
	GUICtrlSetData($Skill2_timer_D, IniRead($FileOpen, "Skill", "Skill2_Timer", ""))
	GUICtrlSetData($Skill2_Repeat_D, IniRead($FileOpen, "Skill", "Skill2_Repeat", ""))
	GUICtrlSetState($Skill2_Check_D, IniRead($FileOpen, "Skill", "Skill2_Check", ""))
	GUICtrlSetData($Skill3_Key_D, IniRead($FileOpen, "Skill", "Skill3_Key", ""))
	GUICtrlSetData($Skill3_Timer_D, IniRead($FileOpen, "Skill", "Skill3_Timer", ""))
	GUICtrlSetData($Skill3_Repeat_D, IniRead($FileOpen, "Skill", "Skill3_Repeat", ""))
	GUICtrlSetState($Skill3_Check_D, IniRead($FileOpen, "Skill", "Skill3_Check", ""))
	GUICtrlSetData($Max_Skill_D, IniRead($FileOpen, "Skill", "Max_Skill", ""))
	GUICtrlSetState($Hp_Pet_Check_D, IniRead($FileOpen, "Pet", "BuffPet_Check", ""))
	GUICtrlSetData($Hp_Pet_Key_D, IniRead($FileOpen, "Pet", "BuffPet_Key", ""))
	GUICtrlSetData($Hp_Pet_Danger_D, IniRead($FileOpen, "Pet", "Hp pet danger", ""))
	GUICtrlSetData($Timer_Pet_A_D, IniRead($FileOpen, "Pet", "Pet attack before", ""))
	GUICtrlSetData($Pet_A_K_D, IniRead($FileOpen, "Pet", "Pet attack key", ""))
	GUICtrlSetData($Hp_key_D, IniRead($FileOpen, "Hp va Mp", "Hp key", ""))
	GUICtrlSetData($Hp_Danger_D, IniRead($FileOpen, "Hp va Mp", "Hp danger", ""))
	GUICtrlSetData($Hp_Times_D, IniRead($FileOpen, "Hp va Mp", "Hp times", ""))
	GUICtrlSetState($Hp_Check_D, IniRead($FileOpen, "Hp va Mp", "Hp check", ""))
	GUICtrlSetData($Mp_key_D, IniRead($FileOpen, "Hp va Mp", "Mp key", ""))
	GUICtrlSetData($Mp_Danger_D, IniRead($FileOpen, "Hp va Mp", "MP danger", ""))
	GUICtrlSetData($Mp_Times_D, IniRead($FileOpen, "Hp va Mp", "MP times", ""))
	GUICtrlSetState($Mp_Check_D, IniRead($FileOpen, "Hp va Mp", "MP check", ""))
	GUICtrlSetData($Sit_key_D, IniRead($FileOpen, "Hp va Mp", "Sit key", ""))
	GUICtrlSetState($Sit_Check_D, IniRead($FileOpen, "Hp va Mp", "Sit check", ""))
	GUICtrlSetState($Skill7_Check_D, IniRead($FileOpen, "Hp va Mp", "Skill7_Check", ""))
	GUICtrlSetData($Skill7_Key_D, IniRead($FileOpen, "Hp va Mp", "Skill7_Key", ""))
	GUICtrlSetState($Skill8_Check_D, IniRead($FileOpen, "Hp va Mp", "Skill8_Check", ""))
	GUICtrlSetData($Skill8_Key_D, IniRead($FileOpen, "Hp va Mp", "Skill8_Key", ""))
	GUICtrlSetData($Skill8_Repeat_D, IniRead($FileOpen, "Hp va Mp", "Skill8_Repeat", ""))
	GUICtrlSetData($Skill4_key_D, IniRead($FileOpen, "Buff", "Skill4 Key", ""))
	GUICtrlSetData($SKill4_Timer_D, IniRead($FileOpen, "Buff", "Skill4 Repeat", ""))
	GUICtrlSetState($Skill4_Check_d, IniRead($FileOpen, "Buff", "Skill4 Check", ""))
	GUICtrlSetData($SKill5_Key_D, IniRead($FileOpen, "Buff", "Skill5 Key", ""))
	GUICtrlSetData($Skill5_Timer_D, IniRead($FileOpen, "Buff", "Skill5 Repeat", ""))
	GUICtrlSetState($Skill5_Check_D, IniRead($FileOpen, "Buff", "Skill5 Check", ""))
	GUICtrlSetData($SKill6_Key_D, IniRead($FileOpen, "Buff", "Skill6 Key", ""))
	GUICtrlSetData($SKill6_Timer_D, IniRead($FileOpen, "Buff", "Skill6 Repeat", ""))
	GUICtrlSetState($SKill6_Check_D, IniRead($FileOpen, "Buff", "Skill6 Check", ""))
	GUICtrlSetState($Buff_Check_D, IniRead($FileOpen, "Buff", "Buff Check", ""))
EndFunc   ;==>Load
Func Save()
	Local $MyFolder = "::{450D8FBA-AD25-11D0-98A8-0800361B1103}"
	$FileSave = FileSaveDialog("Save Setting", $MyFolder, "ini file(*.ini)", 3, "thucson")
	If @error Then
		MsgBox(0, "Error", "Co loi xay ra trong qua trinh ghi file")
	Else
		IniWrite($FileSave, "Skill", "Skill1_Key", GUICtrlRead($Skill1_Key_D))
		IniWrite($FileSave, "Skill", "Skill1_Timer", GUICtrlRead($Skill1_Timer_D))
		IniWrite($FileSave, "Skill", "Skill1_Repeat", GUICtrlRead($Skill1_Repeat_D))
		IniWrite($FileSave, "Skill", "Skill1_Check", GUICtrlRead($Skill1_Check_D))
		IniWrite($FileSave, "Skill", "Skill2_Key", GUICtrlRead($Skill2_Key_D))
		IniWrite($FileSave, "Skill", "Skill2_Timer", GUICtrlRead($Skill2_timer_D))
		IniWrite($FileSave, "Skill", "Skill2_Repeat", GUICtrlRead($Skill2_Repeat_D))
		IniWrite($FileSave, "Skill", "Skill2_Check", GUICtrlRead($Skill2_Check_D))
		IniWrite($FileSave, "Skill", "Skill3_Key", GUICtrlRead($Skill3_Key_D))
		IniWrite($FileSave, "Skill", "Skill3_Timer", GUICtrlRead($Skill3_Timer_D))
		IniWrite($FileSave, "Skill", "Skill3_Repeat", GUICtrlRead($Skill3_Repeat_D))
		IniWrite($FileSave, "Skill", "Skill3_Check", GUICtrlRead($Skill3_Check_D))
		IniWrite($FileSave, "Skill", "Max_Skill", GUICtrlRead($Max_Skill_D))
		IniWrite($FileSave, "Pet", "BuffPet_Check", GUICtrlRead($Hp_Pet_Check_D))
		IniWrite($FileSave, "Pet", "BuffPet_Key", GUICtrlRead($Hp_Pet_Key_D))
		IniWrite($FileSave, "Pet", "Hp pet danger", GUICtrlRead($Hp_Pet_Danger_D))
		IniWrite($FileSave, "Pet", "Pet attack before", GUICtrlRead($Timer_Pet_A_D))
		IniWrite($FileSave, "Pet", "Pet attack key", GUICtrlRead($Pet_A_K_D))
		IniWrite($FileSave, "Hp va Mp", "Hp key", GUICtrlRead($Hp_key_D))
		IniWrite($FileSave, "Hp va Mp", "Hp danger", GUICtrlRead($Hp_Danger_D))
		IniWrite($FileSave, "Hp va Mp", "Hp times", GUICtrlRead($Hp_Times_D))
		IniWrite($FileSave, "Hp va Mp", "Hp check", GUICtrlRead($Hp_Check_D))
		IniWrite($FileSave, "Hp va Mp", "Mp key", GUICtrlRead($Mp_key_D))
		IniWrite($FileSave, "Hp va Mp", "MP danger", GUICtrlRead($Mp_Danger_D))
		IniWrite($FileSave, "Hp va Mp", "MP times", GUICtrlRead($Mp_Times_D))
		IniWrite($FileSave, "Hp va Mp", "MP check", GUICtrlRead($Mp_Check_D))
		IniWrite($FileSave, "Hp va Mp", "Sit key", GUICtrlRead($Sit_key_D))
		IniWrite($FileSave, "Hp va Mp", "Sit check", GUICtrlRead($Sit_Check_D))
		IniWrite($FileSave, "Hp va Mp", "Skill7_Check", GUICtrlRead($Skill7_Check_D))
		IniWrite($FileSave, "Hp va Mp", "Skill7_Key", GUICtrlRead($Skill7_Key_D))
		IniWrite($FileSave, "Hp va Mp", "Skill8_Check", GUICtrlRead($Skill8_Check_D))
		IniWrite($FileSave, "Hp va Mp", "Skill8_Key", GUICtrlRead($Skill8_Key_D))
		IniWrite($FileSave, "Hp va Mp", "Skill8_Repeat", GUICtrlRead($Skill8_Repeat_D))
		IniWrite($FileSave, "Buff", "Skill4 Key", GUICtrlRead($Skill4_key_D))
		IniWrite($FileSave, "Buff", "Skill4 Repeat", GUICtrlRead($SKill4_Timer_D))
		IniWrite($FileSave, "Buff", "Skill4 Check", GUICtrlRead($Skill4_Check_d))
		IniWrite($FileSave, "Buff", "Skill5 Key", GUICtrlRead($SKill5_Key_D))
		IniWrite($FileSave, "Buff", "Skill5 Repeat", GUICtrlRead($Skill5_Timer_D))
		IniWrite($FileSave, "Buff", "Skill5 Check", GUICtrlRead($Skill5_Check_D))
		IniWrite($FileSave, "Buff", "Skill6 Key", GUICtrlRead($SKill6_Key_D))
		IniWrite($FileSave, "Buff", "Skill6 Repeat", GUICtrlRead($SKill6_Timer_D))
		IniWrite($FileSave, "Buff", "Skill6 Check", GUICtrlRead($SKill6_Check_D))
		IniWrite($FileSave, "Buff", "Buff Check", GUICtrlRead($Buff_Check_D))
		MsgBox(0, "File save", "Ban ghi file vao tep" & $FileSave)
	EndIf
EndFunc   ;==>Save
Func Hide_Game() ;- ẩn cửa sổ game cho nhẹ may
	$Hide = Not $Hide
	If $Hide Then
		WinSetState($Title, "", @SW_HIDE)
		GUICtrlSetData($Hide_Game_D, "Show")
	Else
		WinSetState($Title, "", @SW_SHOW)
		GUICtrlSetData($Hide_Game_D, "Hide")
	EndIf
EndFunc   ;==>Hide_Game
Func Hide_Auto() ; an cua so auto
	$Hide_auto = Not $Hide_auto
	If $Hide_auto Then
		WinSetState("Thucson auto v2.1", "", @SW_HIDE)
	Else
		WinSetState("Thucson auto v2.1", "", @SW_SHOW)
	EndIf
EndFunc   ;==>Hide_Auto
Func AltQ() ;- ham thoat khi ?n exit
	_MemoryClose($Pid)
	Exit
EndFunc   ;==>AltQ