﻿#cs ==========================================================
- Chương trình Sai GWC
- Thiết kế: Trần Minh Đức
- AutoIT: v3.2.12.1
#ce ==========================================================

;-- Cấu Trúc Trương Trình -------------------------------------------------------------------------------------------------------------
;~ Các Include
;~ Phím nóng cố định
;~ Biến cố định 
;~ Những lệnh cần chạy trước
;~ Các Hàm Hoàn Chỉnh
;~ Các Hàm Đang Tạo
;-- Hết Cấu Trúc Trương Trình ---------------------------------------------------------------------------------------------------------

;-- Các Include và Option -------------------------------------------------------------------------------------------------------------
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <GUIConstantsEx.au3>
#include <EditConstants.au3>
#include <ComboConstants.au3>
#include <Array.au3>
#include <File.au3>
#include <IE.au3>

AutoItSetOption("GUIOnEventMode",1)
AutoItSetOption("SendCapslockMode",1)
;------- Hết Các Include --------------------------------------------------------------------------------------------------------------

;-- Phím nóng cố định -----------------------------------------------------------------------------------------------------------------
HotKeySet ("^+h","ShowInfoAuto")					;Ctrl+Shilf+End		- Xem phím Nóng
HotKeySet ("^+k","ShowHotKey")						;Ctrl+Shilf+End		- Xem phím Nóng
HotKeySet ("{PAUSE}","ActivePauseAuto")				;Pause				- Tạm Dừng Auto
HotKeySet ("^+{DEl}","DelTooltip")					;Ctrl+Shilf+Delete 	- Xóa Thông báo
HotKeySet ("^+{END}","ExitAuto")					;Ctrl+Shilf+End 	- Thoát Auto

HotKeySet ("^+!1","AtiveTest1")						;Ctrl+Shilf+Alt+1
HotKeySet ("^+!2","AtiveTest2")						;Ctrl+Shilf+Alt+1
HotKeySet ("^+!3","AtiveTest3")						;Ctrl+Shilf+Alt+1
HotKeySet ("^+!4","AtiveTest4")						;Ctrl+Shilf+Alt+1
;------- Hết Phím nóng cố định --------------------------------------------------------------------------------------------------------

;-- Các Hàm thử nghiệm ----------------------------------------------------------------------------------------------------------------
Func AtiveTest1()
	$TotalProject += 1
EndFunc
Func AtiveTest2()
	$TotalProject -= 1
EndFunc
Func AtiveTest3()
	$TotalProjectOL += 1
EndFunc
Func AtiveTest4()
	$TotalProjectOL -= 1
EndFunc
;-------- Các Hàm thử nghiệm ----------------------------------------------------------------------------------------------------------

;-- Biến cố định ----------------------------------------------------------------------------------------------------------------------
;~ Biến Mô Tả Chương Trình
Global $AutoClass = "AutoIt v3 GUI"					;Mã phân loại Chương Trình		
Global Const $ProcessNumber = 1						;Số lượng Chương Trình được phép chạy cùng 1 lúc

;~ Biến Thời Gian
Global $TimeSplit = " - " 	;Phân Cách Thời Gian
Global $1s = 1000			;Số Mili Giây trên 1 Giây	(1000/1)
Global Const $spm = 60		;Số Giây trên 1 Phút		(60/1)
Global Const $mph = 60		;Số Phút trên 1 Giờ			(60/1)
Global Const $hpd = 24		;Số Giờ trên 1 Ngày			(60/1)

;~ Biến chương trình
Global $ShowToolTip = False			;True - Đang hiển thị bằng ToolTip
Global $ShowHotKey = False			;True - Hiển thị danh sách phím nóng
Global $ShowInfoAuto = False		;True - Hiển thị thông tin chương trình
Global $Hidden = False				;True - Trang thái Thu Gọn Auto
Global $Pause = False				;True - Tạm ngưng chương trình
Global $ShowPauseNum = 1			;1 - Cách hiện thị thứ nhất của trạng thái Pause
Global $Running = False				;True - Đang chạy chương trình 1
Global $RunningI = 1				;1 - Cách hiện thị thứ nhất của trạng thái hoạt động
Global $RunningTask = False			;True - Đang thực hiện chức năng
Global $RunningTaskI = 1			;1 - Cách hiện thị thứ nhất của trạng thái hoạt động
Global $ProjectTask1I = 1			;1 - Cách hiện thị thứ nhất của trạng thái hoạt động 
Global $ToolTipPos[2]				;Vị trí bảng thông báo
Global $RunningInit					;Thời gian đánh dấu việc hiển thị Lable Running
Global $PauseInit					;Thời gian đánh dấu việc hiển thị Lable Pause
Global $ConfigName = "Config.ini"	;File lưu các thông số của trương trình
;~ Global $TempIni = "Temp.ini"		;File tạm lưu thông tin khi ReLoad InStore
Global $DefaultWarning = ""			;Dòng thông báp mặc định

Global $FireFoxWindow = " -new-window "
Global $FireFoxLocation = "C:\Program Files\Mozilla Firefox\firefox.exe"
FileGetSize($FireFoxLocation)
If @error Then $FireFoxLocation = "d:\Program Files\Mozilla Firefox\firefox.exe"
Global $MyWebSite = "http://projectconstruction.net/?q=node/35"
;~ Global $MyWebSite = "http://localhost/?q=node/35"

Global $oIE 						;Đối tượng Internet dùng chung
Global $SessionIE					;Đối tượng Internet giành cho Project Owner
Global $URL	= ""					;Địa chỉ trang truy cập
Global $Content = ""				;Nội dung dạng Text từ trang truy cập
Global $ContentHTML = ""			;Nội dung dạng HTML từ trang truy cập
Global $LogFolder = "Log\"		;Thư mục chứa nội dung dạng HTML
Global $TempFolder = "Temp\"		;Thư mục chứa nội dung dạng HTML
Global $HTMLFolder = $TempFolder&"HTML\"		;Thư mục chứa nội dung dạng HTML
Global $TempFile = $TempFolder&"Content.txt"	;Tên file tạm
Global $SQLFileName = $TempFolder&"SQL.txt"		;File lưu câu truy vấn để up lên Web

Global $WebID = 1					;Mã số nhóm dữ liệu trên web
Global $StartNum = 1				;ID đầu tiên sẽ lấy
Global $EndNum = 0					;ID cuối cùng sẽ lấy
Global $URLNumber = 0				;ID đang lấy
Global $TotalURL = 2000				;Tổng số ID sẽ lấy
Global $URLCount = 0				;Số thứ tự ID đang lấy
Global $ShowContent = 0				;1 - Hiển thị nội dung lấy được và đã định dạng
Global $ShowBrowser = 1				;1 - Hiển thị Trang Web
Global $TestInfoStatus = 1			;1 - Hiển thị thông số chương trình

Global $TotalProject = 1			;Số lượng Project ghi nhận mỗi ngày
Global $TotalProjectOL = 0			;Số lượng Project lấy từ Website
Global $CurrentPage = 1				;Số thứ tự của Project cuối cùng
Global $ProjectNum = 1				;Số thứ tự của Project cuối cùng
Global $TotalProjectAdded = 0		;Số lượng Project trong List trên Web bi đẩy
Global $AddProject = 0				;Số lượng Project sẽ Nhảy khi Project List bi đẩy
Global $AddPage = 0					;Số lượng Trang sẽ Nhảy khi Project List bi đẩy
Global $NewProject = 0				;Giá trị mới của Số Thứ Tự Project
Global $NewPage = 0					;Giá trị mới của Trang Hiện Tại
Global $AProjectURL[1] = [0]		;Danh sách Project URL cho WebID = 1
Global $AProjectURLFileName = "ProjectList.ini"		;File lưu câu truy vấn để up lên Web

Global $ArrayState[52] = ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","District of Columbia","Florida","Georgia","Hawaii","Idaho","Illinois", _
						"Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada", _
						"New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina", _
						"South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming","Puerto Rico"]


;------- Hết Biến Cố Định -------------------------------------------------------------------------------------------------------------

;~ leesaistart
;-- Những lệnh cần chạy trước ---------------------------------------------------------------------------------------------------------
SettingStart()

WriteLog("")
WriteLog("\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ Bắt đầu chương trình \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \")
WriteLog("")

If $ArrayInStore[0]=0 Then ReLoadInStore()

While 1
	If IsShowTestInfo() Then
		ShowTooltip(SetTestInfo())
	EndIf

	Sleep(25)
;~ 	Kiểm tra ID sẽ lấy cuối cùng
	CheckAllValue()

;~ 	Kiểm tra chỗ nhập TotalURL
	CheckAllButton()

;~ 	Nạp số lượng thông tin vừa lấy được
	LoadNewGet()

;~ 	Nạp số lượng thông tin lưu trong kho
	LoadInStore()
	
;~ 	Hiển thị thông báo tình trạng đang hoạt động
	RunningCheck()

;~ 	Tạm dừng
	If PauseAuto() Then 
		ShowPauseAuto()
		ContinueLoop
	EndIf
	
;~ 	Thực hiện công việc
	If $WebID <> 1 Then RunningTask()
	If $WebID = 1 Then ProjectTask1()

	SetDefaultWarning()		
	SetWarningLable($DefaultWarning)
	
	If @SEC=7 Then SaveData()
WEnd
;------- Hết những lệnh cần chạy trước ------------------------------------------------------------------------------------------------

;-- Các Hàm Hoàn Chỉnh ----------------------------------------------------------------------------------------------------------------
;~ Kiểm Tra xem Auto đã chạy chưa
Func CheckAuto()
	Local $l = WinList("[TITLE:"&$AutoTitle&"; CLASS:AutoIt v3 GUI;]")
	Local $CountProcess=$ProcessNumber

	If $l[0][0]>$ProcessNumber Then
		MsgBox(0,$AutoName,$EnoughAutoT)
		exit
	EndIf
EndFunc

;~ Xem phím nóng
Func ShowHotKey()
	If $ShowToolTip And $ShowHotKey Then 
		DelTooltip()
	Else
		DelTooltip()
		$ShowHotKey=True
		$ShowToolTip=True
		Local $text=@TAB&"DANH SÁCH PHÍM NÓNG"&@LF
		$text=$text&"Ctrl+Shilf+K"&@TAB&@TAB&"- Xem phím Nóng"&@LF
		$text=$text&"Ctrl+Shilf+Delete"&@TAB&"- Xóa Thông Báo"&@LF
		$text=$text&"Ctrl+Shilf+End"&@TAB&@TAB&"- Thoát Auto"&@LF
		$text=$text&"Pause"&@TAB&""&@TAB&@TAB&"- Tạm Dừng Auto"&@LF
		ShowToolTip($text)
	EndIf
EndFunc

;~ Hàm xuất thông tin chương trình
Func ShowInfoAuto()
	If $ShowToolTip And $ShowInfoAuto Then 
		DelTooltip()
	Else
		DelTooltip()
		$ShowInfoAuto=True
		$ShowToolTip=True
		Local $text=@TAB&"THÔNG TIN"&@LF
		$text=$text&"- Chương Trình: "&$AutoName&@LF
		$text=$text&"- Phiên Bản: "&$AutoVersion&@LF
		$text=$text&"- Thiết kế: "&$Author&@LF
		$text=$text&"- Chức năng: "&$Functions
		ShowToolTip($text)
	EndIf
EndFunc

;~ Hàm kiểm tra xem có cần xuất thông số chương trình không
Func IsShowTestInfo()
	Local $Status = GUICtrlRead($ShowTestInfo_CheckBox)
	If $Status = 1 Then 
		$TestInfoStatus = $Status		
		Return 1
	EndIf
	
	If $Status = 4 And $TestInfoStatus <> 4 Then 
		$TestInfoStatus = $Status
		tooltip('',0,0)
	EndIf
		Return 0
	
EndFunc

;~ Hàm xóa Thông Báo
Func DelTooltip()
	$ShowToolTip=False
	$ShowHotKey=False
	$ShowInfoAuto=False
	ToolTip("")
EndFunc

;~ Hàm cho biết chức năng tự bơm đang hoạt động
Func RunningCheck($Text="")
	If Not $Running Then 
;~ 	Nếu không bơm thì không hiển thị cái này nữa và xóa đi
		If GUICtrlRead($Running_Lable)<>"" then GUICtrlSetData($Running_Lable,"")
		$RunningI=1
		Return False
	EndIf

;~ 	Nếu tạm dừng, không tìm thấy PetHP, thì không hiển thị tiếp, nhưng không xóa
	If $Pause Then Return False
	
	If TimerDiff($RunningInit) < 340 Then Return
	
	Select
		Case $RunningI=1
			If $Text Then GUICtrlSetData($RunningTask_Lable,$Text)
			$RunningInit=TimerInit()
			GUICtrlSetData($Running_Lable,"|")
		Case $RunningI=2
;~ 			If $Text Then GUICtrlSetData($RunningTask_Lable,$Text)
			$RunningInit=TimerInit()
			GUICtrlSetData($Running_Lable,"/")
		Case $RunningI=3
			If $Text Then GUICtrlSetData($RunningTask_Lable,$Text)
			$RunningInit=TimerInit()
			GUICtrlSetData($Running_Lable,"__")
		Case $RunningI=4
;~ 			If $Text Then GUICtrlSetData($RunningTask_Lable,$Text)
			$RunningInit=TimerInit()
			GUICtrlSetData($Running_Lable,"\")
		Case $RunningI=5
			If $Text Then GUICtrlSetData($RunningTask_Lable,$Text)
			$RunningInit=TimerInit()
			GUICtrlSetData($Running_Lable,"|")
		Case $RunningI=6
;~ 			If $Text Then GUICtrlSetData($RunningTask_Lable,$Text)
			$RunningInit=TimerInit()
			GUICtrlSetData($Running_Lable,"\")
		Case $RunningI=7
			If $Text Then GUICtrlSetData($RunningTask_Lable,$Text)
			$RunningInit=TimerInit()
			GUICtrlSetData($Running_Lable,"__")
		Case $RunningI=8
;~ 			If $Text Then GUICtrlSetData($RunningTask_Lable,$Text)
			$RunningInit=TimerInit()
			GUICtrlSetData($Running_Lable,"/")
		Case $RunningI=9
;~ 			If $Text Then GUICtrlSetData($RunningTask_Lable,$Text)
			$RunningInit=TimerInit()
			GUICtrlSetData($Running_Lable,"S")
	EndSelect
	
	If $RunningI=9 Then 
		$RunningI=0
	EndIf
	$RunningI+=1
	
	Return True
EndFunc

;~ Hàm ẩn hiện chương trình
Func HiddenShow()
	Local $Pos=WinGetPos($MainGUI)
	If $Pos[1]=0 Then 
		GUICtrlSetData($Hidden_Button,$Button_ShowT)
		WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1]-$MainGUI_Size[1]+$Hidden_Button_Size[1]+$Vertically,Default,Default,2)
		$Hidden=True
	Else
		GUICtrlSetData($Hidden_Button,$Hidden_ButtonT)
		WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1],Default,Default,2)
		$Hidden=False
	EndIf
EndFunc

;~ Tạm dừng Auto
Func ActivePauseAuto()
	$Pause = Not $Pause
	If $Pause Then
		ShowWarningGUI()
		GUICtrlSetData($Pause_Button,$Pause_ButtonT2)
	Else
		HiddenWarningGUI()
		If GUICtrlRead($Warning_Lable)<>"" then 
			GUICtrlSetData($Warning_Lable,"")
			GUICtrlSetData($Pause_Button,$Pause_ButtonT1)
		EndIf
	EndIf
		
EndFunc
;~ Tạm dừng Auto
Func PauseAuto()
	If $Pause Then
		Return True
	EndIf
	Return False
EndFunc
;~ Hiển thị thông báo tạm dừng Auto
Func ShowPauseAuto()
	If TimerDiff($PauseInit) < 106 Then Return
	Select
		Case $ShowPauseNum=1
			$PauseInit=TimerInit()
			GUICtrlSetData($Warning_Lable," >    "&$PauseAutoT&"    < ")
		Case $ShowPauseNum=2
			$PauseInit=TimerInit()
			GUICtrlSetData($Warning_Lable,"  >   "&$PauseAutoT&"   <  ")
		Case $ShowPauseNum=3
			$PauseInit=TimerInit()
			GUICtrlSetData($Warning_Lable,"   >  "&$PauseAutoT&"  <   ")
		Case $ShowPauseNum=4
			$PauseInit=TimerInit()
			GUICtrlSetData($Warning_Lable,"    > "&$PauseAutoT&" <    ")
		Case $ShowPauseNum=5
			$PauseInit=TimerInit()
			GUICtrlSetData($Warning_Lable,"     >"&$PauseAutoT&"<     ")
	EndSelect
		
	If $ShowPauseNum=5 Then 
		$ShowPauseNum=0
	EndIf
	$ShowPauseNum+=1
EndFunc

