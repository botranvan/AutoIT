;***********************************************
; Free Sms MrViet
; Lê Văn Thanh Việt
; Email : levanthanhviet267dn@gmail.com 
; date 06/04/2010
;**********************************************
 
#include <ButtonConstants.au3>
#include <ComboConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <GuiStatusBar.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#Include <GuiEdit.au3>
#include <String.au3>
#include <GDIPlus.au3>
 
 
#Region ### START Koda GUI section ### Form=
 
$Form1 = GUICreate("Free Sms tạo bởi MrViet", 415, 323, -1, -1)
GUISetBkColor(0xA6CAF0)
$ComboMaVung = GUICtrlCreateCombo("", 16, 40, 200, 25)
GUICtrlSetData(-1, "Vietnam +84|Afghanistan +93|Albania +355|Algeria +213|American Samoa +684|Andorra +376|Angola +244|Anguilla +1-264|Antigua and Barbuda +1-268|Argentina +54|Armenia +374|Aruba +297|Ascension Island +247|Australia +61|Australian External Territories +672|Austria +43|Azerbaijan +994|Bahamas +1-242|Bahrain +973|Bangladesh +880|Barbados +1-246|Belarus +375|Belgium +32|Belize +501|Benin +229|Bermuda +1-441|Bhutan +975|Bolivia +591|Bosnia and Herzegovina +387|Botswana +267|Brazil +55|British Virgin Islands +1-284|Brunei Darussalam +673|Bulgaria +359|Burkina Faso +226|Burundi +257|Cambodia +855|Cameroon +237|Cape Verde +238|Cayman Islands +1-345|Central African Republic +236|Chad +235|Chile +56|China +86|Colombia +57|Comoros +269|Congo +242|Cook Islands +682|Costa Rica +506|Cote d"&Chr(39)&"Ivoire +225|Croatia +385|Cuba +53|Cyprus +357|Czech Republic +420|Democratic People"&Chr(39)&"s Republic of Korea +850|Democratic Republic of the Congo +243|Denmark +45|Diego Garcia +246|Djibouti +253|Dominica +1-767|Dominican Republic +1-829|East Timor +670|Ecuador +593|Egypt +20|El Salvador +503|Equatorial Guinea +240|Eritrea +291|Estonia +372|Ethiopia +251|Falkland Islands +500|Faroe Islands +298|Federated States of Micronesia +691|Fiji +679|Finland +358|France +33|French Guiana +594|French Polynesia +689|Gabon +241|Gambia +220|Georgia +995|Germany +49|Ghana +233|Gibraltar +350|Greece +30|Greenland +299|Grenada +1-473|Guadeloupe +590|Guam +1-671|Guatemala +502|Guinea +224|Guinea-Bissau +245|Guyana +592|Haiti +509|Honduras +504|Hong Kong +852|Hungary +36|Iceland +354|India +91|Indonesia +62|Iran +98|Iraq +964|Ireland +353|Israel +972|Italy +39|Jamaica +1-876|Japan +81|Jordan +962|Kazakhstan +7|Kenya +254|Kiribati +686|Kuwait +965|Kyrgyzstan +996|Laos +856|Latvia +371|Lebanon +961|Lesotho +266|Liberia +231|Libya +218|Liechtenstein +423|Lithuania +370|Luxembourg +352|Macau +853|Macedonia +389|Madagascar +261|Malawi +265|Malaysia +60|Maldives +960|Mali +223|Malta +356|Marshall Islands +692|Martinique +596|Mauritania +222|Mauritius +230|Mayotte +269|Mexico +52|Moldova +373|Monaco +377|Mongolia +976|Montserrat +1-664|Morocco +212|Mozambique +258|Myanmar +95|Namibia +264|Nauru +674|Nepal +977|Netherlands +31|Netherlands Antilles +599|New Caledonia +687|New Zealand +64|Nicaragua +505|Niger +227|Nigeria +234|Niue +683|Northern Mariana Islands +1-670|Norway +47|Oman +968|Pakistan +92|Palau +680|Panama +507|Papua New Guinea +675|Paraguay +595|Peru +51|Philippines +63|Poland +48|Portugal +351|Puerto Rico +1-939|Qatar +974|Republic of Korea +82|Reunion +262|Romania +40|Russia +7|Rwanda +250|Samoa +685|San Marino +378|Sao Tome and Principe +239|Saudi Arabia +966|Senegal +221|Seychelles +248|Sierra Leone +232|Singapore +65|Slovakia +421|Slovenia +386|Solomon Islands +677|Somalia +252|South Africa +27|Spain +34|Sri Lanka +94|St. Helena +290|St. Kitts and Nevis +1-869|St. Lucia +1-758|St. Pierre and Miquelon +508|St. Vincent and the Grenadines +1-784|Sudan +249|Suriname +597|Swaziland +268|Sweden +46|Switzerland +41|Syria +963|Taiwan +886|Tajikistan +992|Tanzania +255|Thailand +66|Togo +228|Tokelau +690|Tonga +676|Trinidad and Tobago +1-868|Tunisia +216|Turkey +90|Turkmenistan +993|Turks and Caicos Islands +1-649|Tuvalu +688|US Virgin Islands +1-340|Uganda +256|Ukraine +380|United Arab Emirates +971|United Kingdom +44|Uruguay +598|Uzbekistan +998|Vanuatu +678|Vatican +379|Venezuela +58|Wallis and Futuna Islands +681|Yemen +967|Yugoslavia +381|Zambia +260|Zimbabwe +263 ", "Vietnam +84")
$txtMessage = GUICtrlCreateEdit("Tuyệt đối ko dùm <enter>, tiếng việt hay các ký tự đặc biêt", 16, 152, 200, 137)
GUICtrlSetLimit(-1, 160)
$txtSoDienThoai = GUICtrlCreateInput("84", 16, 96, 200, 21)
$lblRegionalCode = GUICtrlCreateLabel("Mã vùng :", 16, 16, 80, 17)
$lblPhoneNumber = GUICtrlCreateLabel("Phone Number :", 16, 72, 81, 17)
$lblMessage = GUICtrlCreateLabel("Nội dung :", 16, 128, 48, 17)
$lblCharacters = GUICtrlCreateLabel("142/160 charcters)", 128, 128, 86, 17)
$lblSignure = GUICtrlCreateLabel("Chữ ký:", 224, 128, 55, 17)
$txtChuKy = GUICtrlCreateInput("(Ko reply SMS nay)", 224, 152, 175, 21)
GUICtrlSetLimit(-1, 50)
$lblVerityCode = GUICtrlCreateLabel("Nhập Image :", 224, 16, 64, 17)
$txtVerifyCode = GUICtrlCreateInput("", 224, 40, 100, 21)
GUICtrlSetLimit(-1, 5)
$btnReLoad = GUICtrlCreateButton("Đỗi", 328, 38, 70, 25, $WS_GROUP)
$btnSend = GUICtrlCreateButton("Gởi sms", 224, 192, 177, 33, $WS_GROUP)
$btnExit = GUICtrlCreateButton("Thoát", 224, 240, 177, 33, $WS_GROUP)
$StatusBar1 = _GUICtrlStatusBar_Create($Form1)
_GUICtrlStatusBar_SetSimple($StatusBar1)
_GUICtrlStatusBar_SetText($StatusBar1, "                            MrViet : thanhviet_90dn@yahoo.com.vn - Free Sms")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
 
 
;Khai bao cac bien
$host = 'http://for-ever.us/'
$img_patch = @ScriptDir&"\img.png"
$user_agent_ = "Mozilla/5.0 (Windows; U; Windows NT 6.1; en-US; rv:1.9.2) Gecko/20100115 Firefox/3.6"
Global $oHTTP = ObjCreate("winhttp.winhttprequest.5.1")
Global $hImg,$hGrp
Local $k = 0,$char2 = '',$char3 = ''
 
