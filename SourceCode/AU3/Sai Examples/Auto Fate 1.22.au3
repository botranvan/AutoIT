;Chương Trình Hỗ Trơ cho Game Fate

#cs == Danh Sách Hàm ================================================================================================================
Func CheckAuto()			;Kiểm Tra xem Auto đã chạy chưa
Func CheckMouse() 			;Lấy thông tin liện quan đến chuột

Func FlashLed($time) 		;Nháy Đèn Led
Func BackupSave() 			;Hàm Lưu file Save
Func LoadBackupSave()		;Hàm Nạp file Save
Func ReadAllFile($FileName) ;Hàm dọc toàn bộ File
Func StringSearchSub($String,$Sub);Hàm tìm Chuỗi
Func ConfigFate()			;Hàm hiệu chính cấu hình Fate

Func StarAuto() 			;Restart Chương Trình
Func SetHotKey()			;Hàm Bật/Tắt phím nóng
Func Loading()				;Kiểm tra trước khi Câu
Func Fishing()				;Câu cá
Func ReFishing()			;Hàm Nhấp Cần Câu
Func FindColor($x,$y,$time=0,$color=3552822);Hàm tìm Nút
Func AutoPause()			;Tạm dừng chương trình
Func MouseCrazy($Pos=$OkButton,$time=7);Lắc lắc chuộc
Func SendPetHome()			;Đưa Thú về Làng
Func CalculatorTime($time)	;Hàm định dạng thời gian
Func SaveResult()			;Save Thông Tin Câu Cá
Func HelpFishing()			;Hướng dẫn câu cá
Func CloseAuto()			;Đóng chương trình

#ce =================================================================================================================================

;== Các hiệu chỉnh trước khi chạy =====================================================================
TraySetState(2)
Opt("SendCapslockMode",0)
;== Hết các hiệu chỉnh trước trước khi chạy ===========================================================

#include <array.au3>

;== Danh Sách Biến Cố Định ==========================================================================================================
	Global $AutoName = "Auto Fate 1.22"	;Tên Chương Trình
	Global $SaveName = "Fishing.txt"	;Tên File sẽ lưu

	Global $FileFateFishing			;File lưu thành tích Câu Cá
	Global $Running = False			;False - Auto chưa nạp xong (Chỉ thay đổi 1 lần)

	;Global $ProcessName = "AutoIt3.exe"		;Dùng khi lập trình
	Global $ProcessName = $AutoName&".exe"	;Dùng khi Xuất Thành EXE
;== Kết Thúc Biến Cố Định ===========================================================================================================
		HotKeySet("+^h"		,"HelpFishing")		;Ctrl+Shift+H 	- Hướng dẫn Câu cá
		HotKeySet("+^k"		,"SetHotKey")		;Ctrl+Shift+K 	- Bật/Tắt Phím Nóng

CheckAuto()
FlashLed(2)
ConfigFate()
StarAuto()

While $Running
	Sleep(77)
WEnd

;Kiểm Tra xem Auto đã chạy chưa
Func CheckAuto()
	$l = ProcessList()
	$CountProcess = 1
	For $i = 1 to $l[0][0] Step 1
		If $l[$i][0]=$ProcessName And $CountProcess=0 then
			MsgBox(0,$AutoName,$AutoName&" đã chạy."&@LF&"Không thể mở thêm!!!")
			Exit
		EndIf
		If $l[$i][0]=$ProcessName then $CountProcess-=1
	Next
	TraySetState(1)
EndFunc

;Lấy thông tin liện quan đến chuột [Ctrl+Shift+M]
Func CheckMouse()
	$Pos = MouseGetPos()
	$Cur = MouseGetCursor()
	$Color = PixelGetColor($Pos[0],$Pos[1])
	ToolTip("Mouse: "&$Pos[0]&"/"&$Pos[1]&" - Color: "&$Color,0,0)
EndFunc

;Nháy Đèn Led
Func FlashLed($time)
	Send("{NUMLOCK off}")
	Send("{CAPSLOCK off}")
	Send("{SCROLLLOCK off}")
	For $i = 0 to $time Step 1
		Send("{NUMLOCK TOGGLE}")
		Send("{CAPSLOCK Toggle}")
		Send("{SCROLLLOCK TOGGLE}")
		Sleep(430)
	Next	
EndFunc

;Hàm Lưu file Save [WIN+8]
Func BackupSave()
	ToolTip("Đã Lưu File",0,0)
	$DirSaveFate = "C:\Documents and Settings\All Users\Application Data\WildTangent\fate\Persistent\Save"
	$DirBackupSave = "Save"
	DirCopy($DirBackupSave,"Backup\Auto\A-"&@MDAY&@MON&"-"&@HOUR&@MIN&"-"&@SEC,1)
	If DirCopy($DirSaveFate,$DirBackupSave,1)=0 Then 
		ToolTip("")
		MsgBox(0,$AutoName,"Không tìm thấy Thư Mục Save của Fate!!!")
	EndIf
EndFunc
	
;Hàm Nạp file Save [WIN+9]
Func LoadBackupSave()
	ToolTip("Đã Nạp File",0,0)
	$DirSaveFate = "C:\Documents and Settings\All Users\Application Data\WildTangent\fate\Persistent\Save"
	$DirBackupSave = "Save"
	DirCopy($DirSaveFate,"Backup\Fate\F-"&@MDAY&@MON&"-"&@HOUR&@MIN&"-"&@SEC,1)
	If DirCopy($DirBackupSave,$DirSaveFate,1)=0 Then 
		ToolTip("")
		MsgBox(0,$AutoName,"Không tìm thấy Thư Mục Save của Auto!!!")
	EndIf
EndFunc