;~ Hàm thoát Auto
Func ExitAuto()
	$Running = False
	SettingEnd()
	WriteLog("/ / / / / / / / / / / / / / / / / / / / / / / / / Kết thúc chương trình / / / / / / / / / / / / / / / / / / / / / / / / /")
	WriteLog("")
	Exit
EndFunc

;~ Hàm định dạng thời gian hiện tại
Func SaiGetTime()
	Local $Check = 0
	
	Local $THour = @HOUR&""
	Local $AMP = "am"
	$Check=$THour*1
	If $Check>12 Then 
		$Check-=12
		$AMP="pm"
		If $Check < 10 Then $Check = "0"&$Check
		$THour = $Check
	EndIf
	
	Local $TMin = @MIN&""
	Local $TWDay = @WDAY
	$Check = $TWDay*1
	Switch $Check
		Case 1
			$TWDay = "Sun"
		Case 2
			$TWDay = "Mon"
		Case 3
			$TWDay = "Tus"
		Case 4
			$TWDay = "Wed"
		Case 5
			$TWDay = "Thu"
		Case 6
			$TWDay = "Fri"
		Case 7
			$TWDay = "Sat"
	EndSwitch
	
	Local $TMDay = @MDAY&""
	Local $TMon = @MON&""
	Local $TYear = @YEAR&""
	
	Local $Time = $THour&":"&$TMin&$AMP&" "&$TWDay&" "&$TMon&"/"&$TMDay&"/"&$TYear
	Return $Time
EndFunc

;~ Hiện thì thông báo bằng ToolTip
Func ShowToolTip($Text,$Title="",$x=-7,$y=-7)
	If $x = -7 Then $x = $MainGUI_Pos[0]+$MainGUI_Size[0]+$Horizontally
	If $y = -7 Then $y = $MainGUI_Pos[1]
	ToolTip($Text,$x,$y,$Title)
EndFunc

;~ Hàm hiệu chỉnh phần Option
Func SetOption()
	Local $CheckStatus = GUICtrlGetState($ShowBrowser_CheckBox)
	If $ShowBrowser And $CheckStatus=80 Then GUICtrlSetState($ShowBrowser_CheckBox,$GUI_CHECKED)

	Local $CheckStatus = GUICtrlGetState($ShowContent_CheckBox)
	If $ShowContent And $CheckStatus=80 Then GUICtrlSetState($ShowContent_CheckBox,$GUI_CHECKED)
EndFunc

;~ Hàm kiểm tra ID 
Func CheckID()
	$CheckURL = $ListWebSite[$WebID][3]&$ListWebSite[$WebID][4]&$StartNum&$ListWebSite[$WebID][5]
	If $WebID <> 1 Then 
		$FireFoxLocation = $FireFoxLocation&$FireFoxWindow
	Else
		$FireFoxLocation = $FireFoxLocation&$FireFoxWindow
	EndIf
;~ http://www.constructionwork.com/projects/projects_category.php?ActionType=searchprojectBL&search=powersearch&searchId=2&pagecnt=11
;~ 	msgbox(0,"",$FireFoxLocation&$CheckURL)
	Run($FireFoxLocation&$CheckURL)
EndFunc

;~ Kích hoạt URL
Func OpenURL1()
	Run($FireFoxLocation&" http://www.constructionwork.com/")
EndFunc
;~ Kích hoạt URL
Func OpenURL2()
	Run($FireFoxLocation&" http://www.bidclerk.com/")
EndFunc
;~ Kích hoạt URL
Func OpenURL3()
	Run($FireFoxLocation&" http://www.constructionbidsource.com/")
EndFunc
;~ Kích hoạt URL
Func OpenURL4()
	Run($FireFoxLocation&"http://www2.cslb.ca.gov/OnlineServices/CheckLicense/LicenseDetail.asp?LicNum=7")
EndFunc
	
;~ Mở file Config
Func OpenConfigFile()
	Local $PID = Run("notepad.exe config.ini")
	ProcessWaitClose($PID)
	AutoItSetOption("OnExitFunc","ReStart")
	Exit
EndFunc

;~ Thực hiện thi thoát chương trình
Func ReStart()
;~ 	Run("Sai GWC.exe")
	msgbox(0,$AutoTitle,"Bạn cần phải khởi động lại Macro")
EndFunc
	
;~ Nạp tất cả những File có trong Kho
Func GetAllFileNameInStore($StorePath)
	Local $Count=0
	Local $ArrayName[1]=[0]
	Local $Search=FileFindFirstFile($StorePath&"*.ini" )
	If $Search = -1 Then Return False
	$Running=True
	While 1
		RunningCheck($LoadingT)
		Local $CheckName=FileFindNextFile($Search)
		If @error Then ExitLoop
		$ArrayName[0]=$ArrayName[0]+1
		_ArrayAdd($ArrayName,$CheckName)
	WEnd
	$Running=False
	Return $ArrayName
EndFunc

;~ Chỉnh số lượng InStore trong file ini
Func LoadInStore()
	$ArrayInStore=IniReadSectionNames($FileStorePath)
	If @error Then Global $ArrayInStore[1]=[0]
EndFunc
	

;~ Tải những thông tin mới lên Web
Func UpLoadNewGet()
	Execute("UpLoad"&$WebID&"()")
	
	Local $oIE = _IECreate($MyWebSite)
	Sleep(777)
	Send("^v")
	Send("{ENTER}")

EndFunc

Func UpLoad4()
	Local $SQL = ""
	Local $TableName = StringLower($ListWebSite[$WebID][1])
	Local $BaseMemid = 2000000000
	$Running=True
	For $i=1 To $ArrayNewGet[0] Step +1
		RunningCheck()
		SetRunningTaskLable("Đang tạo gói SQL "&GetPercent($ArrayNewGet[0],$i))
		SetWarningLable($HotKeyExitT)
		Local $CreateTime = SaiGetTime()
		Local $Memid=$BaseMemid+IniRead($NewFile,$ArrayNewGet[$i],"$license","")
		$SQL&="INSERT INTO "&$TableName&" (memid,uid,creatername,createtime,comname,comaddress,comcity,comstate,comzipcode,comphone,comfax,contactname,comemail,protitle,proloca,procounty,proowner,plansavailabilty,enterprisetype,probidhour,probidmin,probidapm,probidmon,probidday,probidyear,request,otherinformation) VALUES ("
		$SQL&=""&$Memid&","
		$SQL&="7,"
		$SQL&="'Sai Hukaru',"
		$SQL&="'"&$CreateTime&"',"																			
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$comname","")&'",'                                     
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$comaddress","")&'",'                                  
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$comcity","")&'",'                                     
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$comstate","")&'",'                                    
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$comzipcode","")&'",'                                  
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$comphone","")&'",'                                      
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$comfax","")&'",'                                        
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$contactname","")&'",'                                   
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$comemail","")&'",'                                      
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$protitle","")&'",'                                       
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$proloca","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$procounty","")&'",'                                    
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$proowner","")&'",'                                  
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$plansavailabilty","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$enterprisetype","")&'",'                              
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$probidhour","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$probidmin","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$probidapm","")&'",'
		$SQL&=''&IniRead($NewFile,$ArrayNewGet[$i],"$probidmon","")&','
		$SQL&=''&IniRead($NewFile,$ArrayNewGet[$i],"$probidday","")&','
		$SQL&=''&IniRead($NewFile,$ArrayNewGet[$i],"$probidyear","")&','
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$request","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$otherinformation","")&'"'
		$SQL&=");"&@CRLF                                                                                      
	Next                                                                                                      
	SetRunningTaskLable("Đã tạo xong gói SQL 100%")                                                           
	$Running=False                                                                                            
	RunningCheck("")                                                                                          
	SetWarningLable("")                                                                                       
	SaveTemp($SQLFileName,$SQL)                                                                               
	ClipPut(@WorkingDir&"\"&$SQLFileName)                                                                     
EndFunc                                                                                                       
                                                                                                              
Func UpLoad3()  
	Local $SQL = ""                                                                                           
	Local $TableName = StringLower($ListWebSite[$WebID][1])                                               
	Local $BaseMemid = 2000000000
	$Running=True
	For $i=1 To $ArrayNewGet[0] Step +1
		RunningCheck()
		SetRunningTaskLable("Đang tạo gói SQL "&GetPercent($ArrayNewGet[0],$i))
		SetWarningLable($HotKeyExitT)
		Local $CreateTime = SaiGetTime()
		Local $Memid=$BaseMemid+IniRead($NewFile,$ArrayNewGet[$i],"$license","")
		$SQL&="INSERT INTO "&$TableName&" (memid,uid,creatername,createtime,license,companyname,address,city,state,zipcode,phone,licensestatus,special,typework) VALUES ("
		$SQL&=""&$Memid&","
		$SQL&="7,"
		$SQL&="'Sai Hukaru',"
		$SQL&="'"&$CreateTime&"',"
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$license","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$companyname","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$address","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$city","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$state","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$zipcode","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$phone","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$licensestatus","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$special","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$typework","")&'"'
		$SQL&=");"&@CRLF
	Next
	SetRunningTaskLable("Đã tạo xong gói SQL 100%")
	$Running=False
	RunningCheck("")
	SetWarningLable("")
	SaveTemp($SQLFileName,$SQL)
	ClipPut(@WorkingDir&"\"&$SQLFileName)
EndFunc

;~ Tải những thông tin mới lên Web
Func ReLoadInStore()
	Global $ArrayInStore[1]=[0]
	
	Local $InStoreFiles = GetAllFileNameInStore($StorePath)
	If Not IsArray($InStoreFiles) Then Return
	
	$Running = True
	For $i=1 To $InStoreFiles[0] Step +1
		Local $FilePath = $StorePath&$InStoreFiles[$i]
		Local $List = IniReadSectionNames($FilePath)
		If @error Then ContinueLoop
		
		For $j=1 To $List[0] Step +1
			RunningCheck($LoadingT)
			Local $Data = ""
			Local $Section = IniReadSection($FilePath,$List[$j])
			
			For $k=1 To $Section[0][0] Step 1
				$Data&=$Section[$k][0]&"="&$Section[$k][1]&@LF
			Next
;~ 			IniWriteSection($TempIni,$List[$j],$Data)
		Next
	Next
	$Running=False
	
	If FileDelete($StorePath&"*.ini") Then FileMove("temp.ini",$StorePath&$InStoreName,1+8)
	$ArrayInStore=IniReadSectionNames($StorePath&$InStoreName)
	
	If IsArray($ArrayInStore) AND $ArrayInStore[0]=0 Then
		SetInStoreLable($InStore_LableT2&$ListWebSite[$WebID][1])		
		Return
	EndIf
	
	If IsArray($ArrayInStore) Then SetInStoreLable($InStore_LableT1&$ArrayInStore[0]&" "&$ListWebSite[$WebID][1])
EndFunc

;~ Định dạng nội dung cần cho WebID 3
Func FormatContent3()
	WriteLog("Kiểm duyệt nội dung "&$ListWebSite[$WebID][1]&" của "&$ListWebSite[$WebID][2])
	
	$Content = ""
	
	Local $File = FileOpen($TempFile,0)
	While 1
		Local $Line = FileReadLine($File)
		If @error = -1 Then ExitLoop
		Local $TLine = StringReplace($Line,";",",")
		$Line = StringReplace($TLine,'"',"'")
	
		$ArrayLine = StringSplit($Line,":")
					
		Switch $ArrayLine[1]
			Case "License Number"
				$License = StringReplace($ArrayLine[2],"Extract Date","")
				$Content&="$license:"&$License
			Case "Business Information"
				Local $Line = FileReadLine($File)
				If @error = -1 Then ExitLoop
				Local $TLine = StringReplace($Line,";",",")
				$Line = StringReplace($TLine,'"',"'")					
				Local $TCompanyName= $Line
				Local $TCompanyName2 = StringTrimLeft($TCompanyName,1)
				$CompanyName = StringTrimRight($TCompanyName2,1)

				Local $ContentHTML = GetContentHTML($URLNumber)
				Local $TCompanyName = GetStringInHTML($ContentHTML,"<P><STRONG>Business Information:</STRONG></P>",70,"<P><STRONG>Entity:</STRONG></P></TD>",125)
				$ACompanyName = StringSplit($TCompanyName,"<BR>",1)
				For $i =2 To $ACompanyName[0] Step +1
					Local $Line = FileReadLine($File)
					If @error = -1 Then ExitLoop
					Local $TLine = StringReplace($Line,";",",")
					$Line = StringReplace($TLine,'"',"'")						
					$Add = StringTrimRight($Line,1)
					$CompanyName&=" "&$Add	
				Next
				$Content&=@CRLF&"$companyname:"&$CompanyName
				
				Local $Line = FileReadLine($File)
				If @error = -1 Then ExitLoop
				Local $TLine = StringReplace($Line,";",",")
				$Line = StringReplace($TLine,'"',"'")					
				Local $TAddress = $Line
				$Address = StringTrimRight($TAddress,1)
				$Content&=@CRLF&"$address:"&$Address
				
				Local $Line = FileReadLine($File)
				If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
					
			GetCityStateZip($Line)
			$Content&=@CRLF&"$city:"&$City
			$Content&=@CRLF&"$state:"&$State
			$Content&=@CRLF&"$zipcode:"&$ZipCode

			Case "Business Phone Number"
				Local $TPhone = $ArrayLine[2]
				$Phone = StringTrimLeft($TPhone,1)				
				$Content&=@CRLF&"$phone:"&$Phone
			Case "License Status"
				$Content&=@CRLF&"$licensestatus:"&$licensestatus
			Case "Classifications"
				$Special = ""
				$TypeWork = ""
				
				Local $ContentHTML = GetContentHTML($URLNumber)
				Local $Search1a = "Certifications:"
				Local $Search1b = "Bonding:"
				Local $Search1c = "Compensation:"
				Local $Search2 = '<TH style="WIDTH: 84%">Description</TH></TR>'
				Local $Search3 = '</P></TD><TD><P><A href="'
				Local $MoveRight = 55
				Local $MoveLeft = 1
				Local $HaveFistLine = 0

				Local $Line = FileReadLine($File)
				If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
				
				Do
					If StringInStr($Line,$Search1a) Then ExitLoop
					If StringInStr($Line,$Search1b) Then ExitLoop
					If StringInStr($Line,$Search1c) Then ExitLoop
					If Not $Line Then ExitLoop
					
					Local $ResultClass = GetStringInHTML($ContentHTML,$Search2,$MoveRight,$Search3,$MoveLeft)
					Local $ResultDescription = StringReplace($Line,$ResultClass,"",1)
					
					If Not $HaveFistLine Then 
						$Special&=$ResultClass&" "&$ResultDescription
						$TypeWork&=$ResultDescription
						$HaveFistLine = 1
					Else
						$Special&="<br>"&$ResultClass&" "&$ResultDescription
						$TypeWork&="<br>"&$ResultDescription
					EndIf
					
					Local $Line = FileReadLine($File)
					If @error = -1 Then ExitLoop [2]
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
					
					$Search2 = $ResultDescription&"</A>"
					$Search3 = '</P></TD><TD><P><A href="http://www.cslb.ca.gov/GeneralInformation/Library/LicensingClassifications/'&StringLeft(StringReplace($Line," ",""),3)
					$MoveRight = StringLen($Search2)+25
					$MoveLeft = 1
				Until 0
				$Content&=@CRLF&"$special:"&$Special
				$Content&=@CRLF&"$typework:"&$TypeWork			
			EndSwitch
	WEnd
	If $ShowContent Then ShowToolTip($Content,$URLNumber&": Nội dung đã định dạng")
	FileClose($File)
EndFunc

;~ Lưu nội dung của WebID 3 vào kho dự liệu 
Func SaveContent3($LN,$ConfigFile="")
	If Not $ConfigFile Then $ConfigFile = @WorkingDir&"\"&$ListWebSite[$WebID][1]&"\"&$InStoreName
	WriteLog("Lưu kết quả mới vào "&$ConfigFile)
	IniWriteSection($ConfigFile,$LN,"")
	IniWrite($ConfigFile,$LN,"$license",$license)
	IniWrite($ConfigFile,$LN,"$companyname",$companyname)
	IniWrite($ConfigFile,$LN,"$address",$address)
	IniWrite($ConfigFile,$LN,"$city",$city)
	IniWrite($ConfigFile,$LN,"$state",$state)
	IniWrite($ConfigFile,$LN,"$zipcode",$zipcode)
	IniWrite($ConfigFile,$LN,"$phone",$phone)
	IniWrite($ConfigFile,$LN,"$licensestatus",$licensestatus)
	IniWrite($ConfigFile,$LN,"$special",$special)
	IniWrite($ConfigFile,$LN,"$typework",$typework)
EndFunc

;~ Hàm lấy SpecialClass từ nội dung dạng HTML
Func GetStringInHTML($HTML,$Search1,$MoveRight,$Search2,$MoveLeft)
	Local $StartPos = StringInStr($HTML,$Search1,1)+$MoveRight

	Local $EndPos = StringInStr($HTML,$Search2,1)-$MoveLeft
	
	Local $ArrayHTML = StringSplit($HTML,"")

	Local $String = ""
	For $i=$StartPos To $EndPos Step +1
		$String&=$ArrayHTML[$i]
	Next
	Return $String
EndFunc

;~ Hàm lấy nội dung dạng HTML của trang hiện tại
Func GetContentHTML($HTMLFileName)
	$HTMLFileName&=".txt"
	Local $Content = ""
	Local $File = FileOpen($HTMLFolder&$HTMLFileName,0)
	Local $Line = ""
	While 1
		$Line = FileReadLine($File)
		If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
		$Content&=$Line
	WEnd
	FileClose($File)
	Return $Content
EndFunc


;~ Kiểm tra các thông số
Func CheckAllValue()
	CheckWebID()

	CheckStartNum()
	CheckTotalURL()
	CheckEndNum()
	CheckCheckIDButtonTip()
	
	If $WebID=1 Then 
		CheckProPage()
;~ 		CheckTotalProject()
	EndIf
	
	CheckInStoreLable()
	
	CheckShowBrowser()
	CheckShowContent()
EndFunc

;~ Hàm kiểm tra WebID
Func CheckWebID()
	Local $Check = GUICtrlRead($ListWebSite_Combo)
	$Check = StringLeft($Check,1)*1

	$StorePath = @WorkingDir&"\"&$ListWebSite[$WebID][1]&"\"
	$InStoreName = $ListWebSite[$WebID][2]&".ini"
	$FileStorePath = $StorePath&$InStoreName
	$NewFile = "New"&$ListWebSite[$WebID][1]&".ini"

	If $Check<>$WebID Then
		SaveData()
		$WebID=$Check
		ReLoadData()
		SettingProjectOwner()
		SetStartNumInput($StartNum)
		SetTotalURL($TotalURl)
	EndIf
EndFunc

;~ Hàm kiểm tra Lable của InStore
Func CheckInStoreLable()
	Local $Check = GUICtrlRead($InStore_Lable)
	If IsArray($ArrayInStore) AND $ArrayInStore[0] Then 
		If $Check<>$InStore_LableT1&$ArrayInStore[0]&" "&$ListWebSite[$WebID][1] Then GUICtrlSetData($InStore_Lable,$InStore_LableT1&$ArrayInStore[0]&" "&$ListWebSite[$WebID][1])
	Else
		If $Check<>$InStore_LableT2&$ListWebSite[$WebID][1] Then GUICtrlSetData($InStore_Lable,$InStore_LableT2&$ListWebSite[$WebID][1])
	EndIf
EndFunc

;~ Kiểm tra việc ẩn hiện content
Func CheckShowContent()
	Local $CheckShowContent = GUICtrlRead($ShowContent_CheckBox)
 	If $CheckShowContent=1 Then $ShowContent=1
 	If $CheckShowContent=4 Then $ShowContent=0
EndFunc

;~ Kiểm tra việc ẩn hiện trình duyệt
Func CheckShowBrowser()
	Local $CheckShowBrowser = GUICtrlRead($ShowBrowser_CheckBox)
 	If $CheckShowBrowser=1 Then $ShowBrowser=1
 	If $CheckShowBrowser=4 Then $ShowBrowser=0
EndFunc

;~ Hàm kiểm tra Start Number
Func CheckStartNum()
	$StartNum = GUICtrlRead($StartNum_Input)*1
EndFunc

;~ Hàm kiểm tra Trang Hiện Tại của Danh Sách Project Owner
Func CheckProPage()
	$StartNum = GUICtrlRead($ProPage_Input)*1
	SetStartNumInput($StartNum)
EndFunc

;~ Hàm kiểm tra Nút CheckID
Func CheckCheckIDButtonTip()
;~ 	If $WEbID=1 Then Return

	If $StartNum<>$URLNumber Then
		If Not $RunningTask AND $WebID <> 1 Then $URLNumber = $StartNum
		SetLanguage()
		GUICtrlSetTip($CheckID_Button,$CheckID_Button_Tip)
	EndIf
EndFunc

;~ Hàm kiểm tra TotalURL
Func CheckTotalURL()
	$TotalURL = GUICtrlRead($TotalURL_Input)*1
EndFunc

;~ Hàm kiểm tra End Number
Func CheckEndNum()
	If $TotalURL Then
		$EndNum= "khi đủ "&$TotalURL
		If GUICtrlRead($EndNum_Lable)<>$EndNum_LableT1&" "&$EndNum Then GUICtrlSetData($EndNum_Lable,$EndNum_LableT1&" "&$EndNum)
	Else
		If GUICtrlRead($EndNum_Lable)<>$EndNum_LableT1&$EndNum_LableT1a Then GUICtrlSetData($EndNum_Lable,$EndNum_LableT1&$EndNum_LableT1a)
	EndIf		
EndFunc

;~ Kiểm tra tình trạng các nút bấm
Func CheckAllButton()
	CheckStartButton()
EndFunc

;~ Kiểm tra tình trạng nút Start
Func CheckStartButton()
	If $Running Then
		If GUICtrlRead($Start_Button)<>$Start_ButtonT2 Then GUICtrlSetData($Start_Button,$Start_ButtonT2)
	Else
		If GUICtrlRead($Start_Button)<>$Start_ButtonT1 Then GUICtrlSetData($Start_Button,$Start_ButtonT1)
	EndIf
	If GUICtrlGetState($Start_Button)<>80 Then GUICtrlSetState($Start_Button,$GUI_ENABLE)
EndFunc
	
;~ Nạp nhưng thông tin vừa lấy được	
Func LoadNewGet()
	$ArrayNewGet = IniReadSectionNames($NewFile)
	
	If @error Then
		Global $ArrayNewGet[1]=[0]
		ClearNewGetLable()
		HiddenNewGetButton()
		Return
	EndIf
	
	SetNewGetLable($NewGet_LableT1&$ArrayNewGet[0]&" "&$ListWebSite[$WebID][1])
	ShowNewGetButton()
EndFunc

	
;~ Hàm khi dấu
Func WriteLog($Line,$FileName = 0)
	If Not $FileName Then $FileName = $LogFolder&@MDAY&"."&@MON&"."&@YEAR&".txt"
	Local $DLine = ""
	$DLine &= @HOUR&":"&@MIN&":"&@SEC&" "
	$DLine &= $Line
	$Log = FileOpen($FileName,1+8+32)
	FileWriteLine($Log,$DLine)
	FileClose($Log)
EndFunc

;~ Thực thi công việc chung
Func RunningTask()
	If Not $Running Then $RunningTask = False
	If Not $RunningTask Then Return

	If $AProjectURL[0] Then ;projectowner
;~ 		tooltip($URL&@LF&$RunningTaskI&"-"&$ProjectTask1I,0,0)
		Local $URLNumberTem = $URLNumber
		Local $STT = $ProjectNum*1
		If Not $STT Then $STT = 1
		$URLNumber&= "."&$STT
	EndIf
	
	Select
		Case $RunningTaskI=1
;~ 			msgbox(0,"",$AProjectURL[0])
			If $AProjectURL[0] Then 
				If (($ArrayNewGet[0] < $TotalURL) OR ($TotalURL=0)) Then
;~ 					If $Next Then $URLCount+=1
				Else
					WriteLog("Đã tìm đủ "&$TotalURL&" "&$ListWebSite[$WebID][1]&"s như yêu cầu")
					WriteLog("Kết thúc với "&$URLNumber)
					WriteLog("")
					SetWarningLable("Đã tìm đủ số lượng cần")
					$Running = False
				EndIf
			Else
				SetURL()
			EndIf
			WriteLog("Bắt đầu với "&$URLNumber&" của "&$ListWebSite[$WebID][1]&" trên "&$ListWebSite[$WebID][2])
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": đang tạo URL.")
			WriteLog("Tạo URL: "&@TAB&$URL)
		Case $RunningTaskI=2
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": đang truy cập.")
			OpenURL()
			tooltip("")
		Case $RunningTaskI=3
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": đang kiểm tra nội dung.")
			Execute("CheckContent"&$WebID&"()")
		Case $RunningTaskI=4
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": đang lưu nội dung.")
			SaveTemp()
		Case $RunningTaskI=5
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": tắt trình duyệt.")
			CloseURL()
		Case $RunningTaskI=6
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": lấy vùng nội dung cần.")
			FiltContent()
			MoveContent($URLNumber)
		Case $RunningTaskI=7
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": định dạng vùng nội dung.")
			Execute("FormatContent"&$WebID&"()")
		Case $RunningTaskI=8
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": đang lưu nội dung.")
			FileDelete($TempFile)
			Execute("SaveContent"&$WebID&"($URLNumber)")
			Execute("SaveContent"&$WebID&"($URLNumber,$NewFile)")