;Lay ma captcha ve
_GDIPlus_StartUp()
load_IMG()
 
While 1
 
$nMsg = GUIGetMsg()
 
Sleep(10)
 
$char = StringLen(GUICtrlRead($txtMessage)) + StringLen(GUICtrlRead($txtChuKy))
 
If $char <> $char2 Then
    $char3 = 160 - Int($char)
    $char2 = $char
    GUICtrlSetData($lblCharacters,$char3& '/160')
    GUICtrlSetLimit($txtMessage,160 - StringLen(GUICtrlRead($txtChuKy)))
EndIf
 
 
;Goi cac ham
Switch $nMsg
Case $GUI_EVENT_CLOSE
Exit
Case $ComboMaVung
    getMaVung()
Case $txtMessage
Case $txtChuKy
Case $btnReLoad
    load_IMG()
Case $btnSend
    SendSMS()
Case $btnExit
    Exit
EndSwitch
WEnd
 
 
;*******************************************
;ham post va getData len web
;*******************************************
Func http($method,$oURL, $oData)
$oHTTP.Open($method, $oURL, False)
If $method = 'POST' Then
 $oHTTP.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
 EndIf
 $oHTTP.setRequestHeader ("User-Agent",$user_agent_)
  $oHTTP.setRequestHeader ("Accept-Language", "en-us,en;q=0.5")
 $oHTTP.setRequestHeader ("Accept-Charset", "ISO-8859-1,utf-8;q=0.7,*;q=0.7")
  $oHTTP.setRequestHeader ("Connection", "keep-alive")
  $oHTTP.setRequestHeader ("Keep-alive", "115")
 $oHTTP.setRequestHeader ("Referer", "http://for-ever.us/")
