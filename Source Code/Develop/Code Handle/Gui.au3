#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Hỗ trợ lập trình viên viết code AutoIT bằng SciTE
#ce ==========================================================

AutoItSetOption("GUIOnEventMode",1)
AutoItSetOption("GUICloseOnESC",0)

;~ Giao diện chính
$MainGUI = Class_Spawn($objClass) ;Returns ISWbemObjectEx Object
$MainGUI.title = "Code Handle"
$MainGUI.width = 200
$MainGUI.height = $Scite.height
$MainGUI.x = 0 
$MainGUI.y = $Scite.y
$MainGUI.style = 0x00040000
$MainGUI.estyle = 0x00000008 + 0x00000080
$MainGUI_Handle = GUICreate($MainGUI.title&" v"&$Version&" | 72ls.NET",$MainGUI.width,$MainGUI.height,$MainGUI.x,$MainGUI.y,$MainGUI.style)
GUISetOnEvent(-3,"ExitTool")

;~ Nút nạp lại
$Reload_Button = Class_Spawn($objClass)
$Reload_Button.title = "Reload All"
$Reload_Button.width = 61
$Reload_Button.height = 25
$Reload_Button.x = 7
$Reload_Button.y = 2
$Reload_Button_Handle = GUICtrlCreateButton($Reload_Button.title,$Reload_Button.x,$Reload_Button.y,$Reload_Button.width,$Reload_Button.height)
GUICtrlSetOnEvent($Reload_Button_Handle,"ReloadTree")

;~ Nút nạp lại
$Save_Button = Class_Spawn($objClass)
$Save_Button.title = "Save Selected"
$Save_Button.width = 80
$Save_Button.height = $Reload_Button.height
$Save_Button.x = $Reload_Button.x + $Reload_Button.width + 7
$Save_Button.y = $Reload_Button.y
$Save_Button_Handle = GUICtrlCreateButton($Save_Button.title,$Save_Button.x,$Save_Button.y,$Save_Button.width,$Save_Button.height)
GUICtrlSetOnEvent($Save_Button_Handle,"SaveSelected")
GUICtrlSetState($Save_Button_Handle,128)

;~ Danh sách các file được include
$File_Tree = Class_Spawn($objClass)
$File_Tree.x = $Reload_Button.x
$File_Tree.y = $Reload_Button.y + $Reload_Button.height + 2
$File_Tree.width = $MainGUI.Width - 2*$Reload_Button.x
$File_Tree.height = $MainGUI.height - 2*$Reload_Button.y - $Reload_Button.height - 27
$File_Tree_Handle = GUICtrlCreateTreeView($File_Tree.x, $File_Tree.y, $File_Tree.width, $File_Tree.height)
;~ GUICtrlSetBkColor($File_Tree_Handle,-1)
	

GUISetState()

;~ Các phương thức của Tree View trong Main GUI
Func GetSelected($Text = 0)
	Return GUICtrlRead($File_Tree_Handle,$Text)
EndFunc

	
;~ Các phương thức của nút Save Button
Func EnableSaveButton()
	Local $Cur = GUICtrlGetState($Save_Button_Handle)
	If $Cur = 144 Then GUICtrlSetState($Save_Button_Handle,64)
;~ 	tooltip(@sec&@msec&" "&$Cur,0,0)
EndFunc	
	
	
	
	
	
	
	