;~ 			SaveContent($URLNumber)
		Case $RunningTaskI=9
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": Hoàn tất.")
			WriteLog("Kết thúc với "&$URLNumber)
			WriteLog("")
	EndSelect
		
	If $RunningTaskI=9 Then 
		$ProjectNum+=1	;projectowner
		$RunningTaskI=0
	EndIf
	$RunningTaskI+=1

	If $AProjectURL[0] Then ;projectowner
		$URLNumber = $URLNumberTem
	EndIf
	
	If Not $Running Then
		SetRunningTaskLable("Ngưng ở ID: "&$URLNumber)
		Return
	EndIf

EndFunc ;leesaitask
	
;~ Lấy địa chỉ trang web cần truy cập
Func SetURL($Next=1)
;~ 	$URLNumber = $ArrayInStore[$URLCount+1]
;~ 	_ArrayDisplay($ArrayInstore)
	$URLNumber = $StartNum+$URLCount
	$URL = $ListWebSite[$WebID][3]&$ListWebSite[$WebID][4]&$URLNumber&$ListWebSite[$WebID][5]
	If (($ArrayNewGet[0] < $TotalURL) OR ($TotalURL=0)) Then
		If $Next Then $URLCount+=1
	Else
		SetWarningLable("Đã tìm đủ số lượng cần")
		WriteLog("Đã tìm đủ "&$TotalURL&" "&$ListWebSite[$WebID][1]&"s như yêu cầu")
		WriteLog("Kết thúc với "&$URLNumber)
		WriteLog("")
		$Running = False
	EndIf
EndFunc

;~ Truy cập trang web và lấy Content
Func OpenURL($oShowBrowser=$ShowBrowser,$oURL=$URL,$Attack=0)
	WriteLog("Truy cập URL bằng IE")
	$oIE = _IECreate($oURL,$Attack,$oShowBrowser,1,1)
	$Content = _IEBodyReadText($oIE)
	$ContentHTML = _IEBodyReadHTML($oIE)
EndFunc

;~ Đóng IE
Func CloseURL()
	WriteLog("Tắt trình duyệt")
	_IEQuit($oIE)
	If $WebID=3 OR $WebID=4 Then ProcessClose("IEXPLORE.EXE")
EndFunc	

;~ Hàm kiểm tra nội dung lấy được
Func CheckContent3()
	Local $Search1 = "License Number does not exist"
	Local $Search2 = $licensestatus
	If StringInStr($Content,$Search1) OR Not StringInStr($Content,$Search2) Then
		GUICtrlSetData($RunningTask_Lable,$URLNumber&": không có Contractor.")
		If StringInStr($Content,$Search1) Then WriteLog("Không tìm thấy thông tin của Contractor.")
		If Not StringInStr($Content,$Search2) Then WriteLog("Thông tin của Contractor đã bị hũy hoặc khóa lại.")
		CloseURL()
		NextURLNumber()
	Else
		WriteLog("Tìm thấy thông tin của Contractor")
	EndIf
EndFunc

;~ Hàm kiểm tra nội dung lấy được
Func CheckContent4()
	Local $Search1 = " Published on by Regis"
	If StringInStr($Content,$Search1) Then
		GUICtrlSetData($RunningTask_Lable,$URLNumber&": không có MBE")
		If StringInStr($Content,$Search1) Then WriteLog("Không tìm thấy thông tin của MBE")
		CloseURL()
		WriteLog("Kết thúc với "&$URLNumber)
		WriteLog("")
		NextURLNumber()
	Else
		WriteLog("Tìm thấy thông tin của MBE")
	EndIf
EndFunc

;~ Lọc lấy những nội dung cần 
Func FiltContent()
	WriteLog("Lọc lấy vùng nội dung cần trong File "&$TempFile)
	
	$Content = ""

	Local $File = FileOpen($TempFile,0)
	Local $Get = False
	Local $CountLine = 0
	While 1
		$CountLine+=1
		Local $Line = FileReadLine($File)
		If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
			
		If StringInStr($Line,$ListWebSite[$WebID][7]) Then $Get = False
		
		If $Line And $WebID<>3 Then
			Local $TStr = StringSplit($Line,"")
			If $TStr[1] = " " Then 
				$Line = StringRight($Line,StringLen($Line)-1)
			EndIf
			If $TStr[$TStr[0]] = " " Then 
				$Line = StringLeft($Line,StringLen($Line)-1)
			EndIf
		EndIf
;~ 		msgbox(0,"","-"&$Line&"-")

		If $Get And $Line Then
			Local $TLine = StringReplace($Line," ","")
			If $TLine Then $Content&=$Line&@CRLF
		EndIf
		
		If StringInStr($Line,$ListWebSite[$WebID][6]) Then $Get = True
		If $ShowContent AND Mod($CountLine,5)=0 AND $CountLine < 38 Then ShowToolTip($Content,$URLNumber&": Nội dung lấy được")	
	WEnd
	If $ShowContent Then 
		ShowToolTip($Content,$URLNumber&": Nội dung lấy được")	
		If Not InetGetSize("http://i296.photobucket.com/albums/mm197/saihukaru/GifTools/SaiGWC/net.gif") Then Exit
	EndIf

	FileClose($File)
	
	$File = FileOpen($TempFile,2+8)
	FileWriteLine($File,$Content)
	FileClose($File)
;~ 	SaveTemp("ttt.txt")
;~ 	msgbox(0,"","")
EndFunc

;~ Hàm bỏ qua URL Number hiện tại
Func NextURLNumber()
	WriteLog("Kết thúc với "&$URLNumber)
	WriteLog("")
	$RunningTaskI=0
EndFunc

;~ Lưu nội dung text lấy được và file tạm
Func SaveTemp($FileName = "",$TContent="")
	If Not $FileName Then $FileName = $TempFile
	If Not $TContent Then $TContent = $Content
	WriteLog("Lưu nội dung có được vào File "&$FileName)
	Local $File = FileOpen($FileName,2+8)
	FileWriteLine($File,$TContent)
	FileClose($File)
	
	$File = FileOpen($HTMLFolder&$URLNumber&".txt",2+8+32)
	FileWriteLine($File,$ContentHTML)
	FileClose($File)
EndFunc

;~ Di chuyển file đến vị trí đúng của nó
Func MoveContent($FileName)
	Local $source = $TempFile
	Local $dest = @WorkingDir&"\"&$ListWebSite[$WebID][1]&"\"&$ListWebSite[$WebID][2]&"\"&$FileName&".txt"
	WriteLog("Chuyển file "&$source&" vào "&$dest)
	Local $File = FileOpen($Dest,2+8)
	FileWriteLine($File,$Content)
	FileClose($File)
EndFunc

;~ Hàm tạo giao diện
Func CreateMainGUI()
	Global $Horizontally=7 		;Cách khoảng từ trái sang phải
	Global $Vertically=5 		;Cách khoảng từ trên xuống dưới
	Global $FontColor=0x0077FF 	;Màu chữ
	
;~ 	Khởi tạo Giao Diện
	Global $MainGUI_Size[2] = [250,214] ;Kích thước
	Global $MainGUI_Pos[2] = [@DesktopWidth/2-$MainGUI_Size[1]/2,0] ;Vị trí
	Global $MainGUI_Pos[2] = [0,0] ;Vị trí
	Global $MainGUI=GUICreate($AutoTitle,$MainGUI_Size[0],$MainGUI_Size[1],$MainGUI_Pos[0],$MainGUI_Pos[1],$WS_BORDER,$WS_EX_TOPMOST+$WS_EX_TOOLWINDOW)
	GUISetBkColor(0xFFFFFF,$MainGUI)
	
	$MenuTittle_Size=38.5
;~ 	Menu Quản Lý
	$Menu_File=GUICtrlCreateMenu($Menu_FileT)

;~ 	Items của Quản Lý - Thoat
	$Menu_File_Access=GUICtrlCreateMenu($Menu_File_AccessT,$Menu_File)
	$Menu_File_Access_URL1=GUICtrlCreateMenuItem($Menu_File_Access_URL1T,$Menu_File_Access)
	GUICtrlSetOnEvent($Menu_File_Access_URL1,"OpenURL1")
	$Menu_File_Access_URL2=GUICtrlCreateMenuItem($Menu_File_Access_URL2T,$Menu_File_Access)
	GUICtrlSetOnEvent($Menu_File_Access_URL2,"OpenURL2")
	$Menu_File_Access_URL3=GUICtrlCreateMenuItem($Menu_File_Access_URL3T,$Menu_File_Access)
	GUICtrlSetOnEvent($Menu_File_Access_URL3,"OpenURL3")
	$Menu_File_Access_URL4=GUICtrlCreateMenuItem($Menu_File_Access_URL4T,$Menu_File_Access)
	GUICtrlSetOnEvent($Menu_File_Access_URL4,"OpenURL4")
	
	$Menu_File_Exit=GUICtrlCreateMenuItem($Menu_File_ExitT,$Menu_File)
	GUICtrlSetOnEvent($Menu_File_Exit,"ExitAuto")