;Hàm dọc toàn bộ File
Func ReadAllFile($FileName,$Mode)
	
	;Tìm file [config.dat]
	$Files = FileFindFirstFile($FileName)
	If $Files=-1 then Return False
	While 1
		$search=FileFindNextFile($Files)
		If @error=1 then Return False
		If $search="config.dat" Then ExitLoop
	WEnd
	
	$CountLine = 1
	$Read = _ArrayCreate(0)
	$File = FileOpen($FileName,$Mode)
	While 1
		 _ArrayAdd($Read,FileReadLine($File,$CountLine))
		If $Read[$CountLine]="" Then 
			FileReadLine($File,$CountLine)
			If @error=-1 Then
				$CountLine-=1
				ExitLoop
			EndIf
		EndIf
		;MsgBox(0,"",$Read[$CountLine])
		$CountLine+=1
	Wend
	FileClose($FileName)
	$Read[0] = $CountLine
	Return $Read
EndFunc

;Hàm tìm Chuỗi
Func StringSearchSub($String,$Sub)
	$StringLen = StringLen($String)
	$SubLen = StringLen($Sub)
	
	For $i = 1 to $StringLen-$SubLen Step 1
		$S=StringMid($String,$i,$SubLen)
		If StringCompare($Sub,$S)=0 then Return $i
	Next
	Return False
EndFunc

;Hàm hiệu chính cấu hình Fate
Func ConfigFate()
	;Kiểm tra Thư Mục Fate
	$DirFate = "C:\Documents and Settings\All Users\Application Data\WildTangent\Fate"
	$s = FileFindFirstFile($DirFate)
	If $s=-1 then
		MsgBox(0,$AutoName,"Không tìm thấy Dữ Liệu của Fate!!!")
		CloseAuto()
	EndIf
	
	;Kiểm Tra File Config.dat
	$ReadConfig = ReadAllFile($DirFate&"\Persistent\config.dat",0)
	If $ReadConfig=False then 
		MsgBox(0,$AutoName,"Không tìm thấy Tập Tin [Config.dat] !!!")
		CloseAuto()
	EndIf
	If $ReadConfig[0]=0 then 
		MsgBox(0,$AutoName,"Tập Tin [Config.dat] rỗng!!!")
		CloseAuto()
	EndIf
	
	;Cập nhật thông số
	$Config = FileOpen($DirFate&"\Persistent\config.dat",2)	
	For $i=1 to $ReadConfig[0] Step 1
		
		If StringSearchSub($ReadConfig[$i],"SCREENWIDTH")<>False Then 
			FileWriteLine($Config,"SCREENWIDTH:800")
			ContinueLoop
		EndIf
		
		If StringSearchSub($ReadConfig[$i],"SCREENHEIGHT")<>False Then 
			FileWriteLine($Config,"SCREENHEIGHT:600")
			ContinueLoop
		EndIf
		
		If StringSearchSub($ReadConfig[$i],"FSAA")<>False Then 
			FileWriteLine($Config,"FSAA:0")
			ContinueLoop
		EndIf
		
		If StringSearchSub($ReadConfig[$i],"SHADOWRESOLUTION")<>False Then 
			FileWriteLine($Config,"SHADOWRESOLUTION:512")
			ContinueLoop
		EndIf
		
		If StringSearchSub($ReadConfig[$i],"PARTICLEDETAIL")<>False Then 
			FileWriteLine($Config,"PARTICLEDETAIL:0")
			ContinueLoop
		EndIf
		
		If StringSearchSub($ReadConfig[$i],"VSYNC")<>False Then 
			FileWriteLine($Config,"VSYNC:0")
			ContinueLoop
		EndIf
		
		If StringSearchSub($ReadConfig[$i],"ANIMATEDFOG")<>False Then 
			FileWriteLine($Config,"ANIMATEDFOG:0")
			ContinueLoop
		EndIf
		
		If StringSearchSub($ReadConfig[$i],"640x460")<>False Then 
			FileWriteLine($Config,"640x460:0")
			ContinueLoop
		EndIf
		
		If StringSearchSub($ReadConfig[$i],"800x600")<>False Then 
			FileWriteLine($Config,"800x600:1")
			ContinueLoop
		EndIf
		
		If StringSearchSub($ReadConfig[$i],"1024x768")<>False Then 
			FileWriteLine($Config,"1024x768:1")
			ContinueLoop
		EndIf
		
		If StringSearchSub($ReadConfig[$i],"1152x864")<>False Then 
			FileWriteLine($Config,"1152x864:0")
			ContinueLoop
		EndIf
		
		If StringSearchSub($ReadConfig[$i],"1280x1024")<>False Then 
			FileWriteLine($Config,"1280x1024:0")
			ContinueLoop
		EndIf
		
		If StringSearchSub($ReadConfig[$i],"1600x1200")<>False Then 
			FileWriteLine($Config,"1600x1200:0")
			ContinueLoop
		EndIf
		
		If StringSearchSub($ReadConfig[$i],"1280x768")<>False Then 
			FileWriteLine($Config,"1280x768:0")
			ContinueLoop
		EndIf
		
		If StringSearchSub($ReadConfig[$i],"1920x1200")<>False Then 
			FileWriteLine($Config,"1920x1200:0")
			ContinueLoop
		EndIf
		FileWriteLine($Config,$ReadConfig[$i])
	Next
	FileClose($Config)
EndFunc

