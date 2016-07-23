#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.4.0
- Chức năng: Tự điền thông tin vào web

Lứu ý: Khi Test thư mục cần được giải nén theo đường dẫn sau
D:\AutoWebInput\AutoWebInput.au3
D:\AutoWebInput\Test.html
#ce ==========================================================

#include <IE.au3>

$url = "file:///D:/AutoWebInput/Test.html"
$FormName = "TestForm"
$REGIONID = 0
$SEVERITYID = 1
$DESCRIPTION = "72ls.net"


$oIE = _IECreate ($url)

$oForm = _IEFormGetObjByName ($oIE, $FormName)

$oQuery = _IEFormElementGetObjByName ($oForm, "REGIONID")
_IEFormElementSetValue ($oQuery, $REGIONID)

$oQuery = _IEFormElementGetObjByName ($oForm, "SEVERITYID")
_IEFormElementSetValue ($oQuery, "1")

$oQuery = _IEFormElementGetObjByName ($oForm, "DESCRIPTION")
_IEFormElementSetValue ($oQuery, "72ls.net")

;~ _IEFormSubmit ($oForm)