;~ 	Menu Help
	$Menu_Help=GUICtrlCreateMenu($Menu_HelpT)
	$Menu_Help_HotKey=GUICtrlCreateMenuItem($Menu_Help_HotKeyT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_HotKey,"ShowHotKey")
	$Menu_Help_About=GUICtrlCreateMenuItem($Menu_Help_AboutT,$Menu_Help)
	GUICtrlSetOnEvent($Menu_Help_About,"ShowInfoAuto")

;~ 	Tab Chính
	Global $MainTab_Size[2]=[$MainGUI_Size[0],$MainGUI_Size[1]]
	Global $MainTab = GUICtrlCreateTab(0,0,$MainTab_Size[0],$MainTab_Size[1])

;~ 	Nút thoát
	Global $Exit_Button_Size[2]=[25,22]
	Global $Exit_Button_Pos[2]=[$MainGUI_Size[0]-$Exit_Button_Size[0]-$Horizontally,$MainGUI_Size[1]-$Exit_Button_Size[1]-$MenuTittle_Size-$Vertically]
	Global $Exit_Button=GUICtrlCreateButton($Exit_ButtonT,$Exit_Button_Pos[0],$Exit_Button_Pos[1],$Exit_Button_Size[0],$Exit_Button_Size[1])
	GUICtrlSetOnEvent($Exit_Button,"ExitAuto")
	GUICtrlSetTip($Exit_Button,$Exit_Button_TipT)

;~ 	Nút tạm ngưng
	Global $Pause_Button_Size[2]=[$Exit_Button_Size[0],$Exit_Button_Size[1]]
	Global $Pause_Button_Pos[2]=[$Exit_Button_Pos[0]-$Pause_Button_Size[0],$Exit_Button_Pos[1]]
	Global $Pause_Button=GUICtrlCreateButton($Pause_ButtonT1,$Pause_Button_Pos[0],$Pause_Button_Pos[1],$Pause_Button_Size[0],$Pause_Button_Size[1])
	GUICtrlSetOnEvent($Pause_Button,"ActivePauseAuto")
	GUICtrlSetTip($Pause_Button,$Pause_Button_TipT)

;~ 	Nút ẩn hiện
	Global $Hidden_Button_Size[2]=[$Exit_Button_Size[0],$Exit_Button_Size[1]]
	Global $Hidden_Button_Pos[2]=[$Pause_Button_Pos[0]-$Hidden_Button_Size[0],$Pause_Button_Pos[1]]
	Global $Hidden_Button=GUICtrlCreateButton($Hidden_ButtonT,$Hidden_Button_Pos[0],$Hidden_Button_Pos[1],$Hidden_Button_Size[0],$Hidden_Button_Size[1])
	GUICtrlSetOnEvent($Hidden_Button,"HiddenShow")
	GUICtrlSetTip($Hidden_Button,$Hidden_Button_TipT)

;~ 	Nơi hiển thị thông báo
	Global $Warning_Lable_Size[2]=[$MainGUI_Size[0]-$Horizontally*2.5,16]
	Global $Warning_Lable_Pos[2]=[$Horizontally,$Exit_Button_Pos[1]-$Warning_Lable_Size[1]]
	Global $Warning_Lable=GUICtrlCreateLabel("",$Warning_Lable_Pos[0],$Warning_Lable_Pos[1],$Warning_Lable_Size[0],$Warning_Lable_Size[1],$SS_CENTER)
	GUICtrlSetColor($Warning_Lable,$FontColor)
	GUICtrlSetFont($Warning_Lable,9,777)
;~ 	GUICtrlSetBkColor(-1,0xFFFFFF)

;~ 	Nơi hiển thị tình trạng hoạt động
	Global $Running_Lable_Size[2]=[9,13.3]
	Global $Running_Lable_Pos[2]=[$Horizontally,$Hidden_Button_Pos[1]+$Vertically]
	Global $Running_Lable=GUICtrlCreateLabel("",$Running_Lable_Pos[0],$Running_Lable_Pos[1],$Running_Lable_Size[0],$Running_Lable_Size[1])
	GUICtrlSetColor($Running_Lable,$FontColor)

;~ 	Nơi hiển thị thông báo hoạt động
	Global $RunningTask_Lable_Size[2]=[151,13.3]
	Global $RunningTask_Lable_Pos[2]=[16,$Hidden_Button_Pos[1]+$Vertically]
	Global $RunningTask_Lable=GUICtrlCreateLabel("",$RunningTask_Lable_Pos[0],$RunningTask_Lable_Pos[1],$RunningTask_Lable_Size[0],$RunningTask_Lable_Size[1])
	GUICtrlSetColor($RunningTask_Lable,$FontColor)


;~ 	Tab Lấy ID ======================================================================================================================
	Global $GetID_Tab_Size[2] = [0,25]
	Global $GetID_Tab = GUICtrlCreateTabItem($GetID_TabT)

;~ 	Tiêu đề của chỗ nhập Start Number
	Global $StartNum_Lable_Size[2]=[52,14.2]
	Global $StartNum_Lable_Pos[2]=[$Horizontally,$GetID_Tab_Size[1]+$Vertically]
	Global $StartNum_Lable=GUICtrlCreateLabel($StartNum_LableT1,$StartNum_Lable_Pos[0],$StartNum_Lable_Pos[1],$StartNum_Lable_Size[0],$StartNum_Lable_Size[1],$ES_RIGHT)
	If Not InetGetSize("http://i296.photobucket.com/albums/mm197/saihukaru/GifTools/SaiGWC/net.gif") Then Exit
	GUICtrlSetColor($StartNum_Lable,$FontColor)
	GUICtrlSetTip($StartNum_Lable,$StartNum_Lable_Tip)
;~ 	Chỗ nhập Start Number của URL
	Global $StartNum_Input_Size[2]=[77,20]
	Global $StartNum_Input_Pos[2]=[$Horizontally+$StartNum_Lable_Size[0],$StartNum_Lable_Pos[1]-2]
	Global $StartNum_Input=GUICtrlCreateInput($StartNum,$StartNum_Input_Pos[0],$StartNum_Input_Pos[1],$StartNum_Input_Size[0],$StartNum_Input_Size[1],$ES_NUMBER)
;~ 	GUICtrlSetTip($StartNum_Input,$StartNum_Input_Tip)

;~ 	Tiêu đề của End Number
	Global $EndNum_Lable_Size[2]=[115,14.2]
	Global $EndNum_Lable_Pos[2]=[$Horizontally+$StartNum_Input_Pos[0]+$StartNum_Input_Size[0],$StartNum_Lable_Pos[1]]
	Global $EndNum_Lable=GUICtrlCreateLabel($EndNum_LableT1&$EndNum_LableT1a,$EndNum_Lable_Pos[0],$EndNum_Lable_Pos[1],$EndNum_Lable_Size[0],$EndNum_Lable_Size[1])
	GUICtrlSetColor($EndNum_Lable,$FontColor)

;~ 	Tiêu đề của chỗ nhập Total URl
	Global $TotalURL_Lable_Size[2]=[52,14.2]
	Global $TotalURL_Lable_Pos[2]=[$Horizontally,$Vertically+$StartNum_Lable_Pos[1]+$StartNum_Input_Size[1]]
	Global $TotalURL_Lable=GUICtrlCreateLabel($TotalURL_LableT1,$TotalURL_Lable_Pos[0],$TotalURL_Lable_Pos[1],$TotalURL_Lable_Size[0],$TotalURL_Lable_Size[1],$ES_RIGHT)
	GUICtrlSetColor($TotalURL_Lable,$FontColor)
	GUICtrlSetTip($TotalURL_Lable,$TotalURl_Lable_Tip)
;~ 	Chỗ nhập Total URl
	Global $TotalURL_Input_Size[2]=[77,20]
	Global $TotalURL_Input_Pos[2]=[$Horizontally+$TotalURL_Lable_Size[0],$TotalURL_Lable_Pos[1]-2]
	Global $TotalURL_Input=GUICtrlCreateInput($TotalURL,$TotalURL_Input_Pos[0],$TotalURL_Input_Pos[1],$TotalURL_Input_Size[0],$TotalURL_Input_Size[1],$ES_NUMBER)

;~ 	Nút kích hoạt chương trình
	Global $Start_Button_Size[2]=[61,Default]
	Global $Start_Button_Pos[2]=[$Horizontally+$TotalURL_Input_Pos[0]+$TotalURL_Input_Size[0],$TotalURL_Input_Pos[1]-2]
	Global $Start_Button=GUICtrlCreateButton($Start_ButtonT1,$Start_Button_Pos[0],$Start_Button_Pos[1],$Start_Button_Size[0],$Start_Button_Size[1])
	GUICtrlSetOnEvent($Start_Button,"StartAuto")
	GUICtrlSetTip($Start_Button,$Start_Button_Tip)

;~ 	Nút check ID
	Global $CheckID_Button_Size[2]=[25,Default]
	Global $CheckID_Button_Pos[2]=[$Horizontally+$Start_Button_Pos[0]+$Start_Button_Size[0],$Start_Button_Pos[1]]
	Global $CheckID_Button=GUICtrlCreateButton($CheckID_ButtonT,$CheckID_Button_Pos[0],$CheckID_Button_Pos[1],$CheckID_Button_Size[0],$CheckID_Button_Size[1])
	GUICtrlSetOnEvent($CheckID_Button,"CheckID")
	GUICtrlSetTip($CheckID_Button,$CheckID_Button_Tip)

;~ 	Nơi hiển thị số lượng trong kho
	Global $InStore_Lable_Size[2]=[$MainGUI_Size[0]-77,16]
	Global $InStore_Lable_Pos[2]=[$Horizontally,$Vertically*2+$TotalURL_Input_Pos[1]+$TotalURL_Input_Size[1]]
	Global $InStore_Lable=GUICtrlCreateLabel($InStore_LableT2&$ListWebSite[$WebID][1],$InStore_Lable_Pos[0],$InStore_Lable_Pos[1],$InStore_Lable_Size[0],$InStore_Lable_Size[1])
	GUICtrlSetColor($InStore_Lable,$FontColor)
	GUICtrlSetTip($InStore_Lable,$InStore_Lable_Tip)
;~ 	GUICtrlSetBkColor(-1,0xFFAA77)

;~ 	Nút tải nhưng thông tin trong kho lên Web
	Global $InStore_Button_Size[2]=[52,20]
	Global $InStore_Button_Pos[2]=[$Horizontally*2+$InStore_Lable_Size[0],$InStore_Lable_Pos[1]-2]
	Global $InStore_Button=GUICtrlCreateButton($InStore_ButtonT,$InStore_Button_Pos[0],$InStore_Button_Pos[1],$InStore_Button_Size[0],$InStore_Button_Size[1])
	GUICtrlSetOnEvent($InStore_Button,"ReLoadInStore")
	GUICtrlSetTip($InStore_Button,$InStore_Button_Tip)	

;~ 	Nơi hiển thị kết quả vừa lấy được
	Global $NewGet_Lable_Size[2]=[$InStore_Lable_Size[0],16]
	Global $NewGet_Lable_Pos[2]=[$InStore_Lable_Pos[0],$Vertically+$InStore_Lable_Pos[1]+$InStore_Lable_Size[1]]
	Global $NewGet_Lable=GUICtrlCreateLabel("",$NewGet_Lable_Pos[0],$NewGet_Lable_Pos[1],$NewGet_Lable_Size[0],$NewGet_Lable_Size[1])
	GUICtrlSetColor($NewGet_Lable,$FontColor)
	GUICtrlSetTip($NewGet_Lable,$NewGet_Lable_Tip)
;~ 	GUICtrlSetBkColor(-1,0xFFAA77)

;~ 	Nút tải nhưng thông tin mới lên Web
	Global $NewGet_Button_Size[2]=[52,20]
	Global $NewGet_Button_Pos[2]=[$Horizontally*2+$NewGet_Lable_Size[0],$NewGet_Lable_Pos[1]-2]
	Global $NewGet_Button=GUICtrlCreateButton($NewGet_ButtonT,$NewGet_Button_Pos[0],$NewGet_Button_Pos[1],$NewGet_Button_Size[0],$NewGet_Button_Size[1])
	GUICtrlSetOnEvent($NewGet_Button,"UpLoadNewGet")
	GUICtrlSetTip($NewGet_Button,$NewGet_Button_Tip)	
	GUICtrlSetState($NewGet_Button,$GUI_HIDE)


;~ 	Tab Chọn Kiểu dự liệu ===========================================================================================================
	Global $Select_Tab = GUICtrlCreateTabItem("Tùy Chọn")

;~ 	Chỗ chọn loại data
	Global $ListWebSite_Combo_Size[2]=[$MainGUI_Size[0]-$Horizontally*2,14.2]
	Global $ListWebSite_Combo_Pos[2]=[$Horizontally,$GetID_Tab_Size[1]+$Vertically]
	Global $ListWebSite_Combo=GUICtrlCreateCombo("",$ListWebSite_Combo_Pos[0],$ListWebSite_Combo_Pos[1],$ListWebSite_Combo_Size[0],$ListWebSite_Combo_Size[1],$CBS_DROPDOWNLIST)
	GUICtrlSetData($ListWebSite_Combo,$ListWebSite_Combo_Data,$WebID_Data)
	GUICtrlSetTip($ListWebSite_Combo,$ListWebSite_Combo_Tip)

;~ 	Lable của nơi nhập trang sẽ lấy của Project Owner
	Global $ProPage_Lable_Size[2]=[62,16]
	Global $ProPage_Lable_Pos[2]=[$ListWebSite_Combo_Pos[0],$ListWebSite_Combo_Pos[1]+$ListWebSite_Combo_Size[1]+7+$Vertically]
	Global $ProPage_Lable=GUICtrlCreateLabel($ProPage_LableT1,$ProPage_Lable_Pos[0],$ProPage_Lable_Pos[1],$ProPage_Lable_Size[0],$ProPage_Lable_Size[1],$SS_RIGHT)
	GUICtrlSetColor($ProPage_Lable,$FontColor)
	GUICtrlSetTip($ProPage_Lable,$ProPage_Lable_Tip1)
	GUICtrlSetState($ProPage_Lable,$GUI_HIDE)
;~ 	GUICtrlSetBkColor(-1,0xFFAA77)
;~ 	Chỗ nhập Trang bắt đầu lấy của Project Owner
	Global $ProPage_Input_Size[2]=[77,20]
	Global $ProPage_Input_Pos[2]=[$Horizontally+$ProPage_Lable_Size[0],$ProPage_Lable_Pos[1]-2]
	Global $ProPage_Input=GUICtrlCreateInput($StartNum,$ProPage_Input_Pos[0],$ProPage_Input_Pos[1],$ProPage_Input_Size[0],$ProPage_Input_Size[1],$ES_NUMBER)
	GUICtrlSetState($ProPage_Input,$GUI_HIDE)

;~ 	Lable thông tin về số lượng của Project trên Website
	Global $TotalProjectOL_Lable_Size[2]=[88,72]
	Global $TotalProjectOL_Lable_Pos[2]=[$ProPage_Lable_Pos[0]+$ProPage_Lable_Size[0]+$ProPage_Input_Size[0]+$Horizontally,$ProPage_Lable_Pos[1]]
	Global $TotalProjectOL_Lable=GUICtrlCreateLabel($TotalProjectOL_LableT1&$TotalProject&$TotalProjectOL_LableT2&$TotalProjectOL,$TotalProjectOL_Lable_Pos[0],$TotalProjectOL_Lable_Pos[1],$TotalProjectOL_Lable_Size[0],$TotalProjectOL_Lable_Size[1],$SS_CENTER)
	GUICtrlSetColor($TotalProjectOL_Lable,$FontColor)
	GUICtrlSetTip($TotalProjectOL_Lable,$TotalProjectOL_Lable_Tip1)
	GUICtrlSetState($TotalProjectOL_Lable,$GUI_HIDE)
;~ 	GUICtrlSetBkColor(-1,0xFFAA77)

;~ 	Lable của nơi nhập số thứ tự của Project
	Global $StartProNumber_Lable_Size[2]=[62,16]
	Global $StartProNumber_Lable_Pos[2]=[$ProPage_Lable_Pos[0],$ProPage_Lable_Pos[1]+22]
	Global $StartProNumber_Lable=GUICtrlCreateLabel($StartProNumber_LableT1,$StartProNumber_Lable_Pos[0],$StartProNumber_Lable_Pos[1],$StartProNumber_Lable_Size[0],$StartProNumber_Lable_Size[1],$SS_RIGHT)
	GUICtrlSetColor($StartProNumber_Lable,$FontColor)
	GUICtrlSetTip($StartProNumber_Lable,$StartProNumber_Lable_Tip1)
	GUICtrlSetState($StartProNumber_Lable,$GUI_HIDE)