;Reset Chương Trình
Func StarAuto()
	Global $FishPos = _ArrayCreate(0,0)		;Vị trí có Cá
	Global $FindPos = _ArrayCreate(0,0)		;Vị trí Chấm Than
	Global $HookButton = _ArrayCreate(0,0)	;Vị trí nút Hook
	Global $StopButton = _ArrayCreate(0,0)	;Vị tí nút Stop
	Global $HomeButton = _ArrayCreate(0,0)	;Vị trí nút cho Thú về Làng
	Global $OkButton = _ArrayCreate(0,0)	;Vị trí nút Ok cho thú về Làng
	Global $FateSize = _ArrayCreate(0,0)	;Kích thước Fate
	Global $SZone = _ArrayCreate(0,0,0,0)	;Khi vực có Chấm Than
	Global $StarTime = _ArrayCreate(@HOUR,@MIN,@SEC)	;Thời gian câu
	Global $HotKey = False			;False - Không dùng Phím Nóng
	Global $Pause = False			;False - Không dùng Auto
	Global $Fishing = False			;True - Đang câu cá
	Global $FishingAble = False		;True - Có thể câu cá
	Global $Helping = False			;True - Đang xem Hướng dẫn
	Global $PetIsHome = False		;True - Pet đang về Làng
	Global $ReFishing = False		;True - Đang nhấp Cần Câu
	Global $Saving = False			;True - Đang Lưu thành tích
	Global $ShadesColor = 7			;Độ khác biệt màu khi tìm màu
	Global $ColorBite = 15528793	;Màu dấu Chấm Than 11514941
	Global $FateHandle = 0			;Mã số của Fate khi chạy
	Global $FindColor = 0			;Màu cần tìm
	Global $TimeReFishing = 0		;Thời gian bắt đầu khi đếm
	Global $CatchFishs = 0			;Số lượng cá Câu được
	Global $CatchItems = 0			;Số lượng đồ Câu được
	Global $MissFish = 0			;Số lần câu hụt
	Global $Catched = 0				;0 - Chưa bắt được Cá
	Global $TimeStar = TimerInit()	;Thời điểm Bắt đầu tính Thành Tích 
	Global $Running = True			;True - Auto đã nạp xong
	SetHotKey()
	Loading()
	ToolTip("Bấm Ctrl+Shilt+H để xem hướng dẫn",0,0)
EndFunc

;Hàm Bật/Tắt phím nóng
Func SetHotKey()
	;WIN là phím ở giữa Ctrl và Alt
	If $HotKey Then ;Tắt Phím Nóng
		$HotKey=False
		ToolTip("Đã Tắt các Phím Nóng",0,0)
		HotKeySet("+^l")		;Ctrl+Shift+L 	- Lưu các Files Save của Fate lại
		HotKeySet("+^n")		;Ctrl+Shift+N 	- Nạp cách Files Save của Fate đả Lưu
		HotKeySet("+^s")		;Ctrl+Shift+S 	- Lưu kết quả Câu Cá thành File
		HotKeySet("+^m")		;Ctrl+Shift+M 	- Lấy thông tin liên quan đến Chuột (Chỉ dùng khi lập trình)

		HotKeySet("{INS}") 		;Insert - Câu cá
		HotKeySet("{DELETE}")		;Delete - Ngưng Câu Cá (Reset Auto)
		HotKeySet("{PAUSE}")		;Pause	- Tạm dừng Auto
		HotKeySet("{SPACE}")		;Space	- Nhấp Cần Câu
		HotKeySet("{HOME}")		;Home 	- Đưa Thú Nuôi về Làng
		HotKeySet("{END}")		;END 	- Tắc chương trình
	Else ;Bật phím nóng
		$HotKey=True
		ToolTip("Đang bật các Phím Nóng. "&Int(Random(1,16))&"%",0,0)
		;Sleep(347)
		HotKeySet("+^l"		,"BackupSave")		;Ctrl+Shift+L 	- Lưu các Files Save của Fate lại
		HotKeySet("+^n"		,"LoadBackupSave")	;Ctrl+Shift+N 	- Nạp cách Files Save của Fate đả Lưu
		HotKeySet("+^s"		,"SaveResult")		;Ctrl+Shift+S 	- Lưu kết quả Câu Cá thành File
		HotKeySet("+^m"		,"CheckMouse")		;Ctrl+Shift+M 	- Lấy thông tin liên quan đến Chuột (Chỉ dùng khi lập trình)
		
		ToolTip("Đang bật các Phím Nóng. "&Int(Random(25,70))&"%",0,0)
		;Sleep(347)
		
		HotKeySet("{INS}"	,"Fishing") 		;Insert - Câu cá
		HotKeySet("{DELETE}","StarAuto")		;Delete - Ngưng Câu Cá (Reset Auto)
		HotKeySet("{PAUSE}"	,"AutoPause")		;Pause	- Tạm dừng Auto
		HotKeySet("{SPACE}"	,"ReFishing")		;Space	- Nhấp Cần Câu
		HotKeySet("{HOME}"	,"SendPetHome")		;Home 	- Đưa Thú Nuôi về Làng
		HotKeySet("{END}"	,"CloseAuto")		;END 	- Tắc chương trình		
		ToolTip("Đang bật các Phím Nóng. "&Int(Random(77,100))&"%",0,0)
		;Sleep(347)
		ToolTip("Đã Bật các Phím Nóng.",0,0)
		Sleep(77)
	EndIf
EndFunc

