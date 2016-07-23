#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Chương trình đóng mở CD
#ce ==========================================================

#include <GUIConstants.au3>
$CDRom = GUICreate("CDRom", 105, 99, 193, 140)
$CDList = GUICtrlCreateCombo("Select", 16, 8, 73, 25)
GUICtrlSetData($CDList,$ListRom)
$Open = GUICtrlCreateButton("Open", 16, 40, 75, 25, 0)
$Close = GUICtrlCreateButton("Close", 16, 70, 75, 25, 0)
GUISetState(@SW_SHOW)