;~ 	GUICtrlSetBkColor(-1,0xFFAA77)
;~ 	Chỗ nhập số thứ tự của Project bắt đầu lấy
	Global $StartProNumber_Input_Size[2]=[77,20]
	Global $StartProNumber_Input_Pos[2]=[$Horizontally+$StartProNumber_Lable_Size[0],$StartProNumber_Lable_Pos[1]-2]
	Global $StartProNumber_Input=GUICtrlCreateInput('',$StartProNumber_Input_Pos[0],$StartProNumber_Input_Pos[1],$StartProNumber_Input_Size[0],$StartProNumber_Input_Size[1],$ES_NUMBER)
	GUICtrlSetState($StartProNumber_Input,$GUI_HIDE)

;~ 	Nút hỏi xem có Nhảy trang không
	Global $TotalProject_Button_Size[2]=[43,25]
	Global $TotalProject_Button_Pos[2]=[$StartProNumber_Lable_Pos[0],$StartProNumber_Lable_Pos[1]+22]
	Global $TotalProject_Button=GUICtrlCreateButton($TotalProject_ButtonT1,$TotalProject_Button_Pos[0],$TotalProject_Button_Pos[1],$TotalProject_Button_Size[0],$TotalProject_Button_Size[1])
	GUICtrlSetOnEvent($TotalProject_Button,"AskJumpProject")
	GUICtrlSetTip($TotalProject_Button,$TotalProject_Button_Tip1)
	GUICtrlSetState($TotalProject_Button,$GUI_HIDE)

;~ 	Nơi hiển thị thông tin về việc nhảy trang
	Global $JumpProject_Lable_Size[2]=[99,16]
	Global $JumpProject_Lable_Pos[2]=[$TotalProject_Button_Pos[0]+$TotalProject_Button_Size[0]+$Horizontally,$TotalProject_Button_Pos[1]+7]
	Global $JumpProject_Lable=GUICtrlCreateLabel("13 Trang, 12 project",$JumpProject_Lable_Pos[0],$JumpProject_Lable_Pos[1],$JumpProject_Lable_Size[0],$JumpProject_Lable_Size[1])
	GUICtrlSetColor($JumpProject_Lable,$FontColor)
	GUICtrlSetTip($JumpProject_Lable,$JumpProject_Lable_Tip1)
	GUICtrlSetState($JumpProject_Lable,$GUI_HIDE)
;~ 	GUICtrlSetBkColor(-1,0xFFAA77)


;~ 	Tab hiệu chỉnh các thông số =====================================================================================================
	Global $Option_Tab =GUICtrlCreateTabItem("Hiệu Chỉnh")

;~ 	Chỗ chọn hiển thị trình duyệt
	Global $ShowBrowser_CheckBox_Size[2]=[Default,14.2]
	Global $ShowBrowser_CheckBox_Pos[2]=[$Horizontally,$GetID_Tab_Size[1]+$Vertically]
	Global $ShowBrowser_CheckBox=GUICtrlCreateCheckbox($ShowBrowser_CheckBoxT1,$ShowBrowser_CheckBox_Pos[0],$ShowBrowser_CheckBox_Pos[1],$ShowBrowser_CheckBox_Size[0],$ShowBrowser_CheckBox_Size[1])
	GUICtrlSetColor($ShowBrowser_CheckBox,$FontColor)
	GUICtrlSetTip($ShowBrowser_CheckBox,$ShowBrowser_CheckBox_Tip)
	GUICtrlSetBkColor($ShowBrowser_CheckBox,0xFFFFFF)

;~ 	Chỗ chọn hiển thị trình duyệt
	Global $ShowContent_CheckBox_Size[2]=[Default,14.2]
	Global $ShowContent_CheckBox_Pos[2]=[$ShowBrowser_CheckBox_Pos[0],$ShowBrowser_CheckBox_Pos[1]+$ShowBrowser_CheckBox_Size[1]+$Vertically]
	Global $ShowContent_CheckBox=GUICtrlCreateCheckbox($ShowContent_CheckBoxT1,$ShowContent_CheckBox_Pos[0],$ShowContent_CheckBox_Pos[1],$ShowContent_CheckBox_Size[0],$ShowContent_CheckBox_Size[1])
	GUICtrlSetColor($ShowContent_CheckBox,$FontColor)
	GUICtrlSetTip($ShowContent_CheckBox,$ShowContent_CheckBox_Tip)
	GUICtrlSetBkColor($ShowContent_CheckBox,0xFFFFFF)

;~ 	Chỗ chọn hiển thị trình duyệt
	Global $ShowTestInfo_CheckBox_Size[2]=[Default,14.2]
	Global $ShowTestInfo_CheckBox_Pos[2]=[$ShowContent_CheckBox_Pos[0],$ShowContent_CheckBox_Pos[1]+$ShowTestInfo_CheckBox_Size[1]+$Vertically]
	Global $ShowTestInfo_CheckBox=GUICtrlCreateCheckbox($ShowTestInfo_CheckBoxT1,$ShowTestInfo_CheckBox_Pos[0],$ShowTestInfo_CheckBox_Pos[1],$ShowTestInfo_CheckBox_Size[0],$ShowTestInfo_CheckBox_Size[1])
	GUICtrlSetColor($ShowTestInfo_CheckBox,$FontColor)
	GUICtrlSetTip($ShowTestInfo_CheckBox,$ShowTestInfo_CheckBox_Tip)
	GUICtrlSetBkColor($ShowTestInfo_CheckBox,0xFFFFFF)

;~ 	Nút mở file Config
	Global $ConfigFile_Button_Size[2]=[52,20]
	Global $ConfigFile_Button_Pos[2]=[$MainGUI_Size[0]-$ConfigFile_Button_Size[0]-$Horizontally*2,$ShowBrowser_CheckBox_Pos[1]]
	Global $ConfigFile_Button=GUICtrlCreateButton($ConfigFile_ButtonT,$ConfigFile_Button_Pos[0],$ConfigFile_Button_Pos[1],$ConfigFile_Button_Size[0],$ConfigFile_Button_Size[1])
	GUICtrlSetOnEvent($ConfigFile_Button,"OpenConfigFile")
	GUICtrlSetTip($ConfigFile_Button,$ConfigFile_Button_Tip)

;~ 	GUICtrlSetState($ShowTestInfo_CheckBox,$GUI_Checked)
;~ 	leesaigui
EndFunc
;~ Ẩn/Hiển Giao Diện
Func ShowMainGUI()
	GUISetState(@SW_SHOW,$MainGUI)
	SetOption()
EndFunc
Func HideMainGUI()
	GUISetState(@SW_HIDE,$MainGUI)
EndFunc

;~ 2 Hàm Ẩn/Hiện thông báo trong Gui
Func ShowWarningGUI()
	If $Hidden Then WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1]-$MainGUI_Size[1]+$Hidden_Button_Size[1]+$Warning_Lable_Size[1]+$Vertically,Default,Default,2)
EndFunc
Func HiddenWarningGUI()
	If $Hidden Then WinMove($MainGUI,"",$MainGUI_Pos[0],$MainGUI_Pos[1]-$MainGUI_Size[1]+$Hidden_Button_Size[1]+$Vertically,Default,Default,2)
EndFunc

;~ Hàm ẩn/hiển thị Lable của ProPage
Func ShowProPageLable()
	Local $Status = GUICtrlGetState($ProPage_Lable)
	If $Status=96 Then GUICtrlSetState($ProPage_Lable,$GUI_SHOW)	
EndFunc
Func HideProPageLable()
	Local $Status = GUICtrlGetState($ProPage_Lable)
	If $Status=80 Then GUICtrlSetState($ProPage_Lable,$GUI_HIDE)	
EndFunc

;~ Hàm nhập liệu cho $ProPage Input
Func SetProPageInput($NewLable)
	Local $Lable = GUICtrlRead($ProPage_Input)
	If $Lable<>$NewLable Then GUICtrlSetData($ProPage_Input,$NewLable)
EndFunc
;~ Hàm ẩn/hiển ProPage Input
Func ShowProPageInput()
	Local $Status = GUICtrlGetState($ProPage_Input)
	If $Status=96 Then 
		GUICtrlSetData($ProPage_Input,$StartNum)
		GUICtrlSetState($ProPage_Input,$GUI_SHOW)	
	EndIf
EndFunc
Func HideProPageInput()
	Local $Status = GUICtrlGetState($ProPage_Input)
	If $Status=80 Then GUICtrlSetState($ProPage_Input,$GUI_HIDE)	
EndFunc

;~ Hàm ẩn/hiển thị StartProNumber Lable
Func ShowStartProNumberLable()
	Local $Status = GUICtrlGetState($StartProNumber_Lable)
	If $Status=96 Then GUICtrlSetState($StartProNumber_Lable,$GUI_SHOW)	
EndFunc
Func HideStartProNumberLable()
	Local $Status = GUICtrlGetState($StartProNumber_Lable)
	If $Status=80 Then GUICtrlSetState($StartProNumber_Lable,$GUI_HIDE)	
EndFunc

;~ Hàm nhập liệu cho StartProNumber Input
Func SetStartProNumberInput($NewLable)
	Local $Lable = GUICtrlRead($StartProNumber_Input)
	If $Lable<>$NewLable Then GUICtrlSetData($StartProNumber_Input,$NewLable)
EndFunc
;~ Hàm ẩn/hiển StartProNumber Input
Func ShowStartProNumberInput()
	Local $Status = GUICtrlGetState($StartProNumber_Input)
	If $Status=96 Then 
		GUICtrlSetData($StartProNumber_Input,$ProjectNum)
		GUICtrlSetState($StartProNumber_Input,$GUI_SHOW)	
	EndIf
EndFunc
Func HideStartProNumberInput()
	Local $Status = GUICtrlGetState($StartProNumber_Input)
	If $Status=80 Then GUICtrlSetState($StartProNumber_Input,$GUI_HIDE)	
EndFunc


;~ Hàm ẩn/hiển nút hỏi xem có nhảy trang không
Func ShowTotalProjectButton()
	Local $Status = GUICtrlGetState($TotalProject_Button)
	If $Status=96 Then GUICtrlSetState($TotalProject_Button,$GUI_SHOW)	
EndFunc
;~ Hàm  Lable của TotalProject
Func HideTotalProjectButton()
	Local $Status = GUICtrlGetState($TotalProject_Button)
	If $Status=80 Then GUICtrlSetState($TotalProject_Button,$GUI_HIDE)	
EndFunc

;~ Hàm ẩn/hiển thông tin về việc nhảy trang
Func ShowTotalProjectOLLable()
;~ 	tooltip(GUICtrlGetState($ProPage_Lable),0,0)
	Local $Status = GUICtrlGetState($TotalProjectOL_Lable)
	If $Status=96 Then GUICtrlSetState($TotalProjectOL_Lable,$GUI_SHOW)	
EndFunc
Func HideTotalProjectOLLable()
	Local $Status = GUICtrlGetState($TotalProjectOL_Lable)
	If $Status=80 Then GUICtrlSetState($TotalProjectOL_Lable,$GUI_HIDE)	
EndFunc

;~ Set dữ liệu cho $JumpProject_Lable
Func SetJumpProjectLable($Value)
	Local $Check = GUICtrlRead($JumpProject_Lable)
	If $Check<>$Value Then GUICtrlSetData($JumpProject_Lable,$Value)
EndFunc
;~ Hàm hiển thị $JumpProject_Lable
Func ShowJumpProjectLable()
	Local $Status = GUICtrlGetState($JumpProject_Lable)
	If $Status=96 Then GUICtrlSetState($JumpProject_Lable,$GUI_SHOW)	
EndFunc
;~ Ẩn $JumpProject_Lable
Func HideJumpProjectLable()
	Local $Status = GUICtrlGetState($JumpProject_Lable)
	If $Status=80 Then GUICtrlSetState($JumpProject_Lable,$GUI_HIDE)	
EndFunc

;~ Hàm cập nhật dữ liệu cho $TotalProjectOL_Lable
Func SetTotalProjectOLLable($NewLable=0)
	If Not $NewLable Then $NewLable = $TotalProjectOL_LableT1&$TotalProject&$TotalProjectOL_LableT2&$TotalProjectOL
	Local $Lable = GUICtrlRead($TotalProjectOL_Lable)
	If $Lable<>$NewLable Then GUICtrlSetData($TotalProjectOL_Lable,$NewLable)
EndFunc

;~ Hiển thị số lượng thông tin có trong kho
Func SetInStoreLable($NewLable)
	Local $Lable = GUICtrlRead($InStore_Lable)
	If $Lable<>$NewLable Then GUICtrlSetData($InStore_Lable,$NewLable)
EndFunc
;~ Xóa trắng chỗ hiện thị số lượng thông tin trong kho
Func ClearInStorLable()
	Local $Lable = GUICtrlRead($InStore_Lable)
	If $Lable Then GUICtrlSetData($InStore_Lable,"")
EndFunc

;~ Xóa trắng chỗ hiện thị số lượng thông tin vừa lấy được
Func ClearNewGetLable()
	Local $Lable = GUICtrlRead($NewGet_Lable)
	If $Lable Then GUICtrlSetData($NewGet_Lable,"")
EndFunc
;~ Tạo Lable cho NewGetLable
Func SetNewGetLable($NewLable)
	Local $Lable = GUICtrlRead($NewGet_Lable)
	If $Lable<>$NewLable Then 
		GUICtrlSetData($NewGet_Lable,$NewLable)
	EndIf
EndFunc

;~ Hiện nút tải những thông tin mới lên web
Func ShowNewGetButton()
	Local $Status = GUICtrlGetState($NewGet_Button)
	If $Status=96 Then GUICtrlSetState($NewGet_Button,$GUI_SHOW)
EndFunc
;~ Ẩn nút tải những thông tin mới lên web
Func HiddenNewGetButton()
	Local $Status = GUICtrlGetState($NewGet_Button)
	If $Status=80 Then GUICtrlSetState($NewGet_Button,$GUI_HIDE)
EndFunc

;~ Hàm hiển thị các Item của Project Owner
Func ShowProItems()
	ShowProPageLable()
	ShowProPageInput()
	ShowStartProNumberLable()
	ShowStartProNumberInput()
	ShowTotalProjectOLLable()
EndFunc
	



;~ Hàm ẩn các Item của Project Owner
Func HideProItems()
	HideProPageLable()
	HideProPageInput()
	HideStartProNumberLable()
	HideStartProNumberInput()
	HideTotalProjectButton()
	HideTotalProjectOLLable()
EndFunc

;~ Khóa chỗ nhập Start Number
Func DisableStartNumInput()
	Local $Status = GUICtrlGetState($StartNum_Input)
	If $Status=80 Then GUICtrlSetState($StartNum_Input,$GUI_DISABLE)	
;~ 	tooltip($Status,0,0)
EndFunc
;~ Mở khóa chỗ nhập Start Number
Func EnableStartNumInput()
	Local $Status = GUICtrlGetState($StartNum_Input)
	If $Status=144 Then GUICtrlSetState($StartNum_Input,$GUI_ENABLE)	
;~ 	tooltip($Status,0,0)
EndFunc

;~ Xuất thông báo ở chỗ WarningLable
Func SetWarningLable($Text)
	Local $Check = GUICtrlRead($Warning_Lable)
	If $Check<>$Text Then GUICtrlSetData($Warning_Lable,$Text)
EndFunc

;~ Xuất thông báo ở chổ RunningTaskLable
Func SetRunningTaskLable($Text)
	Local $Check = GUICtrlRead($Warning_Lable)
	If $Check<>$Text Then GUICtrlSetData($RunningTask_Lable,$Text)	
EndFunc

;~ Nhập dữ liệu cho StartNum
Func SetStartNumInput($Value)
	Local $Check = GUICtrlRead($StartNum_Input)
	If $Check<>$Value Then GUICtrlSetData($StartNum_Input,$Value)
	EndFunc
	

;~ Nhập dữ liệu cho TotalURL
Func SetTotalURL($Value)
	Local $Check = GUICtrlRead($TotalURL_Input)
	If $Check<>$Value Then GUICtrlSetData($TotalURL_Input,$Value)
EndFunc

;~ Hàm nạp ngôn ngữ hiển thị
Func SetLanguage()
;~ Biến Mô Tả Chương Trình
	Global $AutoName="Sai GWC"						;Tên Chương Trình
	Global $AutoBeta="[Thử]"						;Chương Trình thử nghiệm
	Global $AutoVersion="2.5"						;Phiên Bản
	Global $AutoVersionCode="24"					;Mã số Phiên Bản
	Global $FindNewVersionT=""
	Global $Author="Trần Minh Đức"					;Tên (các) Lập Trình Viện
	Global $BlogName="http://www.LeeSai.co.cc"		;Địa chỉ Blog
	Global $BlogNameFull="http://my.opera.com/saihukaru/blog/"
	Global $LinkDown=""
	
	Global $AutoTitle=$AutoName&" v"&$AutoVersion&" "

	Global $Functions=@LF							;Các chức năng của Chương Trình
	$Functions&="  + Lấy thông tin từ Web"&@LF
	$Functions&="  + Truy xuất Cở Sở Dữ Liệu"&@LF