;Kiểm tra trước khi Câu
Func Loading()
	;Khởi tạo đèn Led
	Send("{NUMLOCK off}")		;ON - Đang câu cá
	Send("{CAPSLOCK off}")		;ON - Fate đang chạy
	Send("{SCROLLLOCK On}")		;ON - Auto đang chạy
	
	;Tìm Fate
	$l = WinList()
	For $i=0 to $l[0][0] Step 1
		If Mod($i,25)=0 Then Send("{CAPSLOCK TOGGLE}")
		If $l[$i][0] = "FATE" then 
			$FateHandle=$l[$i][1]
		EndIf
	Next
	
	If $FateHandle = 0 then Return False ;Nếu kg tìm thấy Fate thì thoát
	$FateSize = WinGetClientSize($FateHandle)
	
	If $Fishing then Send("{NUMLOCK on}")
	If $FateSize[0] < 600 then WinSetState($FateHandle,"",@SW_MAXIMIZE)	;Nếu Fate bị thu nhỏ thì phóng to Fate
	$FateSize = WinGetClientSize($FateHandle)
	
	;Dựa vào kích thước Fate, xác định vị trí các Nút
	$HookButton[0] = $FateSize[0]/2
	$HookButton[1] = $FateSize[1]/1.42
	$StopButton[0] = $FateSize[0]/2
	$StopButton[1] = $FateSize[0]/1.7
	$FindPos[0] = $FateSize[0]/2-7
	$FindPos[1] = $FateSize[1]/4
	$SZone[0] = $FindPos[0]-25
	$SZone[1] = $FindPos[1]-$FateSize[1]/4
	$SZone[2] = $FindPos[0]+25
	$SZone[3] = $FindPos[1]+$FateSize[1]/5
	$HomeButton[0] = $FateSize[0]/25
	$HomeButton[1] = $FateSize[1]/5.74
	$OkButton[0] = $FateSize[0]/2
	$OkButton[1] = $FateSize[1]/1.303
	$FishingAble = True
	Send("{CAPSLOCK ON}")	
	Return True
EndFunc

;Câu cá [Insert]
Func Fishing()
	If $Running=False then 	Return
	If $Pause then Return
	If $Fishing then Return
	If NOT $FishingAble then Loading()
	If NOT $FishingAble then Return

	;Chuẩn bị trước khi câu
	$StarTime = _ArrayCreate(@HOUR,@MIN,@SEC)	;Thời gian câu
	$TimeStar = TimerInit()
	$Fishing = True
	$FishPos=MouseGetPos()
	ToolTip("Đang câu cá..",0,0)
	Send("{NUMLOCK ON}")
	MouseCrazy()
	
	;Độ Dài và Rộng của dòng chữ thông báo khi câu được Cá -$FateSize[0]/4
	$z = _ArrayCreate($FateSize[0]/2,$FateSize[1]/2.5,$FateSize[0]/2+$FateSize[0]/4,$FateSize[1]/2.5+7)
	Dim $Step = 1
	While $Fishing 
		Send("{NUMLOCK TOGGLE}")
		MouseClick("Left",$FishPos[0]-7,$FishPos[1],2,1)
		MouseMove($HookButton[0],$HookButton[1],1)
			
		Dim $Catched=0
		$TimeReFishing = TimerInit()
		;Đợi dấu Chấm Than xuất hiện
		Send("{NUMLOCK ON}")
		While IsArray($Catched)=0 AND $Fishing
			;MouseMove($SZone[2],$SZone[3],2)
			$Catched = PixelSearch($SZone[0],$SZone[1],$SZone[2],$SZone[3],$ColorBite,$ShadesColor,$Step) ;14536240 vàng
			If IsArray($Catched)=1 then MouseClick("Left",$HookButton[0],$HookButton[1],6,1)		
			;MouseMove($SZone[0],$SZone[1],2)
			If $Fishing=False then Return
			If TimerDiff($TimeReFishing)>43000 then ReFishing() ;Sau 1 khoảng thời gian thì nhấp cần Câu (ReFishing)
		WEnd
		
		;Thu hẹp phạm vi tìm dấu Chấm Than
		$Step = 1
		If IsArray($Catched)=1 Then
			$SZone[0] = $Catched[0]-2
			$SZone[1] = $Catched[1]-5
			$SZone[2] = $Catched[0]+2
			$SZone[3] = $Catched[1]+5
		EndIf
		
		;Tìm nút Ok Lấy Cá
		Dim $Catched = False
		Dim $TimeCatchFish = TimerInit()
		;Tìm nút Ok Lấy Cá trong 1 khoãn thời gian
		Do 
			If FindColor($HookButton[0]+$HookButton[0]/25.6,$HookButton[1]-$FateSize[1]/9,77) then	;Tìm cho đến khi thấy nút 
				If FindColor($HookButton[0]+$HookButton[0]/25.6,$HookButton[1]-$FateSize[1]/9,-1) Then	;Đưa chuột lên nút để xác nhận lại
					;Xác định xem câu được gì
					For $i = 1 to 5 Step 1 
						Send("{NUMLOCK TOGGLE}")
						;Tìm màu Tím trong dòng thông báo
						;MouseMove($z[0],$z[1],2)
						;$Catched = PixelSearch($z[0],$z[1],$z[2],$z[3],11173093,$ShadesColor)
						;MouseMove($z[2],$z[3],2)
						If IsArray(PixelSearch($z[0],$z[1],$z[2],$z[3],11173093,$ShadesColor))=1 then ;Nếu là Cá tăng $CatchFishs lên 1
							$Catched=True
							;SoundPlay(@WindowsDir & "\media\tada.wav",0)
							SoundPlay(@WindowsDir & "\media\notify.wav",0)
							$CatchFishs = $CatchFishs+1
							ExitLoop ;Thoát khỏi vòng lặp For
							
						EndIf
						Sleep(777)
					Next
			
					;Nếu không có màu Tím ở tròng trên cùng tức là câu Được Đồ
					If $Catched=False then ;Nếu là Đồ thì tăng $CatchItens lên 1
						SoundPlay(@WindowsDir&"\media\tada.wav",0)
						$CatchItems = $CatchItems+1
						$Catched=True
					EndIf
							
					;Bấm cho đến khi nút OK lấy Cá mất
					$Click=False
					Do
						Send("{NUMLOCK TOGGLE}")
						If FindColor($HookButton[0]+$HookButton[0]/25.6,$HookButton[1]-$FateSize[1]/9,77) Then
						If FindColor($HookButton[0]+$HookButton[0]/25.6,$HookButton[1]-$FateSize[1]/9,-1) Then
							MouseClick("left",$HookButton[0]+$HookButton[0]/25.6-7,$HookButton[1]-$FateSize[1]/9,1,1)
							$Click=True
						EndIf
						EndIf
						;Sleep(1006)
						If FindColor($HookButton[0]+$HookButton[0]/25.6,$HookButton[1]-$FateSize[1]/9,-1) then $Click=False
					Until $Click
					$Catched=True	
				EndIf
			EndIf
			
			Send("{NUMLOCK TOGGLE}")
			;Kiểm tra để thoát vòng lặp Do
			If TimerDiff($TimeCatchFish) >=7000 Or $Catched<>0 Then ExitLoop
		Until False
		
		;Nếu không tìm thấy thì tăng $MissFish lên 1
		If $Catched=False then
			SoundPlay(@WindowsDir & "\media\ringout.wav",0)
			$MissFish = $MissFish+1		
		EndIf
		
		;Nếu câu được 100 lần thì lưu lại
		If $MissFish+$CatchFishs+$CatchItems>=106 then SaveResult()
	WEnd
	$Fishing = False
