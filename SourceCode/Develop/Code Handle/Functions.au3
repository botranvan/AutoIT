#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Hỗ trợ lập trình viên viết code AutoIT bằng SciTE
#ce ==========================================================

#cs == Ghi Chú ========================================================
- Mỗi Function có thểm kèm theo 1 Hot Key
#ce ===================================================================

;~ Hàm thoát ứng dụng
Func ExitTool()
 	WinSetState($Scite.title,"",@SW_RESTORE)
;~ 	WinMove($Scite.title,"",0,0,@DesktopWidth,@DesktopHeight)
	WinSetState($Scite.title,"",@SW_MAXIMIZE)
	Exit
EndFunc

;~ Hiệu chỉnh lại chiều ngang của trình soạn thảo
Func SciteCheckExit()
	If Not ProcessExists('scite.exe') Then
		Run($AutoITDir&"SciTE\SciTE.exe")
	EndIf
EndFunc

;~ Hiệu chỉnh lại chiều ngang của trình soạn thảo
Func SciteFixWidth()
	WinSetState($Scite.title,"",@SW_MAXIMIZE)	
;~ 	WinMove($Scite.title,"",0,0,@DesktopWidth,@DesktopHeight)
	WinMove($Scite.title,"",$MainGUI.x+$MainGUI.width+7,$Scite.y,@DesktopWidth - $MainGUI.width,$MainGUI.height)
EndFunc

;~ Lấy địa chỉ file gốc và mở các file được include 
Func GetIncludeFile()
	Global $IncludeList[1]
	
	Local $FilePath = StringSplit(WinGetTitle($Scite.title)," - ",1)
	$FilePath = $FilePath[1]
	
	$IncludeList[0] = 1
	_ArrayAdd($IncludeList,$FilePath)
	$CodeDir = StringReplace($FilePath, Path2FileName($FilePath),"")
	
	GetIncludeFromFile($FilePath)
EndFunc

;~ Tìm và Mở các file Include theo cớ chế đệ quy
Func GetIncludeFromFile($FileName)
	Local $File = FileOpen($FileName,0)
	Local $Line = ""
	Local $LineFix = ""
	
	while 1
		$Line = FileReadLine($File)
		If @error = -1 Then ExitLoop
		if StringInStr($Line,';') < StringInStr($Line,'#include') AND StringInStr($Line,';') Then ContinueLoop ;NoShow	
		
		$Line = StringReplace($Line," ","")
		If NOT StringInStr(StringLower($Line),"#include-once") AND StringInStr(StringLower($Line),"#include") Then ;NoShow
			$Line = StringReplace($Line,"#include","") ;NoShow
			If Not StringInStr($Line,";NoShow") Then		
				
				if StringInStr($Line,'"') then 
					$Line = StringReplace($Line,'"',"",1)
					$Line = StringLeft($Line,StringInStr($Line,'"')-1)
				EndIf
				
				
				if StringInStr($Line,">") Then 
					$Line = StringReplace($Line,'<','')
					$Line = StringLeft($Line,StringInStr($Line,">")-1)
				EndIf
					
				$Line = GetPathFromName($Line)
				If not $Line Then ContinueLoop
							
				$IncludeList[0] += 1
				_ArrayAdd($IncludeList,$Line)
				Sleep(9)
				GetIncludeFromFile($Line)
			EndIf
		EndIf
	WEnd
	FileClose($File)
EndFunc