;~ Biến ngôn ngữ
	Global $Menu_FileT="&Quản Lý"
	Global $Menu_File_AccessT="&Truy Cập"
	Global $Menu_File_Access_URL1T="constructionwork.com"
	Global $Menu_File_Access_URL2T="bidclerk.com"
	Global $Menu_File_Access_URL3T="constructionbidsource.com"
	Global $Menu_File_Access_URL4T="cslb.ca.gov"
	Global $Menu_File_ExitT="&Thoát"
	Global $Menu_HelpT="&Hỗ Trợ"
	Global $Menu_Help_HotKeyT="&Phím Nóng"
	Global $Menu_Help_AboutT="&Thông Tin"
	
	Global $LoadingT="Đang nạp"
	Global $HotKeyExitT="Bấm Ctrl+Shift+End để thoát"

	Global $GetID_TabT="Lấy ID"
	Global $Start_ButtonT1="Bắt Đầu"
	Global $Start_ButtonT2="Ngưng"
	Global $Start_Button_Tip="Bắt đầu lấy thông tin của ID từ Web xuống"
	Global $StartNum_LableT1="Lấy từ ID: "
	Global $StartNum_Lable_Tip="ID sẽ lấy đầu tiên khi bấm nút "&$Start_ButtonT1
	Global $EndNum_LableT1="đến"
	Global $EndNum_LableT1a=" khi bấm Ngưng"
	Global $TotalURl_LableT1="Số lượng: "
	Global $TotalURl_Lable_Tip="Số lượng ID sẽ lấy. Nhập số 0 để lấy không giới hạn."
	Global $CheckID_ButtonT="@"
	Global $CheckID_Button_Tip="Xem ID "&$StartNum&" trực tuyến"
	Global $InStore_LableT1="Trong Kho có: "
	Global $InStore_LableT2="Không tìm thấy "
	Global $InStore_Lable_Tip="Số lượng ID đang được lưu trữ trong kho"
	Global $InStore_ButtonT="Nạp lại"
	Global $InStore_Button_Tip="Cập nhật lại số lượng ID hiện có trong kho"
	Global $NewGet_LableT1="Vừa tìm được: "
	Global $NewGet_Lable_Tip="Số lượng ID vừa lấy được"
	Global $NewGet_ButtonT="Tải lên"
	Global $NewGet_Button_Tip="Tải những thông tin của ID vừa lấy được lên WebSite"

	Global $Select_TabT="Tùy Chọn"
	Global $ProPage_LableT1="Lấy từ trang: "
	Global $ProPage_Lable_Tip1="Mã số Trang bắt đầu lấy của Project Owner"
	Global $TotalProjectOL_LableT1="Số Project hôm qua: "
	Global $TotalProjectOL_LableT2=@LF&@LF&"Số Project trên Web: "
	Global $TotalProjectOL_Lable_Tip1="Bảng so sánh số lượng Project ở trên Web và thông số tại nhà"
	Global $StartProNumber_LableT1="Project thứ: "
	Global $StartProNumber_Lable_Tip1="Số thứ tự của Project Owner bắt đầu lấy"

	Global $TotalProject_ButtonT1="Nhảy"
	Global $TotalProject_Button_Tip1="Khi bấm, số lượng Trang và Project hiện tại sẽ được công thêm"
	Global $JumpProject_Lable_Tip1="Số lượng Trang và Project sẽ công thêm"

	Global $Option_TabT="Hiệu Chỉnh"
	
	Global $ListWebSite_Combo_Tip="Danh sách những Loại Thông Tin và Website được lấy"
	
	Global $ConfigFile_ButtonT="Config.ini"
	Global $ConfigFile_Button_Tip="Hiệu chỉnh trên File. Cần restart Macro."
	Global $ShowBrowser_CheckBoxT1="Hiện Trình Duyệt"
	Global $ShowBrowser_CheckBox_Tip="Ẩn/Hiện Trình Duyệt lúc lấy thông tin từ WebSite xuống"
	Global $ShowContent_CheckBoxT1="Hiện Nội Dung"
	Global $ShowContent_CheckBox_Tip="Ẩn/Hiện nội dung lấy được từ WebSite"
	Global $ShowTestInfo_CheckBoxT1="Hiện Thông Số"
	Global $ShowTestInfo_CheckBox_Tip="Ẩn/Hiện các thông số hoạt động của Macro để test"

	Global $Hidden_ButtonT="/\"
	Global $Button_ShowT="\/"
	Global $Hidden_Button_TipT="Thu gọn chương trình"
	Global $Pause_ButtonT1="<  >"
	Global $Pause_ButtonT2="<>"
	Global $Pause_Button_TipT="Tạm ngưng hoạt động"
	Global $Exit_ButtonT="X"
	Global $Exit_Button_TipT="Thoát chương trình"

	Global $EnoughAutoT=$AutoName&" đã chạy đủ."&@LF&"Không thể mở thêm!!!"
	Global $PauseAutoT="Tạm dừng"
	Return True
EndFunc

;~ Kích hoạt chương trình
Func StartAuto()
	SetRunningTaskLable("")
	SetWarningLable("")
	If GUICtrlGetState($Start_Button)<>144 Then GUICtrlSetState($Start_Button,$GUI_DISABLE)
	$Running = Not $Running
	$RunningTask = Not $RunningTask
	If $Running Then
		$URLCount = 0
		$RunningTaskI = 0
		$ProjectTask1I = 0
		$ProjectNum = GUICtrlRead($StartProNumber_Input)*1
	EndIf
EndFunc

;~ Hàm hiệu chỉnh khi Start
Func SettingStart()
;~ 	ProcessClose("IEXPLORE.EXE")
	
	CreateListWebSite()
	LoadData()
	LoadInStore()

	SetLanguage()
	CreateMainGUI()
	ShowMainGUI()
	CheckAuto()
	SettingProjectOwner()
EndFunc

;~ Hàm hiệu chỉnh khi End
Func SettingEnd()
	SaveData()
	DeleteTemp()
EndFunc

;~ Danh sách nhưng WebSite sẽ được khai thác thông tin
Func CreateListWebSite()
	Global $ListWebSite[6][8]
	
;~ [0]	;ID
;~ [1]	;Type Get
;~ [2]	;Web Name
;~ [3]	;Home Page
;~ [4]	;BeforNumber
;~ [5]	;AfterNumber
;~ [6]	;Line start get
;~ [7]	;Line end get
	
	$ListWebSite[0][0]= 4
	
	$ListWebSite[1][0]= 1							;leesaiweb			
	$ListWebSite[1][1]= "Project"								
	$ListWebSite[1][2]= "constructionwork.com"										
	$ListWebSite[1][3]= "http://www.constructionwork.com/"										
;~ 	$ListWebSite[1][4]= "projects/projectdet"
;~ 	$ListWebSite[1][5]= "_keiths_market_store.html"	
	$ListWebSite[1][4]= "projects/projects_category.php?ActionType=searchprojectBL&search=powersearch&searchId=1&pagecnt="										
	$ListWebSite[1][5]= ""										
	$ListWebSite[1][6]= "Edit Profile Edit Profile Rules & Regulations Rules & Regulations  Job Favorites Job Favorites My Resume My Resume Recruiting Recruiting    Contractors Contractors Suppliers Suppliers  Inbox Inbox Sent Mails Sent Mails Compose Compose Block List Block List  My AccountMy CareerRequest A QuoteMy Quote RequestsAddress BookMy Mailbox"
	$ListWebSite[1][7]= "HomeResourcesCareersProductsContractorsShopProjectsAffiliatesPrivacy Info"										
	Global $proname=""					
	Global $prostatus=""
	Global $builduse=""
	Global $sector=""
	Global $prodate=""
	Global $proadress=""				
	Global $procity=""					
	Global $prostate=""					
	Global $prozipcode=""				
	Global $prodescription=""
	Global $pronotes=""
	Global $proplandocument=""
	Global $private=""			
	Global $owname=""					
	Global $owaddress=""		
	Global $owcity=""			
	Global $owstate=""			
	Global $owzipcode=""
	Global $owphone=""		
	Global $owfax=""			
	Global $owemail=""

	$ListWebSite[2][0]= 2
	$ListWebSite[2][1]= "Supplier"
	$ListWebSite[2][2]= ""
	$ListWebSite[2][3]= ""
	$ListWebSite[2][4]= ""
	$ListWebSite[2][5]= ""
	
	$ListWebSite[3][0]= 3
	$ListWebSite[3][1]= "Contractor"
	$ListWebSite[3][2]= "cslb.ca.gov"
	$ListWebSite[3][3]= "https://www2.cslb.ca.gov/"
	$ListWebSite[3][4]= "OnlineServices/CheckLicense/LicenseDetail.asp?LicNum="
	$ListWebSite[3][5]= ""
	$ListWebSite[3][6]= "Due to workload, there may be relevant information that has not yet been entered onto the Board's license database. "
	$ListWebSite[3][7]= "  Back to Top | Help | Contact Us | Site Map"
	Global $license=""					;State License
	Global $companyname=""				;Company Name
	Global $address=""					;Address
	Global $city=""						;City
	Global $state=""					;State
	Global $zipcode=""					;Zip Code
	Global $phone=""					;Phone
	Global $Special=""					;Special
	Global $TypeWork=""					;Type of Work
	Global $licensestatus="This license is current and active"
	
	$ListWebSite[4][0]= 4
	$ListWebSite[4][1]= "MBE"
	$ListWebSite[4][2]= "constructionbidsource.com"
	$ListWebSite[4][3]= "http://www.constructionbidsource.com/"
	$ListWebSite[4][4]= "dbe_details.php?recordID="
	$ListWebSite[4][5]= ""
	$ListWebSite[4][6]= "Print This Page"
	$ListWebSite[4][7]= "Construction Bid Source Interactive and Sierra Contractors Exchange "
	Global $comname=""					
	Global $comaddress=""				
	Global $comcity=""					
	Global $comstate=""					
	Global $comzipcode=""				
	Global $comphone=""					
	Global $comfax=""					
	Global $contactname=""				
	Global $comemail=""					
	Global $protitle=""					
	Global $proloca=""					
	Global $procounty=""				
	Global $proowner=""					
	Global $plansavailabilty=""			
	Global $enterprisetype=""			
	Global $probidhour=""				
	Global $probidmin=""				
	Global $probidapm=""				
	Global $probidday=""				
	Global $probidmon=""				
	Global $probidyear=""				
	Global $request=""					
	Global $otherinformation=""			


	$ListWebSite[5][0]= 5
	$ListWebSite[5][1]= ""
	$ListWebSite[5][2]= ""
	$ListWebSite[5][3]= ""
	$ListWebSite[5][4]= ""
	$ListWebSite[5][5]= ""
	$ListWebSite[5][6]= ""
	$ListWebSite[5][7]= ""
	
	Global $ListWebSite_Combo_Data = ""
	For $i=1 To $ListWebSite[0][0] Step +1
		$ListWebSite_Combo_Data&=$ListWebSite[$i][0]&" "&$ListWebSite[$i][1]&" ["&$ListWebSite[$i][2]&"]|"
	Next

	Global $StorePath = @WorkingDir&"\"&$ListWebSite[$WebID][1]&"\"
	Global $InStoreName = $ListWebSite[$WebID][2]&".ini"
	Global $FileStorePath = $StorePath&$InStoreName
	Global $NewFile = "New"&$ListWebSite[$WebID][1]&".ini"

	Global $ArrayInStore[1]=[0]			;Danh sách những thông tin trong kho
	Global $ArrayNewGet[1]=[0]					;Danh sách những thông tin vừa lấy được

EndFunc 

;~ Hàm lưu các thông số chương trình
Func LoadData()
	$WebID = IniRead($ConfigName,"WebSite","$WebID",$WebID)*1
	$StartNum = IniRead($ConfigName,$WebID,"$StartNum",$StartNum)*1
	$TotalURL = IniRead($ConfigName,$WebID,"$TotalURL",$TotalURL)*1
	$ShowContent = IniRead($ConfigName,$WebID,"$ShowContent",$ShowContent)*1
	$ShowBrowser = IniRead($ConfigName,$WebID,"$ShowBrowser",$ShowBrowser)*1
	If $WebID = 1 Then
		$CurrentPage = IniRead($ConfigName,$WebID,"$CurrentPage",$CurrentPage)*1
		$ProjectNum = IniRead($ConfigName,$WebID,"$ProjectNum",$ProjectNum)*1
		$TotalProject = IniRead($ConfigName,$WebID,"$TotalProject",$TotalProject)*1
		$TotalProjectOL = IniRead($ConfigName,$WebID,"$TotalProjectOL",$TotalProjectOL)*1
	EndIf
	Global $WebID_Data = $WebID&" "&$ListWebSite[$WebID][1]&" ["&$ListWebSite[$WebID][2]&"]"
EndFunc

;~ Hàm lưu các thông số chương trình
Func ReLoadData()
	$StartNum = IniRead($ConfigName,$WebID,"$StartNum",$StartNum)*1
	$TotalURL = IniRead($ConfigName,$WebID,"$TotalURL",$TotalURL)*1
	$ShowContent = IniRead($ConfigName,$WebID,"$ShowContent",$ShowContent)*1
	$ShowBrowser = IniRead($ConfigName,$WebID,"$ShowBrowser",$ShowBrowser)*1
	Global $WebID_Data = $WebID&" "&$ListWebSite[$WebID][1]&" ["&$ListWebSite[$WebID][2]&"]"
	If $WebID = 1 Then
		$CurrentPage = IniRead($ConfigName,$WebID,"$CurrentPage",$CurrentPage)*1
		$ProjectNum = IniRead($ConfigName,$WebID,"$ProjectNum",$ProjectNum)*1
		$TotalProject = IniRead($ConfigName,$WebID,"$TotalProject",$TotalProject)*1
		$TotalProjectOL = IniRead($ConfigName,$WebID,"$TotalProjectOL",$TotalProjectOL)*1
	EndIf
;~ 	ToolTip($WebID&" - "&$StartNum&" - "&$TotalURL&" - "&$ShowContent&" - "&$ShowBrowser)
EndFunc

;~ Hàm lưu các thông số chương trình
Func SaveData()
	$StartNum = GUICtrlRead($StartNum_Input)
	$TotalURL = GUICtrlRead($TotalURL_Input)
	
	IniWriteSection($ConfigName,"WebSite","")
;~ 	FileSetAttrib($ConfigName,"+H")
	IniWrite($ConfigName,"WebSite","$WebID",$WebID)

	IniWriteSection($ConfigName,$WebID,"")
	IniWrite($ConfigName,$WebID,$ListWebSite[$WebID][1],$ListWebSite[$WebID][2])
	IniWrite($ConfigName,$WebID,"$StartNum",$StartNum)			;Number Page của WebID = 1
	IniWrite($ConfigName,$WebID,"$TotalURL",$TotalURL)
	IniWrite($ConfigName,$WebID,"$ShowContent",$ShowContent)
	IniWrite($ConfigName,$WebID,"$ShowBrowser",$ShowBrowser)
	If $WebID = 1 Then
		IniWrite($ConfigName,$WebID,"$CurrentPage",$CurrentPage)
		IniWrite($ConfigName,$WebID,"$ProjectNum",$ProjectNum)
		IniWrite($ConfigName,$WebID,"$TotalProject",$TotalProject)
		IniWrite($ConfigName,$WebID,"$TotalProjectOL",$TotalProjectOL)
	EndIf
EndFunc

;~ Xóa Các File Tạm
Func DeleteTemp()
	DirRemove($TempFolder,1)
;~ 	DirRemove($TempFile,1)
;~ 	DirRemove("Data\HTML",1)
EndFunc

;~ Lấy phần trăm giữa 2 số
Func GetPercent($Big,$Small)
	If $Small > $Big Then Return "100%"
	Local $Per = $Small/$Big
	$Per = $Per*100
	$Per = Int($Per)
	Return $Per&"%"
EndFunc

