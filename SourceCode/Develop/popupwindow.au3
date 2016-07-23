#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

Global Const $WM_ENTERSIZEMOVE = 0x0231
Global Const $WM_EXITSIZEMOVE = 0x0232

$main_height = 300 ;height of the pop-up window

$slide_speed = 500 ;window pop-up/down speed, bigger number = slower, smaller number = faster

$Gui = GUICreate("Popup Menu", 370, 200) ;main GUI
$checkbox = GUICtrlCreateCheckbox("Khóa Cửa Sổ chính khi mở Popup", 5, 5, 250)
GUICtrlSetState(-1, $GUI_CHECKED)
$button1 = GUICtrlCreateButton("Popup 1", 5, 160, 100, 30)
$button2 = GUICtrlCreateButton("Popup 2", 110, 30, 250, 20)
$bb = GUICtrlCreateTab(130, 80, 200, 100)
$lol = GUICtrlCreateTabItem("Tab 1")
WinSetTrans($Gui, "", 255) ;if it's not set to 255, then sliding out has visual bugs
GUISetState(@SW_SHOW, $Gui)

$ParentPosArr = WinGetPos($Gui)
$ChildGui = GuiCreate("Popup 1", 100, 100, $ParentPosArr[0]+$ParentPosArr[2], $ParentPosArr[1]+5,$WS_POPUP, $WS_EX_MDICHILD, $Gui)
$childpos = WinGetPos($ChildGui)
$label1 = GUICtrlCreateButton("Nút P1", $childpos[2]/2-45, 5, 90)
GUICtrlSetResizing (-1, $GUI_DOCKWIDTH+$GUI_DOCKHCENTER) ;button will be in center, and will not change width in case of window increasement (like when u press button2)
$label2 = GUICtrlCreateButton("Close", $childpos[2]/2-45, 70, 90)
GUICtrlSetResizing (-1, $GUI_DOCKWIDTH+$GUI_DOCKHCENTER)
$label3 = GUICtrlCreateInput("Chỗ nhập 1", $childpos[2]/2-45, 40, 90)
GUICtrlCreateGraphic(0, 0, $childpos[2], $childpos[3], 0x07) ;gray line on the edge of the pop up window
GUISetState(@SW_HIDE, $ChildGui)

$child2 = GuiCreate("Child test", 100, $main_height, $ParentPosArr[0]+$ParentPosArr[2], $ParentPosArr[1]+5,$WS_POPUP, $WS_EX_MDICHILD, $Gui) ;transparent window to lock main window when child is opened
GUISetBkColor(0, $child2)
WinSetTrans($child2, "", 100)
GUISetState(@SW_HIDE, $child2)

GUIRegisterMsg($WM_ENTERSIZEMOVE,"WM_ENTERSIZEMOVE")
GUIRegisterMsg($WM_EXITSIZEMOVE, "WM_EXITSIZEMOVE")

Func WM_ENTERSIZEMOVE($hWndGUI, $MsgID, $WParam, $LParam)
    WinSetTrans($ChildGui,"",254)
EndFunc

Func WM_EXITSIZEMOVE($hWndGUI, $MsgID, $WParam, $LParam)
    WinSetTrans($ChildGui,"",255)
EndFunc

While 1
    $msg = GUIGetMsg()
    Switch $msg
        Case $GUI_EVENT_CLOSE
            Exit
        Case $button1
            _show_child_window($button1, $slide_speed) ;slide in pop-up window ($button1 = button's handle)
        Case $button2
            _show_child_window($button2, $slide_speed)
        case $label2
            _slide_out($ChildGui, $slide_speed)
    EndSwitch
    if WinExists($child2) Then
        if WinActive($child2) = 1 then WinActivate($ChildGui) ;locking main window
    EndIf
WEnd

Func _show_child_window($button_handle, $Speed)
    if WinExists($ChildGui) then
        _slide_out($ChildGui, $Speed/2) ;2x faster if switching between button pop-ups
    endif
        _slide_in($ChildGui, $Speed, $button_handle)
EndFunc

Func _slide_in($hwGui, $Speed, $hwCtrl)
    Local $position = ControlGetPos($Gui, "", $hwCtrl)
    Local $position2 = WinGetPos($Gui)
    Local $position2b = WinGetClientSize($Gui)
    Local $position3 = WinGetPos($hwGui)
    Local $light_border = ($position2[2]-$position2b[0])/2
    Local $thick_border = ($position2[3]-$position2b[1])-$light_border
   
    WinMove($hwGui, "", $position2[0]+$position[0]+$light_border, $position2[1]+$position[1]+$position[3]+$thick_border, $position[2]);set the window exacly below button
    DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $hwGui, "int", $Speed, "long", 0x00040004)
    GUISetState(@SW_SHOW, $hwGui)
   
    if GUICtrlRead($checkbox) = $GUI_CHECKED Then
        WinMove($child2, "", $position2[0]+$light_border, $position2[1]+$thick_border, $position2b[0], $position2b[1])
        WinSetTrans($child2, "", 0)
        GUISetState(@SW_SHOWNOACTIVATE, $child2)
        for $i = 1 to 100 Step 10 ;showing "lock window" in smooth transparency
            WinSetTrans($child2, "", $i)
            Sleep(1)
        Next
    EndIf
EndFunc

func _slide_out($hwGui, $Speed)
    if WinExists($child2) Then
        for $i = 100 to 1 Step -10
            WinSetTrans($child2, "", $i)
            Sleep(1)
        Next
        GUISetState(@SW_HIDE, $child2)
    EndIf
    DllCall("user32.dll", "int", "AnimateWindow", "hwnd", $hwGui, "int", $Speed, "long", 0x00050008)
    GUISetState(@SW_HIDE, $hwGui)
EndFunc