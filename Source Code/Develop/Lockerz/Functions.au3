#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.6.1
- Chức năng: quản lý các công việc của người dùng Lockerz
#ce ==========================================================

;~ Thoát khỏi chương trình
HotKeySet("{Esc}","ExitTool")
Func ExitTool()
	Exit
EndFunc

;~ Bắt đầu công việc với Lockerz
Func StartWork()
	AutoLogin()
EndFunc
	
;~ Tự đăng nhập từ ID và Pass trên GUI
Func AutoLogin()
	$oIE = _IECreate ($LockerzPage)
	$oForm = _IEFormGetCollection ($oIE, 0)
	$oQuery = _IEFormElementGetObjByName ($oForm, "handle")
	_IEFormElementSetValue ($oQuery, GetID())

	$oQuery = _IEFormElementGetObjByName ($oForm, "password")
	_IEFormElementSetValue ($oQuery, GetPass())
	
	_IEFormSubmit ($oForm)
EndFunc

#cs ==========================================================
<form method="post" action="auth/login" id="login-form">
					<div>
				    <label for="rememberme">Remember me</label><input type="checkbox" name="remember me" checked="checked" class="remember">
					
					<label class="no-js" id="email-label" for="email" style="display: none;">Email</label>
					
					<input type="text" autocomplete="off" value="" name="handle" id="email-email">
					
					<label class="no-js" id="combo-label" for="combination" style="display: none;">Combination</label>
										
				    <input type="text" autocomplete="off" value="Combination" id="password-clear" style="display: inline;">
					<input type="password" autocomplete="off" value="" name="password" id="password-password" style="display: none;">
										<input type="submit" value="Sign In" class="signin" id="sumbitLogin">
									    
					</div>
				
				</form>
			#ce ==========================================================