EndFunc

;Hàm Nhấp Cần Câu
Func ReFishing()
	If $Running=False then Return
	If $Pause then Return
	If $ReFishing then Return
	$ReFishing = True
	Send("{NUMLOCK TOGGLE}")
	If $Fishing then

		;Thực hiện Nhấp Cần Câu
		Dim $Click=False
		Do 
			;Bấm StopButton
			MouseClick("Left",$StopButton[0]-7,$StopButton[1],1,1)
			$Click=True
			;Khi nhấp cần nếu cá cắn Câu thì bấm HookButton
			$Catched = PixelSearch($SZone[0],$SZone[1],$SZone[2],$SZone[3],$ColorBite,$ShadesColor) ;14536240
			If IsArray($Catched)=1 then 
				MouseClick("Left",$HookButton[0]-7,$HookButton[1],6,1)
				Return
			EndIf
			If FindColor($StopButton[0],$StopButton[1],-1) then $Click=False
		Until $Click
				
		;Bấm chỗ có Cá
		MouseClick("Left",$FishPos[0]-7,$FishPos[1],7,1)
		Send("{NUMLOCK TOGGLE}")
		If FindColor($HookButton[0],$HookButton[1],7) then 
			MouseMove($HookButton[0],$HookButton[1],1)
		Else
			;Kiểm tra nút OK lấy Cá có tồn tại kg
			If FindColor($HookButton[0]+$HookButton[0]/25.6,$HookButton[1]-$FateSize[1]/9,77) then
			If FindColor($HookButton[0]+$HookButton[0]/25.6,$HookButton[1]-$FateSize[1]/9,-1) then
				Dim $Click=False
				Do ;Nhấn đến khi nút Ok lấy Cá mất
					Send("{NUMLOCK TOGGLE}")
					MouseClick("left",$HookButton[0]+$HookButton[0]/25.6-7,$HookButton[1]-$FateSize[1]/9,1,1)
					$Click=True
					If FindColor($HookButton[0]+$HookButton[0]/25.6,$HookButton[1]-$FateSize[1]/9,-1) Then $Click=False
				Until $Click
			EndIf
			EndIf
		
			MouseClick("Left",$FishPos[0]-7,$FishPos[1],7,1)
			Send("{NUMLOCK TOGGLE}")
			If FindColor($HookButton[0],$HookButton[1],7) then 
				MouseMove($HookButton[0],$HookButton[1],1)
			Else ;Nếu vẫn không có nút Hook thì Nhấp cần lại
				$ReFishing=False
				ReFishing()
			EndIf
		EndIf
	EndIf
	$TimeReFishing = TimerInit()
	$ReFishing = False
EndFunc
	
;Hàm tìm Nút
Func FindColor($x,$y,$time=0,$color=3552822,$step=1);Đen
	If $Pause then Return
	$back=0
	
	;Tìm xem nhấn nút chưa (Nền Vàng)
	If $time=-1	Then
		MouseMove($x,$y,1) ;Để chuột cố đinh trên nút
		Sleep(1006)
		$color = 16245380 ;Vàng 0xEFC85E
		$back = PixelSearch($x-25,$y-16,$x+25,$y+16,$color,$ShadesColor,$step)
		If IsArray($back)=1 then return True
	EndIf
	
	;Tìm cho đến khi có nút
	While IsArray($back)=0 and $time=0
		$back = PixelSearch($x-25,$y-16,$x+25,$y+16,$color,$ShadesColor,$step)
		if IsArray($back)=1 then 
			return true
		EndIf
	WEnd
	
	;Tìm xem có nút chưa trong 1 khoản thời gian
	While $time>0 
		$back = PixelSearch($x-25,$y-16,$x+25,$y+16,$color,$ShadesColor,$step)			
		if IsArray($back)=1 then
			return true
		EndIf
		Sleep($time)
		$time = $time-1
	WEnd
	
	Return False
EndFunc

;Tạm dừng chương trình [Pause]
Func AutoPause()
	If $Running=False then Return
	$Pause = Not $Pause
	ToolTip("Tạm Ngừng",0,0)
	Send("{NUMLOCK off}")
	Send("{CAPSLOCK off}")
	While $Pause
		Send("{SCROLLLOCK TOGGLE}")
		Sleep(77)
	WEnd
	Loading()
	$TimeReFishing = TimerInit()
	If $Pause=False then ToolTip("")
EndFunc

