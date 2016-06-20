#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: quản lý các công việc của người dùng Lockerz
#ce ==========================================================

AutoItSetOption("GUIOnEventMode",1)

;~ Giao diện chính
$Main = Class_Spawn($objClass)
$Main.title = "72ls.NET | Locker Manager"
$Main.x = 0
$Main.y = 2
$Main.width = 250
$Main.height = 250
$Main.style = 0x00040000
$Main_Handle = GUICreate($Main.title&" v"&$Version,$Main.width,$Main.height,$Main.x,$Main.y,$Main.style)
GUISetOnEvent(-3,"ExitTool")

;~ Chữ bên trái chỗ nhập ID
$ID_Lable = Class_Spawn($objClass)
$ID_Lable.title = "User:"
$ID_Lable.x = 7
$ID_Lable.y = 7
$ID_Lable.width = 27
$ID_Lable.height = 18
$ID_Lable.style = 0x0200
$ID_Lable.estyle = 0x00000020
$ID_Lable_Handle = GUICtrlCreateLabel($ID_Lable.title,$ID_Lable.x,$ID_Lable.y,$ID_Lable.width,$ID_Lable.height,$ID_Lable.style,$ID_Lable.estyle)

;~ Chỗ nhập ID
$ID_Input = Class_Spawn($objClass)
$ID_Input.title = "tranminhduc18116@yahoo.com"
$ID_Input.x = $ID_Lable.x + $ID_Lable.width + 2
$ID_Input.y = $ID_Lable.y
$ID_Input.width = $Main.width - ($ID_Lable.x + $ID_Lable.width + 7) 
$ID_Input.height = $ID_Lable.height
$ID_Input_Handle = GUICtrlCreateInput($ID_Input.title,$ID_Input.x,$ID_Input.y,$ID_Input.width ,$ID_Input.height)

;~ Chữ bên trái chỗ nhập Pass
$Pass_Lable = Class_Spawn($objClass)
$Pass_Lable.title = "Pass:"
$Pass_Lable.x = $ID_Lable.x
$Pass_Lable.y = $ID_Lable.y + $ID_Lable.height + 5
$Pass_Lable.width = $ID_Lable.width
$Pass_Lable.height = $ID_Lable.height
$Pass_Lable.style = $ID_Lable.style
$Pass_Lable.estyle = $ID_Lable.estyle 
$Pass_Lable_Handle = GUICtrlCreateLabel($Pass_Lable.title,$Pass_Lable.x,$Pass_Lable.y,$Pass_Lable.width,$Pass_Lable.height,$Pass_Lable.style,$Pass_Lable.estyle)

;~ Chỗ nhập Pass
$Pass_Input = Class_Spawn($objClass)
$Pass_Input.title = "PhaiMua1CaiMoi"
$Pass_Input.x = $Pass_Lable.x + $Pass_Lable.width + 2
$Pass_Input.y = $Pass_Lable.y
$Pass_Input.width = $Main.width - ($Pass_Lable.x + $Pass_Lable.width + 7) 
$Pass_Input.height = $Pass_Lable.height
$Pass_Input_Handle = GUICtrlCreateInput($Pass_Input.title,$Pass_Input.x,$Pass_Input.y,$Pass_Input.width ,$Pass_Input.height)

;~ Nút Login
$Login_Button = Class_Spawn($objClass)
$Login_Button.title = "Start"
$Login_Button.x = $Pass_Input.x
$Login_Button.y = $Pass_Input.y + $Pass_Input.height + 5
$Login_Button.width = 40
$Login_Button.height = 25
$Login_Button_Handle = GUICtrlCreateButton($Login_Button.title,$Login_Button.x,$Login_Button.y,$Login_Button.width ,$Login_Button.height)
GUICtrlSetOnEvent($Login_Button_Handle,"StartWork")


GUISetState()

;~ Các phương thức cho chỗ nhập ID
Func GetID()
	Return GUICtrlRead($ID_Input_Handle)
EndFunc


;~ Các phương thức cho chỗ nhập Pass
Func GetPass()
	Return GUICtrlRead($Pass_Input_Handle)
EndFunc












