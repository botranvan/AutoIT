#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Tự tạo ô số Sudoku
#ce ==========================================================

Global $AutoName = "aSudoku"
Global $AutoVersion = "1.0"
Global $AutoHide = 0
Global $Testing = 0
Global $AutoPos[2] = [1,1]
Global $DataFileName = "Data.ini"
Global $HomePage = "http://72ls.net/"
Global $CreateURL = "http://localhost/?q=node/add/sudoku"

Global $SudokuSize = 9
Global $SudokuLevel = 4

Global $SudokuInput[$SudokuSize][$SudokuSize]
Global $SudokuValue[$SudokuSize][$SudokuSize]
Global $InputSize = 25
Global $Spam = 4

Global $SudokuZone = 0
Global $SoftLevel = 1
Global $SoftRun = 0

Global $SoftPath = 'C:\Program Files\MaaTec\MaaTec Sudoku\mtSudoku.exe'
Global $SoftTitle = 'Unnamed - mtSudoku'

Global $SoftTitle = 'SuDoku Creator Pro'
Global $SoftPath = 'Sudoku.exe'


;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+{DEl}","ToolTipDel")					;Ctrl + Shilf + Delete 	- Xóa Thông báo
HotKeySet("+{Esc}","MainGUIClose")					;Ctrl + Shilf + End 	- Thoát Auto
HotKeySet("^+t","TestingSet")						;Ctrl + Shilf + T 		- Trạng Thái Thử Nghiệm
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

Opt("GUICloseOnESC",0)

#include <IE.au3>		;NoShow
#include <Array.au3>	;NoShow
#include <EditConstants.au3>	;NoShow
#include <array.au3>	;NoShow

#include "GUI.au3"
#include "GUIFunction.au3"
#include "Function.au3"

;~ AutoCheckUpdate()
LoadSetting()
MainGUIFix()
;~ SudokuZoneCreate()
;~ SoftSudokuGetBClick()

$Line = ""
;~ $Line = "406800002582000900010000000320005000004008020060192000901000740007004090648509000"
$Line = StringLen(StringReplace($Line,'0',''))
If $Line Then msgbox(0,"72ls.net",$Line)

While 1
	Sleep(270)
	
	If $SoftRun Then SudokuFromSoftProcess()
	If $Testing Then tooltip(@sec&@msec&" Testing",0,0)
		
WEnd