#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Chương trình quản lý Học Sinh
#ce ==========================================================
#include-once
#include <GUIConstantsEx.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>

;~ Tạo nên Window
$GUI_width = @DesktopWidth/2
$GUI_height = @DesktopHeight/2
$GUI_x = @DesktopWidth/4
$GUI_y = @DesktopHeight/4
$GUI = GUICreate("Quản Lý Học Sinh | 72ls.net",$GUI_width,$GUI_height,$GUI_x,$GUI_y)

;~ Tạo Danh Sách Học Sinh
$V_DSHS_width = $GUI_width-150
$V_DSHS_height = $GUI_height-25
$V_DSHS_x = 150
$V_DSHS_y = 5
$V_DSHS = GUICtrlCreateListView("Mã|Họ Tên|Ngày Sinh|Lớp",$V_DSHS_x,$V_DSHS_y,$V_DSHS_width,$V_DSHS_height)

;~ Tạo tiêu đề mã số
$L_MaSo_width = 47
$L_MaSo_height = 20
$L_MaSo_x = 7
$L_MaSo_y = 7
$L_MaSo = GUICtrlCreateLabel("Mã Số:",$L_MaSo_x,$L_MaSo_y,$L_MaSo_width,$L_MaSo_height)

;~ Tạo chỗ nhập mã số
$I_MaSo_width = 100
$I_MaSo_height = $L_MaSo_height
$I_MaSo_x = $L_MaSo_width
$I_MaSo_y = $L_MaSo_y -2
$I_MaSo = GUICtrlCreateInput(Random(2,72,1),$I_MaSo_x,$I_MaSo_y,$I_MaSo_width,$I_MaSo_height,$ES_NUMBER)

;~ Tạo tiêu đề họ tên
$L_HoTen_width = $L_MaSo_width
$L_HoTen_height = $L_MaSo_height
$L_HoTen_x = $L_MaSo_x
$L_HoTen_y = $L_MaSo_y + $L_MaSo_height
$L_HoTen = GUICtrlCreateLabel("Họ Tên:",$L_HoTen_x,$L_HoTen_y,$L_HoTen_width,$L_HoTen_height)

;~ Tạo chỗ nhập họ tên
$I_HoTen_width = $I_MaSo_width
$I_HoTen_height = $L_MaSo_height
$I_HoTen_x = $L_HoTen_width
$I_HoTen_y = $L_HoTen_y - 2
$I_HoTen = GUICtrlCreateInput(Random(2,72,1),$I_HoTen_x,$I_HoTen_y,$I_HoTen_width,$I_HoTen_height)

;~ Tạo tiêu đề Ngày Sinh
$L_NgSi_width = $L_MaSo_width
$L_NgSi_height = $L_MaSo_height
$L_NgSi_x = $L_MaSo_x
$L_NgSi_y = $I_HoTen_y + $L_MaSo_height + 2
$L_NgSi = GUICtrlCreateLabel("N.Sinh:",$L_NgSi_x,$L_NgSi_y,$L_NgSi_width,$L_NgSi_height)

;~ Tạo chỗ nhập Ngày Sinh
$I_NgSi_width = $I_MaSo_width
$I_NgSi_height = $L_MaSo_height
$I_NgSi_x = $L_NgSi_width
$I_NgSi_y = $L_NgSi_y - 2
$I_NgSi = GUICtrlCreateInput(Random(2,72,1),$I_NgSi_x,$I_NgSi_y,$I_NgSi_width,$I_NgSi_height)

;~ Tạo tiêu đề Tên Lớp
$L_TLop_width = $L_MaSo_width
$L_TLop_height = $L_MaSo_height
$L_TLop_x = $L_MaSo_x
$L_TLop_y = $I_NgSi_y + $L_MaSo_height + 2
$L_TLop = GUICtrlCreateLabel("Lớp:",$L_TLop_x,$L_TLop_y,$L_TLop_width,$L_TLop_height)

;~ Tạo chỗ nhập Tên Lớp
$C_TLop_width = $I_MaSo_width
$C_TLop_height = $L_MaSo_height
$C_TLop_x = $L_TLop_width
$C_TLop_y = $L_TLop_y - 2
$C_TLop = GUICtrlCreateCombo("A001",$C_TLop_x,$C_TLop_y,$C_TLop_width,$C_TLop_height,$CBS_DROPDOWNLIST+$CBS_AUTOHSCROLL)
GUICtrlSetData($C_TLop,"A002|A003|A004|A005|A006|A007")

;~ Tạo nút Nhập
$B_Nhap_width = 140
$B_Nhap_height = $L_MaSo_height
$B_Nhap_x = $L_TLop_x
$B_Nhap_y = $L_TLop_y +$L_TLop_height + 2
$B_Nhap = GUICtrlCreateButton("Nhập/Sữa Học Viên",$B_Nhap_x,$B_Nhap_y,$B_Nhap_width,$B_Nhap_height)


