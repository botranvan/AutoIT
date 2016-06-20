#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=copiadikid7hf.ico
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstants.au3>
#include <StaticConstants.au3>
#include <NomadMemory.au3>

Global $NotepadHande="0x001E022A"

GUICreate("Thuc Son auto 1.5", 441, 278, 263, 129)    ;-Tạo gui,tất cả đều có đuôi là _Dislay hoặc _D,tất cả các thông số và các dùng tớ đã nói ở phần post 
$Hp_Dislay = GUICtrlCreateLabel("", 8, 24, 140, 20)
$Mp_Dislay = GUICtrlCreateLabel("", 8, 56, 148, 28)
$Hp_Pet_Display = GUICtrlCreateLabel("", 8, 104, 148, 28)
GUICtrlCreateGroup("Char info", 0, 0, 169, 129)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateLabel("Time delay", 296, 8, 55, 17)
GUICtrlCreateLabel("Repeat", 360, 8, 39, 17)
GUICtrlCreateLabel("Use", 408, 8, 31, 17)
GUICtrlCreateLabel("Key", 248, 8, 22, 17)
GUICtrlCreateLabel("Skill 1", 184, 32, 52, 28)
GUICtrlCreateLabel("Skill 3", 184, 120, 52, 28)
GUICtrlCreateLabel("Skill 2", 184, 72, 52, 28)
$Skill1_Key_D = GUICtrlCreateCombo("", 240, 32, 60, 25)
	GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|0","1")
$Skill2_Key_D = GUICtrlCreateCombo("", 240, 78, 60, 25)
	GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|0","2")
$Skill3_Key_D = GUICtrlCreateCombo("", 240, 120, 60, 25)
	GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|0","3")
