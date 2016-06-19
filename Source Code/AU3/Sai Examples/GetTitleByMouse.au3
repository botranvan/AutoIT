#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.0
- Lấy title = Click chuột
#ce ==========================================================


#Include <Misc.au3>
HotKeySet("{ESC}","_Exit")

While 1
	Sleep(7)
    If _IsPressed("01") Then
;~     If _IsPressed("31") Then
		tooltip(" ",0,0)
		$var = WinList()
		$text = ""
		For $i = 1 to $var[0][0]
			If $var[$i][0] <> "" AND IsVisible($var[$i][1]) And WinActive($var[$i][1]) Then
				$text&=$var[$i][0] & @LF
			EndIf
		Next
		tooltip($text,0,0)
   EndIf
WEnd

;Kiểm tra xem Windown có hiện hay không
Func IsVisible($handle)
  If BitAnd( WinGetState($handle), 2 ) Then
    Return 1
  Else
    Return 0
  EndIf

EndFunc

;Thoát
Func _Exit()
	Exit
EndFunc
