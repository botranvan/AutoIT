#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: Hỗ trợ lập trình viên viết code AutoIT bằng SciTE
#ce ==========================================================

;~ == Thông tin của trình soạn thảo ========================================
$Scite = Class_Spawn($objClass)
$Scite.title = "[CLASS:SciTEWindow]"
$i = WinGetPos($Scite.title)
$Scite.x = $i[0]
$Scite.y = $i[1]
$Scite.width = $i[2]
$Scite.height = $i[3]
$Scite.path = $AutoITDir&"SciTE\SciTE.exe"

;~ == Biến điều khiển sự vận hành ===========================================
$Running = 1		;1 - Ứng dụng đang hoạt động
$ToolActive = 0		;1 - Tool đang active






