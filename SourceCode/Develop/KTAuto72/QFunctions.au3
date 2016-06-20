;~ leesai100 => 600  pass 123456 sutu, nhan ma
Global $Wait = 270			;Tốc dộ thực hiện Auto
Global $TimeA = 0			;Điểm khởi đầu thời gian đợi
Global $TestClick = 0		;1 - Click chậm để kiểm tra
Global $ShowStep = 0		;1 - Hiển thị tên các Slep
Global $KillCount = 720		;Thời gian đợi để kill mob cho Đề Lạc

Global $Q20 = 0
Global $Q30 = 0
Global $Q35 = 0
Global $Q30Step = 'MiniMapReset'
Global $Q35Step = 'MiniMapReset'
Global $RideKey = "F5"

;~ Big map
Global $BMTNNBC[2] = [365,403]		;Vị trí Trung Nhân Ngư Bí Cảnh trên Map Lớn
Global $CBDao[2] = [209,170]		;Vị trí Cô Băng Đảo trên Map Lớn

;~ Atlantis
Global $NLangLongDe[2] = [600,177]		;Truyền tông Lăng Long Đế

;~ Quảng Trường Atlantis
Global $NDouki[2] = 	[600,270]		;Di tích đã mất
Global $NMorpheus[2] = 	[600,265]		;Truyền tông cõi mộng
Global $NLieger[2] = 	[600,305]		;Huấn luyện thú triệu hồi
Global $NLuDilly[2] = 	[600,225]		;Truyền tông cầu vòng cốc
Global $NGuada[2] = 	[600,285]		;Huấn luyện thú cưỡi

Global $NAtlantis[2] = 	[600,177]		;Truyền tông Atlantis
Global $NMelietEr[2] = 	[600,230]		;Truyền tông bãi thu thập
Global $NMina[2] = 		[600,270]		;Kỹ năng học tập
Global $NSapaco[2] = 	[600,290]		;Đổi sách kỹ năng


;~ Trung Nhân Ngân Bí Cảnh
Global $NDeLac[2] = 	[600,250]		;Đề Lạc
Global $NCalipso[2] = 	[600,200]		;Calipso
Global $NAmalthea[2] = 	[600,217]		;Amalthea

Global $NPCChat1[2] = [100,288]			;Dong thu 1 Dialog Chat voi NPC
Global $NPCChat2[2] = [100,305]			;Dong thu 2 Dialog Chat voi NPC
Global $NPCChat3[2] = [100,322]			;Dong thu 3 Dialog Chat voi NPC
Global $NPCChat4[2] = [100,342]			;Dong thu 4 Dialog Chat voi NPC
Global $NPCChat5[2] = [100,360]			;Dong thu 5 Dialog Chat voi NPC
Global $NPCChat6[2] = [100,380]			;Dong thu 6 Dialog Chat voi NPC
Global $NPCChat7[2] = [100,400]			;Dong thu 7 Dialog Chat voi NPC
Global $NPCChat8[2] = [100,420]			;Dong thu 7 Dialog Chat voi NPC

Global $NPCChatQuestButton[2] = [250,520]			;Dong thu 1 Dialog Chat voi NPC

;~ Xử lý qua trình thực hiện nhiệm vụ
Func QuestProcess()
	Select
    Case $Q20
        tooltip(@sec&@msec&" Q20",0,0)
    Case $Q30
        Q30Process()
    Case $Q35
        Q35Process()
	EndSelect
EndFunc

;~ Thực hiện khi check 30 - Cuong hoa thu
Func Q30_CClick()
	$Q30 = Not $Q30
	If $Q30 Then
		GUICtrlSetState($Q30_C,$GUI_CHECKED)
		WinActivate ($GameHandle)
		$Q30Step = 'MiniMapReset'		
;~ 		$Q30Step = 'LuDillyGoTo'		
	Else
		GUICtrlSetState($Q30_C,$GUI_UNCHECKED)
	EndIf
EndFunc

