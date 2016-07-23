#include <_HttpRequest.au3> ; // tks to Huan Hoang
#include <Array.au3> ; // tks to Huan Hoang
#include-once
#cs INFO
Simple System Lite v1.0
Coded by VinhPham (opdo.vn)
Tks to Huan Hoang (HttpRequest UDF)
#ce

#Region SETTING
Global Const $__SYSTEM__URL = 'http://localhost'
#EndRegion

Global Const $__MY__ID = 0
Global $USER_DETAILS, $USER_PASS, $USER_CHANGE = False

#Region User Func
; #FUNCTION# ====================================================================================================================
; Name ..........: _SS_Login
; Description ...: Thực hiện đăng nhập một account
; Syntax ........: _SS_Login($acc, $pass)
; Parameters ....: $acc                 - account
;                  $pass                - password
; Return values .: return về mảng $USER_DETAILS chứa thông tin user, và $USER_PASS chứa password user. nếu thất bại set @error = 1
; Author ........: Vinh Pham
; ===============================================================================================================================
Func _SS_Login($acc, $pass)
	$request = _HttpRequest(3, $__SYSTEM__URL & '/ss_login.php', 'acc=' & $acc & '&pass=' & $pass & '&id=' & $__MY__ID)
	$message = _Return_Message($request)
	If @error Then
		MsgBox(16, 'Thông báo', $message)
		Return SetError(1, 0, 0)
	EndIf
	Global $USER_DETAILS = StringSplit($message, '|')
	Global $USER_PASS = $pass
	Return $USER_DETAILS
EndFunc   ;==>_SS_Login

; #FUNCTION# ====================================================================================================================
; Name ..........: _SS_RegAcc
; Description ...: Thực hiện đăng ký một account
; Syntax ........: _SS_RegAcc($acc, $pass, $id, $name, $email)
; Parameters ....: $acc                 - account
;                  $pass                - pass
;                  $id                  - id
;                  $name                - name
;                  $email               - email
; Return values .: 1 nếu đăng ký thành công, 0 và báo lỗi nếu đăng ký thất bại
; Author ........: Vinh Pham
; ===============================================================================================================================
Func _SS_RegAcc($acc, $pass, $id, $name, $email)
	$request = _HttpRequest(3, $__SYSTEM__URL & '/ss_reg.php', 'acc=' & $acc & '&pass=' & $pass & '&id=' & $id & '&name=' & $name & '&email=' & $email)
	$message = _Return_Message($request)
	If @error Then
		MsgBox(16, 'Thông báo', $message)
		Return SetError(1, 0, 0)
	EndIf
	Return SetError(1, 0, 1)
EndFunc   ;==>_SS_RegAcc

; #FUNCTION# ====================================================================================================================
; Name ..........: _SS_AddCode
; Description ...: Thực hiện chức năng nạp key tăng hạn sử dụng cho user
; Syntax ........: _SS_AddCode()
; Parameters ....:
; Return values .: False nếu thất bại, True nếu thành công
; Author ........: Vinh Pham
; Related .......: Phải gọi hàm _SS_Login() thành công để sử dụng hàm này
; ===============================================================================================================================
Func _SS_AddCode()
	If Not IsArray($USER_DETAILS) Then Return 0
	$ib = InputBox('Nhập code', 'Nhập code sử dụng')
	If $ib = '' Or @error Then Return False
	$request = _HttpRequest(3, $__SYSTEM__URL & '/ss_func.php?cmd=addcode', 'acc=' & $USER_DETAILS[1] & '&pass=' & $USER_PASS & '&id=' & $__MY__ID & '&code=' & $ib)
	$message = _Return_Message($request)
	If @error Then
		MsgBox(16, 'Thông báo', $message)
		Return False
	Else
		Global $USER_DETAILS = StringSplit($message, '|')
		MsgBox(64, 'Thành công', 'Sử dụng được ' & $USER_DETAILS[5] & ' lần')
		Return True
	EndIf