$Skill1_Timer_D = GUICtrlCreateInput("1500", 304, 32, 49, 21)
$Skill1_Repeat_D = GUICtrlCreateInput("1", 360, 32, 30, 21)
$Skill2_timer_D = GUICtrlCreateInput("1500", 304, 78, 49, 21)
$Skill3_Timer_D = GUICtrlCreateInput("3000", 304, 120, 49, 21)
$Skill2_Repeat_D = GUICtrlCreateInput("4", 360, 78, 30, 21)
$Skill3_Repeat_D = GUICtrlCreateInput("1", 360, 120, 30, 21)
$Skill1_Check_D = GUICtrlCreateCheckbox("Skill1_Check", 408, 32, 17, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
$Skill2_Check_D = GUICtrlCreateCheckbox("Skill2_Check", 408, 78, 17, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
$Skill3_Check_D = GUICtrlCreateCheckbox("Skill3_Check", 408, 120, 17, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateLabel("Buff pet", 0, 160, 49, 17)	
$Hp_Pet_Check_D = GUICtrlCreateCheckbox("", 8, 184, 17, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateLabel("Buff key", 48, 160, 43, 17)
$Hp_Pet_Key_D = GUICtrlCreateCombo("", 48, 184, 41, 25)
	GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|0","8")
GUICtrlCreateLabel("Hp pet danger", 96, 160, 80, 17)
$Hp_Pet_Danger_D = GUICtrlCreateInput("300", 120, 184, 41, 21)
GUICtrlCreateLabel("Pet attack before", 8, 216, 86, 25)
$Timer_Pet_A_D = GUICtrlCreateInput("600", 120, 216, 41, 21)
GUICtrlCreateLabel("Pet attack key", 16, 248, 73, 17)
$Pet_A_K_D = GUICtrlCreateInput("n", 120, 248, 41, 21)
$Group2 = GUICtrlCreateGroup("Pet Info", 0, 144, 169, 129)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateLabel("Sit/Sit key", 184, 160, 70, 17)
$Sit_Display = GUICtrlCreateCheckbox("", 192, 184, 17, 17)
$Sit_key_D = GUICtrlCreateCombo("", 181, 214, 33, 25)
	GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|0","7")
GUICtrlCreateLabel("Key", 264, 160, 39, 17)
GUICtrlCreateLabel("Check", 400, 160, 36, 17)
$Mp_Check_D = GUICtrlCreateCheckbox("", 408, 216, 17, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
$Hp_Check_D = GUICtrlCreateCheckbox("", 408, 184, 17, 17)
	GUICtrlSetState(-1, $GUI_CHECKED)
GUICtrlCreateLabel("Hp", 232, 184, 18, 17)
GUICtrlCreateLabel("Mp", 232, 216, 19, 17)	
GUICtrlCreateLabel("Danger", 312, 160, 47, 17)
$Mp_Danger_D = GUICtrlCreateInput("100", 312, 216, 49, 21)
$Hp_Danger_D = GUICtrlCreateInput("150", 312, 184, 49, 21)
$Mp_key_D = GUICtrlCreateCombo("", 264, 216, 41, 25)
	GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|0","9")
$Hp_key_D = GUICtrlCreateCombo("", 264, 184, 41, 25)
	GUICtrlSetData(-1, "1|2|3|4|5|6|7|8|9|0","0")
GUICtrlCreateLabel("Times", 368, 160, 32, 17)
$Hp_Times_D = GUICtrlCreateInput("1", 368, 184, 33, 21)
$Mp_Times_D = GUICtrlCreateInput("1", 368, 216, 33, 21)
$Read_Dislay = GUICtrlCreateButton("Read data", 186, 248, 57, 25, 0)         ;- là nút để đọc dữ liệu từ gui,tớ chia chương trình thành 2 bước để đỡ lag khi bắt đầu chương trình
	GUICtrlSetOnEvent (-1, "Read")
$Exit_D = GUICtrlCreateButton("Exit", 376, 248, 49, 25, 0)                   ;- là nút exit dùng để thoát auto
    GUICtrlSetOnEvent ($Exit_D, "AltQ")
$Start_D = GUICtrlCreateButton("Start", 256, 248, 49, 25, 0)                  ;- sau khi ấn nút read thì ấn start để bắt đầu gửi phím
    GUICtrlSetOnEvent ($Start_D, "Start")
$Hide_Game_D = GUICtrlCreateButton("Hide game", 312, 248, 57, 25)          ;- hàm để ẩn cửa sổ game
    GUICtrlSetOnEvent ($Hide_Game_D, "Hide_Game")
GUISetState(@SW_SHOW)
Opt("GUIOnEventMode", 1)
Opt("SendKeyDelay",10)
Opt("SendKeyDownDelay",10)
Opt("SendCapslockMode",0)
Opt("TrayMenuMode",1) 
TraySetIcon("C:\Documents and Settings\Lqchinh\Desktop\copiadikid7hf.ico")
$exititem=TrayCreateItem("exit")
TraySetState()
Dim $Hide=False,$Hp_key,$Mp_key,$Pet_A_K,$Sit_Check,$Sit_key,$Hp_key,$Mp_key,$Hp_Pet_Key,$Skill1_Key,$Skill2_Key,$Skill3_Key
Dim $BaseMod =0x00e7d5bc,$Hp_Mod,$MEMID,$Pid,$Hp_Mod_Buffer,$Hp_Buffer,$traymsg,$Title,$Hp_Pet_Ok=True
Dim $Hp_Pet_Curren,$Hp_Pet_Max,$Hp_Pet_Check,$Hp_Pet_Danger
Dim $Sum_timer,$Curren_timer,$TimerInfo,$TimerStamp,$Timer_Pet_Hp,$TimerSit,$Timer_Pet_A
Dim $Hp_Curren,$Hp_Max,$Mp_Curren,$Mp_Max,$Sendok =False, $HP_Check, $MP_Check, $Hp_Danger, $Mp_Danger,$ReadOk =False,$Hp_Times=2,$Mp_Times=1
Dim $BaseAdd = 0x00EB7EE0
Dim $Skill1_Check, $Skill2_Check, $Skill1_Check, $Skill2_Check, $Skill1_Time, $Skill2_Time,$Skill3_Check, $Skill3_Time,$Skill1_Repeat,$Skill3_Repeat,$Skill2_Repeat,$CurentSkill

While 1
	If $Readok Then     ;- nếu nút read được bấm thì readok sẽ chuyển thành true
		if TimerDiff($TimerInfo)>500 then ;- hiển thị thông tin với chu kỳ 500ms 1 lần
			info()
			$TimerInfo=TimerInit()
		EndIf
	EndIf	
	Hp_Mod()   ;- tính chỉ số máu mod 1 cách thường xuyên,nếu không cần thiết có thể cho hàm này lên trên để tính máu mod 0.5s/1 lần
	If $Sendok Then  ;- = true nếu nút start được bấm
		If $Hp_Check Then Hp_Check() ;- kiểm tra hp nếu có sử dụng chức năng kiểm tra máu
		If $Mp_Check Then Mp_Check()
		if $Sit_Check Then Sit()      ;- tọa thiền nếu chọ tọa thiền ở gui
		if $Hp_Pet_Check Then Hp_Pet_Check()  ;- kiểm tra máu pet nếu được dùng
		ToolTip(Hp_Mod()&"/"&$Hp_Mod,0,0)
		If Hp_Mod() = 0 then  
			ControlSend ( $Title, "", "", "{TAB}" )  ;- chuyển target quái nếu thấy hp quái =0(quái đã chít )
			sleep(100)
			if $Hp_Pet_Check then 
				ControlSend ( $Title, "", "", $Pet_A_K & $Pet_A_K)          ;- gui phim cho pet tan cong neu co pet
				sleep($Timer_Pet_A/2)
				ControlSend ( $Title, "", "", $Pet_A_K & $Pet_A_K)           ;- pet này tớ check nếu gửi 1 lần nó không chạy nên gửi luôn 3 lần cho chắc
				sleep($Timer_Pet_A/2)
				ControlSend ( $Title, "", "", $Pet_A_K & $Pet_A_K)
			EndIf	
		EndIf
			$Curren_timer = Int(Timerdiff($TimerStamp))       ;- tính thời gian hiện tại hàm skill
			if $Skill1_Check Then Skill_1()
			if $Skill2_Check Then Skill_2()
			if $Skill3_Check Then Skill_3()
			If ($CurentSkill > ($Skill1_Repeat + $Skill2_Repeat+ $Skill3_Repeat)) And ($Curren_timer >= $Sum_timer) Then ;- nếu đã thực hiện xong 1 chu kỳ skill(từ skill 1 và ra xong cả skill 3)
				$TimerStamp = TimerInit()  ;- khởi tạo lại bố đếm giờ
				$CurentSkill =1    ;- khởi tạo lại biến đếm thời gian
			EndIf	
		EndIf
	$nMsg = GUIGetMsg()      ;-hơi ghét nhìn cái hình thô kệch ở autoit nên đổi biểu tượng,phù phù xong rùi,viết chú thích mà mỏi tay quá
	$traymsg = TrayGetMsg()
	if  ($nMsg=$GUI_EVENT_CLOSE) or ($traymsg = $exititem) then Exit
WEnd

Func Hp_Mod() 
	$Hp_Mod = _MemoryRead($Hp_Mod_Buffer+ 0x538,$MEMID)              ;- tính hp của quái,tất cả các hàm tính hp_mod,Hp,mp của nhân vật tớ đều tối giảm qua biến đệm buffer
	ControlSend($NotepadHande,"","Func Hp_Mod()",1)
	Return $Hp_Mod
EndFunc	
Func Hp_Curren() 
	$Hp_Curren = _MemoryRead($Hp_Buffer+ 0x740,$MEMID)
	ControlSend($NotepadHande,"","Func Hp_Curren()",1)
	Return $Hp_Curren
EndFunc	
Func Hp_Max() 
	$Hp_Max = _MemoryRead($Hp_Buffer+ 0x47c,$MEMID)
	ControlSend($NotepadHande,"","Func Hp_Max()",1)
	Return $Hp_Max
EndFunc	
Func Mp_Max() 
	$Mp_Max = _MemoryRead($Hp_Buffer+ 0x6ec,$MEMID)		
	ControlSend($NotepadHande,"","Func Mp_Max()",1)
	Return $Mp_Max
EndFunc	
Func Mp_Curren()
	$Mp_Curren = _MemoryRead($Hp_Buffer+ 0x744,$MEMID)	 
	ControlSend($NotepadHande,"","Func Mp_Curren()",1)
	Return $Mp_Curren
EndFunc
Func Hp_Pet_Curren() 
	$Hp_Pet_Curren = _MemoryRead($Hp_Buffer+0x8f8 ,$MEMID)
	$Hp_Pet_Curren = _MemoryRead($Hp_Pet_Curren+ 0xC,$MEMID)
	$Hp_Pet_Curren = _MemoryRead($Hp_Pet_Curren+ 0x740,$MEMID)
	ControlSend($NotepadHande,"","Func Hp_Pet_Curren()",1)
	Return $Hp_Pet_Curren
EndFunc	
Func Hp_Pet_Max() 
	$Hp_Pet_Max = _MemoryRead($Hp_Buffer+0x8f8 ,$MEMID)
	$Hp_Pet_Max = _MemoryRead($Hp_Pet_Max+ 0xC,$MEMID)
	$Hp_Pet_Max = _MemoryRead($Hp_Pet_Max+ 0x47C,$MEMID)
	ControlSend($NotepadHande,"","Func Hp_Pet_Max()",1)
	Return $Hp_Pet_Max
EndFunc	
Func Read()               ;- la nut bam Read Data,neu nut bam nay bam thi se doc tat ca du lieu cua gui
	$Readok = Not $ReadOk   ;- đổi trạng thái của nút bấm,như kiểu bật công tắc đèn           
	ControlSend($NotepadHande,"","Func Read()",1)
	If $Readok Then 
		$Title =GetListTitle()       ;- lấy title của cửa sổ game
		If $Title = "" Then   ;- thông báo lỗi nếu không tìm được cửa sổ game
			MsgBox(0,"Thong bao","Ban phai chay game truoc")
		 	Exit
		EndIf	
		$Pid=WinGetProcess($Title)
		$MEMID=_memoryopen($Pid)
		$Hp_Buffer = _MemoryRead($BaseAdd ,$MEMID)	
		$Hp_Buffer = _MemoryRead($Hp_Buffer+0x10c ,$MEMID)           ;- Tính giá trị bộ nhớ đệm,khi chạy game rùi thì chỉ số Hp_buffer sẽ không đổi nữa vì vậy ta tính 1 lần ở đây thôi
		$Hp_Mod_Buffer = _MemoryRead($BaseMod ,$MEMID)	             ;- hàm tính máu pet không thể viết bộ nhớ đệm được vì nó thay đổi sau offset 10c
		$Hp_Mod_Buffer = _MemoryRead($Hp_Mod_Buffer+0xC ,$MEMID)
		$Hp_Mod_Buffer = _MemoryRead($Hp_Mod_Buffer+ 0x2AC,$MEMID)
		GUICtrlSetData($Read_Dislay,"Reset data")
		If GUICtrlRead($Mp_Check_D)=$GUI_CHECKED Then                 ;-  đọc dữ liệu từ gui,và gán cho các biến,tiêu chí của tớ là đọc tất cả các giá trị từ gui ngay khi ấn read để trong vòng lặp chính không
			$Mp_Check = True 											;-phải đọc lại 1 dữ liệu nào từ gui nữa
			$Mp_key=GUICtrlRead($Mp_key_D)
			$Mp_Danger=GUICtrlRead($Mp_Danger_D)
			$Mp_Times=GUICtrlRead($Mp_Times_D)
		else 
			$Mp_Check = False
		EndIf	
		If GUICtrlRead($Hp_Check_D)=$GUI_CHECKED Then 		
			$Hp_Check = True									;- đây là biến tớ dùng để kiểm xem có sử dụng chức năng bơm máu nếu máu thiếu không
			$Hp_key=GUICtrlRead($Hp_key_D)
			$Hp_Danger=GUICtrlRead($Hp_Danger_D)
			$Hp_Times=GUICtrlRead($Hp_Times_D)
		else 
			$Hp_Check = False
		EndIf	
		If GUICtrlRead($Sit_Display)=$GUI_CHECKED Then 
			$Sit_Check =True
			$Sit_key=GUICtrlRead($Sit_key_D)
			$Hp_Check = False                                ;- chỗ này hơi vòng vo 1 chút,nếu đã đánh dấu vào ngồi thiền thì không cho bơm máu và mp nữa
			$Mp_Check = False								;- nhưng vẫn phải đánh dấu vào kiểm tra máu và mp để chương trình còn đọc chỉ số Mp_danger
		Else 
			$Sit_Check =False
		EndIf		
		If GUICtrlRead($Hp_Pet_Check_D)=$GUI_CHECKED Then 
			$Hp_Pet_Check = True   ;- biến này là biến của pet,nếu true thì sẽ thực hiện tất cả mọi thứ liên quan đến pet,còn false thì không làm liên quan đến pet
			$Hp_Pet_Danger = GUICtrlRead($Hp_Pet_Danger_D)
			$Pet_A_K=GUICtrlRead($Pet_A_K_D)
			$Timer_Pet_A=GUICtrlRead($Timer_Pet_A_D)
			$Hp_Pet_Key=GUICtrlRead($Hp_Pet_Key_D)
		else
			$Hp_Pet_Check = False
		EndIf	
		If GUICtrlRead($Skill1_Check_D)=$GUI_CHECKED Then 
			$Skill1_Check = True             ;- có dùng skill 1 không
			$Skill1_time=GUICtrlRead($Skill1_timer_D) ;- thời gian ra hết skill 1(đọc ở bảng skill của nhân vật)
			$Skill1_Repeat=GUICtrlRead($Skill1_Repeat_D)  ;- skill 1 được đánh liên tiếp mấy lần
			$Skill1_Key=GUICtrlRead($Skill1_Key_D)     ;- đọc phím gửi skill 1
		else 
			$Skill1_Check = False
			$Skill1_Time =0
			$Skill1_Repeat =0
		EndIf	
		If GUICtrlRead($Skill2_Check_D)=$GUI_CHECKED Then ;- thông thường tớ hay đặt skill 1 là skill giảm phòng thủ vật lý và skill 2 là skill đánh chay với độ lặp lại là 4
			$Skill2_Check = True							;- tức là đánh 1 skill 1 rùi đến 4 skill dánh chay rùi đến skill 1........
			$Skill2_time=GUICtrlRead($Skill2_timer_D)
			$Skill2_Repeat=GUICtrlRead($Skill2_Repeat_D)
			$Skill2_Key=GUICtrlRead($Skill2_Key_D)
		else 
			$Skill2_Check = False
			$Skill2_Time =0
			$Skill2_Repeat =0
		EndIf	
		If GUICtrlRead($Skill3_Check_D)=$GUI_CHECKED Then 
			$Skill3_Check = True
			$Skill3_time=GUICtrlRead($Skill3_timer_D)
			$Skill3_Repeat=GUICtrlRead($Skill3_Repeat_D)
			$Skill3_Key=GUICtrlRead($Skill3_Key_D)
		else 
			$Skill3_Check = False
			$Skill3_Time =0
			$Skill3_Repeat =0
		EndIf	
		$Sum_timer = Int($Skill1_Time * $Skill1_Repeat + $Skill2_Time * $Skill2_Repeat+ $Skill3_Time * $Skill3_Repeat)	;- tổng thời gian ra hết cả 3 skill
	Else 	
		GUICtrlSetData($Read_Dislay,"Read")
	EndIf	
EndFunc	
Func Start()                                ;- la nut bam cua Start,de bat dau auto sau khi da doc xong du lieu
	$Sendok = Not $Sendok 
	ControlSend($NotepadHande,"","Func Start()",1)
	If $Sendok Then 
		GUICtrlSetData($Start_D,"Stop")
		$TimerStamp = TimerInit()            ;-bat dau dem thoi gian(đánh dấu thời gian)
		$CurentSkill=1				;- là biến tớ để đếm số skill
		WinActive($Title)
		ControlSend ( $Title, "", "", "{TAB}" )   ;-taget quai ngay tranh dung den vong lap
		GUICtrlSetState($Skill1_Key_D, $GUI_DISABLE)  ;- làm cho nút bấm trở thành disable
		GUICtrlSetState($Skill2_Key_D, $GUI_DISABLE)
		GUICtrlSetState($Skill3_Key_D, $GUI_DISABLE)
		GUICtrlSetState($Skill1_Timer_D, $GUI_DISABLE)
		GUICtrlSetState($Skill2_Timer_D, $GUI_DISABLE)
		GUICtrlSetState($Skill3_Timer_D, $GUI_DISABLE)
		GUICtrlSetState($Skill1_Repeat_D, $GUI_DISABLE)
		GUICtrlSetState($Skill2_Repeat_D, $GUI_DISABLE)
		GUICtrlSetState($Skill3_Repeat_D, $GUI_DISABLE)
		GUICtrlSetState($Hp_key_D, $GUI_DISABLE)
		GUICtrlSetState($Mp_key_D, $GUI_DISABLE)
		GUICtrlSetState($Hp_Danger_D, $GUI_DISABLE)
		GUICtrlSetState($Mp_Danger_D, $GUI_DISABLE)
		Sleep(1000)
	Else 
		GUICtrlSetData($Start_D,"Start")           ;- chuyển trạng thái nút bấm từ stop về start
		GUICtrlSetState($Skill1_Key_D, $GUI_ENABLE)     ;- enable các nút và dữ liệu
		GUICtrlSetState($Skill2_Key_D, $GUI_ENABLE)
		GUICtrlSetState($Skill3_Key_D, $GUI_ENABLE)
		GUICtrlSetState($Skill1_Timer_D, $GUI_ENABLE)
		GUICtrlSetState($Skill2_Timer_D, $GUI_ENABLE)
		GUICtrlSetState($Skill3_Timer_D, $GUI_ENABLE)
		GUICtrlSetState($Skill1_Repeat_D, $GUI_ENABLE)
		GUICtrlSetState($Skill2_Repeat_D, $GUI_ENABLE)
		GUICtrlSetState($Skill3_Repeat_D, $GUI_ENABLE)
		GUICtrlSetState($Hp_key_D, $GUI_ENABLE)
		GUICtrlSetState($Mp_key_D, $GUI_ENABLE)
		GUICtrlSetState($Hp_Danger_D, $GUI_ENABLE)
		GUICtrlSetState($Mp_Danger_D, $GUI_ENABLE)	
	EndIf	
EndFunc	
func info()   ;- hàm để hiển thị thông số nhân vật đồng thời làm chức năng tính các chỉ số quan trọng như Hp_curren,Mp_curren
GUICtrlSetData($Hp_Dislay,"Hp  "& Hp_Curren() & "/" & Hp_Max())  
GUICtrlSetData($Mp_Dislay,"Mp  "&  Mp_Curren() & "/" & Mp_Max())
If $Hp_Pet_Check then GUICtrlSetData($Hp_Pet_Display,"PetHp  "&  Hp_Pet_Curren() & "/" & Hp_Pet_Max())    ;- nếu có pet thì hiển thị máu pet
ControlSend($NotepadHande,"","Func info()",1)
EndFunc
Func Hp_Pet_Check()    ;- hàm kiểm tra máu pet để bơm nếu thấp hơn mức nguy hiểm
	ControlSend($NotepadHande,"","Func Hp_Pet_Check()",1)
	If (not $Hp_Pet_Ok) then ;- khởi đầu thì hp_pet_ok là true nên điều kiện này là false
		If TimerDiff($Timer_Pet_Hp)>= 6000 Then ; chỉ cho bơm máu cho pet lần 2 sau khi đã bơm máu lần 1 là 6s
			$Hp_Pet_Ok = True
		EndIf
	EndIf
	If ( Hp_Pet_Curren() <> 0) and (Hp_Pet_Curren() < $Hp_Pet_Danger) and $Hp_Pet_Ok Then ;-hp-pet_ok luôn true,chỉ trừ khi hàm bơm máu này kích hoạt
		ControlSend($Title,"","",$Hp_Pet_Key)   ;gửi phím
		Sleep(100)
		$Hp_Pet_Ok = False     ;- đổi sang false để không cho gửi phím bơm máu 2 lần liên tiếp trong vòng lặp chính
		$Timer_Pet_Hp = TimerInit()  ;- khởi tạo bộ đếm giờ sau khi đã bơm máu cho pet
	EndIf
EndFunc	
Func Hp_Check()
	Local $j
	ControlSend($NotepadHande,"","Func Hp_Check()",1)
	If (Hp_Curren() <> 0) and (Hp_Curren() < $Hp_Danger)  And Hp_Mod()=0 Then
		Sleep(3000)   ;- đợi nhân vật chuyển sang chế độ hồi thủ mới uống máu được
		For $j=1 to $Hp_Times     ;- uống máu mấy bình,nên mua bình máu nhỏ uống nhiều lần để tiết kiệm tiền
		ControlSend($Title,"","",$Hp_key)
		Sleep(15000)   ;- nghỉ thời gian đang uống máu
		Next
	EndIf
EndFunc	
Func Mp_Check()   ;- tương tự hàm hp
	Local $i
	ControlSend($NotepadHande,"","Func Mp_Check()",1)
	If (Mp_Curren() <> 0) and (Mp_Curren() < $Mp_Danger)  And Hp_Mod()=0 Then
		Sleep(3000)
		For $i=1 to $Mp_Times 
		ControlSend($Title,"","",$Mp_key)
		Sleep(15000)
		Next
	EndIf
EndFunc	

Func Sit()
	If (((Hp_Curren() <> 0) and (Hp_Curren() < $Hp_Danger)) or ((Hp_Curren() <> 0) and (Mp_Curren() < $Mp_Danger)))   And (Hp_Mod()=0) Then 
		ControlSend($NotepadHande,"","Func Sit()",1)
		Sleep(3000)
		$TimerSit=TimerInit()
		ControlSend($Title,"","",$Sit_key)
		Do
			if TimerDiff($TimerSit)>1000 then ;- khi ngồi thiện tớ dùng biến đọc từ bộ nhớ với chu kỳ 1s đọc chỉ số 1 lần(trong khi auto là 500ms / 1 lần)
				Hp_Curren()
				Hp_Max()
				Mp_Curren()
				Mp_Max()
				$TimerSit=TimerInit()
			EndIf
		Until (Hp_Curren()= Hp_Max()) And (Mp_Curren()= Mp_Max())
	EndIf
EndFunc
;- hàm skill này làm tớ phải suy nghĩ 1 ngày mới thành công
;- phím cần bấm      1______2_____2_____2______2_______3_______
;- thời gian	     0      1     2      3	    4       5
;- skill hiện tại  1     2     3     4      5      6        7
;-nhìn vào sơ đồ trên rùi tớ tính toán điều kiện khi nào cần gửi skill nào cho vòng lặp đầu tiên
Func Skill_1()
	If $CurentSkill <= $Skill1_Repeat Then     ;- gủi skill phụ thuộc số skill
		If  ((Mod($Curren_timer, $Sum_timer) < ( $Skill1_Time * $CurentSkill))) and ((Mod($Curren_timer, $Sum_timer) >= ($Skill1_Time * ($CurentSkill-1))))  Then ;- gửi skill phụ thuộc thời gian ,quy định trong 1 khoảng thời gain chỉ gửi 1 lần 1 skill 
			ControlSend($NotepadHande,"","Func Skill_1()",1)
			ControlSend ( $Title, "", "", $Skill1_Key)   ;- gửi skilll vao game
			Sleep(100)
			$CurentSkill = $CurentSkill + 1			;- 1 lần ra 1 skill thì tăng số đếm skill l
		EndIf
	EndIf
EndFunc

Func Skill_2()
	If ($CurentSkill > $Skill1_Repeat) and ($CurentSkill <= ($Skill1_Repeat + $Skill2_Repeat)) Then
		If  (Mod($Curren_timer, $Sum_timer) < ($Skill1_Time *$Skill1_Repeat + $Skill2_Time * ($CurentSkill-$Skill1_Repeat))) and (Mod($Curren_timer, $Sum_timer) >= ($Skill1_Time * $Skill1_Repeat +$Skill2_Time * ($CurentSkill-$Skill1_Repeat-1))) Then
			ControlSend($NotepadHande,"","Func Skill_2()",1)
			ControlSend ( $Title, "", "", $Skill2_Key )
			Sleep(100)
			$CurentSkill = $CurentSkill + 1			
		EndIf
	EndIf
EndFunc
Func Skill_3()
	If ($CurentSkill > $Skill1_Repeat+$Skill2_Repeat) and ($CurentSkill <= ($Skill1_Repeat + $Skill2_Repeat+$Skill3_Repeat)) Then
		If  (Mod($Curren_timer, $Sum_timer) < ($Skill1_Time *$Skill1_Repeat+$Skill2_Time *$Skill2_Repeat +$Skill3_Time * ($CurentSkill-$Skill1_Repeat-$Skill2_Repeat))) and (Mod($Curren_timer, $Sum_timer) >= ($Skill1_Time * $Skill1_Repeat+$Skill2_Time * $Skill2_Repeat+$Skill3_Time * ($CurentSkill-$Skill1_Repeat-$Skill2_Repeat-1))) Then
			ControlSend($NotepadHande,"","Func Skill_3()",1)
			ControlSend ( $Title, "", "", $Skill3_Key )	
			Sleep(100)
			$CurentSkill = $CurentSkill + 1			
		EndIf
	EndIf
EndFunc	

Func GetListTitle()
	ControlSend($NotepadHande,"","Func GetListTitle()",1)
	Local $aWinList = WinList("[CLASS:evWin32Wnd]")     ;-liệt kê các cửa sổ game
    Local $sRet_List = ""
    $sRet_List &= $aWinList[1][0]         ; tớ định làm 1 cái combo để liệt kê toàn bộ cửa sổ trong process nhưng vướng 1 cái tên game là   ThucSon | sv | 1.0  nó có cái dấu | nếu add vào combo nó lại tưởng là 3 đối tượng nên nó ghi 3 dòng
    Return StringStripWS($sRet_List, 3)
EndFunc
Func Hide_Game()  ;- ẩn cửa sổ game cho nhẹ máy
	$Hide = Not $Hide
	ControlSend($NotepadHande,"","Func Hide_Game()",1)
	If $Hide Then
		WinSetState($Title, "", @SW_HIDE)
		GUICtrlSetData($Hide_Game_D,"Show")
	Else
		WinSetState($Title, "", @SW_SHOW)
		GUICtrlSetData($Hide_Game_D,"Hide")
	EndIf
EndFunc
Func AltQ()   ;- hàm thoát khi ấn exit
	_MemoryClose($pid)
	Exit
EndFunc