;~ Thực hiện khi check 35 - 2 Trung Sinh
Func Q35_CClick()
	$Q35 = Not $Q35
	If $Q35 Then
		GUICtrlSetState($Q35_C,$GUI_CHECKED)
		WinActivate ($GameHandle)
		$Q35Step = 'MiniMapReset'
	Else
		StartAuto_BClick(0)
		GUICtrlSetState($Q35_C,$GUI_UNCHECKED)
	EndIf
EndFunc

;~ Thực hiện khi Quest 35 - 2 Trùng Sinh
Func Q35Process()
;~ 	$Q35Step = 'TNNBCGoTo'
	Switch $Q35Step
		
	Case 'MiniMapReset'
		If $ShowStep Then ToolTip(@sec&@msec&" MiniMapReset",0,0)
		MiniMapReset()
		$Q35Step = 'TNNBCGoTo'	
		
	Case 'TNNBCGoTo'
		If $ShowStep Then ToolTip(@sec&@msec&" TNNBCGoTo",0,0)
		If Not IsRide() Then 
			SendKey($RideKey)
			Sleep(5200)
		Else			
			TNNBCGoTo()
			$TimeA = TimerInit()
			$Q35Step = 'TNNBCWait'			
		EndIf		
			
	Case 'TNNBCWait'
		If $ShowStep Then ToolTip(@sec&@msec&" TNNBCWait",0,0)
		If IsChatNPC() Then
			Sleep($Wait)
			SendKey("ESC")
			Sleep($Wait)
			MiniMapReset()
			MiniMapResetTop()
			Sleep($Wait)
			$Q35Step = 'DeLacGoTo'
		EndIf

	Case 'DeLacGoTo'
		If $ShowStep Then ToolTip(@sec&@msec&" DeLacGoTo",0,0)
		DeLacGoTo()
		If IsChatNPC() Then 
			NPCChatClick(2)
			NPCChatClickQuest()
			Sleep($Wait)
			$Q35Step = 'KillMod'
			If IsRide() Then 		
				SendKey($RideKey)
			EndIf
			StartAuto_BClick()
			$TimeA = TimerInit()
		EndIf
		
	Case 'KillMod'
		Local $TimeB = Floor(TimerDiff($TimeA) / 1000)
		If $ShowStep Then 
			ToolTip(@sec&@msec&" KillMod",0,0)
		Else
			tooltip(@sec&@msec&" Count: "&$TimeB&"/"&$KillCount,0,0)
		EndIf
		If $TimeB > $KillCount Then 
			StartAuto_BClick()
			$Q35Step = 'TakeRide'
		EndIf
		
	Case 'TakeRide'
		If $ShowStep Then ToolTip(@sec&@msec&" TakeRide",0,0)
		If IsRide() Then 
			$Q35Step = 'DeLacReturn1'
		Else
			SendKey($RideKey)
			Sleep(5200)
		EndIf	
		
	Case 'DeLacReturn1'
		If $ShowStep Then ToolTip(@sec&@msec&" DeLacReturn1",0,0)
		DeLacGoTo()
		If IsChatNPC() Then 
			$Q35Step = 'AmaltheaGoTo'
			$TimeA = TimerInit()
			Local $TimeB = Floor(TimerDiff($TimeA)/1000)
			ToolTip("Count: "&$TimeB&"/72",0,0)
			
			NPCChatClick(2)
			NPCChatClickQuest()
			Sleep($Wait)
			NPCChatClick(2)
			NPCChatClickQuest()
		EndIf

	Case 'AmaltheaGoTo'
		Local $TimeB = Floor(TimerDiff($TimeA)/1000)
		ToolTip("Count: "&$TimeB&"/72",0,0)
		AmaltheaGoTo()
		If IsChatNPC() Then 
			NPCChatClick(2)
			NPCChatClickQuest()
			Sleep($Wait)
			$Q35Step = 'DeLacGoTo'
			Q35_CClick()
		EndIf
	EndSwitch	
	Sleep(777)
EndFunc