EndFunc   ;==>_SS_AddCode


; #FUNCTION# ====================================================================================================================
; Name ..........: _SS_ChangeInfo
; Description ...: Đổi info của user
; Syntax ........: _SS_ChangeInfo($info, $value)
; Parameters ....: $info                - column muốn đổi.
;                  $value               - đổi thành giá trị nào.
; Return values .: True nếu thành công và false nếu thất bại, sau đó nếu thành công các giá trị của $USER_DETAILS sẽ được thay đổi, $USER_CHANGE chuyển thành true
; Author ........: Vinh Pham
; Related .......: Phải gọi hàm _SS_Login() thành công để sử dụng hàm này
; ===============================================================================================================================
Func _SS_ChangeInfo($info, $value)
	$request = _HttpRequest(3, $__SYSTEM__URL & '/ss_func.php?cmd=changeinfo', 'acc=' & $USER_DETAILS[1] & '&pass=' & $USER_PASS & '&id=' & $__MY__ID & '&info=' & $info & '&value=' & $value)
	If Number($request) = 1 Then
		$request = _HttpRequest(3, $__SYSTEM__URL & '/ss_login.php', 'acc=' & $USER_DETAILS[1] & '&pass=' & $USER_PASS & '&id=' & $__MY__ID)
		$message = _Return_Message($request)
		$USER_CHANGE = True
		$USER_DETAILS = StringSplit($message, '|')
		Return True
	Else
		Return False
	EndIf
EndFunc   ;==>_SS_ChangeInfo

; #FUNCTION# ====================================================================================================================
; Name ..........: _SS_CheckVaild
; Description ...: Kiểm tra hạn sử dụng của tài khoản
; Syntax ........: _SS_CheckVaild()
; Parameters ....:
; Return values .: True nếu còn hạn, False nếu hết hạn
; Author ........: Vinh Pham
; Related .......: Phải gọi hàm _SS_Login() thành công để sử dụng hàm này
; ===============================================================================================================================
Func _SS_CheckVaild()
	If Not IsArray($USER_DETAILS) Then Return 0
	$request = _HttpRequest(3, $__SYSTEM__URL & '/ss_func.php?cmd=checkvaild', 'acc=' & $USER_DETAILS[1])
	If Number($request) = 1 Then Return True
	Return False
EndFunc   ;==>_SS_CheckVaild

; #FUNCTION# ====================================================================================================================
; Name ..........: _SS_CFC
; Description ...: Gọi một function cmd trên php
; Syntax ........: _SS_CFC($cmd[, $post = ''])
; Parameters ....: $cmd                 - lệnh cmd muốn gửi lên.
;                  $post                - [optional] lệnh post muốn gửi kèm. Default is ''.
; Return values .: Trả về $request từ php
; Author ........: Vinh Pham
; Related .......: Phải gọi hàm _SS_Login() thành công để sử dụng hàm này
; ===============================================================================================================================
Func _SS_CFC($cmd, $post = '') ; call func cmd
	If IsArray($USER_DETAILS) Then
		If $post <> '' Then $post = '&' & $post
		$request = _HttpRequest(3, $__SYSTEM__URL & '/ss_func.php?cmd=' & $cmd, 'acc=' & $USER_DETAILS[1] & '&pass=' & $USER_PASS & '&id=' & $__MY__ID & $post)
		Return $request
	EndIf
EndFunc   ;==>_SS_CFC


; #FUNCTION# ====================================================================================================================
; Name ..........: _SS_GetInfo
; Description ...: Lấy thông tin simple system
; Syntax ........: _SS_GetInfo()
; Parameters ....:
; Return values .: Thông tin trả về dạng <phiên bản>|<count by date: 1 nếu có, 0 nếu count by times>
; Author ........: Vinh Phạm
; ===============================================================================================================================
Func _SS_GetInfo()
	$request = _HttpRequest(3, $__SYSTEM__URL & '/ss_func.php?cmd=getinfo')
	Return StringSplit($request, '|')