;Lắc lắc chuộc
Func MouseCrazy($Pos=0,$time=1)
	If $Pause then Return
	Dim $move = 7
	Dim $speed = 1
	If $Pos=0 then 
		$Pos=MouseGetPos()
	EndIf

	For $i = 0 to $time Step 1
		MouseMove($Pos[0]+$move,$Pos[1]+$move,$speed)
		MouseMove($Pos[0]-$move,$Pos[1]-$move,$speed)
		MouseMove($Pos[0]-$move,$Pos[1]+$move,$speed)
		MouseMove($Pos[0]+$move,$Pos[1]-$move,$speed)
		MouseMove($Pos[0]-$move,$Pos[1]-$move,$speed)
		MouseMove($Pos[0]+$move,$Pos[1]-$move,$speed)
		MouseMove($Pos[0]-$move,$Pos[1]+$move,$speed)
		Send("{NUMLOCK TOGGLE}")
		Sleep(250)
	Next
EndFunc

;Đưa Thú về Làng [Home]
Func SendPetHome()
	If $Running=False then Return
	If $FateSize[0] < 600 then Return
	MouseClick("Left",$HomeButton[0]-7,$HomeButton[1],2,1)
	Dim $Click=False
	Do
		MouseClick("Left",$OkButton[0]-$OkButton[0]/7,$OkButton[1],1,1)
		$Click=True
		If FindColor($OkButton[0]-$OkButton[0]/7,$OkButton[1],-1) Then $Click=False
	Until $Click

	Return 
	$PetBack=False
	Sleep(9)
	While FindColor(389,185,0,13678466,2)=False
	If FindColor($OkButton[0]-$OkButton[0]/7,$OkButton[1],-1) then
		Dim $Click=False
		Do
			MouseClick("Left",$OkButton[0]-$OkButton[0]/7-7,$OkButton[1],1,1)
			$Click=True
			If FindColor($OkButton[0],$OkButton[1],-1) then $Click=False
		Until $Click
	EndIf
	WEnd
EndFunc

;Lưu Thông Tin Câu Cá [Ctrl+Shift+S]
Func SaveResult()
	If $Saving Then Return
	FileClose(FileOpen($SaveName,1)) ;Tạo File nếu chưa có
	
	$Saving = True
	;Nạp File nội dung củ của File
	$i = 1
	$Read = _ArrayCreate("")
	$FileFateFishing = FileOpen($SaveName,0)
	While 1
		FileReadLine($FileFateFishing,$i)
		If @error = -1 Then ExitLoop
		 _ArrayAdd($Read,FileReadLine($FileFateFishing,$i))
		;MsgBox(0,"",$Read[$i])
		$i = $i + 1
	Wend
	FileClose($FileFateFishing)

	;Lưu file
	;$CatchFishs = 9
	;$CatchItems = 2
	;$MissFish = 1

	;Bắt đầu ghi thông tin mới
	$Total = $CatchFishs + $CatchItems
	If $Total = 0 then 
		$Per = 0
	ElseIf $MissFish = 0 Then
		$Per = 100
	Else
		$Per = ($Total/($Total + $MissFish))*100
	EndIf

	Switch $Per
		Case 0 To 9.99
			$Rank = "Quá Tệ (T_T)hít hít"
		Case 10 To 19.99
			$Rank = "Hơi Tệ ( ~_~)"
		Case 20 To 39.99
			$Rank = "Hơi Được (0_0)"
		Case 40 To 59.99
			$Rank = "Tạm Được (*_*')"
		Case 60 To 69.99
			$Rank = "Hơi Khá ( *_*)"
		Case 70 To 79.99
			$Rank = "Khá (^.^')"
		Case 80 To 89.99
			$Rank = "Hơi Giỏi ('^_^)"
		Case 90 To 97.99
			$Rank = "Giỏi (^.^ )"
		Case 98 To 100
			$Rank = "Quá Tuyệt (^_^ )"
	EndSwitch
	If $Total=$MissFish and $MissFish=0 then $Rank = "(Bạn không Câu Cá)"

	$h = ""
	For $x = 0 to 34 Step 1
		$h = $h&"=+"
	Next
	$Per = StringFormat("%.2f",$Per)	
	$FileFateFishing = FileOpen($SaveName,2+8+128)
	FileWriteLine($FileFateFishing,"")
	FileWriteLine($FileFateFishing,"Ngày "&@MDAY&" tháng "&@MON&" năm "&@YEAR)
	FileWriteLine($FileFateFishing,"Thời gian câu: "&$StarTime[0]&":"&$StarTime[1]&":"&$StarTime[2]&" - "&@HOUR&":"&@MIN&":"&@SEC)
	FileWriteLine($FileFateFishing,"Tỷ Lệ: "&$Per&"% "&$Rank)
	FileWriteLine($FileFateFishing,"-----------------------------------------------")
	FileWriteLine($FileFateFishing,"Câu được: "&$CatchFishs&" con cá")
	FileWriteLine($FileFateFishing,"Câu được: "&$CatchItems&" món đồ")
	FileWriteLine($FileFateFishing,"Câu hụt: "&$MissFish&" lần")
	FileWriteLine($FileFateFishing,$h)
	For $j = 1 to $i-1 Step 1
		FileWriteLine($FileFateFishing,$Read[$j])
	Next
	FileClose($FileFateFishing)
	$CatchFishs = 0
	$CatchItems = 0
	$MissFish = 0
	Global $StarTime = _ArrayCreate(@HOUR,@MIN,@SEC)	;Thời gian câu
	ToolTip("Đã lưu thành tích.",0,0)
	Sleep(777)
	ToolTip("")
	$Saving = False
	MouseMove($FishPos[0],$FishPos[1],1)
	StarAuto()
	Fishing()
EndFunc

