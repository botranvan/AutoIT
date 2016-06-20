#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Tìm và shap chép file dạng index
#ce ==========================================================

$Start = "www"
$Save = "new"
$Count = 0
$Re = FileOpen("re.txt",2)
FindIndex($Start)
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
			If StringInStr($File,'index.html') or StringInStr($File,'default.html') or StringInStr($File,'main.html') _ 
			or StringInStr($File,'index.htm') or StringInStr($File,'default.htm') or StringInStr($File,'main.htm') _ 
			or StringInStr($File,'index.php') or StringInStr($File,'default.php') or StringInStr($File,'main.php') _ 
			Then 
				$Count+=1
				FileWriteLine($Re,$Count&": "&$Save&"\"&$Path&"\"&$File)
				FileCopy($Path&"\"&$File,$Save&"\"&$Path&"\"&$File,1+8)
			EndIf
		EndIf
	WEnd

	; Close the search handle
	FileClose($File)
	FileClose($search)
EndFunc
msgbox(0,"72ls.net","Tìm được: "&$Count)
FileClose($re)