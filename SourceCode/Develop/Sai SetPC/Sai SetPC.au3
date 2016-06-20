;== Cấu Trúc Trương Trình ===========================================================================================================
;~ Các Include
;~ Phím nóng cố định
;~ Biến cố định 
;~ Những lệnh cần chạy trước
;~ Các Hàm Hoàn Chỉnh
	;~ Các Hàm xử lý chương trình chính
		;Func ExitAuto();~ Hàm thoát Auto
		;Func PauseAuto();~ Tạm dừng Auto
		;Func SetRunMode();~ Hàm cài đặt chế độ hoạt động
	;~ Các Hàm xử lý Module
		;Func GetAllModulesLocation($SearchFolder="Modules");~ Hàm nạp vị trí các Modules 
		
;~ Các Hàm Đang Tạo
;== Hết Cấu Trúc Trương Trình =======================================================================================================

;== Các Include mặc định ============================================================================================================
#include-once
#include <Array.au3>
#include <File.au3>
;======= Hết Các Include mặc định ===================================================================================================

;== Phím nóng cố định =================================================================================================================
HotKeySet ("{PAUSE}","PauseAuto")					;Pause				- Tạm Dừng Auto
HotKeySet ("^+{END}","ExitAuto")					;Ctrl+Shilf+End 	- Thoát Auto
;======= Hết Phím nóng cố định ========================================================================================================

;== Biến cố định ======================================================================================================================
;~ Biến Mô Tả Chương Trình
Global Const $AutoName="Sai SetPC"					;Tên Chương Trình
Global Const $AutoClass="AutoIt v3 GUI"				;Mã phân loại Chương Trình		
Global $AutoHandle=""								;Mã Chương Trình khi chạy
Global Const $AutoVersion="1.0"						;Phiên Bản
Global Const $Author="Trần Minh Đức"				;Tên (các) Lập Trình Viện
Global Const $ProcessName="AutoIt3.exe"				;Dùng khi lập trình
;Global Const $ProcessName=$AutoName&".exe"			;Dùng khi Xuất Thành EXE
Global Const $CountProcess=1 						;Số lượng Chương Trình được phép chạy cùng 1 lúc

;~ Các chức năng của Chương Trình
Global $FunctionsLocation[77][3]

;~ Biến định dạng Giao Diện
Global $Horizontally=7								;Cách khoản Trên Xuống
Global $Vertically=7								;Cách khoản Trái Phải
Global $AutoSize=_ArrayCreate(160,250)				;Kích thước Chương Trình
Global $AutoPos=_ArrayCreate(0,0)					;Vị trí Chương Trình
Global $AutoStype=Default
Global $AutoExStype=Default

;~ Biến Thời Gian
Global $TimeSplit=" - " 	;Phân Cách Thời Gian
Global $1s=1000				;Số Mili Giây trên 1 Giây	(1000/1)
Global Const $spm=60		;Số Giây trên 1 Phút		(60/1)
Global Const $mph=60		;Số Phút trên 1 Giờ			(60/1)	
Global Const $hpd=24		;Số Giờ trên 1 Ngày			(60/1)

;~ Biến dùng chung
Global $Pause=False
Global $ModulesFolder="Modules"
;======= Hết Biến Cố Định =============================================================================================================

;== Những lệnh cần chạy trước =========================================================================================================
CheckAuto()						;Kiểm tra Auto
SetRunMode()					;Cài đặt chế độ hoạt động mắt định của chương trình

GetAllModulesLocation()			;Lấy đường dẫn các Module
GetModuleInfo()					;Nạp thông tin của tất cả cá Module
IncludeAllModule()				;Hàm inlcude tất cả các Module

SetInterface()					;Tạo giao diện ban đầu
While 1
	Sleep(777)
WEnd 
;======= Hết những lệnh cần chạy trước ================================================================================================



;== Các Hàm xử lý chương trình chính ================================================================================================
;~ Hàm Kiểm Tra Trước khi Chạy Auto
Func CheckAuto()
	$l=ProcessList()
	$Count=$CountProcess
	For $i=1 to $l[0][0] Step 1
		If $l[$i][0]=$ProcessName And $Count=0 then
			ToolTip("")
			MsgBox(0,$AutoName,$CountProcess&" chương trình "&$AutoName&" đã chạy."&@LF&"Không thể mở thêm!!!")
			Exit
		EndIf
		If $l[$i][0]=$ProcessName then $Count-=1
	Next
	TraySetState(1)
