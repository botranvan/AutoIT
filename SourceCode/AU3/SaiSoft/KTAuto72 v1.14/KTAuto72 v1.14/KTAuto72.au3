#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Auto Hỗ Trợ Game Kiếm Tiên
#ce ==========================================================
#include-once
#include <IE.au3>	;NoShow
#include <INet.au3>	;NoShow
#include "NomadMemory.au3"	;NoShow


Global $Version = "1.14"
Global $AutoTitle = "KT Auto v"&$Version&" | 72ls.net"
Global $AutoMini = 0
Global $AutoPos[2] = [204, 197]
Global $DelayHelp = "Hãy nhập thời gian đợi của Skill vào."&@LF&@LF&"Bạn có thể nhập 1 phép toán"&@LF&"Ví dụ 2 phút 520 mili giây:"&@LF&"(60*2) + 0.52"
Global $URL = "http://autoit.72ls.net/viewtopic.php?t=1118"


Global $MemGame
Global $GameClass = "[CLASS:_PERFECTWORLD_HUGEROCK]"
Global $GameCharList
Global $GameHandle = 0
Global $GamePid = 0
Global $Target = 0
Global $Mod_HPCur = 0
Global $Mod_HPMax = 0
Global $Char_Name = ''
Global $Char_HPCur = 100
Global $Char_HPMax = 100
Global $Char_MPCur = 100
Global $Char_MPMax = 100
Global $Char_XPCur = 0
Global $Pet_HPCur = 100
Global $Pet_HPMax = 100
Global $Pet_MPCur = 100
Global $Pet_MPMax = 100
Global $SkillList = "1|2|3|4|5|6|7|8|9|0|F1|F2|F3|F4|F5|F6|F7|F8"
Global $PercentList = "7%|16%|27%|34%|43%|52%|61%|72%|81%|92%|97%|100%"
Global $SkillNumber = 18
Global $Skill[$SkillNumber] = [1,2,3,4,5,"F1","F2","F3","F4","F5",'F6','F7','F8',6,7,8,9,0]
Global $SkillNeed[$SkillNumber] = [720,720,720,720,720,"52","43","52","43","100",'52','52','0',720,720,720,720,720]
Global $SkillDelay[$SkillNumber]
Global $SkillOn[$SkillNumber]
Global $CharHeal = 1
Global $Training = 0
Global $Attacked = 0
Global $Buffing = 1
Global $AttGifFile = "att.gif"
Global $GameAuto = 0
Global $AutoWithGame = 1

Opt("SendCapslockMode",0)
Opt("GUICloseOnESC",0)
Opt("TrayOnEventMode",1)
Opt("TrayMenuMode",1)

HotKeySet("+{ESC}","ExitAuto")
HotKeySet("!{e}","StartAuto_BClick")
HotKeySet("!{y}","BuffOn_BClick")
HotKeySet("+^{DOWN}","AutoMini_BClick")
HotKeySet("+^{UP}","AutoMini_BClick")

#include "GIFAnimation.au3"
#include "Gui.au3"
#include "Functions.au3"
#include "GUIFunctions.au3"

AutoSetFile()
CharListReload_BClick()
GameOpenMemory()

$Char_Name = WinList($AutoTitle)
If $Char_Name[0][0] < 2 Then AutoCheckUpdate()
		
While 1
	Sleep(50)
	GetGameInfo()
	ShowGameInfo()
	HealChar()
	UseSkills()
	If $Training And $AutoWithGame And Not $GameAuto Then GameAutoOn()
	If $Training And $GameAuto And $AutoWithGame And Not GameIsAuto() Then GameAutoOn()
;~ 	ShowTestInfo()
WEnd

