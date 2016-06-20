;~ Chương trình giả lập màng hình báo lỗi cửa Window9X

#include <GUIConstants.au3>
HotKeySet("{Esc}", "terminate")
HotKeySet("{DEL}", "Bep")

;~ Tạo 1 GUI có kích thước lớn hơn Desktop 50 Pixel
GUICreate ('Bluescreen', @DesktopWidth + '50' , @DesktopHeight + '50')
GUISetBkColor (0x0000FF)
GUISetIcon('shell32.dll', 295)

    $w = GUICtrlCreateButton("Windows", 500, 220, 99, 24)
    GUIctrlSetBkColor($w, 0xC0C0C0)
        GUICtrlSetFont($w, 17, 400, -1, "MS Reference Sans Serif")
        GUICtrlSetColor($w, 0x0000FF)
        
    $m1 = GUICtrlCreateLabel ('An critical error has accurred.     To continue:', 280, 300, 700)
        GUICtrlSetFont($m1, 14, 400, -1, "MS Reference Sans Serif")
        GUICtrlSetColor($m1, 0xFFFFFF)

    $m2 = GUICtrlCreateLabel ('Press Enter to return to Windows, or', 280, 340, 700)
        GUICtrlSetFont($m2, 14, 400, -1, "MS Reference Sans Serif")
        GUICtrlSetColor($m2, 0xFFFFFF) 

    $m3 = GUICtrlCreateLabel ('Press Enter to return to Windows, or', 280, 340, 700)
        GUICtrlSetFont($m3, 14, 400, -1, "MS Reference Sans Serif")
        GUICtrlSetColor($m3, 0xFFFFFF) 
    
        
    $m4 = GUICtrlCreateLabel ('Press CTRL+ALT+DEL to restart your computer. If you do this,', 280, 370, 700, 23)
		GUICtrlSetFont($m4, 14, 400, -1, "MS Reference Sans Serif")
        GUICtrlSetColor($m4, 0xFFFFFF)
        
    $m5 = GUICtrlCreateLabel ('you will lose any unsaved information in all open applications.', 280, 395, 700, 23)
		GUICtrlSetFont($m5, 14, 400, -1, "MS Reference Sans Serif")
        GUICtrlSetColor($m5, 0xFFFFFF)


    $m6 = GUICtrlCreateLabel ('Error: Unknown Error', 280, 445, 700)
		GUICtrlSetFont($m6, 14, 400, -1, "MS Reference Sans Serif")
        GUICtrlSetColor($m6, 0xFFFFFF)

	$help = @LF&@LF&@LF&'-Bấm DEL kêu Beep'&@LF&'-Bấm ESC để thoát'
    $m7 = GUICtrlCreateLabel ('Press any key to continue _'&$help, 450, 540, 700, 150)
		GUICtrlSetFont($m7, 14, 400, -1, "MS Reference Sans Serif")
        GUICtrlSetColor($m7, 0xFFFFFF)
        

        
beep (700)


Sleep('2000')
GUISetState (@SW_SHOW)
Sleep(200000)

;~ Tạo tiếng Beep
Func Bep()
	beep (1000)
	Sleep (2000)
EndFunc

;~ Thoát Chương Trình
Func terminate()
	Exit   
Endfunc