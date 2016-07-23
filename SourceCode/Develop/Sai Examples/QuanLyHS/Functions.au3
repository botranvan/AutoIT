#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Chương trình quản lý Học Sinh
#ce ==========================================================

#Include <GuiListView.au3>;NoShow

;~ Hàm thoát chương trình
HotKeySet("{Esc}","ExitTool")
Func ExitTool()
	Exit
EndFunc

;~ Lưu học sinh vào danh sách
Func LuuHocSinh($MaSo,$HocSinh)
	
	If $DS_Max*1 < $MaSo*1 Then 
		$DS_Max = $MaSo
		ReDim $DSHocSinh[$DS_Max+1]
	EndIf
	
	ConsoleWrite("Nhap Hoc Sinh - $DS_Max:"&$DS_Max&" - $MaSo:"&$MaSo&@LF)
	$DSHocSinh[$MaSo] = $HocSinh
	$DSHocSinh[0]+=1
EndFunc

;~ Hiện danh sách các học viên
Func HienDanhSach()
	ConsoleWrite("Xoa toan bo List View"&@LF)
	_GUICtrlListView_DeleteAllItems($V_DSHS)
	
	ConsoleWrite("Xuat Danh Sach ra List View"&@LF)
	For $i = 1 To $DS_Max
		If $DSHocSinh[$i] Then GUICtrlCreateListViewItem($DSHocSinh[$i],$V_DSHS)
	Next
EndFunc

;Tự nhập mới 1 sinh viên khác
Func RandomInfo()
	ConsoleWrite("Random thong tin Hoc Sinh"&@LF)
	GUICtrlSetData($I_MaSo,Random(2,72,1))
	GUICtrlSetData($I_HoTen,Random(2,72,1))
	GUICtrlSetData($I_NgSi,Random(2,72,1))
EndFunc	
	
;~ Tìm một học sinh
Func TimHocSinh($Delete = 0)
	
;~ 	Thoát nếu chưa có học sinh nào
	If Not $DSHocSinh[0] Then 
		MsgBox(0,"72ls.NET","Chưa có Học Sinh Nào") 
		Return
	EndIf
	
;~ 	Kiểm tra chế độ tìm
	Local $TMaSo = GUICtrlRead($R_TMaSo)
	
	If $TMaSo = 1 Then	;Tìm theo mã số
		Local $MaSo = GUICtrlRead($I_TMaSo)		
		If $MaSo*1 <= $DS_Max*1 Then
			If $DSHocSinh[$MaSo] Then
				Local $HocSinh = StringSplit($DSHocSinh[$MaSo],"|")
				$HocSinh = "Mã Số: "&$HocSinh[1]&@LF& _
						   "Họ Tên: "&$HocSinh[2]&@LF& _
						   "Ngày Sinh: "&$HocSinh[3]&@LF& _
						   "Tên Lớp: "&$HocSinh[4]
				MsgBox(0,"72ls.NET",$HocSinh)
				
				If $Delete Then ;Xóa học sinh
					$DSHocSinh[$MaSo] = ""
					$DSHocSinh[0] -= 1
				EndIf
			Else
				MsgBox(0,"72ls.NET","Không tìm thấy")		
			EndIf
		Else
			MsgBox(0,"72ls.NET","Không tìm thấy")		
		EndIf
		
	Else	;Tìm theo Họ Tên
		Local $Ten = GUICtrlRead($I_TTen)
		Local $Count = 0
		For $i = 1 To $DS_Max
			If $DSHocSinh[$i] Then
				Local $HocSinh = StringSplit($DSHocSinh[$i],"|")
				If StringInStr($HocSinh[2],$Ten) Then
					$Count+=1
					$HocSinh = "Mã Số: "&$HocSinh[1]&@LF& _
							   "Họ Tên: "&$HocSinh[2]&@LF& _
							   "Ngày Sinh: "&$HocSinh[3]&@LF& _
							   "Tên Lớp: "&$HocSinh[4]
					MsgBox(0,"72ls.NET",$HocSinh)
					If $Delete Then ;Xóa học sinh
						$DSHocSinh[$i] = ""
						$DSHocSinh[0] -= 1
					EndIf					
				EndIf
			EndIf			
		Next
		
		If $Count Then
			MsgBox(0,"72ls.NET","Tìm được "&$Count&" Học Sinh") 
		Else
			MsgBox(0,"72ls.NET","Không Tìm thấy") 
		EndIf
	EndIf
EndFunc

;~ Lưu danh sách xuống file
Func LuuDanhSach()
	If Not $DSHocSinh[0] Then Return
	Local $FileName = InputBox("72ls.NET","Nhập tên File muốn lưu","DanhSach.txt")
	Local $File = FileOpen($FileName,2+8+128)
	FileWrite($File,"Lưu ngày: "&@MDAY&"/"&@MON&"/"&@YEAR&"  "&@HOUR&":"&@MIN&" "&@SEC&@CRLF)
	For $i=1 To $DS_Max
		If $DSHocSinh[$i] Then FileWrite($File,$DSHocSinh[$i]&@CRLF)
	Next
	FileClose($File)	
EndFunc

;~ Nạp danh sách vào chương trình
Func NapDanhSach()
	Local $Line,$MaSo
	Global $DS_Max = 1					;Số lượng phần tử trong danh sách
	Global $DSHocSinh[$DS_Max] = [0]	;Danh sách các học sinh
	
	Local $FileName = InputBox("72ls.NET","Chọn File muốn nạp","DanhSach.txt")
	Local $File = FileOpen($FileName,0)
	MsgBox(0,"72ls.NET","Nạp danh sách "&FileReadLine($File)) 
 	While 1
		$Line = FileReadLine($File)
		If @error = -1 Then ExitLoop
		$MaSo = StringSplit($Line,"|")
		LuuHocSinh($MaSo[1],$Line)
	Wend
	FileClose($File)
	HienDanhSach()
EndFunc