;~ Thực hiện khi Quest 30 - Cuong hoa thu
Func Q30Process()
;~ 	$Q30Step = 'MiniMapReset'
	Switch $Q30Step
	Case 'MiniMapReset'
		If Not IsRide() Then 
			SendKey($RideKey)
			Sleep(5200)
		EndIf
		MiniMapReset()
		MiniMapResetTop()
		$Q30Step = 'DoukiGoTo'
		
	Case 'DoukiGoTo'
		DoukiGoTo()
		If IsChatNPC() Then 
			NPCChatClick(2)
			NPCChatClickQuest()
			Sleep($Wait)
			$Q30Step = 'MorpheusGoTo'
		EndIf
		
	Case 'MorpheusGoTo'
		MorpheusGoTo()
		If IsChatNPC() Then 
			NPCChatClick(2)
			NPCChatClickQuest()
			Sleep($Wait)
			NPCChatClick(2)
			NPCChatClickQuest()
			$Q30Step = 'LiegerGoTo'
		EndIf
		
	Case 'LiegerGoTo'
		LiegerGoTo()
		If IsChatNPC() Then 
			NPCChatClick(8)
			NPCChatClickQuest()
			Sleep($Wait)
			NPCChatClick(8)
			NPCChatClickQuest()
			$Q30Step = 'LuDillyGoTo'
		EndIf
		
	Case 'LuDillyGoTo'
		LuDillyGoTo()
		If IsChatNPC() Then 
			NPCChatClick(3)
			NPCChatClickQuest()
			Sleep($Wait)
			NPCChatClick(3)
			NPCChatClickQuest()
			$Q30Step = 'GuadaGoTo'
		EndIf
		
	Case 'GuadaGoTo'
		GuadaGoTo()
		If IsChatNPC() Then 
			NPCChatClick(3)
			NPCChatClickQuest()
			Sleep($Wait)
			Q30_CClick()
			$Q30Step = 'DoukiGoTo'
			SendKey('ESC')
			Sleep(5775)
		EndIf
	EndSwitch	
	Sleep(777)
EndFunc

;~ Khởi tạo lại danh sách bên phải MiniMap
Func MiniMapReset()
	Sleep($Wait)
	SendKey('m')
	Sleep($Wait)
	GameClick($CBDao[0],$CBDao[1],1)
	Sleep($Wait)
	SendKey('m')
	Sleep($Wait)
	MapOpen()
EndFunc

;~ Đóng danh sách trên dùng bên phải
Func MiniMapResetTop()
	Sleep($Wait)
	MapOpen()
	Sleep($Wait)
	MiniMapClick(1)
	Sleep($Wait)
	MapOpen()
EndFunc
	
;~ Bấm vào chữ Người Hướng Dẫn Hoạt Động trên Map
Func MiniMapClick($Line)
Global $MMLine1[2] = [600,160]
Global $MMLine2[2] = [600,177]
Global $MMLine3[2] = [600,200]
Global $MMLine4[2] = [600,220]
Global $MMLine5[2] = [600,240]
Global $MMLine6[2] = [600,260]
Global $MMLine7[2] = [600,287]

	Switch $Line
	Case 1
		GameClick($MMLine1[0],$MMLine1[1])
	Case 2
		GameClick($MMLine2[0],$MMLine2[1])
	Case 3
		GameClick($MMLine3[0],$MMLine3[1])
	Case 4
		GameClick($MMLine4[0],$MMLine4[1])
	Case 5
		GameClick($MMLine5[0],$MMLine4[1])
	Case 6
		GameClick($MMLine6[0],$MMLine6[1])
	Case 7
		GameClick($MMLine7[0],$MMLine7[1])
	Case 8
		GameClick($MMLine8[0],$MMLine8[1])
	EndSwitch	
EndFunc


;~ Đi tớ Trung Nhân Ngư Bí Cảnh 139AEEE0
Func TNNBCGoTo()
	Sleep($Wait)
	SendKey("m")
	Sleep($Wait)
	GameClick($BMTNNBC[0],$BMTNNBC[1],1)
	Sleep($Wait)
	SendKey("m")
	Sleep($Wait)
	MiniMapClick(1)
	Sleep($Wait)
	MiniMapClick(2)
	Sleep($Wait)
	DeLacMapClick()
	Sleep($Wait)
	MiniMapClick(2)
	Sleep($Wait)
	MiniMapClick(1)
	Sleep($Wait)
	MapOpen()
