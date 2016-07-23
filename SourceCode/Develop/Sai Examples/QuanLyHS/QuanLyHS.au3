#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Chương trình quản lý Học Sinh
#ce ==========================================================

Global $DS_Max = 1					;Số lượng phần tử trong danh sách
Global $DSHocSinh[$DS_Max] = [0]	;Danh sách các học sinh
#include-once
#include <Array.au3>
#include <gui.au3>
#include <functions.au3>

While 1
	Sleep(27)

	$msg = GUIGetMsg()

    If $msg = $GUI_EVENT_CLOSE Then ExitTool()	;Xử lý khi bấm thoát	
		
;~ 	Xử lý thao tác nhập
	If $msg = $B_Nhap Then 
		ConsoleWrite(@LF&@LF&"== Bat dau Nhap ======"&@LF)
		Local $MaSo = GUICtrlRead($I_MaSo)
		Local $HoTen = GUICtrlRead($I_HoTen)
		Local $NgSi = GUICtrlRead($I_NgSi)
		Local $Lop = GUICtrlRead($C_TLop)
		Local $HocSinh = $MaSo&"|"&$HoTen&"|"&$NgSi&"|"&$Lop
		
		LuuHocSinh($MaSo,$HocSinh)
		HienDanhSach()
		RandomInfo()	;Tự nhập mới 1 sinh viên khác
;~ 		_ArrayDisplay($DSHocSinh)
	EndIf

;~ 	Xử lý thao tác tìm
	If $msg = $B_Tim Then TimHocSinh()
	
;~ 	Xử lý thao tác tìm
	If $msg = $B_Xoa Then 
		TimHocSinh(1)
		HienDanhSach()
	EndIf

;~ 	Xử lý thao tác Lưu
	If $msg = $B_Save Then LuuDanhSach()

;~ 	Xử lý thao tác Lưu
	If $msg = $B_Load Then NapDanhSach()
		
;~ 	Xử lý thao tác xóa tất cả
	If $msg = $B_Clear Then 
		Global $DS_Max = 1					;Số lượng phần tử trong danh sách
		Global $DSHocSinh[$DS_Max] = [0]	;Danh sách các học sinh
		_GUICtrlListView_DeleteAllItems($V_DSHS)
	EndIf
WEnd