$oHTTP.setRequestHeader ("Accept","text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
  $oHTTP.Send($oData)
  $cookie = $oHTTP.getallresponseheaders
    Return $oHTTP.Responsetext
EndFunc
 
 
;*******************************************
;ham load file hinh captcha ve
;*******************************************
Func load_IMG()
_GDIPlus_ImageDispose($hImg)
$recv = http('GET',$host,'')
$hash = _StringBetween($recv,'?sid=','"')
   
If StringInStr($recv,'too many sms') Then
    MsgBox(16,'Lỗi roài ^^','Bạn đã gởi quá nhiều Sms, vui lòng reset modem để có thể tiếp tục'
    Return
EndIf
 
$link_captcha = 'http://for-ever.us/captcha/fuckXiaorui.php?sid=' & $hash[1]
 
$oHTTP.Open("GET", $link_captcha, False)
$oHTTP.setRequestHeader ("User-Agent",$user_agent_)
$oHTTP.setRequestHeader ("Accept",'*/*')
$oHTTP.setRequestHeader ("Referer",'http://for-ever.us/')
 
$oHTTP.Send()
$rec = $oHTTP.ResponseBody
Local $fh=FileOpen($img_patch, 2)
FileWrite($fh, $rec)
FileClose($fh)
 
$hImg = _GDIPlus_ImageLoadFromFile($img_patch)
$hGrp = _GDIPlus_GraphicsCreateFromHWND($Form1)
_GDIPlus_GraphicsDrawImage($hGrp, $hImg, 224, 72)
 
Global $hImg,$hGrp
 
EndFunc
 
 
;*******************************************
;ham gui SMS
;*******************************************
Func SendSMS()
Local $mobile,$sms,$captcha,$data
$mobile  = Int(GUICtrlRead($txtSoDienThoai))
$sms = GUICtrlRead($txtMessage)
$sig = GUICtrlRead($txtChuKy)
$sms = $sms & $sig
$captcha = GUICtrlRead($txtVerifyCode)
$len_mobile = StringLen($mobile)
$len_mess = StringLen($sms)
Select
Case IsInt($mobile) = 0 Or $len_mobile <11 Or $len_mobile > 12
     MsgBox(16,'Có lỗi ^_^!!!','Vui lòng nhập lại số mobi')
     Return
 Case StringLen($captcha) <> 5
     MsgBox(16,'Có lỗi ^_^!!!','Vui lòng nhập lại Image!')
     Return
 Case $len_mess < 1
      MsgBox(16,'Có lỗi ^_^!!!','Vui lòng nhập tin nhắn')
       Return
EndSelect
$data = 'phonenumber='&$mobile&'&submit_btn=Send&message='&$sms&'&verify='&$captcha
$result = http("POST",$host,$data)
GUICtrlSetData($txtVerifyCode,'')
If StringInStr($result,'the verify code you entered was invalid') Then
    load_IMG()
    MsgBox(16,'Có lỗi ^_^!!!','Vui lòng nhập lại Image! ')
    Return
    EndIf
If Not StringInStr($result,'Your sms has been sent to') Then
     MsgBox(16,'Có lỗi ^_^!!!','Có lỗi xảy ra, xin vui lòng nhập lại!')
 Else
   
MsgBox(0,"Chú ý","Tin nhắn đã được gởi tới số mobile " & $mobile)
EndIf
    load_IMG()
EndFunc
 
;*******************************************
;ham lay ma vung
;*******************************************
FunC getMaVung()
    $str = GUICtrlRead($ComboMaVung)
    $pos = StringInStr($str,"+");
    $code = StringRight($str,StringLen($str) - $pos)
    GUICtrlSetData($txtSoDienThoai,$code)
EndFunc
 