EndFunc   ;==>_SS_GetInfo

Func _Return_Message($message)
	$ss = StringSplit($message, '[opdo:]', 1)
	If @error Then Return $message
	If $ss[0] < 2 Then Return $message
	If $ss[1] = 'ERROR' Then Return SetError(1, 0, $ss[2])
	If $ss[1] = 'SUCCESS' Then Return SetError(0, 0, $ss[2])
	Return SetError(1, 0, $ss[2])
EndFunc   ;==>_Return_Message

#EndRegion

#Region Admin func
; #FUNCTION# ====================================================================================================================
; Name ..........: _SS_Admin_IsAdmin
; Description ...: Kiểm tra quyền admin của tài khoản
; Syntax ........: _SS_Admin_IsAdmin()
; Parameters ....:
; Return values .: True nếu có, False nếu không
; Author ........: Vinh Pham
; Related .......: Phải gọi hàm _SS_Login() thành công để sử dụng hàm này
; ===============================================================================================================================
Func _SS_Admin_IsAdmin()
	If Not IsArray($USER_DETAILS) Then Return False
	$request = _HttpRequest(3, $__SYSTEM__URL & '/ss_admin.php?admin=isadmin', 'acc=' & $USER_DETAILS[1] & '&pass=' & $USER_PASS)
	if Number($request) = 1 Then Return True
	Return False
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _SS_Admin_GetListMember
; Description ...: Lấy danh sách member system
; Syntax ........: _SS_Admin_GetListMember()
; Parameters ....:
; Return values .: Trả về list bao gồm 1 mảng mà mỗi ngăn là thông tin được tách với nhau bằng dấu "|"
; Author ........: Vinh Pham
; Related .......: Phải gọi hàm _SS_Login() thành công để sử dụng hàm này
; ===============================================================================================================================
Func _SS_Admin_GetListMember()
	If Not IsArray($USER_DETAILS) Then Return 0
	$request = _HttpRequest(3, $__SYSTEM__URL & '/ss_admin.php?admin=listmember', 'acc=' & $USER_DETAILS[1] & '&pass=' & $USER_PASS)
	$message = _Return_Message($request)
	If @error Then
		MsgBox(16, 'Thông báo', $message)
		Return -1
	Else
		Local $return[0]
		Local $ss = StringSplit($request,@CRLF)
		For $i = 1 To $ss[0]
			if $ss[$i] <> '' Then _ArrayAdd($return,$ss[$i],Default, Default, Default, 1)
		Next
		Return $return
	EndIf
EndFunc

; #FUNCTION# ====================================================================================================================
; Name ..........: _SS_Admin_ChangeInfo
; Description ...: Thay đổi thông tin một user bất kỳ
; Syntax ........: _SS_Admin_ChangeInfo($acc, $info, $value)
; Parameters ....: $acc                 - account muốn đổi thông tin.
;                  $info                - column muốn đổi.
;                  $value               - giá trị muốn đổi.
; Return values .: True nếu thành công và false nếu thất bại
; Author ........: Vinh Pham
; Related .......: Phải gọi hàm _SS_Login() thành công để sử dụng hàm này
; ===============================================================================================================================
Func _SS_Admin_ChangeInfo($acc ,$info, $value)
	If Not IsArray($USER_DETAILS) Then Return 0
	$request = _HttpRequest(3, $__SYSTEM__URL & '/ss_admin.php?admin=changeinfo', 'acc=' & $USER_DETAILS[1] & '&pass=' & $USER_PASS & '&uacc=' & $acc & '&uinfo=' & $info & '&uvalue=' & $value)
	If Number($request) = 1 Then
		Return true
	Else
		Return False
	EndIf
EndFunc   ;==>_SS_ChangeInfo
#EndRegion