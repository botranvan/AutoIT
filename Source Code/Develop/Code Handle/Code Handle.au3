#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Hỗ trợ lập trình viên viết code AutoIT bằng SciTE
+ Hiện hàm ở trên cùng màng hình, không chỉ hiện tên hàm không.
#ce ==========================================================

;~ == Biến Dùng Chung =======================================================
$Version = "0.062"
$AutoITDir =  RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\AutoIt v3\AutoIt", "InstallDir")&"\"
$CodeDir = ""
Dim $IncludeList[1]			;Danh sách đường dẫn các file đã include
Dim $FunctionList[1]		;Cây chứa handle của các file đã include hiển thị trong GUI
Dim $IncludeTree[270]		;Cây chứa handle của các file đã include hiển thị trong GUI
;~ Dim $FunctionTree[200]	;Cây chứa handle của các file đã include hiển thị trong GUI

;~ == Bắt đầu chương trình
SciteCheckExit()

#include-once
  
;~ #include <WindowsConstants.au3> 
;~ #include <GUIConstantsEx.au3>
#include <Array.au3>
#include <ClassManager.au3>
#include <Var.au3>
#include <Gui.au3>
#include <Functions.au3>

SciteFixWidth()
ReloadTree()

;~ _ArrayDisplay($IncludeList)

While $Running
	CheckToolActive()
	CheckToolWidth()
	CheckSelected()
	Sleep(77)
WEnd