#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.0
- Chức năng: Duyệt thư mục
#ce ==========================================================

FolderScan()
Func FolderScan($path = "*")
	Local $search,$file
	
	$search = FileFindFirstFile($path)  

	If $search = -1 Then
		MsgBox(0, "Error", $path)
		Exit
	EndIf

	While 1
		$file = FileFindNextFile($search) 
		If @error Then ExitLoop
		
		FolderScan($path = "*")
		
		MsgBox(4096, "File:", $file)
	WEnd
	
	FileClose($search)
EndFunc


; Close the search handle

