#include <GUIConstants.au3>
#include <Misc.au3>
#include <SROVNLIB.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>

Opt("GUIOnEventMode", 1)

;--------------------
;-- Phan chinh sua --
;--------------------
SetScreen(3) ; Do phan giai game
Const $BuffCount = 6 ; So luong skill buff
Const $BuffBar = "{F2}" ; Skill buff dat o bar nao
Const $HPPercent = 70 ; Phan tram de bom HP = pot
Const $MPPercent = 50 ; Phan tram de bom MP = pot
Const $HealPercent = 80 ; ; Phan tram de bom HP = skill

;-------------------
;-- Bien toan cuc --
;-------------------

Global $Paused = True
Global $AutoPickup = True
Global $AutoBuff = True
Global $AutoAtt = True
Global $AutoHeal = False
Global $AutoCure = False
Global $AutoHP = True
Global $AutoMP = True
Global $AutoPill = True
Global $AttMode = 1

; --------------------
; -- SCRIPT HOT KEY --
; --------------------
HotKeySet("^q", "Close")			; Thoat khoi chuong trinh
HotKeySet("{F10}","ToggleShow")		; An hien giao dien chuong trinh
HotKeySet("{PAUSE}", "TogglePause") ; Dung / Chay chuong trinh
HotKeySet("{F5}", "ToggleBuff")		; Bat / tat AutoBuff
HotKeySet("{F6}", "TogglePickup")	; Bat / tat tu nhat do
HotKeySet("{F7}", "ToggleAtt")		; Bat / tat Tu dung skill
HotKeySet("{F8}", "ToggleAttMode")	; Thay doi kieu danh
HotKeySet("^,", "ToggleHeal")		; Bat / ta Tu dong dung skill Heal
HotKeySet("^.", "ToggleCure")		; Bat / ta Tu dong dung skill Cure
HotKeySet("^-", "ToggleHP")			; Bat / ta Tu dong dung binh HP
HotKeySet("^=", "ToggleMP")			; Bat / ta Tu dong dung binh MP
HotKeySet("^\", "TogglePill")		; Bat / ta Tu dong dung Pill


; -------------------------------
; -- Ham de thoat chuong trinh --
; -------------------------------
Func Close()
    Exit 0
EndFunc

; ---------------------------
; -- Ham an hien giao dien --
; ---------------------------
Func ToggleShow()
	If WinExists("BsroAuto") And WinGetState("BsroAuto")=23 Then
		GUISetState(@SW_RESTORE)
		If WinExists("SRO_Client") Then WinActivate("SRO_Client")
	Else
		GUISetState(@SW_MINIMIZE)
		If WinExists("SRO_Client") Then WinActivate("SRO_Client")
	EndIf
EndFunc

; -----------------------------------------
; -- Ham de tam dung / chay chuong trinh --
; -----------------------------------------
Func TogglePause()
    $Paused = NOT $Paused
	if $Paused Then
		GUICtrlSetColor($status,0xFF0000)
		GUICtrlSetData($Status,"Tam dung")
	Else
		GUICtrlSetColor($status,0x0000FF)
		GUICtrlSetData($Status,"Dang hoat dong")
	EndIf
    ;While $Paused
	;	sleep(100)
	;	ShowClock()
    ;WEnd
EndFunc

; --------------------------------
; -- Ham bat / tat Tu dong buff --
; --------------------------------
Func ToggleBuff()
	$AutoBuff = Not $AutoBuff
	If $AutoBuff Then
		GUICtrlSetBkColor($lblBuff,0x0000FF)
	Else
		GUICtrlSetBkColor($lblBuff,0xCCCCCC)
	EndIf
EndFunc


; -----------------------------------
; -- Ham bat / tat Tu dong nhat do --
; -----------------------------------
Func TogglePickup()
	$AutoPickup = Not $AutoPickup
	If $AutoPickup Then
		GUICtrlSetBkColor($lblNhatDo,0x0000FF)
	Else
		GUICtrlSetBkColor($lblNhatDo,0xCCCCCC)
	EndIf
EndFunc

; -------------------------------
; -- Ham bat / tat Tu dong Att --
; -------------------------------
Func ToggleAtt()
	$AutoAtt = not $AutoAtt
	If $AutoAtt Then
		GUICtrlSetBkColor($lblAtt,0x0000FF)
		GUICtrlSetBkColor($lblAttMode,0xFF0000)
	Else
		GUICtrlSetBkColor($lblAtt,0xCCCCCC)
		GUICtrlSetBkColor($lblAttMode,0xCCCCCC)
	EndIf
EndFunc

; --------------------------------
; -- Ham thay doi kieu tan cong --
; --------------------------------
 Func ToggleAttMode()
	$AttMode = $AttMode + 1
	if $AttMode > 3 then $AttMode = 1
	GUICtrlSetData($lblAttMode,$AttMode)
EndFunc

; --------------------------
; -- Ham bat tat AutoHeal --
; --------------------------
Func ToggleHeal()
	$AutoHeal = Not $AutoHeal
	If $AutoHeal Then
		GUICtrlSetBkColor($lblHeal,0x0000FF)
	Else
		GUICtrlSetBkColor($lblHeal,0xCCCCCC)
	EndIf
EndFunc

; --------------------------
; -- Ham bat tat AutoCure --
; --------------------------
Func ToggleCure()
	$AutoCure = Not $AutoCure
	If $AutoCure Then
		GUICtrlSetBkColor($lblCure,0x0000FF)
	Else
		GUICtrlSetBkColor($lblCure,0xCCCCCC)
	EndIf
EndFunc

; ------------------------
; -- Ham bat tat AutoHP --
; ------------------------
Func ToggleHP()
	$AutoHP = Not $AutoHP
	If $AutoHP Then
		GUICtrlSetBkColor($lblHP,0x0000FF)
	Else
		GUICtrlSetBkColor($lblHP,0xCCCCCC)
	EndIf
EndFunc

; ------------------------
; -- Ham bat tat AutoMP --
; ------------------------
Func ToggleMP()
	$AutoMP = Not $AutoMP
	If $AutoMP Then
		GUICtrlSetBkColor($lblMP,0x0000FF)
	Else
		GUICtrlSetBkColor($lblMP,0xCCCCCC)
	EndIf
EndFunc

; --------------------------
; -- Ham bat tat AutoPill --
; --------------------------
Func TogglePill()
	$AutoPill = Not $AutoPill
	If $AutoPill Then
		GUICtrlSetBkColor($lblPill,0x0000FF)
	Else
		GUICtrlSetBkColor($lblPill,0xCCCCCC)
	EndIf
EndFunc

; -- Ham hien thi dong ho --
; --------------------------
Func ShowClock()
	GUICtrlSetData($clock,@HOUR & ":" & @MIN)
EndFunc

; ---------------------
; -- Giao dien chinh --
; ---------------------
$MainGUI = GUICreate("BsroAuto",195,90,$ToaDo[$MyScreen][$TD_Width]-325,0,$WS_POPUP,$WS_EX_LAYERED)

$lblHP = GUICtrlCreateLabel("AutoHP",10,5,55,15,$SS_CENTER )
GUICtrlSetBkColor($lblHP,0x0000FF)
GUICtrlSetColor($lblHP,0xFFFFFF)
GUICtrlSetTip($lblHP,"Bat/tat tu dong bom HP - Phim tat [Ctrl] + [-]")
GUICtrlSetOnEvent($lblHP,"ToggleHP")

$lblMP = GUICtrlCreateLabel("AutoMP",70,5,55,15,$SS_CENTER )
GUICtrlSetBkColor($lblMP,0x0000FF)
GUICtrlSetColor($lblMP,0xFFFFFF)
GUICtrlSetTip($lblMP,"Bat/tat tu dong bom MP - Phim tat [Ctrl] + [=]")
GUICtrlSetOnEvent($lblMP,"ToggleMP")

$lblPill = GUICtrlCreateLabel("AutoPill",130,5,55,15,$SS_CENTER )
GUICtrlSetBKColor($lblPill,0x0000FF)
GUICtrlSetColor($lblPill,0xFFFFFF)
GUICtrlSetTip($lblPill,"Bat/tat tu dong dung Pill - Phim tat [Ctrl] + [\]")
GUICtrlSetOnEvent($lblPill,"TogglePill")

$lblBuff = GUICtrlCreateLabel("Buff",10,25,55,15,$SS_CENTER )
GUICtrlSetBkColor($lblBuff,0x0000FF)
GUICtrlSetColor($lblBuff,0xFFFFFF)
GUICtrlSetTip($lblBuff,"Bat/tat tu dong Buff - Phim tat [F5]")
GUICtrlSetOnEvent($lblBuff,"ToggleBuff")

$lblNhatDo = GUICtrlCreateLabel("Nhat do",70,25,55,15,$SS_CENTER )
GUICtrlSetBkColor($lblNhatDo,0x0000FF)
GUICtrlSetColor($lblNhatDo,0xFFFFFF)
GUICtrlSetTip($lblNhatDo,"Bat/tat tu dong nhat do - Phim tat [F6]")
GUICtrlSetOnEvent($lblNhatDo,"TogglePickup")

$lblAtt = GUICtrlCreateLabel("Attack",130,25,50,15,$SS_CENTER )
GUICtrlSetBKColor($lblAtt,0x0000FF)
GUICtrlSetColor($lblAtt,0xFFFFFF)
GUICtrlSetTip($lblAtt,"Bat/tat tu dong tan cong - Phim tat [F7]")
GUICtrlSetOnEvent($lblAtt,"ToggleAtt")

$lblAttMode = GUICtrlCreateLabel("1",180,25,5,15,$SS_CENTER )
GUICtrlSetBKColor($lblAttMode,0xFF0000)
GUICtrlSetColor($lblAttMode,0xFFFFFF)
GUICtrlSetTip($lblAttMode,"Thay doi kieu tan cong - Phim tat [F8]")
GUICtrlSetOnEvent($lblAttMode,"ToggleAttMode")

$lblHeal = GUICtrlCreateLabel("AutoHeal",10,45,55,15,$SS_CENTER )
GUICtrlSetBkColor($lblHeal,0xCCCCCC)
GUICtrlSetColor($lblHeal,0xFFFFFF)
GUICtrlSetTip($lblHeal,"Bat/tat tu dong bom HP bang skill - Phim tat [Ctrl] + [,]")
GUICtrlSetOnEvent($lblHeal,"ToggleHeal")

$lblCure = GUICtrlCreateLabel("AutoCure",70,45,55,15,$SS_CENTER )
GUICtrlSetBkColor($lblCure,0xCCCCCC)
GUICtrlSetColor($lblCure,0xFFFFFF)
GUICtrlSetTip($lblCure,"Bat/tat tu giai di trang bang skill - Phim tat [Ctrl] + [.]")
GUICtrlSetOnEvent($lblCure,"ToggleCure")

$lblMin = GUICtrlCreateLabel("Thu nho",130,45,55,15,$SS_CENTER )
GUICtrlSetBkColor($lblMin,0x00CCFF)
GUICtrlSetColor($lblMin,0xFFFFFF)
GUICtrlSetTip($lblMin,"An/Hien giao dien - Phim tat [F10]")
GUICtrlSetOnEvent($lblMin,"ToggleShow")

$clock = GUICtrlCreateLabel(@HOUR & ":" & @MIN,105,65,95,15,$SS_CENTER )

$status = GUICtrlCreateLabel("Tam dung",10,65,95,15,$SS_CENTER )
GUICtrlSetColor($status,0xFF0000)
GUICtrlSetTip($status,"Tam dung/Bat dau Auto - Phim tat [Pause]")
GUICtrlSetOnEvent($status,"TogglePause")

GUISetState(@SW_SHOW)
WinSetOnTop("BsroAuto", "", 1)
WinSetTrans("BsroAuto", "", 200)

If WinExists("SRO_Client") Then WinActivate("SRO_Client")

Func AutoAtt($Mode)
	If $Mode=3 or MobIsGiant() Then 
		While MobIsSelected()
			If $AutoHP Then AutoHP($HPPercent)
            If $AutoMP Then AutoMO($MPPercent)
			If $AutoPill Then AutoPill()
			SkillWaitReady(2)
			SkillWaitReady(1)
			Send(2)
			SkillWaitActive(2)
			Send(1)
			Sleep(300)

			If $AutoHP Then AutoHP($HPPercent)
			If $AutoMP Then AutoMO($MPPercent)
			If $AutoPill Then AutoPill()
			SkillWaitReady(3)
			Send(3)
			Sleep(300)

			If $AutoHP Then AutoHP($HPPercent)
			If $AutoMP Then AutoMO($MPPercent)
			If $AutoPill Then AutoPill()
			SkillWaitReady(2)
			Send(2)
            Sleep(1000)

			;Ket thuc vong lap tai day se kha on. Nhung dong tiep theo con dang thu nghiem, chua biet co duoc hay khong

			If $AutoHP Then AutoHP($HPPercent)
			If $AutoMP Then AutoMO($MPPercent)
			If $AutoPill Then AutoPill()
			SkillWaitReady(1)
			SkillWaitReady(4)
			Send(4)
			SkillWaitActive(4)
			Send(1)

			If $AutoHP Then AutoHP($HPPercent)
			If $AutoMP Then AutoMO($MPPercent)
			If $AutoPill Then AutoPill()
			SkillWaitActive2(5,6)
			Send("x")
		WEnd
	
	ElseIf $Mode=2 or MobIsChamp() Then
		for $i= 1 to 2 ;Lap lai 2 lan chieu danh mob thuong
	        If $AutoHP Then AutoHP($HPPercent)
            If $AutoMP Then AutoMO($MPPercent)
			If $AutoPill Then AutoPill()
			SkillWaitReady(2)
            SkillWaitReady(1)
            Send(2)
            SkillWaitActive(2)
            Send(1)
            Sleep(300)

            If $AutoHP Then AutoHP($HPPercent)
			If $AutoMP Then AutoMO($MPPercent)
			If $AutoPill Then AutoPill()
			SkillWaitReady(3)
			Send(3)
			SkillWaitActive(3)
			Sleep(300)

			If $AutoHP Then AutoHP($HPPercent)
			If $AutoMP Then AutoMO($MPPercent)
			If $AutoPill Then AutoPill()
			SkillWaitReady(2)
			Send(2)
			Sleep(1000)
			;Khi ket thuc vong lap lan dau se co 1 khoang thoi gian ngan cho cho skill 2 san sang, Char cua minh se danh mob binh thuong khong skill
			
			If MobGetHP()>20 Then
				SkillWaitReady(4)
				Send(4)
				If MobGetHP()>20 Then
					SkillWaitActive(4)
					SkillWaitActive2(5,6)
				EndIf
			EndIf
			Send("x")
		Next
	
	ElseIf $Mode=1 Then
		If $AutoHP Then AutoHP($HPPercent)
		If $AutoMP Then AutoMO($MPPercent)
		If $AutoPill Then AutoPill()
		SkillWaitReady(2)
        SkillWaitReady(1)
        Send(2)
        SkillWaitActive(2)
        Send(1)
        Sleep(300)

        If $AutoHP Then AutoHP($HPPercent)
		If $AutoMP Then AutoMO($MPPercent)
		If $AutoPill Then AutoPill()
		SkillWaitReady(3)
		Send(3)
		SkillWaitActive(3)
		Sleep(300)

		If $AutoHP Then AutoHP($HPPercent)
		If $AutoMP Then AutoMO($MPPercent)
		If $AutoPill Then AutoPill()
		SkillWaitReady(2)
		Send(2)
		Sleep(1000)
		;Khi ket thuc vong lap lan dau se co 1 khoang thoi gian ngan cho cho skill 2 san sang, Char cua minh se danh mob binh thuong khong skill
		
		If MobGetHP()>10 Then
			SkillWaitReady(4)
			Send(4)
			SkillWaitActive(4)
			SkillWaitActive2(5,6)
		EndIf
		Send("x")
	EndIf
EndFunc

While 1
	If WinActive("BsroAuto") and WinExists("SRO_Client") Then
		Sleep(100)
		WinActivate("SRO_Client")
	EndIf
	If Not $Paused and WinActive("SRO_Client") Then
		If MobIsSelected() Then
			If MobGetHP()=100 Then
				If $AutoAtt Then AutoAtt($AttMode)
			EndIf
		Else
			If $AutoBuff Then AutoBuff($BuffCount,$BuffBar)
			If $AutoPickUp Then AutoPickUp()
			If $AutoMP Then AutoMP($MPPercent)
			If $AutoHeal Then 
				AutoHeal($HealPercent)
			ElseIf $AutoHP Then
				AutoHP($HPPercent)
			EndIf
			If $AutoCure Then 
				AutoCure()
			ElseIf $AutoPill Then
				AutoPill()
			EndIf
		EndIf
	EndIf
WEnd