;~ Tạo nút Tìm
$B_Tim_width = 60
$B_Tim_height = $L_MaSo_height
$B_Tim_x = $B_Nhap_x + 7
$B_Tim_y = $B_Nhap_y + 30
$B_Tim = GUICtrlCreateButton("Tìm",$B_Tim_x,$B_Tim_y,$B_Tim_width,$B_Tim_height)

;~ Tạo nút Xóa
$B_Xoa_width = $B_Tim_width
$B_Xoa_height = $L_MaSo_height
$B_Xoa_x = $B_Tim_x + $B_Tim_width + 7
$B_Xoa_y = $B_Tim_y 
$B_Xoa = GUICtrlCreateButton("Xóa",$B_Xoa_x,$B_Xoa_y,$B_Xoa_width,$B_Xoa_height)


;~ Tạo tùy chọn tìm mã số
$R_TMaSo_width = 18
$R_TMaSo_height = $L_MaSo_height
$R_TMaSo_x = 7
$R_TMaSo_y = $B_Xoa_y + $B_Xoa_height + 5
$R_TMaSo = GUICtrlCreateRadio("",$R_TMaSo_x,$R_TMaSo_y,$R_TMaSo_width,$R_TMaSo_height)
GUICtrlSetState($R_TMaSo, $GUI_CHECKED)

;~ Tạo tiêu đề tìm mã số
$L_TMaSo_width = 25
$L_TMaSo_height = $L_MaSo_height
$L_TMaSo_x = $R_TMaSo_x + $R_TMaSo_width
$L_TMaSo_y = $R_TMaSo_y + 2
$L_TMaSo = GUICtrlCreateLabel("Mã:",$L_TMaSo_x,$L_TMaSo_y,$L_TMaSo_width,$L_TMaSo_height)

;~ Tạo chỗ nhập tìm mã số
$I_TMaSo_width = 97
$I_TMaSo_height = $L_TMaSo_height
$I_TMaSo_x = $L_TMaSo_x + $L_TMaSo_width
$I_TMaSo_y = $R_TMaSo_y
$I_TMaSo = GUICtrlCreateInput(Random(2,72,1),$I_TMaSo_x,$I_TMaSo_y,$I_TMaSo_width,$I_TMaSo_height,$ES_NUMBER)


;~ Tạo tùy chọn tìm họ tên
$R_TTen_width = $R_TMaSo_width
$R_TTen_height = $L_MaSo_height
$R_TTen_x = 7
$R_TTen_y = $R_TMaSo_y + $R_TMaSo_height
$R_TTen = GUICtrlCreateRadio("",$R_TTen_x,$R_TTen_y,$R_TTen_width,$R_TTen_height)

;~ Tạo tiêu đề tìm họ tên
$L_TTen_width = $L_TMaSo_width
$L_TTen_height = $L_MaSo_height
$L_TTen_x = $R_TTen_x + $R_TTen_width
$L_TTen_y = $R_TTen_y + 2
$L_TTen = GUICtrlCreateLabel("Tên:",$L_TTen_x,$L_TTen_y,$L_TTen_width,$L_TTen_height)

;~ Tạo chỗ nhập tìm họ tên
$I_TTen_width = $I_TMaSo_width
$I_TTen_height = $L_TTen_height
$I_TTen_x = $L_TTen_x + $L_TTen_width
$I_TTen_y = $R_TTen_y
$I_TTen = GUICtrlCreateInput(Random(2,72,1),$I_TTen_x,$I_TTen_y,$I_TTen_width,$I_TTen_height,$ES_NUMBER)


;~ Tạo nút Tìm
$B_Save_width = 60
$B_Save_height = $L_MaSo_height
$B_Save_x = $B_Nhap_x + 7
$B_Save_y = $B_Nhap_y + 106
$B_Save = GUICtrlCreateButton("Lưu",$B_Save_x,$B_Save_y,$B_Save_width,$B_Save_height)

;~ Tạo nút Xóa
$B_Load_width = $B_Save_width
$B_Load_height = $L_MaSo_height
$B_Load_x = $B_Save_x + $B_Save_width + 7
$B_Load_y = $B_Save_y 
$B_Load = GUICtrlCreateButton("Nạp",$B_Load_x,$B_Load_y,$B_Load_width,$B_Load_height)

;~ Tạo nút Tìm
$B_Clear_width = 120
$B_Clear_height = $L_MaSo_height
$B_Clear_x = $B_Nhap_x + 10
$B_Clear_y = $B_Load_y + $B_Load_height + 7
$B_Clear = GUICtrlCreateButton("Xóa Tất Cả",$B_Clear_x,$B_Clear_y,$B_Clear_width,$B_Clear_height)




GUISetState()