EndFunc
;~ Lấy tên Map hiện tại
Func MapNameRead()
	Return GameRead(0x139AEEE0,'WCHAR[27]')
EndFunc

;~ Đi đến chỗ Douki
Func AmaltheaGoTo()	
	Sleep($Wait)
	MapOpen()
	Sleep($Wait)
	MiniMapClick(2)
	Sleep($Wait)
	AmaltheaMapClick()
	Sleep($Wait)
	MiniMapClick(2)
	Sleep($Wait)
	MapOpen()
EndFunc
;~ Bấm vào Amalthea trên Map
Func AmaltheaMapClick()
	GameClick($NAmalthea[0],$NAmalthea[1],2)	
EndFunc

;~ Đi đến chỗ Douki
Func DeLacGoTo()
	Sleep($Wait)
	MapOpen()
	Sleep($Wait)
	MiniMapClick(2)
	Sleep($Wait)
	DeLacMapClick()
	Sleep($Wait)
	MiniMapClick(2)
	Sleep($Wait)
	MapOpen(0)
EndFunc
;~ Bấm vào DeLac trên Map
Func DeLacMapClick()
	GameClick($NDeLac[0],$NDeLac[1],2)	
EndFunc

;~ Đi đến chỗ Guada
Func GuadaGoTo()
	Sleep($Wait)
	MapOpen()
	Sleep($Wait)
	MiniMapClick(3)
	Sleep($Wait)
	GuadaMapClick()
	Sleep($Wait)
	MiniMapClick(3)
	Sleep($Wait)
	MapOpen(0)
EndFunc
;~ Bấm vào Guada trên Map
Func GuadaMapClick()
	GameClick($NGuada[0],$NGuada[1],2)	
EndFunc

;~ Đi đến chỗ Lu Dilly
Func LuDillyGoTo()
	Sleep($Wait)
	MapOpen()
	Sleep($Wait)
	MiniMapClick(2)
	Sleep($Wait)
	LuDillyMapClick()
	Sleep($Wait)
	MiniMapClick(2)
	Sleep($Wait)
	MapOpen(0)
EndFunc
;~ Bấm vào Lu Dilly trên Map
Func LuDillyMapClick()
	GameClick($NLuDilly[0],$NLuDilly[1],2)	
EndFunc

;~ Đi đến chỗ Guada
Func LiegerGoTo()
	Sleep($Wait)
	MapOpen()
	Sleep($Wait)
	MiniMapClick(7)
	Sleep($Wait)
	LiegerMapClick()
	Sleep($Wait)
	MiniMapClick(7)
	Sleep($Wait)
	MapOpen(0)
EndFunc
;~ Bấm vào Lieger trên Map
Func LiegerMapClick()
	GameClick($NLieger[0],$NLieger[1],2)	
EndFunc

;~ Đi đến chỗ Morpheus
Func MorpheusGoTo()
	Sleep($Wait)
	MapOpen()
	Sleep($Wait)
	MiniMapClick(2)
	Sleep($Wait)
	MorpheusMapClick()
	Sleep($Wait)
	MiniMapClick(2)
	Sleep($Wait)
	MapOpen(0)
EndFunc
;~ Bấm vào Morpheus trên Map
Func MorpheusMapClick()
	GameClick($NMorpheus[0],$NMorpheus[1],2)	
EndFunc

;~ Đi đến chỗ Douki
Func DoukiGoTo()
	Sleep($Wait)
	MapOpen()
	Sleep($Wait)
	MiniMapClick(4)
	Sleep($Wait)
	DoukiMapClick()
	Sleep($Wait)
	MiniMapClick(4)
	Sleep($Wait)
	MapOpen(0)