;~ Lấy địa chỉ file từ tên file
Func GetPathFromName($FileName)
	If FileExists($CodeDir&$FileName) Then Return $CodeDir&$FileName
	If FileExists($AutoITDir&"include\"&$FileName) Then Return $AutoITDir&"include\"&$FileName
	Return 0
EndFunc

;~ Hiển thị file đã include ra Tree View của GUI
Func ShowIncludeFile()
	DeleteTreeAll()
;~ 	ReDim $IncludeTree[$IncludeList[0]+1]
	$IncludeTree[0] = 0;
	For $i = 1 To $IncludeList[0] Step 1
		$IncludeTree[0] += 1
		$IncludeTree[$i] = GUICtrlCreateTreeViewItem(Path2FileName($IncludeList[$i]), $File_Tree_Handle)
		GUICtrlSetOnEvent($IncludeTree[$i],"OpenIncludeFile")
		GUICtrlSetTip($IncludeTree[$i],$IncludeList[$i])
		ShowFunction($i)
	Next
;~ 		Global $Test = GUICtrlCreateTreeViewItem("test", $File_Tree_Handle)
EndFunc

;~ Xóa tất cả những item có trong Tree View
Func DeleteTreeAll()
	GUICtrlDelete($File_Tree_Handle)
	$File_Tree_Handle = GUICtrlCreateTreeView($File_Tree.x, $File_Tree.y, $File_Tree.width, $File_Tree.height)
EndFunc

;~ Lấy tên file từ đường dẫn
Func Path2FileName($Path)
	Local $FileName = StringSplit($Path,'\')
	$FileName = $FileName[$FileName[0]]
	return $FileName
EndFunc

;~ Mở 1 file bằng Scite
Func OpenIncludeFile()
	$item = GUICtrlRead($File_Tree_Handle)
	For $i=1 To $IncludeList[0] Step 1
		If StringInStr($IncludeList[$i],GUICtrlRead($item, 1)) Then OpenIncludeFilePath($IncludeList[$i])
	Next
;~ 	tooltip(@sec&@msec&" "&$IncludeList[$item-4],0,0)
EndFunc

;~ Mở 1 file bằng Scite từ 1 đường dẫn cho trước
Func OpenIncludeFilePath($Path)
	$Path = StringReplace($Path,'\',"\\")
	Run('"'&$Scite.path&'" "-open:'&$Path&'"')
EndFunc

;~ Lấy tất cả các Function từ danh sách file đã include
Func GetAllFunction()
	Local $File
	Local $Line
	For $i = 1 To $IncludeList[0] Step 1
		GetFunction($IncludeList[$i],$i)
	Next
	tooltip("",0,0) 
;~ 	ExitTool()
EndFunc

;~ Lấy tất cả Function trong 1 dường dẫn
Func GetFunction($FilePath,$i = 0)
	Local $Line
	Local $FileName = Path2FileName($FilePath)
	If FileExists(@WorkingDir&'\'&StringReplace($FileName,".au3",'')) Then 
		$File = FileOpen(@WorkingDir&'\'&StringReplace($FileName,".au3",''))
		while 1
			$Line = FileReadLine($File)
			If @error = -1 Then ExitLoop
			$Line = StringSplit($Line,"||",1)
			Local $F = Class_Spawn($FunctionClass)
			$F.name = $Line[2]
			$F.file = $i
			$F.line = $Line[1]
			_ArrayAdd($FunctionList,$F)
			$FunctionList[0] += 1
			tooltip($Line[1]&" "&$Line[2],0,0) 				
		WEnd
		FileClose($File)
		Return
	EndIf
		
	$File = FileOpen($FilePath)
	Local $LineNumber = 0
	while 1
		$LineNumber += 1
		$Line = FileReadLine($File,$LineNumber)
		If @error = -1 Then ExitLoop
		
		if StringInStr($Line,';') < StringInStr($Line,'Func ') AND StringInStr($Line,';') Then ContinueLoop ;NoShow	
				
		If StringInStr($Line,"Func ") AND NOT StringInStr($Line,"EndFunc ") AND NOT StringInStr($Line,";NoShow") Then
			Local $F = Class_Spawn($FunctionClass)
			$F.name = $Line
			$F.file = $i
			$F.line = $LineNumber
			_ArrayAdd($FunctionList,$F)
			$FunctionList[0] += 1
				
			tooltip($LineNumber&" "&$Line,0,0) 				
		EndIf
	WEnd			
	FileClose($File)	
EndFunc

;~ Hiển thị các function trong file đã include ra Tree View của GUI
Func ShowFunction($Num)
	Local $Have = 0
	_ArraySort($FunctionList,1,1)
	For $i = 1 To $FunctionList[0] Step 1
		If $FunctionList[$i].file = $Num Then 
			If Not $Have Then $Have = 1
			Local $FTree = GUICtrlCreateTreeViewItem(GetFunctionName($FunctionList[$i].name), $IncludeTree[$Num])
			$IncludeTree[0] += 1
			$IncludeTree[$IncludeTree[0]] = $FTree
			GUICtrlSetOnEvent($IncludeTree[$IncludeTree[0]],"OpenFunction")
		EndIf
	Next
	If $Have Then GUICtrlSetColor($IncludeTree[$Num],0x0000FF)
EndFunc

;~ Lấy tên file từ đường dẫn
Func GetFunctionName($Line)
	Local $FileName = StringReplace($Line,"Func ","") ;NoShow
	while StringLeft($FileName,1) == " "
		$FileName = StringRight($FileName,StringLen($FileName)-1)
	WEnd
	return $FileName
EndFunc

;~ Nạp lại tree file và function của GUI
Func ReloadTree()
	GetIncludeFile()
	GetAllFunction()
	ShowIncludeFile()
;~ 	ShowAllFunction()
EndFunc

;~ Mở 1 function trong file bằng Scite
Func OpenFunction()
	$item = GUICtrlRead($File_Tree_Handle)
	For $i=1 To $FunctionList[0] Step 1
		If StringInStr($FunctionList[$i].name,GUICtrlRead($item, 1)) Then 
			OpenFunctionPath($IncludeList[$FunctionList[$i].file],$FunctionList[$i].line)
		EndIf
	Next
EndFunc

;~ Mở 1 file bằng Scite từ 1 đường dẫn cho trước
Func OpenFunctionPath($Path,$Line)
	$Path = StringReplace($Path,'\',"\\")
	Run('"'&$Scite.path&'" "-open:'&$Path&'" -goto:'&$Line)
EndFunc

;~ Kiểm tra xem item nào đang được chọn
Func CheckSelected()
	Local $ID = GetSelected()
	If $ID Then EnableSaveButton()
EndFunc

;~ Kiểm tra độ rộng của tool để cập nhập lại cho Scite
Func CheckToolWidth()
	Local $GUI = WinGetPos($MainGUI.title)
	If @error Then Return
	If $GUI[0] <> $MainGUI.x or $GUI[1] <> $MainGUI.y or $GUI[3] <> $MainGUI.height Then WinMove($MainGUI.title,"",$MainGUI.x,$MainGUI.y,$GUI[2],$MainGUI.height)
	If $GUI[2] <> $MainGUI.width or Then WinMove($Scite.title,"",$GUI[0]+$GUI[2],$GUI[1],@DesktopWidth - $GUI[2])		
EndFunc

;~ Kiểm tra để active Tool khi cần
Func CheckToolActive()
	If WinActive($Scite.title)Then
		if Not $ToolActive Then 
			$ToolActive = 1
			WinActivate($MainGUI_Handle)
			WinActivate($Scite.title)
		EndIf
	Else
		If WinActive($MainGUI.title) Then
			$ToolActive = 1
			Return
		EndIf
		$ToolActive = 0
	EndIf
EndFunc

;~ Nạp lại file được chọn
Func SaveSelected()
	Local $FileName = GetSelected(1)
	Local $Function 
	Local $Data
	For $i = 1 To $FunctionList[0]
		if StringInStr($IncludeList[$FunctionList[$i].file],$FileName) Then 
			$Data &= $FunctionList[$i].line&"||"&$FunctionList[$i].name&@CRLF
		EndIf
	Next
	Local $File = FileOpen(@WorkingDir&'\'&StringReplace($FileName,".au3",''),2+8)
	FileWrite($File,$Data)
	FileClose($File)
EndFunc
	