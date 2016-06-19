#cs ==========================================================
- Website: http://72ls.net
- Forum: http://hocautoit.com
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng:
#ce ==========================================================

$String = ClipGet()
$String = StringReplace($String,'</option><option value="',@CRLF)
$String = StringReplace($String,'">'," - ")
ClipPut($String)
