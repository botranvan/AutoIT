#region _Memory
Func _MEMORYOPEN($IV_PID, $IV_DESIREDACCESS = 2035711, $IV_INHERITHANDLE = 1)
	If Not ProcessExists($IV_PID) Then
		SetError(1)
		Return 0
	EndIf
	Local $AH_HANDLE[2] = [DllOpen("kernel32.dll")]
	If @error Then
		SetError(2)
		Return 0
	EndIf
	Local $AV_OPENPROCESS = DllCall($AH_HANDLE[0], "int", "OpenProcess", "int", $IV_DESIREDACCESS, "int", $IV_INHERITHANDLE, "int", $IV_PID)
	If @error Then
		DllClose($AH_HANDLE[0])
		SetError(3)
		Return 0
	EndIf
	$AH_HANDLE[1] = $AV_OPENPROCESS[0]
	Return $AH_HANDLE
EndFunc
Func _MEMORYREAD($IV_ADDRESS, $AH_HANDLE, $SV_TYPE = "dword")
	If Not IsArray($AH_HANDLE) Then
		SetError(1)
		Return 0
	EndIf
	Local $V_BUFFER = DllStructCreate($SV_TYPE)
	If @error Then
		SetError(@error + 1)
		Return 0
	EndIf
	DllCall($AH_HANDLE[0], "int", "ReadProcessMemory", "int", $AH_HANDLE[1], "int", $IV_ADDRESS, "ptr", DllStructGetPtr($V_BUFFER), "int", DllStructGetSize($V_BUFFER), "int", "")
	If Not @error Then
		Local $V_VALUE = DllStructGetData($V_BUFFER, 1)
		Return $V_VALUE
	Else
		SetError(6)
		Return 0
	EndIf
EndFunc
Func _MEMORYWRITE($IV_ADDRESS, $AH_HANDLE, $V_DATA, $SV_TYPE = "dword")
	If Not IsArray($AH_HANDLE) Then
		SetError(1)
		Return 0
	EndIf
	Local $V_BUFFER = DllStructCreate($SV_TYPE)
	If @error Then
		SetError(@error + 1)
		Return 0
	Else
		DllStructSetData($V_BUFFER, 1, $V_DATA)
		If @error Then
			SetError(6)
			Return 0
		EndIf
	EndIf
	DllCall($AH_HANDLE[0], "int", "WriteProcessMemory", "int", $AH_HANDLE[1], "int", $IV_ADDRESS, "ptr", DllStructGetPtr($V_BUFFER), "int", DllStructGetSize($V_BUFFER), "int", "")
	If Not @error Then
		Return 1
	Else
		SetError(7)
		Return 0
	EndIf
EndFunc
Func _MEMORYCLOSE($AH_HANDLE)
	If Not IsArray($AH_HANDLE) Then
		SetError(1)
		Return 0
	EndIf
	DllCall($AH_HANDLE[0], "int", "CloseHandle", "int", $AH_HANDLE[1])
	If Not @error Then
		DllClose($AH_HANDLE[0])
		Return 1
	Else
		DllClose($AH_HANDLE[0])
		SetError(2)
		Return 0
	EndIf
EndFunc
Func SETPRIVILEGE($PRIVILEGE, $BENABLE)
	Const $TOKEN_ADJUST_PRIVILEGES = 32
	Const $TOKEN_QUERY = 8
	Const $SE_PRIVILEGE_ENABLED = 2
	Local $HTOKEN, $SP_AUXRET, $SP_RET, $HCURRPROCESS, $NTOKENS, $NTOKENINDEX, $PRIV
	$NTOKENS = 1
	$LUID = DllStructCreate("dword;int")
	If IsArray($PRIVILEGE) Then $NTOKENS = UBound($PRIVILEGE)
	$TOKEN_PRIVILEGES = DllStructCreate("dword;dword[" & (3 * $NTOKENS) & "]")
	$NEWTOKEN_PRIVILEGES = DllStructCreate("dword;dword[" & (3 * $NTOKENS) & "]")
	$HCURRPROCESS = DllCall("kernel32.dll", "hwnd", "GetCurrentProcess")
	$SP_AUXRET = DllCall("advapi32.dll", "int", "OpenProcessToken", "hwnd", $HCURRPROCESS[0], "int", BitOR($TOKEN_ADJUST_PRIVILEGES, $TOKEN_QUERY), "int_ptr", 0)
	If $SP_AUXRET[0] Then
		$HTOKEN = $SP_AUXRET[3]
		DllStructSetData($TOKEN_PRIVILEGES, 1, 1)
		$NTOKENINDEX = 1
		While $NTOKENINDEX <= $NTOKENS
			If IsArray($PRIVILEGE) Then
				$PRIV = $PRIVILEGE[$NTOKENINDEX - 1]
			Else
				$PRIV = $PRIVILEGE
			EndIf
			$RET = DllCall("advapi32.dll", "int", "LookupPrivilegeValue", "str", "", "str", $PRIV, "ptr", DllStructGetPtr($LUID))
			If $RET[0] Then
				If $BENABLE Then
					DllStructSetData($TOKEN_PRIVILEGES, 2, $SE_PRIVILEGE_ENABLED, (3 * $NTOKENINDEX))
				Else
					DllStructSetData($TOKEN_PRIVILEGES, 2, 0, (3 * $NTOKENINDEX))
				EndIf
				DllStructSetData($TOKEN_PRIVILEGES, 2, DllStructGetData($LUID, 1), (3 * ($NTOKENINDEX - 1)) + 1)
				DllStructSetData($TOKEN_PRIVILEGES, 2, DllStructGetData($LUID, 2), (3 * ($NTOKENINDEX - 1)) + 2)
				DllStructSetData($LUID, 1, 0)
				DllStructSetData($LUID, 2, 0)
			EndIf
			$NTOKENINDEX += 1
		WEnd
		$RET = DllCall("advapi32.dll", "int", "AdjustTokenPrivileges", "hwnd", $HTOKEN, "int", 0, "ptr", DllStructGetPtr($TOKEN_PRIVILEGES), "int", DllStructGetSize($NEWTOKEN_PRIVILEGES), "ptr", DllStructGetPtr($NEWTOKEN_PRIVILEGES), "int_ptr", 0)
		$F = DllCall("kernel32.dll", "int", "GetLastError")
	EndIf
	$NEWTOKEN_PRIVILEGES = 0
	$TOKEN_PRIVILEGES = 0
	$LUID = 0
	If $SP_AUXRET[0] = 0 Then Return 0
	$SP_AUXRET = DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $HTOKEN)
	If Not $RET[0] And Not $SP_AUXRET[0] Then Return 0
	Return $RET[0]
EndFunc
#EndRegion
Global $CHAR_NAME = ""
Global $CHAR_ID = 0
Global $CHAR_LV = 1
Global $CHAR_HPCUR = 100
Global $CHAR_HPMAX = 100
Global $CHAR_MPCUR = 100
Global $CHAR_MPMAX = 100
Global $PET_HPCUR
Global $PET_HPMAX
Global $PET_MPCUR
Global $PET_MPMAX
Global $PET_ID = 0
Global $BUFFSELF[4]
Global $BUFFPET[4]
Global $MEMGAME
Global $GAMECLASS = "[CLASS:_PERFECTWORLD_HUGEROCK]"
Global $GAMECHARLIST = WinList($GAMECLASS)
If Not $GAMECHARLIST[0][0] Then
	MsgBox(0, "micBotKT", "Cannot find game")
	Exit