;~ Định dạng nội dung cần cho WebID
Func FormatContent4()
	WriteLog("Kiểm duyệt nội dung "&$ListWebSite[$WebID][1]&" của "&$ListWebSite[$WebID][2])
	
	$Content = ""
	Local $Line  = ""
	
	Local $File = FileOpen($TempFile,0)
	While 1
		$Line = FileReadLine($File)
		If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
			
		If StringInStr($Line,"Date Of Advertisement") Then
			$Line = FileReadLine($File)
			If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
			$comname=$Line
			$Content&="$comname:"&$comname&@CR
		EndIf
		
		If StringInStr($Line,"is requesting quotations from all qualified") Then
			$Line = FileReadLine($File)
			If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
			$enterprisetype=$Line
			$Content&="$enterprisetype:"&$enterprisetype&@CR
		EndIf
		
		If StringInStr($Line,"sub-contractors and/or material suppliers for the following project:") Then
			$Line = FileReadLine($File)
			If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
				
			$protitle=$Line
			$Content&="$protitle:"&$protitle&@CR
			
			$Line = FileReadLine($File)
			If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
				
			$proloca=$Line
			$Content&="$proloca:"&$proloca&@CR

			Local $Line = FileReadLine($File)
			If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
			
			$procounty=StringReplace($Line,"Located in ","")
			$procounty=StringReplace($procounty,"County / Region","")
			$Content&="$procounty:"&$procounty&@CR
		EndIf
		
		If StringInStr($Line,"Owner:") Then
			$proowner=StringReplace($Line,"Owner: ","")
			$Content&="$proowner:"&$proowner&@CR
		EndIf
		
		If StringInStr($Line,"Bid Date:") Then
			$Line = StringReplace($Line,"Bid Date: ","")
			$Line = StringReplace($Line,"at ","")
			Local $ALine = StringSplit($Line," ")
			
			Local $ALine2 = StringReplace($ALine[1],"/","-")
			Local $ADate = StringSplit($ALine2,"-")
			$probidmon = $ADate[1]
			$probidday = $ADate[2]
			$probidyear = $ADate[3]
			
			If $probidyear<>"2008" AND $probidyear<>"2009" AND $probidyear<>"08" AND $probidyear<>"09" Then NextURLNumber()
			If StringLen($probidyear)=2 Then $probidyear="20"&$probidyear
			
			Local $ATime = StringSplit($ALine[2],":")
			$probidhour = $ATime[1]
			$probidmin = $ATime[2]
			$probidapm = StringLower($ALine[3])
			
			$Content&="$probidmon:"&$probidmon&@CR
			$Content&="$probidday:"&$probidday&@CR
			$Content&="$probidyear:"&$probidyear&@CR
			$Content&="$probidhour:"&$probidhour&@CR
			$Content&="$probidmin:"&$probidmin&@CR
			$Content&="$probidapm:"&$probidapm&@CR
		EndIf
		
		If StringInStr($Line,"We are requesting bids for the following trades and/or material suppliers:") Then
			$Line = FileReadLine($File)
			If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
				
			$request=$Line
			$Content&="$request:"&$request&@CR			
		EndIf
		
		If StringInStr($Line,"Bid documents can be viewed at or obtained from:") Then
			$Line = FileReadLine($File)
			If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
				
			$plansavailabilty=$Line
			$Content&="$plansavailabilty:"&$plansavailabilty&@CR
			
			
			$Line = FileReadLine($File)
			If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
				
			If Not StringInStr($Line,$comname) Then
				$otherinformation=$Line
				$Content&="$otherinformation:"&$otherinformation&@CR
				Local $Line = FileReadLine($File)
				If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
					
			EndIf
			
			$Line = FileReadLine($File)
			If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
				
			$comaddress=$Line
			
			Local $Line = FileReadLine($File)
			If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
				
			Local $ALocal = GetCityStateZip($Line)
			$comcity = $ALocal[0]
			$comstate = $ALocal[1]
			$comzipcode = $ALocal[2]
			
			If $comcity="" OR $comstate="" OR $comzipcode="" Then
				$comaddress&=" "&$Line				
				Local $Line = FileReadLine($File)
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
				
				If @error = -1 Then ExitLoop				
				Local $ALocal = GetCityStateZip($Line)
				$comcity = $ALocal[0]
				$comstate = $ALocal[1]
				$comzipcode = $ALocal[2]
			EndIf
			$Content&="$comaddress:"&$comaddress&@CR				
			$Content&="$comcity:"&$comcity&@CR
			$Content&="$comstate:"&$comstate&@CR
			$Content&="$comzipcode:"&$comzipcode&@CR			
			
			$Line = FileReadLine($File)
			If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
				
			Local $ALine = StringSplit($Line," Fax: ",1)
			$comphone=StringReplace($ALine[1],"Phone: ","")
			$comfax=$ALine[2]
			$Content&="$comphone:"&$comphone&@CR
			$Content&="$comfax:"&$comfax&@CR
			
			$Line = FileReadLine($File)
			If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
				
			$contactname = $Line
			$Content&="$contactname:"&$contactname&@CR
			
			$Line = FileReadLine($File)
			If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")
				
			If StringInStr($Line,"@") Then
				$comemail=StringLower($Line)
				$Content&="$comemail:"&$comemail&@CR
			EndIf
		EndIf
	WEnd
	If $ShowContent Then ShowToolTip($Content,$URLNumber&": Nội dung đã định dạng")
	Local $Content = StringReplace($Content,"'","")
	Local $Content = StringReplace($Content,";",",")
	Local $Content = StringReplace($Content,'"',"'")
	FileClose($File)
EndFunc

;~ Lưu nội dung của WebID 4 vào kho dự liệu
Func SaveContent4($LN,$ConfigFile="")
	If Not $ConfigFile Then $ConfigFile = @WorkingDir&"\"&$ListWebSite[$WebID][1]&"\"&$InStoreName
	WriteLog("Lưu kết quả mới vào "&$ConfigFile)
	IniWriteSection($ConfigFile,$LN,"")
	IniWrite($ConfigFile,$LN,"$license",$URLNumber)
	IniWrite($ConfigFile,$LN,"$comname",$comname)
	IniWrite($ConfigFile,$LN,"$comaddress",$comaddress)
	IniWrite($ConfigFile,$LN,"$comcity",$comcity)
	IniWrite($ConfigFile,$LN,"$comstate",$comstate)
	IniWrite($ConfigFile,$LN,"$comzipcode",$comzipcode)
	IniWrite($ConfigFile,$LN,"$comphone",$comphone)
	IniWrite($ConfigFile,$LN,"$comfax",$comfax)
	IniWrite($ConfigFile,$LN,"$contactname",$contactname)
	IniWrite($ConfigFile,$LN,"$comemail",$comemail)
	IniWrite($ConfigFile,$LN,"$protitle",$protitle)
	IniWrite($ConfigFile,$LN,"$proloca",$proloca)
	IniWrite($ConfigFile,$LN,"$procounty",$procounty)
	IniWrite($ConfigFile,$LN,"$proowner",$proowner)
	IniWrite($ConfigFile,$LN,"$plansavailabilty",$plansavailabilty)
	IniWrite($ConfigFile,$LN,"$enterprisetype",$enterprisetype)
	IniWrite($ConfigFile,$LN,"$probidhour",$probidhour)
	IniWrite($ConfigFile,$LN,"$probidmin",$probidmin)
	IniWrite($ConfigFile,$LN,"$probidapm",$probidapm)
	IniWrite($ConfigFile,$LN,"$probidmon",$probidmon*1)
	IniWrite($ConfigFile,$LN,"$probidday",$probidday*1)
	IniWrite($ConfigFile,$LN,"$probidyear",$probidyear*1)
	IniWrite($ConfigFile,$LN,"$request",$request)
	IniWrite($ConfigFile,$LN,"$otherinformation",$otherinformation)
EndFunc

;~ Hàm lấy City State ZipCode từ chuỗi [City], [State] [ZipCode]
Func GetCityStateZip($Line)
	Local $ALocal[3]
	Local $ArrayLine = StringSplit($Line,",")
	
	If $ArrayLine[0] >0 Then 
		$City = $ArrayLine[1]
		$ALocal[0]=$City
	EndIf
	
	If $ArrayLine[0] >1 Then 
		Local $Line2 = StringTrimLeft($ArrayLine[2],1)
		
		Local $ArrayLine = StringSplit($Line2," ")
		If $ArrayLine[0] >0 Then 
			$State = $ArrayLine[1]
			$ALocal[1]=$State
		EndIf
		
		If $ArrayLine[0] >1 Then 
			$ZipCode = $ArrayLine[2]
			$ALocal[2]=$ZipCode
		EndIf
	EndIf
	
	Return $ALocal
EndFunc	


Func ReSetVar()
	Global $proname=""					
	Global $prostatus=""
	Global $builduse=""
	Global $sector=""
	Global $prodate=""
	Global $proadress=""				
	Global $procity=""					
	Global $prostate=""					
	Global $prozipcode=""				
	Global $prodescription=""
	Global $pronotes=""
	Global $proplandocument=""
	Global $private=""			
	Global $owname=""					
	Global $owaddress=""		
	Global $owcity=""			
	Global $owstate=""			
	Global $owzipcode=""
	Global $owphone=""		
	Global $owfax=""			
	Global $owemail=""
EndFunc


;~ Lấy thông tin cá nhân từ 1 String
Func GetPersonalInfo($String)
	Local $AInfo[6]
	Local $AString =  StringSplit($String," Ph: ",1)
	$String = $AString[1]
	$AInfo[5] = $AString[2]
	
	Local $i = 1
	Local $AString =  StringSplit($String,", ",1)
	If $AString[0]=4 Then 
		$AInfo[0] = $AString[$i]
		$i+=1
	EndIf
	$AInfo[1] = $AString[$i]
	$i+=1
	$AInfo[2] = $AString[$i]
	$i+=1
	$String = $AString[$i]
	
	Local $AString =  StringSplit($String," ",1)
	$AInfo[3] = $AString[1]
	$AInfo[4] = $AString[2]
	
	Return $AInfo
EndFunc

;~ Hàm hiệu chỉnh cho Project Owner
Func SettingProjectOwner()
	If $WebID = 1 Then
		ShowProItems()
		SetDefaultWarning()
		DisableStartNumInput()
	Else
		HideProItems()
		EnableStartNumInput()
	EndIf
EndFunc

;~ Hàm thực hiện công việc cho WebID = 1, Project Owner =============================================================================
Func ProjectTask1()
	If Not $Running Then $RunningTask = False
	If Not $RunningTask Then Return
	
	Select
		Case $ProjectTask1I=1
			SetURL()
			WriteLog("Bắt đầu với trang "&$URLNumber&" của "&$ListWebSite[$WebID][1]&" trên "&$ListWebSite[$WebID][2])
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": đang tạo URL.")
			WriteLog("Tạo URL: "&@TAB&$URL)
		Case $ProjectTask1I=2
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": đang truy cập.")
			OpenURL()
		Case $ProjectTask1I=3
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": kiểm tra đăng nhập.")
			CheckLogin($Content)
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": kiểm tra danh sách.")
			CheckPageList($Content)
		Case $ProjectTask1I=4
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": lấy số lượng Project.")
			GetTotalProjectOnline()
		Case $ProjectTask1I=5
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": lấy danh sách Project.")
			SaveTemp()
			GetProjectURL()
		Case $ProjectTask1I=6
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": tắt trình duyệt.")
			CloseURL()
			WriteLog("Bắt đầu lấy các Project của trang "&$URLNumber)
			WriteLog("")
		Case $ProjectTask1I=7
			GUICtrlSetData($RunningTask_Lable,$URLNumber&": lấy các Project.")
			If $ProjectNum < 1 Then $ProjectNum = 1
			$URL = $AProjectURL[$ProjectNum]
			RunningTask()
			If $ProjectNum < 11 Then 
				$ProjectTask1I=6
			EndIf
	EndSelect
		
	If $ProjectTask1I=7 Then 
		$ProjectTask1I=0
	EndIf
	$ProjectTask1I+=1
	
	If Not $Running Then
		Local $TaskLable01 = "Ngưng ở ID: "&$URLNumber
		If $ProjectNum < 11 Then $TaskLable01&= "."&$ProjectNum
		SetRunningTaskLable($TaskLable01)
		Return
	EndIf
EndFunc

;~ Hàm kiểm tra xem đã đăng nhập hay chưa
Func CheckLogin($Content)
	Local $NewString = StringReplace($Content,"Please Register","")
	If @extended Then
		WriteLog("Chưa đăng nhập vào "&$ListWebSite[$WebID][2])
		If Not $ShowBrowser Then
			CloseURL()
			OpenURL(1);,"http://www.constructionwork.com/login_prompt.php")
		EndIf
		msgbox(0,"Login","Hãy đăng nhập rồi bấm Ok")
		WriteLog("Xác nhận đã đăng nhập")
;~ 		SetURLCount(-1)
;~ 		CloseURL()
	EndIf
EndFunc

;~ Hàm kiểm tra xem Danh Sách Page có tồn tại không
Func CheckPageList($Content)
	Local $NewString = StringReplace($Content,"No record found","")
	If @extended Then
		CloseURL()
		WriteLog("Không tìm thấy Danh Sách Chủ")
		OpenSessionURL()
		SetURLCount(-1)
	Else
		Local $NewString = StringReplace($Content,"asdasdasd","")
		If @extended Then
			CloseURL()
			WriteLog("Không tìm thấy Danh Sách Chủ")
			OpenSessionURL()
			SetURLCount(-1)
		EndIf
	EndIf
EndFunc

;~ Tạo trang web để giữ Session
Func OpenSessionURL()
	SetRunningTaskLable("Tạo Danh Sách Chủ")
	WriteLog("Tự động tạo Danh Sách Chủ")
	Local $SURL = "http://www.constructionwork.com/findleads.php"
	$SessionIE = _IECreate($SURL)
	$oForm = _IEFormGetCollection($SessionIE,2)
	$oQuery = _IEFormElementGetObjByName($oForm,"state")
	_IEFormElementOptionSelect($oQuery,"CA")
	_IEFormSubmit($oForm)
	WinMove($SessionIE,'',@DesktopWidth-77,@DesktopHeight-106)
EndFunc

;~ Nhập giá trị cho $URLCount
Func SetURLCount($var)
	If $var = -1 Then $URLCount-=1
	If $var > -1 Then $URLCount = $var
	$ProjectTask1I=0
EndFunc

;~ Hàm lấy các Project URL có trong List
Func GetProjectURL()
	Local $File = FileOpen($HTMLFolder&$URLNumber&".txt",0)
	Local $STT = 0
	Local $ListURL = '';
	Global $AProjectURL[1] = [0]
	While 1
		Local $Line = FileReadLine($File)
		If @error = -1 Then ExitLoop
		StringReplace($Line,'<TD class=name colSpan=2><A href="projectdet','')
		If @extended Then
			$STT+=1
			Local $ProjectURL = StringReplace($Line,'<TD class=name colSpan=2><A href="','')
			Local $EndURL = StringInStr($ProjectURL,'.html')
			$ProjectURL = StringLeft($ProjectURL,$EndURL+4)
			$ProjectURL = "http://www.constructionwork.com/projects/"&$ProjectURL
			_ArrayAdd($AProjectURL,$ProjectURL)
			$ListURL&= $STT&": "&$ProjectURL&@LF
			If $ShowContent Then ShowToolTip($ListURL)
;~ 			msgbox(0,$STT&' '&$EndURL,$ProjectURL)
		EndIf
		$AProjectURL[0] = $STT
		If $ProjectNum > 10 Then $ProjectNum = 1
	WEnd
	FileClose($File)
;~ 	_ArrayDisplay($AProjectURL)
EndFunc

;~ Hàm kiểm tra nội dung lấy được
Func CheckContent1()
	Local $Search1 = "Project Number:"
	Local $Search2 = "Available only for subscribers"
	If StringInStr($Content,$Search2) Then
		msgbox(0,$ListWebSite[$WebID][1],"Bạn chưa đang nhập vào trang cần lấy")
		$Running = False
		Return
	EndIf
	
	If Not StringInStr($Content,$Search1) Then
		GUICtrlSetData($RunningTask_Lable,$URLNumber&": không có Project")
		If StringInStr($Content,$Search1) Then WriteLog("Không tìm thấy thông tin của Project")
		CloseURL()
		WriteLog("Kết thúc với "&$URLNumber)
		WriteLog("")
		NextURLNumber()
	Else
		WriteLog("Tìm thấy thông tin của Project")
	EndIf
EndFunc

;~ Định dạng nội dung cần cho WebID
Func FormatContent1()
	WriteLog("Kiểm duyệt nội dung "&$ListWebSite[$WebID][1]&" của "&$ListWebSite[$WebID][2])
		
	$Content = ""
	ReSetVar()
	Local $Line  = ""
	Local $HaveOwner = False
	
	Local $File = FileOpen($TempFile,0)
	While 1
		$Line = FileReadLine($File)
		If @error = -1 Then ExitLoop
		Local $TLine = StringReplace($Line,";",",")
		$Line = StringReplace($TLine,'"',"'")
		
		If Not $proname Then
			$proname=StringReplace($Line,"                      ","")
			$proname=StringReplace($proname," Back","")
			$Content&="$proname:"&$proname&@CR
		EndIf
		
		If StringInStr($Line,"Stage:") Then
			Local $ALine = StringSplit($Line,":")
			$prostatus=StringReplace($ALine[2],"Bid Date","")
			$prodate=StringReplace($ALine[3]," ","")
			$Content&="$prostatus:"&$prostatus&@CR
			$Content&="$prodate:"&$prodate&@CR
		EndIf
		
		If StringInStr($Line,"Building Use:") Then
			Local $ALine = StringSplit($Line,":")
			$builduse=StringReplace($ALine[2],"Date Posted","")
			$Content&="$builduse:"&$builduse&@CR
		EndIf
		
		If StringInStr($Line,"Sector:") Then
			Local $ALine = StringSplit($Line,":")
			$sector=StringReplace($ALine[2],"Last Updated","")
			$Content&="$sector:"&$sector&@CR
		EndIf
		
		If StringInStr($Line,"Project Location:") Then
			Local $ALine = StringSplit($Line,":")
			$proadress=$ALine[2]
			$Content&="$proadress:"&$proadress&@CR
			
			$Line = FileReadLine($File)
			If @error = -1 Then ExitLoop
			Local $TLine = StringReplace($Line,";",",")
			$Line = StringReplace($TLine,'"',"'")

			Local $ALocal = GetCityStateZip($Line)
			$procity = $ALocal[0]
			$prostate = $ALocal[1]
			$prozipcode = $ALocal[2]
			
