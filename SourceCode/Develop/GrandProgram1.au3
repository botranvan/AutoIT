#cs ----------------------------------------------------------------------------
	AutoIt Version:		3.2.12.1
	Author:         	Trần Tiến Thành
	Script Function:	Grand Program
	
Cấu trúc chương trình:
	1. Các include
	2. Khai báo biến
	3. Các thủ tục và hàm chạy trước
	4. Hệ thống tra cứu các biến trong chương trình theo vần abc
	5. Các hàm
#ce ----------------------------------------------------------------------------
;Các Include
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ListviewConstants.au3>

;2. Khai báo biến
Global $Main, $Msg ;Biến tạo giao diện GUI
Global $ListView, $Item_ListView[1000], $i, $j ;(Các) biến tạo giao diện xem chương trình
Global $Search, $File ;(Các) biến sử dụng tìm kiếm chương trình
Global $Tab, $Tab_Infor, $Tab_Option, $Tab_Help ;(Các) biến tạo các Tab
Global $GUI_ButtonStart ;(Các) biến tạo nút nhấn
Global $GUI_NameProcess ;(Các) biến tạo hộp input
Global $FileName, $FileSize, $FileTime, $FileVersion ;(Các) biến sử dụng cho việc tìm thông tin File
Global $GUI_FileName, $GUI_FileSize, $GUI_FileTime, $GUI_FileVersion  ; (Các) biến để hiện thông tin File

;3. Các thủ tục và hàm chạy trước
AutoItSetOption("GUIOnEventMode",1)
AutoItSetOption("GUIEventOptions",1)
Opt('MustDeclareVars', 1)
Main()

Do	
	$Msg = GUIGetMsg()
Until $Msg = $GUI_EVENT_CLOSE

;4. Hệ thống tra cứu các biến trong chương trình theo vần abc

;5. Các hàm
;Hàm tạo giao diện GUI
Func Main()
	$Main = GUICreate("Grand Program", 300, 600, @DesktopWidth-310, 1)
	GUISetBkColor(0x00E0FFFF)
	$GUI_NameProcess = GUICtrlCreateInput("", 10, 320, 230, 20)
	GUICtrlSetState(-1, $GUI_DROPACCEPTED)   ; to allow drag and dropping
	GUISetState()
	$GUI_ButtonStart = GUICtrlCreateButton("Chạy", 240, 320, 50 , 20)
	GUICtrlSetOnEvent($GUI_ButtonStart,"OpenPro") ;Sự kiện cho nút Chạy
	Find_Process()
	GUISetState(@SW_SHOW)
	
	GUISetOnEvent($GUI_EVENT_CLOSE,"ExitPrograme")
EndFunc
Func ExitPrograme()
	Exit
EndFunc

;Hàm kích hoạt File EXE
Func OpenPro()
	Run(StringTrimRight(GUICtrlRead($GUI_NameProcess),1))
EndFunc

;Hàm tìm chương trình
Func Find_Process()
	$ListView = GUICtrlCreateListView("Tên chương trình              ", 10, 10, 280, 300, $LVS_NOCOLUMNHEADER)
	$Search = FileFindFirstFile("*.exe")  
	If $search = -1 Then
		MsgBox(0, "Có lỗi", "Không tìm thấy chương trình nào")
	EndIf
	$i = 0
	While 1
		$File = FileFindNextFile($Search)
		If @error Then ExitLoop
		$Item_ListView[$i] = GUICtrlCreateListViewItem($File, $ListView)
		GUICtrlSetOnEvent($Item_ListView[$i],"Dipslay_Infor_File") ;Thêm cái này thui
		GUICtrlSetData($Item_ListView, $File)
		$i = $i + 1
	WEnd
	FileClose($Search)
EndFunc

;Thông tin File
Func Infor_File()
	$FileName = StringTrimRight(GUICtrlRead(GUICtrlRead($ListView)), 1)
	$FileSize = FileGetSize(@ScriptDir&"\"&$FileName)
	$FileTime = FileGetTime(@ScriptDir&"\"&$FileName, 1)
	$FileVersion = FileGetVersion(@ScriptDir&"\"&$FileName)
EndFunc
;Hiện thông tin File
Func Dipslay_Infor_File()
	Infor_File()
	$GUI_FileName = GUICtrlCreateLabel("Tên file: "&$FileName, 15, 360, 280, 20)
	$GUI_FileSize = GUICtrlCreateLabel("Kích thước: "&$FileSize, 15, 380, 180, 20)
	$GUI_FileTime = GUICtrlCreateLabel("Thời gian tạo: "&$FileTime[2]&"/"&$FileTime[1]&"/"&$FileTime[0]&" "&$FileTime[3]&":"&$FileTime[4]&":"&$FileTime[5], 15, 400, 180, 20)
	$GUI_FileVersion = GUICtrlCreateLabel("Phiên bản: "&$FileVersion, 15, 420, 180, 20)
EndFunc	