EndFunc

;~ Hàm thoát Auto
Func ExitAuto()
	Exit
EndFunc

;~ Tạm dừng Auto
Func PauseAuto()
	$Pause=Not $Pause
	While $Pause
		ToolTip("Tạm Dừng...",0,0)
		Sleep(777)
	WEnd
	ToolTip("")
EndFunc

;~ Hàm cài đặt chế độ hoạt động
Func SetRunMode()
	AutoItSetOption("GUIOnEventMode",1)
EndFunc
;======= Hết Các Hàm xử lý chương trình chính =======================================================================================




;== Các Hàm xử lý Module ============================================================================================================
;~ Hàm nạp vị trí các Modules 
;~~ Các Module muốn được ghi nhận phải có đủ 2 File *.Info và *.Module
;~~ Khi tìm thấy 2 File *.Info và *.Module thì ngưng không tìm trong Thư Mục đó nữa
Func GetAllModulesLocation($SearchFolder="Modules")
	Local $Searchs=FileFindFirstFile($SearchFolder&"\*")
	If $Searchs=-1 Then Return False	;Không tìm thấy gì trong Thư Mục
	
	Local $Info=False
	Local $AU3=False
	Local $Folders=_ArrayCreate(0)
	While 1 ;Duyệt qua các File/Folder tìm được
		$Files = FileFindNextFile($Searchs)
		If @error Then ExitLoop
		
		If StringInStr($Files,".info",1)<>0 Then $Info=$Files
		If StringInStr($Files,".au3",1)<>0 Then $AU3=$Files
		If StringInStr($Files,".",1)=0 Then 
			$Folders[0]+=1
			_ArrayAdd($Folders,$Files)
		EndIf
	WEnd
	
	;Ghi nhận tên Thu Mục nếu có dủ *.Info và *.Module
	If $Info<>False And $AU3<>False Then
		$FunctionsLocation[0][0]+=1
		$FunctionsLocation[$FunctionsLocation[0][0]][0]=$SearchFolder
		$FunctionsLocation[$FunctionsLocation[0][0]][1]=$Info
		$FunctionsLocation[$FunctionsLocation[0][0]][2]=$AU3
		Return True
	Else
		For $i=1 To $Folders[0] Step 1
			GetAllModulesLocation($SearchFolder&"\"&$Folders[$i])
		Next
	EndIf
EndFunc

;======= Hết Hàm xử lý Modules ======================================================================================================




;== Các Hàm Đang Tạo ==================================================================================================================
;~ Hàm Tạo Giao Diện
Func SetInterface()
	$AutoHandle=CreateMainInteface()
	;$AutoHandle=$TempHandle
EndFunc

;~ Hàm tạo Giao Diện chính
Func CreateMainInteface()
	Local $MainHandle=GUICreate($AutoName,$AutoSize[0],$AutoSize[1],$AutoPos[0],$AutoPos[1],$AutoStype,$AutoExStype)
	GUISetOnEvent($GUI_EVENT_CLOSE,"ExitAuto",$MainHandle)
	
	;Thêm vào Menu Chính
	CreateMainMenu()
	
	
	GUISetState(@SW_SHOW,$MainHandle)
	Return $Mainhandle
EndFunc

;~ Hàm tạo Menu chính
;~~ Menu này luôn xuất hiện dù bất kỳ Module nào đang hoạt động
Func CreateMainMenu()
	;Menu Quản Lý tương ứng với Menu File
	Global $File_MENU=GUICtrlCreateMenu("&Quản Lý")
		GUICtrlCreateMenuItem("",$File_MENU)
		
	Global $File_MENU_Module_MENU=GUICtrlCreateMenu("&Chức năng",$File_MENU)
	CreateModuleMenuItem($File_MENU_Module_MENU)
	Global $File_MENU_CloseAllModule_ITEM=GUICtrlCreateMenuItem("Đóng &Hết",$File_MENU)
		GUICtrlCreateMenuItem("",$File_MENU)
		
	Global $File_MENU_Help_ITEM=GUICtrlCreateMenuItem("&Trợ Giúp",$File_MENU)
	Global $File_MENU_Close_ITEM=GUICtrlCreateMenuItem("Đó&ng "&$AutoName,$File_MENU)
	GUICtrlSetOnEvent($File_MENU_Close_ITEM,"ExitAuto")
EndFunc

;~ Hàm tạo Danh Sách Module trong Menu Module
Func CreateModuleMenuItem($Menu)
	If $FunctionsLocation[0][0]=0 Then Return False
	
	;Tìm và tạo Menu Item
	Global $Module_MENU[$FunctionsLocation[0][0]+1]
	For $i=1 to $FunctionsLocation[0][0] Step 1
		$Module_MENU[$i]=GUICtrlCreateMenuItem($FunctionsInfo[$i][3],$Menu)
		GUICtrlSetOnEvent(-1,"EventActive"&$FunctionsInfo[$i][0])
		;$File_MENU_Module_MENU__ITEM=GUICtrlCreateMenuItem($FunctionsLocation[$i],$Menu)
	Next
EndFunc	

;~ Hàm include Module
Func IncluseModules()
	If $FunctionsLocation[0][0]=0 Then Return 0
	;For $i=1 To $FunctionsLocation[0] Step
EndFunc

;~ Hàm lấy thông tin của Module
Func GetModuleInfo()
	If $FunctionsLocation[0][0]=0 Then Return 0
		
	Global $FunctionsInfo[$FunctionsLocation[0][0]+1][7]
	For $i=1 To $FunctionsLocation[0][0] Step 1
		$FileInfo=FileOpen($FunctionsLocation[$i][0]&"\"&$FunctionsLocation[$i][1],0)
		While 1
			$L=FileReadLine($FileInfo)
			If @error=-1 Then ExitLoop
			$aL=StringSplit($L,"=")
			Select
				Case $aL[1]="ModuleMame"
					$FunctionsInfo[$i][0]=$aL[2]
				Case $aL[1]="ModuleRunWith"
					$FunctionsInfo[$i][1]=$aL[2]
				Case $aL[1]="ModuleNotRunWith"
					$FunctionsInfo[$i][2]=$aL[2]
				Case $aL[1]="RegionName"
					$FunctionsInfo[$i][3]=$aL[2]
				Case $aL[1]="Version"
					$FunctionsInfo[$i][4]=$aL[2]
				Case $aL[1]="Author"
					$FunctionsInfo[$i][5]=$aL[2]
				Case $aL[1]="Description"
					$FunctionsInfo[$i][6]=$aL[2]
			EndSelect
		WEnd
		FileClose($FileInfo)
	Next	
EndFunc

;~ Hàm include tất cả các Module
Func IncludeAllModule()
	For $i=1 To $FunctionsLocation[0][0] Step 1
		$File=$FunctionsLocation[$i][0]&"\"&$FunctionsLocation[$i][2]
		$FullPathFile=_PathFull($File)
		$FullPathInclude=_PathFull("AutoIt3\Include")
		;FileCopy($FullPathFile,$FullPathInclude,1)
		MsgBox(0,"",Execute('#include <'&$FunctionsLocation[$i][2]&'>'))
	Next
EndFunc
;======= Hết Các Hàm Đang Tạo =========================================================================================================

#cs
	For $i=1 To $FunctionsLocation[0][0] Step 1
		MsgBox(0,$FunctionsLocation[$i][0],$FunctionsInfo[$i][0])
		MsgBox(0,$FunctionsLocation[$i][0],$FunctionsInfo[$i][1])
		MsgBox(0,$FunctionsLocation[$i][0],$FunctionsInfo[$i][2])
		MsgBox(0,$FunctionsLocation[$i][0],$FunctionsInfo[$i][3])
		MsgBox(0,$FunctionsLocation[$i][0],$FunctionsInfo[$i][4])
		MsgBox(0,$FunctionsLocation[$i][0],$FunctionsInfo[$i][5])
		MsgBox(0,$FunctionsLocation[$i][0],$FunctionsInfo[$i][6])
	Next
#ce