EndIf
Global $GAMEHANDLE = $GAMECHARLIST[1][1]
Global $GAMEPID = WinGetProcess($GAMEHANDLE)
Global Const $BS_GROUPBOX = 7
Global Const $BS_BOTTOM = 2048
Global Const $BS_CENTER = 768
Global Const $BS_DEFPUSHBUTTON = 1
Global Const $BS_LEFT = 256
Global Const $BS_MULTILINE = 8192
Global Const $BS_PUSHBOX = 10
Global Const $BS_PUSHLIKE = 4096
Global Const $BS_RIGHT = 512
Global Const $BS_RIGHTBUTTON = 32
Global Const $BS_TOP = 1024
Global Const $BS_VCENTER = 3072
Global Const $BS_FLAT = 32768
Global Const $BS_ICON = 64
Global Const $BS_BITMAP = 128
Global Const $BS_NOTIFY = 16384
Global Const $BS_SPLITBUTTON = 12
Global Const $BS_DEFSPLITBUTTON = 13
Global Const $BS_COMMANDLINK = 14
Global Const $BS_DEFCOMMANDLINK = 15
Global Const $BCSIF_GLYPH = 1
Global Const $BCSIF_IMAGE = 2
Global Const $BCSIF_STYLE = 4
Global Const $BCSIF_SIZE = 8
Global Const $BCSS_NOSPLIT = 1
Global Const $BCSS_STRETCH = 2
Global Const $BCSS_ALIGNLEFT = 4
Global Const $BCSS_IMAGE = 8
Global Const $BUTTON_IMAGELIST_ALIGN_LEFT = 0
Global Const $BUTTON_IMAGELIST_ALIGN_RIGHT = 1
Global Const $BUTTON_IMAGELIST_ALIGN_TOP = 2
Global Const $BUTTON_IMAGELIST_ALIGN_BOTTOM = 3
Global Const $BUTTON_IMAGELIST_ALIGN_CENTER = 4
Global Const $BS_3STATE = 5
Global Const $BS_AUTO3STATE = 6
Global Const $BS_AUTOCHECKBOX = 3
Global Const $BS_CHECKBOX = 2
Global Const $BS_RADIOBUTTON = 4
Global Const $BS_AUTORADIOBUTTON = 9
Global Const $BS_OWNERDRAW = 11
Global Const $GUI_SS_DEFAULT_BUTTON = 0
Global Const $GUI_SS_DEFAULT_CHECKBOX = 0
Global Const $GUI_SS_DEFAULT_GROUP = 0
Global Const $GUI_SS_DEFAULT_RADIO = 0
Global Const $BCM_FIRST = 5632
Global Const $BCM_GETIDEALSIZE = ($BCM_FIRST + 1)
Global Const $BCM_GETIMAGELIST = ($BCM_FIRST + 3)
Global Const $BCM_GETNOTE = ($BCM_FIRST + 10)
Global Const $BCM_GETNOTELENGTH = ($BCM_FIRST + 11)
Global Const $BCM_GETSPLITINFO = ($BCM_FIRST + 8)
Global Const $BCM_GETTEXTMARGIN = ($BCM_FIRST + 5)
Global Const $BCM_SETDROPDOWNSTATE = ($BCM_FIRST + 6)
Global Const $BCM_SETIMAGELIST = ($BCM_FIRST + 2)
Global Const $BCM_SETNOTE = ($BCM_FIRST + 9)
Global Const $BCM_SETSHIELD = ($BCM_FIRST + 12)
Global Const $BCM_SETSPLITINFO = ($BCM_FIRST + 7)
Global Const $BCM_SETTEXTMARGIN = ($BCM_FIRST + 4)
Global Const $BM_CLICK = 245
Global Const $BM_GETCHECK = 240
Global Const $BM_GETIMAGE = 246
Global Const $BM_GETSTATE = 242
Global Const $BM_SETCHECK = 241
Global Const $BM_SETDONTCLICK = 248
Global Const $BM_SETIMAGE = 247
Global Const $BM_SETSTATE = 243
Global Const $BM_SETSTYLE = 244
Global Const $BCN_FIRST = -1250
Global Const $BCN_DROPDOWN = ($BCN_FIRST + 2)
Global Const $BCN_HOTITEMCHANGE = ($BCN_FIRST + 1)
Global Const $BN_CLICKED = 0
Global Const $BN_PAINT = 1
Global Const $BN_HILITE = 2
Global Const $BN_UNHILITE = 3
Global Const $BN_DISABLE = 4
Global Const $BN_DOUBLECLICKED = 5
Global Const $BN_SETFOCUS = 6
Global Const $BN_KILLFOCUS = 7
Global Const $BN_PUSHED = $BN_HILITE
Global Const $BN_UNPUSHED = $BN_UNHILITE
Global Const $BN_DBLCLK = $BN_DOUBLECLICKED
Global Const $BST_CHECKED = 1
Global Const $BST_INDETERMINATE = 2
Global Const $BST_UNCHECKED = 0
Global Const $BST_FOCUS = 8
Global Const $BST_PUSHED = 4
Global Const $BST_DONTCLICK = 128
Global Const $CB_ERR = -1
Global Const $CB_ERRATTRIBUTE = -3
Global Const $CB_ERRREQUIRED = -4
Global Const $CB_ERRSPACE = -2
Global Const $CB_OKAY = 0
Global Const $STATE_SYSTEM_INVISIBLE = 32768
Global Const $STATE_SYSTEM_PRESSED = 8
Global Const $CBS_AUTOHSCROLL = 64
Global Const $CBS_DISABLENOSCROLL = 2048
Global Const $CBS_DROPDOWN = 2
Global Const $CBS_DROPDOWNLIST = 3
Global Const $CBS_HASSTRINGS = 512
Global Const $CBS_LOWERCASE = 16384
Global Const $CBS_NOINTEGRALHEIGHT = 1024
Global Const $CBS_OEMCONVERT = 128
Global Const $CBS_OWNERDRAWFIXED = 16
Global Const $CBS_OWNERDRAWVARIABLE = 32
Global Const $CBS_SIMPLE = 1
Global Const $CBS_SORT = 256
Global Const $CBS_UPPERCASE = 8192
Global Const $CBM_FIRST = 5888
Global Const $CB_ADDSTRING = 323
Global Const $CB_DELETESTRING = 324
Global Const $CB_DIR = 325
Global Const $CB_FINDSTRING = 332
Global Const $CB_FINDSTRINGEXACT = 344
Global Const $CB_GETCOMBOBOXINFO = 356
Global Const $CB_GETCOUNT = 326
Global Const $CB_GETCUEBANNER = ($CBM_FIRST + 4)
Global Const $CB_GETCURSEL = 327
Global Const $CB_GETDROPPEDCONTROLRECT = 338
Global Const $CB_GETDROPPEDSTATE = 343
Global Const $CB_GETDROPPEDWIDTH = 351
Global Const $CB_GETEDITSEL = 320
Global Const $CB_GETEXTENDEDUI = 342
Global Const $CB_GETHORIZONTALEXTENT = 349
Global Const $CB_GETITEMDATA = 336
Global Const $CB_GETITEMHEIGHT = 340
Global Const $CB_GETLBTEXT = 328
Global Const $CB_GETLBTEXTLEN = 329
Global Const $CB_GETLOCALE = 346
Global Const $CB_GETMINVISIBLE = 5890
Global Const $CB_GETTOPINDEX = 347
Global Const $CB_INITSTORAGE = 353
Global Const $CB_LIMITTEXT = 321
Global Const $CB_RESETCONTENT = 331
Global Const $CB_INSERTSTRING = 330
Global Const $CB_SELECTSTRING = 333
Global Const $CB_SETCUEBANNER = ($CBM_FIRST + 3)
Global Const $CB_SETCURSEL = 334
Global Const $CB_SETDROPPEDWIDTH = 352
Global Const $CB_SETEDITSEL = 322
Global Const $CB_SETEXTENDEDUI = 341
Global Const $CB_SETHORIZONTALEXTENT = 350
Global Const $CB_SETITEMDATA = 337
Global Const $CB_SETITEMHEIGHT = 339
Global Const $CB_SETLOCALE = 345
Global Const $CB_SETMINVISIBLE = 5889
Global Const $CB_SETTOPINDEX = 348
Global Const $CB_SHOWDROPDOWN = 335
Global Const $CBN_CLOSEUP = 8
Global Const $CBN_DBLCLK = 2
Global Const $CBN_DROPDOWN = 7
Global Const $CBN_EDITCHANGE = 5
Global Const $CBN_EDITUPDATE = 6
Global Const $CBN_ERRSPACE = (-1)
Global Const $CBN_KILLFOCUS = 4
Global Const $CBN_SELCHANGE = 1
Global Const $CBN_SELENDCANCEL = 10
Global Const $CBN_SELENDOK = 9
Global Const $CBN_SETFOCUS = 3
Global Const $CBES_EX_CASESENSITIVE = 16
Global Const $CBES_EX_NOEDITIMAGE = 1
Global Const $CBES_EX_NOEDITIMAGEINDENT = 2
Global Const $CBES_EX_NOSIZELIMIT = 8
Global Const $CBES_EX_PATHWORDBREAKPROC = 4
Global Const $__COMBOBOXCONSTANT_WM_USER = 1024
Global Const $CBEM_DELETEITEM = $CB_DELETESTRING
Global Const $CBEM_GETCOMBOCONTROL = ($__COMBOBOXCONSTANT_WM_USER + 6)
Global Const $CBEM_GETEDITCONTROL = ($__COMBOBOXCONSTANT_WM_USER + 7)
Global Const $CBEM_GETEXSTYLE = ($__COMBOBOXCONSTANT_WM_USER + 9)
Global Const $CBEM_GETEXTENDEDSTYLE = ($__COMBOBOXCONSTANT_WM_USER + 9)
Global Const $CBEM_GETIMAGELIST = ($__COMBOBOXCONSTANT_WM_USER + 3)
Global Const $CBEM_GETITEMA = ($__COMBOBOXCONSTANT_WM_USER + 4)
Global Const $CBEM_GETITEMW = ($__COMBOBOXCONSTANT_WM_USER + 13)
Global Const $CBEM_GETUNICODEFORMAT = 8192 + 6
Global Const $CBEM_HASEDITCHANGED = ($__COMBOBOXCONSTANT_WM_USER + 10)
Global Const $CBEM_INSERTITEMA = ($__COMBOBOXCONSTANT_WM_USER + 1)
Global Const $CBEM_INSERTITEMW = ($__COMBOBOXCONSTANT_WM_USER + 11)
Global Const $CBEM_SETEXSTYLE = ($__COMBOBOXCONSTANT_WM_USER + 8)
Global Const $CBEM_SETEXTENDEDSTYLE = ($__COMBOBOXCONSTANT_WM_USER + 14)
Global Const $CBEM_SETIMAGELIST = ($__COMBOBOXCONSTANT_WM_USER + 2)
Global Const $CBEM_SETITEMA = ($__COMBOBOXCONSTANT_WM_USER + 5)
Global Const $CBEM_SETITEMW = ($__COMBOBOXCONSTANT_WM_USER + 12)
Global Const $CBEM_SETUNICODEFORMAT = 8192 + 5
Global Const $CBEM_SETWINDOWTHEME = 8192 + 11
Global Const $CBEN_FIRST = (-800)
Global Const $CBEN_LAST = (-830)
Global Const $CBEN_BEGINEDIT = ($CBEN_FIRST - 4)
Global Const $CBEN_DELETEITEM = ($CBEN_FIRST - 2)
Global Const $CBEN_DRAGBEGINA = ($CBEN_FIRST - 8)
Global Const $CBEN_DRAGBEGINW = ($CBEN_FIRST - 9)
Global Const $CBEN_ENDEDITA = ($CBEN_FIRST - 5)
Global Const $CBEN_ENDEDITW = ($CBEN_FIRST - 6)
Global Const $CBEN_GETDISPINFO = ($CBEN_FIRST - 0)
Global Const $CBEN_GETDISPINFOA = ($CBEN_FIRST - 0)
Global Const $CBEN_GETDISPINFOW = ($CBEN_FIRST - 7)
Global Const $CBEN_INSERTITEM = ($CBEN_FIRST - 1)
Global Const $CBEIF_DI_SETITEM = 268435456
Global Const $CBEIF_IMAGE = 2
Global Const $CBEIF_INDENT = 16
Global Const $CBEIF_LPARAM = 32
Global Const $CBEIF_OVERLAY = 8
Global Const $CBEIF_SELECTEDIMAGE = 4
Global Const $CBEIF_TEXT = 1
Global Const $__COMBOBOXCONSTANT_WS_VSCROLL = 2097152
Global Const $GUI_SS_DEFAULT_COMBO = BitOR($CBS_DROPDOWN, $CBS_AUTOHSCROLL, $__COMBOBOXCONSTANT_WS_VSCROLL)
Global Const $ES_LEFT = 0
Global Const $ES_CENTER = 1
Global Const $ES_RIGHT = 2
Global Const $ES_MULTILINE = 4
Global Const $ES_UPPERCASE = 8
Global Const $ES_LOWERCASE = 16
Global Const $ES_PASSWORD = 32
Global Const $ES_AUTOVSCROLL = 64
Global Const $ES_AUTOHSCROLL = 128
Global Const $ES_NOHIDESEL = 256
Global Const $ES_OEMCONVERT = 1024
Global Const $ES_READONLY = 2048
Global Const $ES_WANTRETURN = 4096
Global Const $ES_NUMBER = 8192
Global Const $EC_ERR = -1
Global Const $ECM_FIRST = 5376
Global Const $EM_CANUNDO = 198
Global Const $EM_CHARFROMPOS = 215
Global Const $EM_EMPTYUNDOBUFFER = 205
Global Const $EM_FMTLINES = 200
Global Const $EM_GETCUEBANNER = ($ECM_FIRST + 2)
Global Const $EM_GETFIRSTVISIBLELINE = 206
Global Const $EM_GETHANDLE = 189
Global Const $EM_GETIMESTATUS = 217
Global Const $EM_GETLIMITTEXT = 213
Global Const $EM_GETLINE = 196
Global Const $EM_GETLINECOUNT = 186
Global Const $EM_GETMARGINS = 212
Global Const $EM_GETMODIFY = 184
Global Const $EM_GETPASSWORDCHAR = 210
Global Const $EM_GETRECT = 178
Global Const $EM_GETSEL = 176
Global Const $EM_GETTHUMB = 190
Global Const $EM_GETWORDBREAKPROC = 209
Global Const $EM_HIDEBALLOONTIP = ($ECM_FIRST + 4)
Global Const $EM_LIMITTEXT = 197
Global Const $EM_LINEFROMCHAR = 201
Global Const $EM_LINEINDEX = 187
Global Const $EM_LINELENGTH = 193
Global Const $EM_LINESCROLL = 182
Global Const $EM_POSFROMCHAR = 214
Global Const $EM_REPLACESEL = 194
Global Const $EM_SCROLL = 181
Global Const $EM_SCROLLCARET = 183
Global Const $EM_SETCUEBANNER = ($ECM_FIRST + 1)
Global Const $EM_SETHANDLE = 188
Global Const $EM_SETIMESTATUS = 216
Global Const $EM_SETLIMITTEXT = $EM_LIMITTEXT
Global Const $EM_SETMARGINS = 211
Global Const $EM_SETMODIFY = 185
Global Const $EM_SETPASSWORDCHAR = 204
Global Const $EM_SETREADONLY = 207
Global Const $EM_SETRECT = 179
Global Const $EM_SETRECTNP = 180
Global Const $EM_SETSEL = 177
Global Const $EM_SETTABSTOPS = 203
Global Const $EM_SETWORDBREAKPROC = 208
Global Const $EM_SHOWBALLOONTIP = ($ECM_FIRST + 3)
Global Const $EM_UNDO = 199
Global Const $EC_LEFTMARGIN = 1
Global Const $EC_RIGHTMARGIN = 2
Global Const $EC_USEFONTINFO = 65535
Global Const $EMSIS_COMPOSITIONSTRING = 1
Global Const $EIMES_GETCOMPSTRATONCE = 1
Global Const $EIMES_CANCELCOMPSTRINFOCUS = 2
Global Const $EIMES_COMPLETECOMPSTRKILLFOCUS = 4
Global Const $EN_ALIGN_LTR_EC = 1792
Global Const $EN_ALIGN_RTL_EC = 1793
Global Const $EN_CHANGE = 768
Global Const $EN_ERRSPACE = 1280
Global Const $EN_HSCROLL = 1537
Global Const $EN_KILLFOCUS = 512
Global Const $EN_MAXTEXT = 1281
Global Const $EN_SETFOCUS = 256
Global Const $EN_UPDATE = 1024
Global Const $EN_VSCROLL = 1538
Global Const $TTI_NONE = 0
Global Const $TTI_INFO = 1
Global Const $TTI_WARNING = 2
Global Const $TTI_ERROR = 3
Global Const $TTI_INFO_LARGE = 4
Global Const $TTI_WARNING_LARGE = 5
Global Const $TTI_ERROR_LARGE = 6
Global Const $__EDITCONSTANT_WS_VSCROLL = 2097152
Global Const $__EDITCONSTANT_WS_HSCROLL = 1048576
Global Const $GUI_SS_DEFAULT_EDIT = BitOR($ES_WANTRETURN, $__EDITCONSTANT_WS_VSCROLL, $__EDITCONSTANT_WS_HSCROLL, $ES_AUTOVSCROLL, $ES_AUTOHSCROLL)
Global Const $GUI_SS_DEFAULT_INPUT = BitOR($ES_LEFT, $ES_AUTOHSCROLL)
Global Const $GUI_EVENT_CLOSE = -3
Global Const $GUI_EVENT_MINIMIZE = -4
Global Const $GUI_EVENT_RESTORE = -5
Global Const $GUI_EVENT_MAXIMIZE = -6
Global Const $GUI_EVENT_PRIMARYDOWN = -7
Global Const $GUI_EVENT_PRIMARYUP = -8
Global Const $GUI_EVENT_SECONDARYDOWN = -9
Global Const $GUI_EVENT_SECONDARYUP = -10
Global Const $GUI_EVENT_MOUSEMOVE = -11
Global Const $GUI_EVENT_RESIZED = -12
Global Const $GUI_EVENT_DROPPED = -13
Global Const $GUI_RUNDEFMSG = "GUI_RUNDEFMSG"
Global Const $GUI_AVISTOP = 0
Global Const $GUI_AVISTART = 1
Global Const $GUI_AVICLOSE = 2
Global Const $GUI_CHECKED = 1
Global Const $GUI_INDETERMINATE = 2
Global Const $GUI_UNCHECKED = 4
Global Const $GUI_DROPACCEPTED = 8
Global Const $GUI_NODROPACCEPTED = 4096
Global Const $GUI_ACCEPTFILES = $GUI_DROPACCEPTED
Global Const $GUI_SHOW = 16
Global Const $GUI_HIDE = 32
Global Const $GUI_ENABLE = 64
Global Const $GUI_DISABLE = 128
Global Const $GUI_FOCUS = 256
Global Const $GUI_NOFOCUS = 8192
Global Const $GUI_DEFBUTTON = 512
Global Const $GUI_EXPAND = 1024
Global Const $GUI_ONTOP = 2048
Global Const $GUI_FONTITALIC = 2
Global Const $GUI_FONTUNDER = 4
Global Const $GUI_FONTSTRIKE = 8
Global Const $GUI_DOCKAUTO = 1
Global Const $GUI_DOCKLEFT = 2
Global Const $GUI_DOCKRIGHT = 4
Global Const $GUI_DOCKHCENTER = 8
Global Const $GUI_DOCKTOP = 32
Global Const $GUI_DOCKBOTTOM = 64
Global Const $GUI_DOCKVCENTER = 128
Global Const $GUI_DOCKWIDTH = 256
Global Const $GUI_DOCKHEIGHT = 512
Global Const $GUI_DOCKSIZE = 768
Global Const $GUI_DOCKMENUBAR = 544
Global Const $GUI_DOCKSTATEBAR = 576
Global Const $GUI_DOCKALL = 802
Global Const $GUI_DOCKBORDERS = 102
Global Const $GUI_GR_CLOSE = 1
Global Const $GUI_GR_LINE = 2
Global Const $GUI_GR_BEZIER = 4
Global Const $GUI_GR_MOVE = 6
Global Const $GUI_GR_COLOR = 8
Global Const $GUI_GR_RECT = 10
Global Const $GUI_GR_ELLIPSE = 12
Global Const $GUI_GR_PIE = 14
Global Const $GUI_GR_DOT = 16
Global Const $GUI_GR_PIXEL = 18
Global Const $GUI_GR_HINT = 20
Global Const $GUI_GR_REFRESH = 22
Global Const $GUI_GR_PENSIZE = 24
Global Const $GUI_GR_NOBKCOLOR = -2
Global Const $GUI_BKCOLOR_DEFAULT = -1
Global Const $GUI_BKCOLOR_TRANSPARENT = -2
Global Const $GUI_BKCOLOR_LV_ALTERNATE = -33554432
Global Const $GUI_WS_EX_PARENTDRAG = 1048576
Global Const $SS_LEFT = 0
Global Const $SS_CENTER = 1
Global Const $SS_RIGHT = 2
Global Const $SS_ICON = 3
Global Const $SS_BLACKRECT = 4
Global Const $SS_GRAYRECT = 5
Global Const $SS_WHITERECT = 6
Global Const $SS_BLACKFRAME = 7
Global Const $SS_GRAYFRAME = 8
Global Const $SS_WHITEFRAME = 9
Global Const $SS_SIMPLE = 11
Global Const $SS_LEFTNOWORDWRAP = 12
Global Const $SS_BITMAP = 14
Global Const $SS_ETCHEDHORZ = 16
Global Const $SS_ETCHEDVERT = 17
Global Const $SS_ETCHEDFRAME = 18
Global Const $SS_NOPREFIX = 128
Global Const $SS_NOTIFY = 256
Global Const $SS_CENTERIMAGE = 512
Global Const $SS_RIGHTJUST = 1024
Global Const $SS_SUNKEN = 4096
Global Const $GUI_SS_DEFAULT_LABEL = 0
Global Const $GUI_SS_DEFAULT_GRAPHIC = 0
Global Const $GUI_SS_DEFAULT_ICON = $SS_NOTIFY
Global Const $GUI_SS_DEFAULT_PIC = $SS_NOTIFY
Global Const $TCS_BOTTOM = 2
Global Const $TCS_BUTTONS = 256
Global Const $TCS_FIXEDWIDTH = 1024
Global Const $TCS_FLATBUTTONS = 8
Global Const $TCS_FOCUSNEVER = 32768
Global Const $TCS_FOCUSONBUTTONDOWN = 4096
Global Const $TCS_FORCEICONLEFT = 16
Global Const $TCS_FORCELABELLEFT = 32
Global Const $TCS_HOTTRACK = 64
Global Const $TCS_MULTILINE = 512
Global Const $TCS_MULTISELECT = 4
Global Const $TCS_OWNERDRAWFIXED = 8192
Global Const $TCS_RAGGEDRIGHT = 2048
Global Const $TCS_RIGHT = 2
Global Const $TCS_RIGHTJUSTIFY = 0
Global Const $TCS_SCROLLOPPOSITE = 1
Global Const $TCS_SINGLELINE = 0
Global Const $TCS_TABS = 0
Global Const $TCS_TOOLTIPS = 16384
Global Const $TCS_VERTICAL = 128
Global Const $TCS_EX_FLATSEPARATORS = 1
Global Const $TCS_EX_REGISTERDROP = 2
Global Const $TCHT_NOWHERE = 1
Global Const $TCHT_ONITEMICON = 2
Global Const $TCHT_ONITEMLABEL = 4
Global Const $TCHT_ONITEM = 6
Global Const $TCIF_TEXT = 1
Global Const $TCIF_IMAGE = 2
Global Const $TCIF_RTLREADING = 4
Global Const $TCIF_PARAM = 8
Global Const $TCIF_STATE = 16
Global Const $TCIF_ALLDATA = 27
Global Const $TCIS_BUTTONPRESSED = 1
Global Const $TCIS_HIGHLIGHTED = 2
Global Const $TC_ERR = -1
Global Const $GUI_SS_DEFAULT_TAB = 0
Global Const $TCM_FIRST = 4864
Global Const $TCCM_FIRST = 8192
Global Const $TCM_ADJUSTRECT = ($TCM_FIRST + 40)
Global Const $TCM_DELETEALLITEMS = ($TCM_FIRST + 9)
Global Const $TCM_DELETEITEM = ($TCM_FIRST + 8)
Global Const $TCM_DESELECTALL = ($TCM_FIRST + 50)
Global Const $TCM_GETCURFOCUS = ($TCM_FIRST + 47)
Global Const $TCM_GETCURSEL = ($TCM_FIRST + 11)
Global Const $TCM_GETEXTENDEDSTYLE = ($TCM_FIRST + 53)
Global Const $TCM_GETIMAGELIST = ($TCM_FIRST + 2)
Global Const $TCM_GETITEMA = ($TCM_FIRST + 5)
Global Const $TCM_GETITEMW = ($TCM_FIRST + 60)
Global Const $TCM_GETITEMCOUNT = ($TCM_FIRST + 4)
Global Const $TCM_GETITEMRECT = ($TCM_FIRST + 10)
Global Const $TCM_GETROWCOUNT = ($TCM_FIRST + 44)
Global Const $TCM_GETTOOLTIPS = ($TCM_FIRST + 45)
Global Const $TCCM_GETUNICODEFORMAT = ($TCCM_FIRST + 6)
Global Const $TCM_GETUNICODEFORMAT = $TCCM_GETUNICODEFORMAT
Global Const $TCM_HIGHLIGHTITEM = ($TCM_FIRST + 51)
Global Const $TCM_HITTEST = ($TCM_FIRST + 13)
Global Const $TCM_INSERTITEMA = ($TCM_FIRST + 7)
Global Const $TCM_INSERTITEMW = ($TCM_FIRST + 62)
Global Const $TCM_REMOVEIMAGE = ($TCM_FIRST + 42)
Global Const $TCM_SETITEMA = ($TCM_FIRST + 6)
Global Const $TCM_SETITEMW = ($TCM_FIRST + 61)
Global Const $TCM_SETITEMEXTRA = ($TCM_FIRST + 14)
Global Const $TCM_SETITEMSIZE = $TCM_FIRST + 41
Global Const $TCM_SETCURFOCUS = ($TCM_FIRST + 48)
Global Const $TCM_SETCURSEL = ($TCM_FIRST + 12)
Global Const $TCM_SETEXTENDEDSTYLE = ($TCM_FIRST + 52)
Global Const $TCM_SETIMAGELIST = $TCM_FIRST + 3
Global Const $TCM_SETMINTABWIDTH = ($TCM_FIRST + 49)
Global Const $TCM_SETPADDING = ($TCM_FIRST + 43)
Global Const $TCM_SETTOOLTIPS = ($TCM_FIRST + 46)
Global Const $TCCM_SETUNICODEFORMAT = ($TCCM_FIRST + 5)
Global Const $TCM_SETUNICODEFORMAT = $TCCM_SETUNICODEFORMAT
Global Const $TCN_FIRST = -550
Global Const $TCN_FOCUSCHANGE = ($TCN_FIRST - 4)
Global Const $TCN_GETOBJECT = ($TCN_FIRST - 3)
Global Const $TCN_KEYDOWN = ($TCN_FIRST - 0)
Global Const $TCN_SELCHANGE = ($TCN_FIRST - 1)
Global Const $TCN_SELCHANGING = ($TCN_FIRST - 2)
Global Const $WS_TILED = 0
Global Const $WS_OVERLAPPED = 0
Global Const $WS_MAXIMIZEBOX = 65536
Global Const $WS_MINIMIZEBOX = 131072
Global Const $WS_TABSTOP = 65536
Global Const $WS_GROUP = 131072
Global Const $WS_SIZEBOX = 262144
Global Const $WS_THICKFRAME = 262144
Global Const $WS_SYSMENU = 524288
Global Const $WS_HSCROLL = 1048576
Global Const $WS_VSCROLL = 2097152
Global Const $WS_DLGFRAME = 4194304
Global Const $WS_BORDER = 8388608
Global Const $WS_CAPTION = 12582912
Global Const $WS_OVERLAPPEDWINDOW = 13565952
Global Const $WS_TILEDWINDOW = 13565952
Global Const $WS_MAXIMIZE = 16777216
Global Const $WS_CLIPCHILDREN = 33554432
Global Const $WS_CLIPSIBLINGS = 67108864
Global Const $WS_DISABLED = 134217728
Global Const $WS_VISIBLE = 268435456
Global Const $WS_MINIMIZE = 536870912
Global Const $WS_CHILD = 1073741824
Global Const $WS_POPUP = -2147483648
Global Const $WS_POPUPWINDOW = -2138570752
Global Const $DS_MODALFRAME = 128
Global Const $DS_SETFOREGROUND = 512
Global Const $DS_CONTEXTHELP = 8192
Global Const $WS_EX_ACCEPTFILES = 16
Global Const $WS_EX_MDICHILD = 64
Global Const $WS_EX_APPWINDOW = 262144
Global Const $WS_EX_COMPOSITED = 33554432
Global Const $WS_EX_CLIENTEDGE = 512
Global Const $WS_EX_CONTEXTHELP = 1024
Global Const $WS_EX_DLGMODALFRAME = 1
Global Const $WS_EX_LEFTSCROLLBAR = 16384
Global Const $WS_EX_OVERLAPPEDWINDOW = 768
Global Const $WS_EX_RIGHT = 4096
Global Const $WS_EX_STATICEDGE = 131072
Global Const $WS_EX_TOOLWINDOW = 128
Global Const $WS_EX_TOPMOST = 8
Global Const $WS_EX_TRANSPARENT = 32
Global Const $WS_EX_WINDOWEDGE = 256
Global Const $WS_EX_LAYERED = 524288
Global Const $WS_EX_CONTROLPARENT = 65536
Global Const $WS_EX_LAYOUTRTL = 4194304
Global Const $WS_EX_RTLREADING = 8192
Global Const $WM_GETTEXTLENGTH = 14
Global Const $WM_GETTEXT = 13
Global Const $WM_SIZE = 5
Global Const $WM_SIZING = 532
Global Const $WM_USER = 1024
Global Const $WM_CREATE = 1
Global Const $WM_DESTROY = 2
Global Const $WM_MOVE = 3
Global Const $WM_ACTIVATE = 6
Global Const $WM_SETFOCUS = 7
Global Const $WM_KILLFOCUS = 8
Global Const $WM_ENABLE = 10
Global Const $WM_SETREDRAW = 11
Global Const $WM_SETTEXT = 12
Global Const $WM_PAINT = 15
Global Const $WM_CLOSE = 16
Global Const $WM_QUIT = 18
Global Const $WM_ERASEBKGND = 20
Global Const $WM_SYSCOLORCHANGE = 21
Global Const $WM_SHOWWINDOW = 24
Global Const $WM_WININICHANGE = 26
Global Const $WM_DEVMODECHANGE = 27
Global Const $WM_ACTIVATEAPP = 28
Global Const $WM_FONTCHANGE = 29
Global Const $WM_TIMECHANGE = 30
Global Const $WM_CANCELMODE = 31
Global Const $WM_SETCURSOR = 32
Global Const $WM_MOUSEACTIVATE = 33
Global Const $WM_CHILDACTIVATE = 34
Global Const $WM_QUEUESYNC = 35
Global Const $WM_GETMINMAXINFO = 36
Global Const $WM_PAINTICON = 38
Global Const $WM_ICONERASEBKGND = 39
Global Const $WM_NEXTDLGCTL = 40
Global Const $WM_SPOOLERSTATUS = 42
Global Const $WM_DRAWITEM = 43
Global Const $WM_MEASUREITEM = 44
Global Const $WM_DELETEITEM = 45
Global Const $WM_VKEYTOITEM = 46
Global Const $WM_CHARTOITEM = 47
Global Const $WM_SETFONT = 48
Global Const $WM_GETFONT = 49
Global Const $WM_SETHOTKEY = 50
Global Const $WM_GETHOTKEY = 51
Global Const $WM_QUERYDRAGICON = 55
Global Const $WM_COMPAREITEM = 57
Global Const $WM_GETOBJECT = 61
Global Const $WM_COMPACTING = 65
Global Const $WM_COMMNOTIFY = 68
Global Const $WM_WINDOWPOSCHANGING = 70
Global Const $WM_WINDOWPOSCHANGED = 71
Global Const $WM_POWER = 72
Global Const $WM_NOTIFY = 78
Global Const $WM_COPYDATA = 74
Global Const $WM_CANCELJOURNAL = 75
Global Const $WM_INPUTLANGCHANGEREQUEST = 80
Global Const $WM_INPUTLANGCHANGE = 81
Global Const $WM_TCARD = 82
Global Const $WM_HELP = 83
Global Const $WM_USERCHANGED = 84
Global Const $WM_NOTIFYFORMAT = 85
Global Const $WM_CUT = 768
Global Const $WM_COPY = 769
Global Const $WM_PASTE = 770
Global Const $WM_CLEAR = 771
Global Const $WM_UNDO = 772
Global Const $WM_CONTEXTMENU = 123
Global Const $WM_STYLECHANGING = 124
Global Const $WM_STYLECHANGED = 125
Global Const $WM_DISPLAYCHANGE = 126
Global Const $WM_GETICON = 127
Global Const $WM_SETICON = 128
Global Const $WM_NCCREATE = 129
Global Const $WM_NCDESTROY = 130
Global Const $WM_NCCALCSIZE = 131
Global Const $WM_NCHITTEST = 132
Global Const $WM_NCPAINT = 133
Global Const $WM_NCACTIVATE = 134
Global Const $WM_GETDLGCODE = 135
Global Const $WM_SYNCPAINT = 136
Global Const $WM_NCMOUSEMOVE = 160
Global Const $WM_NCLBUTTONDOWN = 161
Global Const $WM_NCLBUTTONUP = 162
Global Const $WM_NCLBUTTONDBLCLK = 163
Global Const $WM_NCRBUTTONDOWN = 164
Global Const $WM_NCRBUTTONUP = 165
Global Const $WM_NCRBUTTONDBLCLK = 166
Global Const $WM_NCMBUTTONDOWN = 167
Global Const $WM_NCMBUTTONUP = 168
Global Const $WM_NCMBUTTONDBLCLK = 169
Global Const $WM_KEYDOWN = 256
Global Const $WM_KEYUP = 257
Global Const $WM_CHAR = 258
Global Const $WM_DEADCHAR = 259
Global Const $WM_SYSKEYDOWN = 260
Global Const $WM_SYSKEYUP = 261
Global Const $WM_SYSCHAR = 262
Global Const $WM_SYSDEADCHAR = 263
Global Const $WM_INITDIALOG = 272
Global Const $WM_COMMAND = 273
Global Const $WM_SYSCOMMAND = 274
Global Const $WM_TIMER = 275
Global Const $WM_HSCROLL = 276
Global Const $WM_VSCROLL = 277
Global Const $WM_INITMENU = 278
Global Const $WM_INITMENUPOPUP = 279
Global Const $WM_MENUSELECT = 287
Global Const $WM_MENUCHAR = 288
Global Const $WM_ENTERIDLE = 289
Global Const $WM_MENURBUTTONUP = 290
Global Const $WM_MENUDRAG = 291
Global Const $WM_MENUGETOBJECT = 292
Global Const $WM_UNINITMENUPOPUP = 293
Global Const $WM_MENUCOMMAND = 294
Global Const $WM_CHANGEUISTATE = 295
Global Const $WM_UPDATEUISTATE = 296
Global Const $WM_QUERYUISTATE = 297
Global Const $WM_CTLCOLORMSGBOX = 306
Global Const $WM_CTLCOLOREDIT = 307
Global Const $WM_CTLCOLORLISTBOX = 308
Global Const $WM_CTLCOLORBTN = 309
Global Const $WM_CTLCOLORDLG = 310
Global Const $WM_CTLCOLORSCROLLBAR = 311
Global Const $WM_CTLCOLORSTATIC = 312
Global Const $WM_CTLCOLOR = 25
Global Const $MN_GETHMENU = 481
Global Const $NM_FIRST = 0
Global Const $NM_OUTOFMEMORY = $NM_FIRST - 1
Global Const $NM_CLICK = $NM_FIRST - 2
Global Const $NM_DBLCLK = $NM_FIRST - 3
Global Const $NM_RETURN = $NM_FIRST - 4
Global Const $NM_RCLICK = $NM_FIRST - 5
Global Const $NM_RDBLCLK = $NM_FIRST - 6
Global Const $NM_SETFOCUS = $NM_FIRST - 7
Global Const $NM_KILLFOCUS = $NM_FIRST - 8
Global Const $NM_CUSTOMDRAW = $NM_FIRST - 12
Global Const $NM_HOVER = $NM_FIRST - 13
Global Const $NM_NCHITTEST = $NM_FIRST - 14
Global Const $NM_KEYDOWN = $NM_FIRST - 15
Global Const $NM_RELEASEDCAPTURE = $NM_FIRST - 16
Global Const $NM_SETCURSOR = $NM_FIRST - 17
Global Const $NM_CHAR = $NM_FIRST - 18
Global Const $NM_TOOLTIPSCREATED = $NM_FIRST - 19
Global Const $NM_LDOWN = $NM_FIRST - 20
Global Const $NM_RDOWN = $NM_FIRST - 21
Global Const $NM_THEMECHANGED = $NM_FIRST - 22
Global Const $WM_MOUSEMOVE = 512
Global Const $WM_LBUTTONDOWN = 513
Global Const $WM_LBUTTONUP = 514
Global Const $WM_LBUTTONDBLCLK = 515
Global Const $WM_RBUTTONDOWN = 516
Global Const $WM_RBUTTONUP = 517
Global Const $WM_RBUTTONDBLCK = 518
Global Const $WM_MBUTTONDOWN = 519
Global Const $WM_MBUTTONUP = 520
Global Const $WM_MBUTTONDBLCK = 521
Global Const $WM_MOUSEWHEEL = 522
Global Const $WM_XBUTTONDOWN = 523
Global Const $WM_XBUTTONUP = 524
Global Const $WM_XBUTTONDBLCLK = 525
Global Const $WM_MOUSEHWHEEL = 526
Global Const $PS_SOLID = 0
Global Const $PS_DASH = 1
Global Const $PS_DOT = 2
Global Const $PS_DASHDOT = 3
Global Const $PS_DASHDOTDOT = 4
Global Const $PS_NULL = 5
Global Const $PS_INSIDEFRAME = 6
Global Const $LWA_ALPHA = 2
Global Const $LWA_COLORKEY = 1
Global Const $RGN_AND = 1
Global Const $RGN_OR = 2
Global Const $RGN_XOR = 3
Global Const $RGN_DIFF = 4
Global Const $RGN_COPY = 5
Global Const $ERRORREGION = 0
Global Const $NULLREGION = 1
Global Const $SIMPLEREGION = 2
Global Const $COMPLEXREGION = 3
Global Const $TRANSPARENT = 1
Global Const $OPAQUE = 2
Global Const $CCM_FIRST = 8192
Global Const $CCM_GETUNICODEFORMAT = ($CCM_FIRST + 6)
Global Const $CCM_SETUNICODEFORMAT = ($CCM_FIRST + 5)
Global Const $CCM_SETBKCOLOR = $CCM_FIRST + 1
Global Const $CCM_SETCOLORSCHEME = $CCM_FIRST + 2
Global Const $CCM_GETCOLORSCHEME = $CCM_FIRST + 3
Global Const $CCM_GETDROPTARGET = $CCM_FIRST + 4
Global Const $CCM_SETWINDOWTHEME = $CCM_FIRST + 11
Global Const $GA_PARENT = 1
Global Const $GA_ROOT = 2
Global Const $GA_ROOTOWNER = 3
Global Const $SM_CXSCREEN = 0
Global Const $SM_CYSCREEN = 1
Global Const $SM_CXVSCROLL = 2
Global Const $SM_CYHSCROLL = 3
Global Const $SM_CYCAPTION = 4
Global Const $SM_CXBORDER = 5
Global Const $SM_CYBORDER = 6
Global Const $SM_CXDLGFRAME = 7
Global Const $SM_CYDLGFRAME = 8
Global Const $SM_CYVTHUMB = 9
Global Const $SM_CXHTHUMB = 10
Global Const $SM_CXICON = 11
Global Const $SM_CYICON = 12
Global Const $SM_CXCURSOR = 13
Global Const $SM_CYCURSOR = 14
Global Const $SM_CYMENU = 15
Global Const $SM_CXFULLSCREEN = 16
Global Const $SM_CYFULLSCREEN = 17
Global Const $SM_CYKANJIWINDOW = 18
Global Const $SM_MOUSEPRESENT = 19
Global Const $SM_CYVSCROLL = 20
Global Const $SM_CXHSCROLL = 21
Global Const $SM_DEBUG = 22
Global Const $SM_SWAPBUTTON = 23
Global Const $SM_RESERVED1 = 24
Global Const $SM_RESERVED2 = 25
Global Const $SM_RESERVED3 = 26
Global Const $SM_RESERVED4 = 27
Global Const $SM_CXMIN = 28
Global Const $SM_CYMIN = 29
Global Const $SM_CXSIZE = 30
Global Const $SM_CYSIZE = 31
Global Const $SM_CXFRAME = 32
Global Const $SM_CYFRAME = 33
Global Const $SM_CXMINTRACK = 34
Global Const $SM_CYMINTRACK = 35
Global Const $SM_CXDOUBLECLK = 36
Global Const $SM_CYDOUBLECLK = 37
Global Const $SM_CXICONSPACING = 38
Global Const $SM_CYICONSPACING = 39
Global Const $SM_MENUDROPALIGNMENT = 40
Global Const $SM_PENWINDOWS = 41
Global Const $SM_DBCSENABLED = 42
Global Const $SM_CMOUSEBUTTONS = 43
Global Const $SM_SECURE = 44
Global Const $SM_CXEDGE = 45
Global Const $SM_CYEDGE = 46
Global Const $SM_CXMINSPACING = 47
Global Const $SM_CYMINSPACING = 48
Global Const $SM_CXSMICON = 49
Global Const $SM_CYSMICON = 50
Global Const $SM_CYSMCAPTION = 51
Global Const $SM_CXSMSIZE = 52
Global Const $SM_CYSMSIZE = 53
Global Const $SM_CXMENUSIZE = 54
Global Const $SM_CYMENUSIZE = 55
Global Const $SM_ARRANGE = 56
Global Const $SM_CXMINIMIZED = 57
Global Const $SM_CYMINIMIZED = 58
Global Const $SM_CXMAXTRACK = 59
Global Const $SM_CYMAXTRACK = 60
Global Const $SM_CXMAXIMIZED = 61
Global Const $SM_CYMAXIMIZED = 62
Global Const $SM_NETWORK = 63
Global Const $SM_CLEANBOOT = 67
Global Const $SM_CXDRAG = 68
Global Const $SM_CYDRAG = 69
Global Const $SM_SHOWSOUNDS = 70
Global Const $SM_CXMENUCHECK = 71
Global Const $SM_CYMENUCHECK = 72
Global Const $SM_SLOWMACHINE = 73
Global Const $SM_MIDEASTENABLED = 74
Global Const $SM_MOUSEWHEELPRESENT = 75
Global Const $SM_XVIRTUALSCREEN = 76
Global Const $SM_YVIRTUALSCREEN = 77
Global Const $SM_CXVIRTUALSCREEN = 78
Global Const $SM_CYVIRTUALSCREEN = 79
Global Const $SM_CMONITORS = 80
Global Const $SM_SAMEDISPLAYFORMAT = 81
Global Const $SM_IMMENABLED = 82
Global Const $SM_CXFOCUSBORDER = 83
Global Const $SM_CYFOCUSBORDER = 84
Global Const $SM_TABLETPC = 86
Global Const $SM_MEDIACENTER = 87
Global Const $SM_STARTER = 88
Global Const $SM_SERVERR2 = 89
Global Const $SM_CMETRICS = 90
Global Const $SM_REMOTESESSION = 4096
Global Const $SM_SHUTTINGDOWN = 8192
Global Const $SM_REMOTECONTROL = 8193
Global Const $SM_CARETBLINKINGENABLED = 8194
Global Const $BLACKNESS = 66
Global Const $CAPTUREBLT = 1073741824
Global Const $DSTINVERT = 5570569
Global Const $MERGECOPY = 12583114
Global Const $MERGEPAINT = 12255782
Global Const $NOMIRRORBITMAP = -2147483648
Global Const $NOTSRCCOPY = 3342344
Global Const $NOTSRCERASE = 1114278
Global Const $PATCOPY = 15728673
Global Const $PATINVERT = 5898313
Global Const $PATPAINT = 16452105
Global Const $SRCAND = 8913094
Global Const $SRCCOPY = 13369376
Global Const $SRCERASE = 4457256
Global Const $SRCINVERT = 6684742
Global Const $SRCPAINT = 15597702
Global Const $WHITENESS = 16711778
Global Const $DT_BOTTOM = 8
Global Const $DT_CALCRECT = 1024
Global Const $DT_CENTER = 1
Global Const $DT_EDITCONTROL = 8192
Global Const $DT_END_ELLIPSIS = 32768
Global Const $DT_EXPANDTABS = 64
Global Const $DT_EXTERNALLEADING = 512
Global Const $DT_HIDEPREFIX = 1048576
Global Const $DT_INTERNAL = 4096
Global Const $DT_LEFT = 0
Global Const $DT_MODIFYSTRING = 65536
Global Const $DT_NOCLIP = 256
Global Const $DT_NOFULLWIDTHCHARBREAK = 524288
Global Const $DT_NOPREFIX = 2048
Global Const $DT_PATH_ELLIPSIS = 16384
Global Const $DT_PREFIXONLY = 2097152
Global Const $DT_RIGHT = 2
Global Const $DT_RTLREADING = 131072
Global Const $DT_SINGLELINE = 32
Global Const $DT_TABSTOP = 128
Global Const $DT_TOP = 0
Global Const $DT_VCENTER = 4
Global Const $DT_WORDBREAK = 16
Global Const $DT_WORD_ELLIPSIS = 262144
Global Const $RDW_ERASE = 4
Global Const $RDW_FRAME = 1024
Global Const $RDW_INTERNALPAINT = 2
Global Const $RDW_INVALIDATE = 1
Global Const $RDW_NOERASE = 32
Global Const $RDW_NOFRAME = 2048
Global Const $RDW_NOINTERNALPAINT = 16
Global Const $RDW_VALIDATE = 8
Global Const $RDW_ERASENOW = 512
Global Const $RDW_UPDATENOW = 256
Global Const $RDW_ALLCHILDREN = 128
Global Const $RDW_NOCHILDREN = 64
Global Const $WM_RENDERFORMAT = 773
Global Const $WM_RENDERALLFORMATS = 774
Global Const $WM_DESTROYCLIPBOARD = 775
Global Const $WM_DRAWCLIPBOARD = 776
Global Const $WM_PAINTCLIPBOARD = 777
Global Const $WM_VSCROLLCLIPBOARD = 778
Global Const $WM_SIZECLIPBOARD = 779
Global Const $WM_ASKCBFORMATNAME = 780
Global Const $WM_CHANGECBCHAIN = 781
Global Const $WM_HSCROLLCLIPBOARD = 782
Global Const $HTERROR = -2
Global Const $HTTRANSPARENT = -1
Global Const $HTNOWHERE = 0
Global Const $HTCLIENT = 1
Global Const $HTCAPTION = 2
Global Const $HTSYSMENU = 3
Global Const $HTGROWBOX = 4
Global Const $HTSIZE = $HTGROWBOX
Global Const $HTMENU = 5
Global Const $HTHSCROLL = 6
Global Const $HTVSCROLL = 7
Global Const $HTMINBUTTON = 8
Global Const $HTMAXBUTTON = 9
Global Const $HTLEFT = 10
Global Const $HTRIGHT = 11
Global Const $HTTOP = 12
Global Const $HTTOPLEFT = 13
Global Const $HTTOPRIGHT = 14
Global Const $HTBOTTOM = 15
Global Const $HTBOTTOMLEFT = 16
Global Const $HTBOTTOMRIGHT = 17
Global Const $HTBORDER = 18
Global Const $HTREDUCE = $HTMINBUTTON
Global Const $HTZOOM = $HTMAXBUTTON
Global Const $HTSIZEFIRST = $HTLEFT
Global Const $HTSIZELAST = $HTBOTTOMRIGHT
Global Const $HTOBJECT = 19
Global Const $HTCLOSE = 20
Global Const $HTHELP = 21
Global Const $COLOR_SCROLLBAR = 0
Global Const $COLOR_BACKGROUND = 1
Global Const $COLOR_ACTIVECAPTION = 2
Global Const $COLOR_INACTIVECAPTION = 3
Global Const $COLOR_MENU = 4
Global Const $COLOR_WINDOW = 5
Global Const $COLOR_WINDOWFRAME = 6
Global Const $COLOR_MENUTEXT = 7
Global Const $COLOR_WINDOWTEXT = 8
Global Const $COLOR_CAPTIONTEXT = 9
Global Const $COLOR_ACTIVEBORDER = 10
Global Const $COLOR_INACTIVEBORDER = 11
Global Const $COLOR_APPWORKSPACE = 12
Global Const $COLOR_HIGHLIGHT = 13
Global Const $COLOR_HIGHLIGHTTEXT = 14
Global Const $COLOR_BTNFACE = 15
Global Const $COLOR_BTNSHADOW = 16
Global Const $COLOR_GRAYTEXT = 17
Global Const $COLOR_BTNTEXT = 18
Global Const $COLOR_INACTIVECAPTIONTEXT = 19
Global Const $COLOR_BTNHIGHLIGHT = 20
Global Const $COLOR_3DDKSHADOW = 21
Global Const $COLOR_3DLIGHT = 22
Global Const $COLOR_INFOTEXT = 23
Global Const $COLOR_INFOBK = 24
Global Const $COLOR_HOTLIGHT = 26
Global Const $COLOR_GRADIENTACTIVECAPTION = 27
Global Const $COLOR_GRADIENTINACTIVECAPTION = 28
Global Const $COLOR_MENUHILIGHT = 29
Global Const $COLOR_MENUBAR = 30
Global Const $COLOR_DESKTOP = 1
Global Const $COLOR_3DFACE = 15
Global Const $COLOR_3DSHADOW = 16
Global Const $COLOR_3DHIGHLIGHT = 20
Global Const $COLOR_3DHILIGHT = 20
Global Const $COLOR_BTNHILIGHT = 20
Global Const $HINST_COMMCTRL = -1
Global Const $IDB_STD_SMALL_COLOR = 0
Global Const $IDB_STD_LARGE_COLOR = 1
Global Const $IDB_VIEW_SMALL_COLOR = 4
Global Const $IDB_VIEW_LARGE_COLOR = 5
Global Const $IDB_HIST_SMALL_COLOR = 8
Global Const $IDB_HIST_LARGE_COLOR = 9
Global Const $STARTF_FORCEOFFFEEDBACK = 128
Global Const $STARTF_FORCEONFEEDBACK = 64
Global Const $STARTF_RUNFULLSCREEN = 32
Global Const $STARTF_USECOUNTCHARS = 8
Global Const $STARTF_USEFILLATTRIBUTE = 16
Global Const $STARTF_USEHOTKEY = 512
Global Const $STARTF_USEPOSITION = 4
Global Const $STARTF_USESHOWWINDOW = 1
Global Const $STARTF_USESIZE = 2
Global Const $STARTF_USESTDHANDLES = 256
Global Const $CDDS_PREPAINT = 1
Global Const $CDDS_POSTPAINT = 2
Global Const $CDDS_PREERASE = 3
Global Const $CDDS_POSTERASE = 4
Global Const $CDDS_ITEM = 65536
Global Const $CDDS_ITEMPREPAINT = 65537
Global Const $CDDS_ITEMPOSTPAINT = 65538
Global Const $CDDS_ITEMPREERASE = 65539
Global Const $CDDS_ITEMPOSTERASE = 65540
Global Const $CDDS_SUBITEM = 131072
Global Const $CDIS_SELECTED = 1
Global Const $CDIS_GRAYED = 2
Global Const $CDIS_DISABLED = 4
Global Const $CDIS_CHECKED = 8
Global Const $CDIS_FOCUS = 16
Global Const $CDIS_DEFAULT = 32
Global Const $CDIS_HOT = 64
Global Const $CDIS_MARKED = 128
Global Const $CDIS_INDETERMINATE = 256
Global Const $CDIS_SHOWKEYBOARDCUES = 512
Global Const $CDIS_NEARHOT = 1024
Global Const $CDIS_OTHERSIDEHOT = 2048
Global Const $CDIS_DROPHILITED = 4096
Global Const $CDRF_DODEFAULT = 0
Global Const $CDRF_NEWFONT = 2
Global Const $CDRF_SKIPDEFAULT = 4
Global Const $CDRF_NOTIFYPOSTPAINT = 16
Global Const $CDRF_NOTIFYITEMDRAW = 32
Global Const $CDRF_NOTIFYSUBITEMDRAW = 32
Global Const $CDRF_NOTIFYPOSTERASE = 64
Global Const $CDRF_DOERASE = 8
Global Const $CDRF_SKIPPOSTPAINT = 256
Global Const $GUI_SS_DEFAULT_GUI = BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU)
Opt("GUIOnEventMode", 1)
#Region ### START Koda GUI section ### Form=d:\user\mydocs\kiemtien\micbotkt\koda_1.7.2.0\forms\micbotkt_gui.kxf
$FORM1_1 = GUICreate("micBotKT", 290, 249, 378, 219)
GUISetIcon("E:\OLD\Projects\engine5\miccy.ico")
GUISetOnEvent($GUI_EVENT_CLOSE, "ExitAuto")
$TAB1 = GUICtrlCreateTab(8, 8, 273, 233)
GUICtrlSetResizing(-1, $GUI_DOCKWIDTH + $GUI_DOCKHEIGHT)
$TABSHEET1 = GUICtrlCreateTabItem("Main")
$GRPCHARINFO = GUICtrlCreateGroup("Char Info", 20, 33, 249, 81)
$LBLCHARNAME = GUICtrlCreateLabel("lblCharName", 28, 57, 115, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 16711680)
$LBLHP = GUICtrlCreateLabel("lblHP", 28, 73, 115, 17)
$LBLMP = GUICtrlCreateLabel("lblMP", 28, 89, 115, 17)
$LABEL5 = GUICtrlCreateLabel("Pet", 148, 57, 115, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 255)
$LBLPETHP = GUICtrlCreateLabel("lblHP", 148, 73, 115, 17)
$LBLPETMP = GUICtrlCreateLabel("lblMP", 148, 89, 115, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$GROUP1 = GUICtrlCreateGroup("ID Info", 20, 121, 137, 105)
$LABEL1 = GUICtrlCreateLabel("Char ID", 28, 147, 40, 17)
$LABEL2 = GUICtrlCreateLabel("Pet ID", 28, 172, 34, 17)
$INPCHARID = GUICtrlCreateInput("inpCharID", 76, 145, 73, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY, $ES_NUMBER))
$INPPETID = GUICtrlCreateInput("inpPetID", 76, 170, 73, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY, $ES_NUMBER))
$INPTARGETID = GUICtrlCreateInput("inpTargetID", 76, 196, 73, 21, BitOR($ES_AUTOHSCROLL, $ES_READONLY, $ES_NUMBER))
$LABEL3 = GUICtrlCreateLabel("Target ID", 28, 198, 49, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$CHKAUTO = GUICtrlCreateCheckbox("Auto", 164, 126, 41, 25)
$CHKFOLLOW = GUICtrlCreateCheckbox("Follow", 164, 151, 49, 25)
$INPFOLLOWID = GUICtrlCreateInput("0", 220, 153, 49, 21, BitOR($ES_AUTOHSCROLL, $ES_NUMBER))
$CBOCHARLIST = GUICtrlCreateCombo("cboCharList", 164, 205, 105, 25)
GUICtrlSetOnEvent(-1, "cboCharListChange")
$LABEL4 = GUICtrlCreateLabel("Char List:", 164, 185, 48, 17)
$BTNUPDATECHARLIST = GUICtrlCreateButton("Reload", 220, 184, 49, 17, $WS_GROUP)
$CBOHOTKEY = GUICtrlCreateCombo("", 212, 128, 57, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "NUMPAD1|NUMPAD2|NUMPAD3|NUMPAD4|NUMPAD5|NUMPAD6|NUMPAD7|NUMPAD8|NUMPAD9|NUMPAD0")
GUICtrlSetFont(-1, 4, 400, 0, "MS Sans Serif")
GUICtrlSetOnEvent(-1, "cboHotkeyChange")
$TABSHEET2 = GUICtrlCreateTabItem("Buff")
$INPBUFFHPSELF = GUICtrlCreateInput("0", 120, 64, 27, 21, BitOR($ES_AUTOHSCROLL, $ES_NUMBER))
GUICtrlSetState(-1, $GUI_DISABLE)
$LABEL6 = GUICtrlCreateLabel("Target", 40, 40, 41, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$CHKBUFFSELF = GUICtrlCreateCheckbox("", 16, 64, 17, 17)
GUICtrlSetOnEvent(-1, "chkBuffSelfClick")
$LABEL7 = GUICtrlCreateLabel("%HP", 120, 40, 30, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$LABEL8 = GUICtrlCreateLabel("%MP", 152, 40, 31, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$LABEL9 = GUICtrlCreateLabel("Action", 192, 40, 40, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
$CHKBUFFPET = GUICtrlCreateCheckbox("", 16, 87, 17, 17)
GUICtrlSetOnEvent(-1, "chkBuffPetClick")
$INPBUFFHPPET = GUICtrlCreateInput("0", 120, 87, 27, 21, BitOR($ES_AUTOHSCROLL, $ES_NUMBER))
GUICtrlSetState(-1, $GUI_DISABLE)
$INPBUFFMPSELF = GUICtrlCreateInput("0", 152, 64, 27, 21, BitOR($ES_AUTOHSCROLL, $ES_NUMBER))
GUICtrlSetState(-1, $GUI_DISABLE)
$INPBUFFMPPET = GUICtrlCreateInput("0", 152, 87, 27, 21, BitOR($ES_AUTOHSCROLL, $ES_NUMBER))
GUICtrlSetState(-1, $GUI_DISABLE)
$LABEL10 = GUICtrlCreateLabel("Self", 40, 64, 26, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 16711680)
$LABEL11 = GUICtrlCreateLabel("Pet", 40, 87, 23, 17)
GUICtrlSetFont(-1, 8, 800, 0, "MS Sans Serif")
GUICtrlSetColor(-1, 255)
$CBOBUFFSKILLSELF = GUICtrlCreateCombo("", 192, 64, 73, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|F1|F2|F3|F4|F5|F6|F7|F8", "0")
GUICtrlSetState(-1, $GUI_DISABLE)
$CBOBUFFSKILLPET = GUICtrlCreateCombo("", 192, 87, 73, 25, BitOR($CBS_DROPDOWNLIST, $CBS_AUTOHSCROLL))
GUICtrlSetData(-1, "0|1|2|3|4|5|6|7|8|9|F1|F2|F3|F4|F5|F6|F7|F8", "0")
GUICtrlSetState(-1, $GUI_DISABLE)
$TABSHEET3 = GUICtrlCreateTabItem("About")
$EDIT1 = GUICtrlCreateEdit("", 24, 48, 241, 177, BitOR($ES_AUTOVSCROLL, $ES_READONLY, $ES_WANTRETURN, $WS_VSCROLL))
GUICtrlSetData(-1, StringFormat("micBotTK - Auto Kiếm Tiên\r\ncoded by micral - 21/07/2010\r\n\r\n*** SỬ DỤNG AUTO ***\r\n- Mở " & '"' & "Trợ thủ chiến đấu" & '"' & " trong game (Ctrl-Z) chỉnh thông số phù hợp\r\n- Kích hoạt " & '"' & "Trợ thủ chiến đấu" & '"' & " và tắt đi 1 lần để lưu thiết lập auto\r\n- Mở micBotTK và chọn Auto để bắt đầu (có thể set hotkey NUMPAD0->9)\r\n\r\n- Mỗi lần chạy game chỉ cần mở và tắt " & '"' & "Trợ thủ" & '"' & " 1 lần để lưu thiết lập\r\n- Nếu muốn thay đổi thiết lập auto chỉ cần mở trợ thủ và thay đổi trực tiếp, không cần kích hoạt lại\r\n\r\n*** FOLLOW ***\r\n- Điền ID của nhân vật bạn muốn đi theo và check vào ô Follow\r\n- Cho dù nhaâ vật có chuyển map nếu bạn vẫn còn ở trong tầm di chuyển thì sẽ đi theo nhân vật do\r\n- Dùng để giữ cho party auto ko đi quá xa nhau\r\n\r\n*** BUFF ***\r\n- Chức năng dành cho Mục Sư\r\n- Check vào Self để tự buff cho nhân vật\r\n- Check vào Pet để buff cho Thú triệu hồi\r\n- Thiết lập điều kiện (%HP,%MP) rồi chọn Action (phím tắt của skill buff trong game)\r\n\r\n*** AUTO NHIEU CHAR ***\r\n- Ban co the mở nhiều cửa sổ micBotTK cùng lúc và chọn nhân vật khác nhau cho từng cửa sổ micBotTK\r\n- Nếu không thấy hết nhân vật click Reload\r\n\r\n*** GREETS & THANKS ***\r\n- Cám ơn LeeSai và bản auto open source của bạn"))
GUICtrlCreateTabItem("")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###
Func CHKBUFFPETCLICK()
	If GUICtrlRead($CHKBUFFPET) == 1 Then
		GUICtrlSetState($INPBUFFHPPET, $GUI_ENABLE)
		GUICtrlSetState($INPBUFFMPPET, $GUI_ENABLE)
		GUICtrlSetState($CBOBUFFSKILLPET, $GUI_ENABLE)
		$BUFFPET[0] = 1
	Else
		GUICtrlSetState($INPBUFFHPPET, $GUI_DISABLE)
		GUICtrlSetState($INPBUFFMPPET, $GUI_DISABLE)
		GUICtrlSetState($CBOBUFFSKILLPET, $GUI_DISABLE)
		$BUFFPET[0] = 0
	EndIf
EndFunc
Func CHKBUFFSELFCLICK()
	If GUICtrlRead($CHKBUFFSELF) == 1 Then
		GUICtrlSetState($INPBUFFHPSELF, $GUI_ENABLE)
		GUICtrlSetState($INPBUFFMPSELF, $GUI_ENABLE)
		GUICtrlSetState($CBOBUFFSKILLSELF, $GUI_ENABLE)
		$BUFFSELF[0] = 1
	Else
		GUICtrlSetState($INPBUFFHPSELF, $GUI_DISABLE)
		GUICtrlSetState($INPBUFFMPSELF, $GUI_DISABLE)
		GUICtrlSetState($CBOBUFFSKILLSELF, $GUI_DISABLE)
		$BUFFSELF[0] = 0
	EndIf
EndFunc
Func EXITAUTO()
	Exit
EndFunc
Func CBOCHARLISTCHANGE()
	$CHAR_NAME = GUICtrlRead($CBOCHARLIST)
	For $I = 1 To $GAMECHARLIST[0][0]
		If $CHAR_NAME == $GAMECHARLIST[$I][0] Then
			$GAMEHANDLE = $GAMECHARLIST[$I][1]
			$GAMEPID = WinGetProcess($GAMEHANDLE)
			GAMEOPENMEMORY()
			Return
		EndIf
	Next
EndFunc
Func BTNUPDATECHARLISTCLICK()
	INITCHARLIST()
EndFunc
Func TOGGLEAUTO()
	If GUICtrlRead($CHKAUTO) = 1 Then
		GUICtrlSetState($CHKAUTO, $GUI_UNCHECKED)
	Else
		GUICtrlSetState($CHKAUTO, $GUI_CHECKED)
	EndIf
EndFunc
Func CBOHOTKEYCHANGE()
	HotKeySet("{" & GUICtrlRead($CBOHOTKEY) & "}", "ToggleAuto")
EndFunc
Func GAMEOPENMEMORY()
	If $GAMEPID <> -1 Then
		$MEMGAME = _MEMORYOPEN($GAMEPID)
		If @error Then
			MsgBox(0, "micBotKT", "Cannot open game memory")
		EndIf
	Else
		MsgBox(0, "micBotKT", "Game not found")
	EndIf
EndFunc
Func ISCHAT()
	If _MEMORYREAD(24288379, $MEMGAME) == 0 Then
		Return 0
	Else
		Return 1
	EndIf
EndFunc
Func GETPERCENT($NUM1, $NUM2)
	Return Floor($NUM1 / $NUM2 * 100)
EndFunc
Func INITCHARLIST()
	Local $PID
	Local $MEM
	$GAMECHARLIST = WinList($GAMECLASS)
	If Not $GAMECHARLIST[0][0] Then
		MsgBox(0, "micBotKT", "Cannot find game")
		Exit
	EndIf
	For $I = 1 To $GAMECHARLIST[0][0]
		$PID = WinGetProcess($GAMECHARLIST[$I][1])
		$MEM = _MEMORYOPEN($PID)
		$GAMECHARLIST[$I][0] = _MEMORYREAD(15040652, $MEM, "char[24]")
	Next
	GUICtrlSetData($CBOCHARLIST, "", "")
	Local $DATA
	For $I = 1 To $GAMECHARLIST[0][0]
		$DATA &= $GAMECHARLIST[$I][0] & "|"
	Next
	GUICtrlSetData($CBOCHARLIST, $DATA, $GAMECHARLIST[1][0])
EndFunc
Func GETCHARINFO()
	$CHAR_NAME = _MEMORYREAD(15040652, $MEMGAME, "char[24]")
	$CHAR_ID = _MEMORYREAD(11799896, $MEMGAME, "dword")
	$CHAR_HPCUR = _MEMORYREAD(15075296, $MEMGAME)
	$CHAR_HPMAX = _MEMORYREAD(15075352, $MEMGAME)
	$CHAR_MPCUR = _MEMORYREAD(15075304, $MEMGAME)
	$CHAR_MPMAX = _MEMORYREAD(15075360, $MEMGAME)
	$CHAR_LV = _MEMORYREAD(11799962, $MEMGAME)
	$PET_ID = _MEMORYREAD(11813368, $MEMGAME)
	$PET_HPCUR = _MEMORYREAD(15188604, $MEMGAME)
	$PET_HPMAX = _MEMORYREAD(15188608, $MEMGAME)
	$PET_MPCUR = _MEMORYREAD(15189408, $MEMGAME)
	$PET_MPMAX = _MEMORYREAD(15189412, $MEMGAME)
EndFunc
Func SHOWCHARINFO()
	Local $INFOHP = "HP: " & $CHAR_HPCUR & "/" & $CHAR_HPMAX
	Local $INFOMP = "MP: " & $CHAR_MPCUR & "/" & $CHAR_MPMAX
	Local $INFOCHAR = $CHAR_NAME & " (" & $CHAR_LV & ")"
	Local $INFOPETHP = "HP: " & $PET_HPCUR & "/" & $PET_HPMAX
	Local $INFOPETMP = "HP: " & $PET_MPCUR & "/" & $PET_MPMAX
	GUICtrlSetData($LBLCHARNAME, $INFOCHAR)
	GUICtrlSetData($LBLHP, $INFOHP)
	GUICtrlSetData($LBLMP, $INFOMP)
	GUICtrlSetData($INPCHARID, $CHAR_ID)
	GUICtrlSetData($INPPETID, $PET_ID)
	GUICtrlSetData($LBLPETHP, $INFOPETHP)
	GUICtrlSetData($LBLPETMP, $INFOPETMP)
	Local $TARGETID = _MEMORYREAD(11751068, $MEMGAME)
	GUICtrlSetData($INPTARGETID, $TARGETID)
EndFunc
Func DOAUTO()
	If $GAMEPID == -1 Then Return
	If GUICtrlRead($CHKAUTO) = 1 Then
		_MEMORYWRITE(15032976, $MEMGAME, 1, "char")
	Else
		_MEMORYWRITE(15032976, $MEMGAME, 0, "char")
	EndIf
EndFunc
Func DOFOLLOW()
	If $GAMEPID == -1 Then Return
	If GUICtrlRead($CHKFOLLOW) = 1 Then
		Local $FOLLOWID = GUICtrlRead($INPFOLLOWID)
		_MEMORYWRITE(15075184, $MEMGAME, $FOLLOWID, "dword")
	Else
		_MEMORYWRITE(15075184, $MEMGAME, 0, "dword")
	EndIf
EndFunc
Func DOBUFF()
	Local $TARGETIDADDIE = 11751068
	If $BUFFSELF[0] <> 0 Then
		$BUFFSELF[1] = GUICtrlRead($INPBUFFHPSELF)
		$BUFFSELF[2] = GUICtrlRead($INPBUFFMPSELF)
		$BUFFSELF[3] = GUICtrlRead($CBOBUFFSKILLSELF)
		If (GETPERCENT($CHAR_HPCUR, $CHAR_HPMAX) <= $BUFFSELF[1]) Or (GETPERCENT($CHAR_MPCUR, $CHAR_MPMAX) <= $BUFFSELF[2]) Then
			_MEMORYWRITE($TARGETIDADDIE, $MEMGAME, $CHAR_ID, "dword")
			If ISCHAT() == 1 Then ControlSend($GAMEHANDLE, "", "", "{ENTER}")
			ControlSend($GAMEHANDLE, "", "", "{" & $BUFFSELF[3] & "}")
		EndIf
	EndIf
	If $BUFFPET[0] <> 0 Then
		$BUFFPET[1] = GUICtrlRead($INPBUFFHPPET)
		$BUFFPET[2] = GUICtrlRead($INPBUFFMPPET)
		$BUFFPET[3] = GUICtrlRead($CBOBUFFSKILLPET)
		If (GETPERCENT($PET_HPCUR, $PET_HPMAX) <= $BUFFPET[1]) Or (GETPERCENT($PET_MPCUR, $PET_MPMAX) <= $BUFFPET[2]) Then
			_MEMORYWRITE($TARGETIDADDIE, $MEMGAME, $PET_ID, "dword")
			If ISCHAT() = 1 Then ControlSend($GAMEHANDLE, "", "", "{ENTER}")
			ControlSend($GAMEHANDLE, "", "", "{" & $BUFFPET[3] & "}")
		EndIf
	EndIf
EndFunc
GAMEOPENMEMORY()
INITCHARLIST()
While 1
	GETCHARINFO()
	SHOWCHARINFO()
	DOAUTO()
	DOBUFF()
	DOFOLLOW()
	Sleep(500)
WEnd
; DeTokenise by myAut2Exe >The Open Source AutoIT/AutoHotKey script decompiler< 2.9 build(146)