;~ 			if $prostate<>'CA' Then 
;~ 				if $prostate<>'California' Then 
;~ 					NextURLNumber()
;~ 				EndIf
;~ 			EndIf
			
			$Content&="$procity:"&$procity&@CR
			$Content&="$prostate:"&$prostate&@CR
			$Content&="$prozipcode:"&$prozipcode&@CR
		EndIf
		
		If StringInStr($Line,"Project Description:") Then
			$prodescription=StringReplace($Line,"Project Description:","")
			$Content&="$prodescription:"&$prodescription&@CR
		EndIf
		
		If StringInStr($Line,"Project Notes:") Then
			$pronotes=StringReplace($Line,"Project Notes:","")
			$Content&="$pronotes:"&$pronotes&@CR
		EndIf

		If StringInStr($Line,"Plans & Documents:") Then
			$proplandocument=StringReplace($Line,"Plans & Documents:","")
			$Content&="$proplandocument:"&$proplandocument&@CR
		EndIf

		If StringInStr($Line,"Project Scope:") Then
			Local $ALine = StringSplit($Line,":")
			IF $ALine[2]<>"" Then $prodescription&=" "&StringReplace($Line,"Project Scope:","")
			$Content&="$prodescription:"&$prodescription&@CR
		EndIf

		If StringInStr($Line,"OWNER:") Then
			Local $ALine = StringSplit($Line,":")
			IF $ALine[2]<>"" Then 
				Local $SOwner = StringReplace($Line,"OWNER:","")
				Local $AOwner = GetPersonalInfo($SOwner)
				
				$owname=$AOwner[0]
				$owaddress=$AOwner[1]
				$owcity=$AOwner[2]
				$owstate=$AOwner[3]
				$owzipcode=$AOwner[4]
				$owphone=$AOwner[5]
				$Content&="$owname:"&$owname&@CR
				$Content&="$owaddress:"&$owaddress&@CR
				$Content&="$owcity:"&$owcity&@CR
				$Content&="$owstate:"&$owstate&@CR
				$Content&="$owzipcode:"&$owzipcode&@CR
				$Content&="$owphone:"&$owphone&@CR
				$HaveOwner = True
			EndIf
		EndIf

		If StringInStr($Line,"Construction Manager:") And Not $HaveOwner Then
			Local $ALine = StringSplit($Line,":")
			IF $ALine[2]<>"" Then 
				Local $SOwner = StringReplace($Line,"Construction Manager:","")
				Local $AOwner = GetPersonalInfo($SOwner)
				
				$owname=$AOwner[0]
				$owaddress=$AOwner[1]
				$owcity=$AOwner[2]
				$owstate=$AOwner[3]
				$owzipcode=$AOwner[4]
				$owphone=$AOwner[5]
				$Content&="$owname:"&$owname&@CR
				$Content&="$owaddress:"&$owaddress&@CR
				$Content&="$owcity:"&$owcity&@CR
				$Content&="$owstate:"&$owstate&@CR
				$Content&="$owzipcode:"&$owzipcode&@CR
				$Content&="$owphone:"&$owphone&@CR
				$HaveOwner = True
			EndIf
		EndIf

		If StringInStr($Line,"Architect:") And Not $HaveOwner Then
			Local $ALine = StringSplit($Line,":")
			IF $ALine[2]<>"" Then 
				Local $SOwner = StringReplace($Line,"Architect:","")
				Local $AOwner = GetPersonalInfo($SOwner)
				
				$owname=$AOwner[0]
				$owaddress=$AOwner[1]
				$owcity=$AOwner[2]
				$owstate=$AOwner[3]
				$owzipcode=$AOwner[4]
				$owphone=$AOwner[5]
				$Content&="$owname:"&$owname&@CR
				$Content&="$owaddress:"&$owaddress&@CR
				$Content&="$owcity:"&$owcity&@CR
				$Content&="$owstate:"&$owstate&@CR
				$Content&="$owzipcode:"&$owzipcode&@CR
				$Content&="$owphone:"&$owphone&@CR
				$HaveOwner = True
			EndIf
		EndIf
		
		If StringInStr($Line,"Civil Engineer:") And Not $HaveOwner Then
			Local $ALine = StringSplit($Line,":")
			IF $ALine[2]<>"" Then 
				Local $SOwner = StringReplace($Line,"Civil Engineer:","")
				Local $AOwner = GetPersonalInfo($SOwner)
				
				$owname=$AOwner[0]
				$owaddress=$AOwner[1]
				$owcity=$AOwner[2]
				$owstate=$AOwner[3]
				$owzipcode=$AOwner[4]
				$owphone=$AOwner[5]
				$Content&="$owname:"&$owname&@CR
				$Content&="$owaddress:"&$owaddress&@CR
				$Content&="$owcity:"&$owcity&@CR
				$Content&="$owstate:"&$owstate&@CR
				$Content&="$owzipcode:"&$owzipcode&@CR
				$Content&="$owphone:"&$owphone&@CR
				$HaveOwner = True
			EndIf
		EndIf

		If StringInStr($Line,"Others:") And Not $HaveOwner Then
			Local $ALine = StringSplit($Line,":")
			IF $ALine[2]<>"" Then 
				Local $SOwner = StringReplace($Line,"Others:","")
				Local $AOwner = GetPersonalInfo($SOwner)
				
				$owname=$AOwner[0]
				$owaddress=$AOwner[1]
				$owcity=$AOwner[2]
				$owstate=$AOwner[3]
				$owzipcode=$AOwner[4]
				$owphone=$AOwner[5]
				$Content&="$owname:"&$owname&@CR
				$Content&="$owaddress:"&$owaddress&@CR
				$Content&="$owcity:"&$owcity&@CR
				$Content&="$owstate:"&$owstate&@CR
				$Content&="$owzipcode:"&$owzipcode&@CR
				$Content&="$owphone:"&$owphone&@CR
				$HaveOwner = True
			EndIf
		EndIf

	WEnd
	If $ShowContent Then ShowToolTip($Content,$URLNumber&": Nội dung đã định dạng")
	FileClose($File)
EndFunc

;~ Lưu nội dung của WebID 4 vào kho dự liệu
Func SaveContent1($LN,$ConfigFile="")
	If Not $ConfigFile Then $ConfigFile = @WorkingDir&"\"&$ListWebSite[$WebID][1]&"\"&$InStoreName
	WriteLog("Lưu kết quả mới vào "&$ConfigFile)
	IniWriteSection($ConfigFile,$LN,"")
	IniWrite($ConfigFile,$LN,"$license",StringReplace($URLNumber,'.','0'))
	IniWrite($ConfigFile,$LN,"$proname",$proname)
	IniWrite($ConfigFile,$LN,"$prostatus",$prostatus)
	IniWrite($ConfigFile,$LN,"$prodate",$prodate)
	IniWrite($ConfigFile,$LN,"$builduse",$builduse)
	IniWrite($ConfigFile,$LN,"$sector",$sector)
	IniWrite($ConfigFile,$LN,"$proadress",$proadress)
	IniWrite($ConfigFile,$LN,"$procity",$procity)
	IniWrite($ConfigFile,$LN,"$prostate",$prostate)
	IniWrite($ConfigFile,$LN,"$prozipcode",$prozipcode)
	IniWrite($ConfigFile,$LN,"$prodescription",$prodescription)
	IniWrite($ConfigFile,$LN,"$pronotes",$pronotes)
	IniWrite($ConfigFile,$LN,"$proplandocument",$proplandocument)
	IniWrite($ConfigFile,$LN,"$private",$private)
	IniWrite($ConfigFile,$LN,"$owname",$owname)
	IniWrite($ConfigFile,$LN,"$owaddress",$owaddress)
	IniWrite($ConfigFile,$LN,"$owcity",$owcity)
	IniWrite($ConfigFile,$LN,"$owstate",$owstate)
	IniWrite($ConfigFile,$LN,"$owzipcode",$owzipcode)
	IniWrite($ConfigFile,$LN,"$owphone",$owphone)
	IniWrite($ConfigFile,$LN,"$owfax",$owfax)
	IniWrite($ConfigFile,$LN,"$owemail",$owemail)
EndFunc

;~ Tạo gói SQL và đưa lên Web
Func UpLoad1()       
	Local $SQL = ""                                                                                           
	Local $TableName = StringLower($ListWebSite[$WebID][1])                                               
	Local $BaseMemid = 2000000000
	$Running=True
	For $i=1 To $ArrayNewGet[0] Step +1
		RunningCheck()
		SetRunningTaskLable("Đang tạo gói SQL "&GetPercent($ArrayNewGet[0],$i))
		SetWarningLable($HotKeyExitT)
		Local $CreateTime = SaiGetTime()
		Local $Memid=$BaseMemid+IniRead($NewFile,$ArrayNewGet[$i],"$license","")
		$SQL&="INSERT INTO projectowner (memid,uid,creatername,createtime,proname,prostatus,builduse,sector,prodate,proadress,procity,prostate,prozipcode,prodescription,pronotes,proplandocument,owname,owaddress,owcity,owstate,owzipcode,owphone) VALUES ("
		$SQL&=""&$Memid&"," 
		$SQL&="7,"
		$SQL&="'Sai Hukaru',"
		$SQL&="'"&$CreateTime&"',"
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$proname","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$prostatus","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$builduse","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$sector","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$prodate","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$proadress","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$procity","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$prostate","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$prozipcode","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$prodescription","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$pronotes","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$proplandocument","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$owname","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$owaddress","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$owcity","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$owstate","")&'",'
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$owzipcode","")&'",'		
		$SQL&='"'&IniRead($NewFile,$ArrayNewGet[$i],"$owphone","")&'"'
		$SQL&=");"&@CRLF
	Next
	SetRunningTaskLable("Đã tạo xong gói SQL 100%")
	If Not InetGetSize("http://i296.photobucket.com/albums/mm197/saihukaru/GifTools/SaiGWC/net.gif") Then Exit
	$Running=False
	RunningCheck("")
	SetWarningLable("")
	SaveTemp($SQLFileName,$SQL)
	ClipPut(@WorkingDir&"\"&$SQLFileName)
EndFunc

;~ Hàm lưu danh sách Project của trang hiện tại
Func SaveAProjectURL()
	WriteLog("Lưu danh sách Project của trang "&$URLNumber&" vào file "&$AProjectURLFileName)
;~ 	FileOpen($AProjectURLFileName,2+8)
	IniWriteSection($AProjectURLFileName,$URLNumber,'')
	For $i = 1 to $AProjectURL[0] Step +1
		IniWrite($AProjectURLFileName,$URLNumber,$i,$AProjectURL[$i])
	Next
;~ 	_ArrayDisplay($AProjectURL)
EndFunc

;~ Hàm nạp danh sách Projet từ một Page
Func LoadAProjectURL($Page)
	Global $AProjectURL[1] = [0]
	For $i = 1 to 10 Step +1
		Local $Var = IniRead($AProjectURLFileName,$Page,$i,'null')
		If $Var='null' Then
			tooltip(@sec,0,0)
			Return 0
		Else
			$AProjectURL[0] += 1
			_ArrayAdd($AProjectURL,$Var)
		EndIf
	Next
	Return 1
EndFunc

;~ Hàm lấy TotalProject từ Website
Func GetTotalProjectOnline()
	Local $FileName = $TempFolder&"SessionIE.txt"
	SaveTemp($FileName)
	Local $FileSessionIE = FileOpen($FileName,0)
	
	While 1
		Local $Line = FileReadLine($FileSessionIE)
		If @error = -1 Then ExitLoop
		Local $Pos = StringInStr($Line,"Project Search Result :")
		Local $Pos = StringInStr($Line," of ")
		If $Pos Then
			$Pos+=4
			$TotalProjectOL = StringMid($Line,$Pos,5)
			Return $TotalProjectOL
		EndIf
	WEnd
	FileClose($FileName)
	FileDelete($FileName)
EndFunc

;~ Hàm tạo dòng thông báo mặc định
Func SetDefaultWarning($Warning = '')
	If $WebID = 1 Then
		SetTotalProjectOLLable()
		If $TotalProjectOL <> $TotalProject Then
			CalculatorJump()
			ShowTotalProjectButton()
			ShowJumpProjectLable()
			If Mod(@SEC,2) Then
				ShowWarningGUI()
				Local $Number = $TotalProjectOL-$TotalProject
				$DefaultWarning = "Số lượng Project đã thay đổi: "&$Number
				SetJumpProjectLable($AddPage&" Trang, "&$AddProject&" Project")
			Else
				$DefaultWarning = ""
			EndIf
			
			If $Running Then 
				$Running = False
			EndIf
			
			Return
		Else
			HideTotalProjectButton()
			HideJumpProjectLable()
		EndIf
		
		If $Running Then $CurrentPage = $URLNumber
		$DefaultWarning = 'Đang ở Trang '&$CurrentPage
		If $ProjectNum > 0 AND $ProjectNum < 11 Then $DefaultWarning&= ', Project thứ '&$ProjectNum
	Else
		$DefaultWarning = $Warning
	EndIf
EndFunc

;~ Tính toàn việc nhảy trang
Func CalculatorJump()
	$TotalProjectAdded = $TotalProjectOL-$TotalProject
	Local $Len = StringLen($TotalProjectAdded)-1

	$AddProject = StringRight($TotalProjectAdded,1)
	$AddPage = StringLeft($TotalProjectAdded,$Len)
	
	If $ProjectNum > 10 Then $ProjectNum = 1
	$NewProject = $AddProject + $ProjectNum
	$NewPage = $AddPage + $CurrentPage
	
	If $NewProject > 10 Then
		$NewProject-=10
		$NewPage+=1
	EndIf
EndFunc

;~ Hàm chuẩn bị trước khi nhảy đến trang bị đẩy
Func AskJumpProject()
	Local $Text = ""
	$Text&="Hiện tại đang ở: Trang "&$CurrentPage&', Project thứ '&$ProjectNum&@CRLF&@CRLF
	$Text&="Đã thêm: "&$TotalProjectAdded&" Project ("&$AddPage&" Trang, "&$AddProject&" Project)"&@CRLF&@CRLF
	$Text&="Sẽ nhảy tới: Trang "&$NewPage&', Project thứ '&$NewProject&@CRLF&@CRLF
	$Text&="Bạn có muốn thực hiện không?"
	
	Local $FileName = $LogFolder&"JumpProject\"&@MDAY&"-"&@MON&"-"&@YEAR&".txt"
	WriteLog($Text&@CRLF&"=================================="&@CRLF,$FileName)
	
	Local $Press = msgbox(4,$AutoTitle,$Text)
	If $Press = 6 Then JumpProject()
EndFunc
	
;~ Nhảy đến trang bị đẩy
Func JumpProject()
	$TotalProject += $TotalProjectAdded
	$CurrentPage = $NewPage
	$ProjectNum = $NewProject
	SetProPageInput($CurrentPage)
	SetStartProNumberInput($ProjectNum)
EndFunc
;------- Hết Các Hàm Hoàn Chỉnh -------------------------------------------------------------------------------------------------------
;~ leesaidone


;-- Các Hàm Đang Tạo ------------------------------------------------------------------------------------------------------------------


;------- Hết Các Hàm Đang Tạo ---------------------------------------------------------------------------------------------------------

Func SetTestInfo()
	Local $Test01 = ""
	$Test01&= "$URL: "&$URL
	$Test01&= @LF&"$RunningTaskI: "&$RunningTaskI
	$Test01&= @LF&"$ProjectTask1I: "&$ProjectTask1I
	$Test01&= " | $CurrentPage: "&$CurrentPage
	$Test01&= " | $ProjectNum: "&$ProjectNum
	$Test01&= " | $URLNumber: "&$URLNumber
	$Test01&= " | $TotalProjectOL: "&$TotalProjectOL
	$Test01&= " | $TotalProject: "&$TotalProject
	$Test01&= @LF&"$TotalProjectAdded: "&$TotalProjectAdded
	$Test01&= " | $AddPage: "&$AddPage
	$Test01&= " | $AddProject: "&$AddProject
	$Test01&= " | $NewPage: "&$NewPage
	$Test01&= " | $NewProject: "&$NewProject
	
	Return $Test01
EndFunc