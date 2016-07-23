    #include <GUIConstantsEx.au3>
	#include <ComboConstants.au3>


;~ 	Tạo HotKey mặc định
	Global $Key = 1
	HotKeySet("{"&$Key&"}","TestFuntion")

;~ 	Tạo GUI
    GUICreate("My GUI")
	$Edit = GUICtrlCreateInput("",27,57)
	$Combo = GUICtrlCreateCombo("1",27,27,Default,Default,$CBS_DROPDOWNLIST)
	GUICtrlSetData($Combo,"2|3|F1|F2|F3")
    GUISetState(@SW_SHOW)

    While 1
        $msg = GUIGetMsg()

        If $msg = $GUI_EVENT_CLOSE Then ExitLoop
        If $msg = $Combo Then CreateHotKey()
    WEnd
    GUIDelete()


;~ Các Hàm
Func CreateHotKey()
	HotKeySet("{"&$Key&"}") ;Bỏ hot key củ đi

	$Key = GUICtrlRead($Combo) ;Lấy key mới từ ComboBox

	HotKeySet("{"&$Key&"}","TestFuntion") ;Kết nối Function với Key mới

	GUICtrlSetState($Edit,$GUI_FOCUS)	;Focus đến 1 Control khác để khi bấm Key ComboBox kg thay đổi giá trị
EndFunc

Func TestFuntion()
	msgbox(0,"SetHotKey","72ls.net")
EndFunc