EndFunc
;~ Bấm vào Douki trên Map
Func DoukiMapClick()
	GameClick($NDouki[0],$NDouki[1],2)	
EndFunc

;~ Đi đến chỗ Guada
Func AtlantisGoTo()
	Sleep($Wait)
	MapOpen()
	Sleep($Wait)
	GameClick($NAtlantis[0],$NAtlantis[1],2)
	Sleep($Wait)
	MapOpen(0)
EndFunc

;~ Mở bản đồ Mini nên
Func MapOpen($Open = 1)
;~ 	If $Open Then 
	SendKey("Tab")
EndFunc
	
;~ Bấm 1 key bất kỳ
Func SendKey($Key)
	If IsChat() Then 
		ControlSend($GameHandle,'','','{Enter}')
		Sleep($Wait)
	EndIf
	ControlSend($GameHandle,'','','{'&$Key&'}')
EndFunc
	
;~ Bấm vào 1 điểm trên màn hình
Func GameClick($x,$y,$click = 1,$button = 'left')
	If $TestClick Then
		$Pos = WinGetCaretPos()
		$Pos[0]+= $x
		$Pos[1]+= $y
		tooltip(@sec&@msec&" Q30",$Pos[0],$Pos[1])
		Sleep(1222)
	EndIf
	ControlClick($GameHandle,'','',$button,$click,$x,$y)
EndFunc

;~ Kiểm tra xem có đang chat với NPC không
Func IsChatNPC()
	return GameRead(0x0120AF8C)
EndFunc

;~ Kiểm tra xem có đang chat với NPC không
Func IsRide()
	return GameRead(0x010A05EC)
EndFunc

;~ Bấm vào dòng chat với NPC
Func NPCChatClick($Line)
	Switch $Line
	Case 1
		GameClick($NPCChat1[0],$NPCChat1[1])
	Case 2
		GameClick($NPCChat2[0],$NPCChat2[1])
	Case 3
		GameClick($NPCChat3[0],$NPCChat3[1])
	Case 4
		GameClick($NPCChat4[0],$NPCChat4[1])
	Case 5
		GameClick($NPCChat5[0],$NPCChat4[1])
	Case 6
		GameClick($NPCChat6[0],$NPCChat6[1])
	Case 7
		GameClick($NPCChat7[0],$NPCChat7[1])
	Case 8
		GameClick($NPCChat8[0],$NPCChat8[1])
	EndSwitch	
EndFunc

;~ Bấm vào nút nhận Nhiệm Vụ
Func NPCChatClickQuest()
	GameClick($NPCChatQuestButton[0],$NPCChatQuestButton[1])
EndFunc

;~ Hiển thị tọa độ trong của game
Func ShowMousePos()
	Local $Pos = WinGetCaretPos()
	Local $Mos = MouseGetPos()
	$Pos[0] = $Mos[0] - $Pos[0]
	$Pos[1] = $Mos[1] - $Pos[1]
	tooltip(@sec&@msec&" "&$Pos[0]&"/"&$Pos[1],$Mos[0]+27,$Mos[1]+27)
EndFunc
#cs
== Các Nhiệm Vụ Sẽ Làm =======
Lvl 20 - Học Viện Ma Pháp

Lvl 30 - Chỉ dẫn của Thần
	Douki - 
	Morpheus
	Lieger
	Lu Dilly
	Guada => 3 Cường Hóa Thú Cưỡi
	Mina
	Mordini
	Yinakesi
	Diana => Bùa ghép ngọc cấp 1
	Lamy Da
	Garcia
	Adelie
	Qiu Lifei
	Gunkel

Lvl 35 - ???

== Cần xem trước =======
1. Tool chỉ thiết kế chạy trên WinXP
2. Để cho nhanh, khi Auto không nên di chuyển bất kỳ cữa sổ nào
3. Tool sẽ thiết kế cho game ở chế độ Cữa Sổ 800x600

== Cần hỏi trước =======
1. Việc train lvl cho Char là tự làm hay tích hợp vào Tool luôn?
=> Client tự làm lên đến 35
#ce