;Hướng dẫn câu cá [Ctrl+Shift+H]
Func HelpFishing()
	If $Running=False then 	Return
	If $Helping=True then Return
	
	$AddedRight=False
	$Helping = True
	$Vertically = 16		;Cách Khoản Ngang
	$Horizontally = 16		;Cách Khoản Dọc
	$WinHelpBkColor = 0xffffff	;Màu Nền
	$WinHelpFont = 0xAAC00A9	;Màu Chữ
	$WinHelpFontSize = 9		;Cỡ Chữ
	$WinHelpFontB = 777			;Cỡ Chữ
	
	$BKtest = 0	;Đổi Màu Nền Chữ
	
	;Phần Danh Sách Phím Nóng =========================================
	;Kích thước Nút Thoát
	$ButtonSize = _ArrayCreate(16,16)
	;Kích thước Nút Mở Lưu Ý
	$AddRightSize = _ArrayCreate(25,16)
	;Kích thước Danh Sách Phím Nóng
	
	;Đinh dạng vị trí và kích thước vùng nội dung Phím Nóng
	$Group1Pos = _ArrayCreate($Vertically,$Horizontally-9.7)
	$Group1Size = _ArrayCreate(232,214)
	$Lable1Pos = _ArrayCreate($Group1Pos[0]+$Vertically,$Group1Pos[1]+$Horizontally)
	$Lable1Size = _ArrayCreate($Group1Size[0]-$Vertically-$Vertically,$Group1Size[1]-$Horizontally-$Horizontally)	
	
	;Kích thước cửa Sổ Phím Nóng
	$HotKeySize = _ArrayCreate(0,0)			
	$HotKeySize[0] = $Group1Pos[0]+$Group1Size[0]+$AddRightSize[0];$Vertically	
	$HotKeySize[1] = $Group1Size[1]+$Group1Pos[1]+$Horizontally
	;Vị Trí của HotKey
	$HotKeyPos = _ArrayCreate(@DesktopWidth/3,@DesktopHeight/4)	
	
	;Tạo Cửa Sổ Hot Key
	Local $HandleHotKey = GUICreate("Hướng Dẫn",$HotKeySize[0],$HotKeySize[1],$HotKeyPos[0],$HotKeyPos[1],$WS_POPUP)
	GUISetFont($WinHelpFontSize, $WinHelpFontB, 0, "Arial",$HandleHotKey)
	GUISetBkColor($WinHelpBkColor)
	GUISetState(@SW_SHOW,$HandleHotKey)
	
	;Tạo Nút đóng cửa sổ help
	$Button = GUICtrlCreateButton("X",$HotKeySize[0]-$AddRightSize[0]-$ButtonSize[0],$HotKeySize[1]-$ButtonSize[1],$ButtonSize[0],$ButtonSize[1])
	GUICtrlSetTip($Button,"Close")
	;Tạo Nút Mở Cửa Sổ Lưu Ý
	$AddRight = GUICtrlCreateButton("=>",$HotKeySize[0]-$AddRightSize[0],$HotKeySize[1]-$AddRightSize[1],$AddRightSize[0],$AddRightSize[1])
	GUICtrlSetTip($AddRight,"Lưu Ý")
	
	$XColor = _ArrayCreate(9,1,2,3,4,5,6,7,8,9,"0x000000","0x0000AA","0x4433FF","0x00AAAA","0xAAAAAA","0xFFAA44","0x22FF55","0x77FF00",$WinHelpFont)
	$XSize = _ArrayCreate($AddRightSize[0]/2,$AddRightSize[0]/2)
	$XPos = _ArrayCreate($HotKeySize[0]-$XSize[0],$XSize[1])
	For $i=1 to $XColor[0] Step 1
		$XColor[$i] = GUICtrlCreateGraphic($XPos[0],$XPos[1],$XSize[0],$XSize[1])
		GUICtrlSetBkColor(-1,$XColor[$i+$XColor[0]])
		$XPos[1]+= $XSize[1]+7
	Next
	
	;Nội Dung Danh Sách Hot Key
	Dim $text = ""
	$text = $text&"Ctrl+Shift+K   - Bật/Tắt Phím Nóng "&@LF
	$text = $text&"Ctrl+Shift+H   - Hướng dẫn Câu cá "&@LF
	$text = $text&"Ctrl+Shift+L   - Lưu các File Save "&@LF
	$text = $text&"Ctrl+Shift+N   - Nạp các File Save "&@LF
	$text = $text&"Ctrl+Shift+S   - Lưu kết quả Câu Cá "&@LF
	$text = $text&@LF
	$text = $text&"Insert	- Câu Cá (Xem Lưu Ý) "&@LF
	$text = $text&"Delete	- Ngưng Câu Cá "&@LF
	$text = $text&"Pause	- Tạm dừng Câu Cá "&@LF
	$text = $text&"Space	- Nhấp Cần Câu "&@LF
	$text = $text&"Home 	- Đưa Thú về Làng "&@LF
	$text = $text&"END	- Tắt Auto "&@LF
	$text = $text&@LF
	GUICtrlCreateGroup("Danh Sách Phím Nóng",$Group1Pos[0],$Group1Pos[1],$Group1Size[0],$Group1Size[1])
	$Lable1 = GUICtrlCreateLabel($text,$Lable1Pos[0],$Lable1Pos[1],$Lable1Size[0],$Lable1Size[1])
	GUICtrlSetBkColor(-1,$WinHelpBkColor+$BKtest)
	GUICtrlSetColor(-1,$WinHelpFont)
	GUICtrlCreateGroup("",-99,-99,1,1)
	;Tên Chương Trình
	$LableAutoName = GUICtrlCreateLabel($AutoName,$Vertically,$HotKeySize[1]-$Horizontally)
	GUICtrlSetBkColor(-1,$WinHelpBkColor+$BKtest)
	GUICtrlSetColor(-1,$WinHelpFont)
	
	;Hết Phần Danh Sách Phím Nóng ========================================
	
	
	;Phần Lưu Ý ==========================================================
	;Đinh dạng vị trí và kích thước vùng nội dung Lưu Ý
	$Group2Pos = _ArrayCreate($Vertically,$Group1Pos[1])
	$Group2Size = _ArrayCreate(313,448)
	$Lable2Pos = _ArrayCreate($Group2Pos[0]+$Vertically,$Group2Pos[1]+$Horizontally)
	$Lable2Size = _ArrayCreate($Group2Size[0]-$Vertically-$Vertically,$Group2Size[1]-$Horizontally-$Horizontally)	
	
	;Kích thước cửa Sổ Phím Nóng
	$AddRightSize = _ArrayCreate(0,0)			
	$AddRightSize[0] = $Group2Pos[0]+$Group2Size[0]+$Vertically	;Trái
	$AddRightSize[1] = $Group2Size[1]+$Group2Pos[1]+$Horizontally		;Phải
	;Vị Trí của HotKey
	$AddRightPos = _ArrayCreate($HotKeyPos[0]+$HotKeySize[0],$HotKeyPos[1])
	
	;Tạo cửa sổ Lưu Ý
	Local $HandleAddRight = GUICreate("Lưu Ý",$AddRightSize[0],$AddRightSize[1],$AddRightPos[0],$AddRightPos[1],$WS_POPUP,$WS_EX_TOOLWINDOW,$HandleHotKey)
	GUISetFont($WinHelpFontSize+2, $WinHelpFontB, 0, "Arial",$HandleAddRight)
	GUISetBkColor($WinHelpBkColor)
	GUISetState(@SW_HIDE,$HandleAddRight)
					
	;Nội dung Lưu Ý
	Dim $text = ""
	$text = $text&" 1- Cách Câu cá "&@LF
	$text = $text&"   + Tìm tới xát chỗ có các Đóm Vàng "&@LF
	$text = $text&"   + Đưa chuột lên chúng (không Click) "&@LF
	$text = $text&"   + Bấm nút [Insert] để bắt đầu câu "&@LF
	$text = $text&"   + Bấm [Delete] để ngưng câu "&@LF
	$text = $text&"   + Dùng nút [Pause] để tạm dừng "&@LF
	$text = $text&@LF
	$text = $text&" 2- Việc Lưu Kết Quả Câu (Ctrl+Shift+S) "&@LF
	$text = $text&"   + Lưu trên tập tin: "&$SaveName&@LF
	$text = $text&"   + Khi đã lưu các chỉ số sẽ trở về 0 "&@LF
	$text = $text&@LF
	$text = $text&" 3- Lưu/Nạp Save File (Ctrl+Shift+L/N) "&@LF
	$text = $text&"   + Chức năng cho máy có DeedFree "&@LF
	$text = $text&"   + Bạn vẫn có thể dùng khi cần "&@LF
	$text = $text&"   + Việc Sao/Lưu luôn có file dự phòng "&@LF
	$text = $text&"   + TM:Fate chứa File bị mất khi Nạp "&@LF
	$text = $text&"   + TM:Auto chứa File bị mất khi Lưu "&@LF
	$text = $text&@LF
	$text = $text&" 4- Các Lưu Ý khác "&@LF
	$text = $text&"   + Cần chạy Auto trước khi chạy Fate, "&@LF
	$text = $text&"   + Vì Auto sẽ tự cấu hình cho Fate. "&@LF
	$text = $text&"   + Tỷ lệ câu thành công phụ thuộc vào tốc độ Máy Tính. "&@LF
	$text = $text&"   + Nếu gặp lỗi xin liên hệ Nick Yahoo bên dưới, để được sữa lỗi và nhận phiên bản mới. "&@LF
	GUICtrlCreateGroup("Lưu Ý",$Group2Pos[0],$Group2Pos[1],$Group2Size[0],$Group2Size[1])
	$Lable2 = GUICtrlCreateLabel($text,$Lable2Pos[0],$Lable2Pos[1],$Lable2Size[0],$Lable2Size[1])
	GUICtrlSetBkColor(-1,$WinHelpBkColor+$BKtest)
	GUICtrlSetColor(-1,$WinHelpFont)
	GUICtrlCreateGroup("",-99,-99,1,1)
	
	;Đia chỉ Mail
	$LableMail = GUICtrlCreateLabel("tranminhduc18116@yahoo.com",$Vertically,$AddRightSize[1]-$Horizontally)
	GUICtrlSetBkColor(-1,$WinHelpBkColor+$BKtest)
	GUICtrlSetColor(-1,$WinHelpFont)


	While $Helping 
		$msg = GUIGetMsg()
		Select
			Case $msg = $Button
				$Helping = False
				;Exit
			Case $msg = $AddRight
				If $AddedRight then
					GUISetState(@SW_HIDE,$HandleAddRight)
					GUICtrlSetData($AddRight,"=>")
					$AddedRight=False				
				Else
					GUISetState(@SW_SHOW,$HandleAddRight)
					GUICtrlSetData($AddRight,"<=")
					$AddedRight=True
				EndIf
		EndSelect
		For $i=1 to $XColor[0] Step 1
			Select
				Case $msg = $XColor[$i]
					GUICtrlSetColor($Lable1,$XColor[$i+$XColor[0]])
					GUICtrlSetColor($Lable2,$XColor[$i+$XColor[0]])
					GUICtrlSetColor($LableMail,$XColor[$i+$XColor[0]])
					GUICtrlSetColor($LableAutoName,$XColor[$i+$XColor[0]])
			EndSelect
		Next
	WEnd
	GUIDelete($HandleAddRight)
	GUIDelete($HandleHotKey)
	$Helping = False
EndFunc

;Đóng chương trình [End]
Func CloseAuto()
	Send("{NUMLOCK OFF}")
	ToolTip("Đang đóng..",0,0)
	Sleep(444)	
	Send("{CAPSLOCK OFF}")
	ToolTip("Đang đóng.",0,0)
	Sleep(333)	
	Send("{SCROLLLOCK OFF}")
	Exit
EndFunc
