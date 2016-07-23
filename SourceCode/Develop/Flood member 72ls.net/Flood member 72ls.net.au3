#include <WinHTTP.au3>
Global $Cookie1 = "SESSfc4899f35c918701338fe1e394d5f81a=iebj761qb08cqg11o381te8712; has_js=1; phpbb3_igx4g_u=1; phpbb3_igx4g_k=; phpbb3_igx4g_sid=e38ca470942a8ec2e0827a0919c6ea0b"
Dim $Number_1 = 1
HotKeySet("{ESC}","Exit_")

While 1

$Number_1 = $Number_1 + 1

$OpenHttp = _WinHttpOpen("Flood member")
$ConnectHttp = _WinHttpConnect($OpenHttp,"localhost",80)
$RequestHttp = _WinHttpOpenRequest($ConnectHttp,"POST","user/register","HTTP/1.1","http://localhost","text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
_WinHttpAddRequestHeaders($RequestHttp,$Cookie1)
_WinHttpSendRequest($RequestHttp,"Content-Type: application/x-www-form-urlencoded","name=Test"&$Number_1&"&mail=chock"&$Number_1&"%40gmail.com&pass%5Bpass1%5D=123123&pass%5Bpass2%5D=123123&timezone=25200&form_build_id=form-32413d6ee5a4cb6a0dec8f55192ce741&form_id=user_register&captcha_sid=9883&op=T%E1%BA%A1o+T%C3%A0i+Kho%E1%BA%A3n")
_WinHttpReceiveResponse($RequestHttp)
ToolTip("Da reg xong tai khoan : Test_Member"&$Number_1)
WEnd
Func Exit_()
	Exit
	EndFunc