#NoTrayIcon
Global Const $MB_OK = 0
Global Const $MB_OKCANCEL = 1
Global Const $MB_ABORTRETRYIGNORE = 2
Global Const $MB_YESNOCANCEL = 3
Global Const $MB_YESNO = 4
Global Const $MB_RETRYCANCEL = 5
Global Const $MB_CANCELTRYCONTINUE = 6
Global Const $MB_HELP = 0x4000
Global Const $MB_ICONSTOP = 16
Global Const $MB_ICONERROR = 16
Global Const $MB_ICONHAND = 16
Global Const $MB_ICONQUESTION = 32
Global Const $MB_ICONEXCLAMATION = 48
Global Const $MB_ICONWARNING = 48
Global Const $MB_ICONINFORMATION = 64
Global Const $MB_ICONASTERISK = 64
Global Const $MB_USERICON = 0x00000080
Global Const $MB_DEFBUTTON1 = 0
Global Const $MB_DEFBUTTON2 = 256
Global Const $MB_DEFBUTTON3 = 512
Global Const $MB_DEFBUTTON4 = 768
Global Const $MB_APPLMODAL = 0
Global Const $MB_SYSTEMMODAL = 4096
Global Const $MB_TASKMODAL = 8192
Global Const $MB_DEFAULT_DESKTOP_ONLY = 0x00020000
Global Const $MB_RIGHT = 0x00080000
Global Const $MB_RTLREADING = 0x00100000
Global Const $MB_SETFOREGROUND = 0x00010000
Global Const $MB_TOPMOST = 0x00040000
Global Const $MB_SERVICE_NOTIFICATION = 0x00200000
Global Const $MB_RIGHTJUSTIFIED = $MB_RIGHT
Global Const $IDTIMEOUT = -1
Global Const $IDOK = 1
Global Const $IDCANCEL = 2
Global Const $IDABORT = 3
Global Const $IDRETRY = 4
Global Const $IDIGNORE = 5
Global Const $IDYES = 6
Global Const $IDNO = 7
Global Const $IDCLOSE = 8
Global Const $IDHELP = 9
Global Const $IDTRYAGAIN = 10
Global Const $IDCONTINUE = 11
Global Const $OPT_COORDSRELATIVE = 0
Global Const $OPT_COORDSABSOLUTE = 1
Global Const $OPT_COORDSCLIENT = 2
Global Const $OPT_ERRORSILENT = 0
Global Const $OPT_ERRORFATAL = 1
Global Const $OPT_CAPSNOSTORE = 0
Global Const $OPT_CAPSSTORE = 1
Global Const $OPT_MATCHSTART = 1
Global Const $OPT_MATCHANY = 2
Global Const $OPT_MATCHEXACT = 3
Global Const $OPT_MATCHADVANCED = 4
Global Const $CCS_TOP = 0x01
Global Const $CCS_NOMOVEY = 0x02
Global Const $CCS_BOTTOM = 0x03
Global Const $CCS_NORESIZE = 0x04
Global Const $CCS_NOPARENTALIGN = 0x08
Global Const $CCS_NOHILITE = 0x10
Global Const $CCS_ADJUSTABLE = 0x20
Global Const $CCS_NODIVIDER = 0x40
Global Const $CCS_VERT = 0x0080
Global Const $CCS_LEFT = 0x0081
Global Const $CCS_NOMOVEX = 0x0082
Global Const $CCS_RIGHT = 0x0083
Global Const $DT_DRIVETYPE = 1
Global Const $DT_SSDSTATUS = 2
Global Const $DT_BUSTYPE = 3
Global Const $PROXY_IE = 0
Global Const $PROXY_NONE = 1
Global Const $PROXY_SPECIFIED = 2
Global Const $OBJID_WINDOW = 0x00000000
Global Const $OBJID_TITLEBAR = 0xFFFFFFFE
Global Const $OBJID_SIZEGRIP = 0xFFFFFFF9
Global Const $OBJID_CARET = 0xFFFFFFF8
Global Const $OBJID_CURSOR = 0xFFFFFFF7
Global Const $OBJID_ALERT = 0xFFFFFFF6
Global Const $OBJID_SOUND = 0xFFFFFFF5
Global Const $DLG_CENTERONTOP = 0
Global Const $DLG_NOTITLE = 1
Global Const $DLG_NOTONTOP = 2
Global Const $DLG_TEXTLEFT = 4
Global Const $DLG_TEXTRIGHT = 8
Global Const $DLG_MOVEABLE = 16
Global Const $DLG_TEXTVCENTER = 32
Global Const $IDC_UNKNOWN = 0
Global Const $IDC_APPSTARTING = 1
Global Const $IDC_ARROW = 2
Global Const $IDC_CROSS = 3
Global Const $IDC_HAND = 32649
Global Const $IDC_HELP = 4
Global Const $IDC_IBEAM = 5
Global Const $IDC_ICON = 6
Global Const $IDC_NO = 7
Global Const $IDC_SIZE = 8
Global Const $IDC_SIZEALL = 9
Global Const $IDC_SIZENESW = 10
Global Const $IDC_SIZENS = 11
Global Const $IDC_SIZENWSE = 12
Global Const $IDC_SIZEWE = 13
Global Const $IDC_UPARROW = 14
Global Const $IDC_WAIT = 15
Global Const $IDI_APPLICATION = 32512
Global Const $IDI_ASTERISK = 32516
Global Const $IDI_EXCLAMATION = 32515
Global Const $IDI_HAND = 32513
Global Const $IDI_QUESTION = 32514
Global Const $IDI_WINLOGO = 32517
Global Const $IDI_SHIELD = 32518
Global Const $IDI_ERROR = $IDI_HAND
Global Const $IDI_INFORMATION = $IDI_ASTERISK
Global Const $IDI_WARNING = $IDI_EXCLAMATION
Global Const $SD_LOGOFF = 0
Global Const $SD_SHUTDOWN = 1
Global Const $SD_REBOOT = 2
Global Const $SD_FORCE = 4
Global Const $SD_POWERDOWN = 8
Global Const $SD_FORCEHUNG = 16
Global Const $SD_STANDBY = 32
Global Const $SD_HIBERNATE = 64
Global Const $STDIN_CHILD = 1
Global Const $STDOUT_CHILD = 2
Global Const $STDERR_CHILD = 4
Global Const $STDERR_MERGED = 8
Global Const $STDIO_INHERIT_PARENT = 0x10
Global Const $RUN_CREATE_NEW_CONSOLE = 0x00010000
Global Const $UBOUND_DIMENSIONS = 0
Global Const $UBOUND_ROWS = 1
Global Const $UBOUND_COLUMNS = 2
Global Const $MOUSEEVENTF_ABSOLUTE = 0x8000
Global Const $MOUSEEVENTF_MOVE = 0x0001
Global Const $MOUSEEVENTF_LEFTDOWN = 0x0002
Global Const $MOUSEEVENTF_LEFTUP = 0x0004
Global Const $MOUSEEVENTF_RIGHTDOWN = 0x0008
Global Const $MOUSEEVENTF_RIGHTUP = 0x0010
Global Const $MOUSEEVENTF_MIDDLEDOWN = 0x0020
Global Const $MOUSEEVENTF_MIDDLEUP = 0x0040
Global Const $MOUSEEVENTF_WHEEL = 0x0800
Global Const $MOUSEEVENTF_XDOWN = 0x0080
Global Const $MOUSEEVENTF_XUP = 0x0100
Global Const $REG_NONE = 0
Global Const $REG_SZ = 1
Global Const $REG_EXPAND_SZ = 2
Global Const $REG_BINARY = 3
Global Const $REG_DWORD = 4
Global Const $REG_DWORD_LITTLE_ENDIAN = 4
Global Const $REG_DWORD_BIG_ENDIAN = 5
Global Const $REG_LINK = 6
Global Const $REG_MULTI_SZ = 7
Global Const $REG_RESOURCE_LIST = 8
Global Const $REG_FULL_RESOURCE_DESCRIPTOR = 9
Global Const $REG_RESOURCE_REQUIREMENTS_LIST = 10
Global Const $REG_QWORD = 11
Global Const $REG_QWORD_LITTLE_ENDIAN = 11
Global Const $HWND_BOTTOM = 1
Global Const $HWND_NOTOPMOST = -2
Global Const $HWND_TOP = 0
Global Const $HWND_TOPMOST = -1
Global Const $SWP_NOSIZE = 0x0001
Global Const $SWP_NOMOVE = 0x0002
Global Const $SWP_NOZORDER = 0x0004
Global Const $SWP_NOREDRAW = 0x0008
Global Const $SWP_NOACTIVATE = 0x0010
Global Const $SWP_FRAMECHANGED = 0x0020
Global Const $SWP_DRAWFRAME = 0x0020
Global Const $SWP_SHOWWINDOW = 0x0040
Global Const $SWP_HIDEWINDOW = 0x0080
Global Const $SWP_NOCOPYBITS = 0x0100
Global Const $SWP_NOOWNERZORDER = 0x0200
Global Const $SWP_NOREPOSITION = 0x0200
Global Const $SWP_NOSENDCHANGING = 0x0400
Global Const $SWP_DEFERERASE = 0x2000
Global Const $SWP_ASYNCWINDOWPOS = 0x4000
Global Const $KEYWORD_DEFAULT = 1
Global Const $KEYWORD_NULL = 2
Global Const $DECLARED_LOCAL = -1
Global Const $DECLARED_UNKNOWN = 0
Global Const $DECLARED_GLOBAL = 1
Global Const $ASSIGN_CREATE = 0
Global Const $ASSIGN_FORCELOCAL = 1
Global Const $ASSIGN_FORCEGLOBAL = 2
Global Const $ASSIGN_EXISTFAIL = 4
Global Const $BI_ENABLE = 0
Global Const $BI_DISABLE = 1
Global Const $BREAK_ENABLE = 1
Global Const $BREAK_DISABLE = 0
Global Const $CDTRAY_OPEN = "open"
Global Const $CDTRAY_CLOSED = "closed"
Global Const $SEND_DEFAULT = 0
Global Const $SEND_RAW = 1
Global Const $DIR_DEFAULT = 0
Global Const $DIR_EXTENDED= 1
Global Const $DIR_NORECURSE = 2
Global Const $DIR_REMOVE= 1
Global Const $DT_ALL = "ALL"
Global Const $DT_CDROM = "CDROM"
Global Const $DT_REMOVABLE = "REMOVABLE"
Global Const $DT_FIXED = "FIXED"
Global Const $DT_NETWORK = "NETWORK"
Global Const $DT_RAMDISK = "RAMDISK"
Global Const $DT_UNKNOWN = "UNKNOWN"
Global Const $DT_UNDEFINED = 1
Global Const $DT_FAT = "FAT"
Global Const $DT_FAT32 = "FAT32"
Global Const $DT_EXFAT = "exFAT"
Global Const $DT_NTFS = "NTFS"
Global Const $DT_NWFS = "NWFS"
Global Const $DT_CDFS = "CDFS"
Global Const $DT_UDF = "UDF"
Global Const $DMA_DEFAULT = 0
Global Const $DMA_PERSISTENT = 1
Global Const $DMA_AUTHENTICATION = 8
Global Const $DS_UNKNOWN = "UNKNOWN"
Global Const $DS_READY = "READY"
Global Const $DS_NOTREADY = "NOTREADY"
Global Const $DS_INVALID = "INVALID"
Global Const $MOUSE_CLICK_LEFT = "left"
Global Const $MOUSE_CLICK_RIGHT = "right"
Global Const $MOUSE_CLICK_MIDDLE = "middle"
Global Const $MOUSE_CLICK_MAIN = "main"
Global Const $MOUSE_CLICK_MENU = "menu"
Global Const $MOUSE_CLICK_PRIMARY = "primary"
Global Const $MOUSE_CLICK_SECONDARY = "secondary"
Global Const $MOUSE_WHEEL_UP = "up"
Global Const $MOUSE_WHEEL_DOWN = "down"
Global Const $NUMBER_AUTO = 0
Global Const $NUMBER_32BIT = 1
Global Const $NUMBER_64BIT = 2
Global Const $NUMBER_DOUBLE = 3
Global Const $OBJ_NAME = 1
Global Const $OBJ_STRING = 2
Global Const $OBJ_PROGID = 3
Global Const $OBJ_FILE = 4
Global Const $OBJ_MODULE = 5
Global Const $OBJ_CLSID = 6
Global Const $OBJ_IID = 7
Global Const $EXITCLOSE_NORMAL = 0
Global Const $EXITCLOSE_BYEXIT = 1
Global Const $EXITCLOSE_BYCLICK = 2
Global Const $EXITCLOSE_BYLOGOFF = 3
Global Const $EXITCLOSE_BYSUTDOWN = 4
Global Const $PROCESS_STATS_MEMORY = 0
Global Const $PROCESS_STATS_IO = 1
Global Const $PROCESS_LOW = 0
Global Const $PROCESS_BELOWNORMAL = 1
Global Const $PROCESS_NORMAL = 2
Global Const $PROCESS_ABOVENORMAL = 3
Global Const $PROCESS_HIGH = 4
Global Const $PROCESS_REALTIME = 5
Global Const $RUN_LOGON_NOPROFILE = 0
Global Const $RUN_LOGON_PROFILE = 1
Global Const $RUN_LOGON_NETWORK = 2
Global Const $RUN_LOGON_INHERIT = 4
Global Const $SOUND_NOWAIT = 0
Global Const $SOUND_WAIT = 1
Global Const $SHEX_OPEN = "open"
Global Const $SHEX_EDIT = "edit"
Global Const $SHEX_PRINT = "print"
Global Const $SHEX_PROPERTIES = "properties"
Global Const $TCP_DATA_DEFAULT = 0
Global Const $TCP_DATA_BINARY = 1
Global Const $UDP_OPEN_DEFAULT = 0
Global Const $UDP_OPEN_BROADCAST = 1
Global Const $UDP_DATA_DEFAULT = 0
Global Const $UDP_DATA_BINARY = 1
Global Const $UDP_DATA_ARRAY = 2
Global Const $TIP_NOICON = 0
Global Const $TIP_INFOICON = 1
Global Const $TIP_WARNINGICON = 2
Global Const $TIP_ERRORICON = 3
Global Const $TIP_BALLOON = 1
Global Const $TIP_CENTER = 2
Global Const $TIP_FORCEVISIBLE = 4
Global Const $WINDOWS_NOONTOP = 0
Global Const $WINDOWS_ONTOP = 1
Global Const $STR_NOCASESENSE = 0
Global Const $STR_CASESENSE = 1
Global Const $STR_NOCASESENSEBASIC = 2
Global Const $STR_STRIPLEADING = 1
Global Const $STR_STRIPTRAILING = 2
Global Const $STR_STRIPSPACES = 4
Global Const $STR_STRIPALL = 8
Global Const $STR_CHRSPLIT = 0
Global Const $STR_ENTIRESPLIT = 1
Global Const $STR_NOCOUNT = 2
Global Const $STR_REGEXPMATCH = 0
Global Const $STR_REGEXPARRAYMATCH = 1
Global Const $STR_REGEXPARRAYFULLMATCH = 2
Global Const $STR_REGEXPARRAYGLOBALMATCH = 3
Global Const $STR_REGEXPARRAYGLOBALFULLMATCH = 4
Global Const $STR_ENDISSTART = 0
Global Const $STR_ENDNOTSTART = 1
Global Const $SB_ANSI = 1
Global Const $SB_UTF16LE = 2
Global Const $SB_UTF16BE = 3
Global Const $SB_UTF8 = 4
Global Const $SE_UTF16 = 0
Global Const $SE_ANSI = 1
Global Const $SE_UTF8 = 2
Global Const $STR_UTF16 = 0
Global Const $STR_UCS2 = 1
Global Enum $ARRAYFILL_FORCE_DEFAULT, $ARRAYFILL_FORCE_SINGLEITEM, $ARRAYFILL_FORCE_INT, $ARRAYFILL_FORCE_NUMBER, $ARRAYFILL_FORCE_PTR, $ARRAYFILL_FORCE_HWND, $ARRAYFILL_FORCE_STRING
Global Enum $ARRAYUNIQUE_NOCOUNT, $ARRAYUNIQUE_COUNT
Global Enum $ARRAYUNIQUE_AUTO, $ARRAYUNIQUE_FORCE32, $ARRAYUNIQUE_FORCE64, $ARRAYUNIQUE_MATCH, $ARRAYUNIQUE_DISTINCT
Func _ArrayAdd(ByRef $aArray, $vValue, $iStart = 0, $sDelim_Item = "|", $sDelim_Row = @CRLF, $iForce = $ARRAYFILL_FORCE_DEFAULT)
If $iStart = Default Then $iStart = 0
If $sDelim_Item = Default Then $sDelim_Item = "|"
If $sDelim_Row = Default Then $sDelim_Row = @CRLF
If $iForce = Default Then $iForce = $ARRAYFILL_FORCE_DEFAULT
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS)
Local $hDataType = 0
Switch $iForce
Case $ARRAYFILL_FORCE_INT
$hDataType = Int
Case $ARRAYFILL_FORCE_NUMBER
$hDataType = Number
Case $ARRAYFILL_FORCE_PTR
$hDataType = Ptr
Case $ARRAYFILL_FORCE_HWND
$hDataType = Hwnd
Case $ARRAYFILL_FORCE_STRING
$hDataType = String
EndSwitch
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
If $iForce = $ARRAYFILL_FORCE_SINGLEITEM Then
ReDim $aArray[$iDim_1 + 1]
$aArray[$iDim_1] = $vValue
Return $iDim_1
EndIf
If IsArray($vValue) Then
If UBound($vValue, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(5, 0, -1)
$hDataType = 0
Else
Local $aTmp = StringSplit($vValue, $sDelim_Item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
If UBound($aTmp, $UBOUND_ROWS) = 1 Then
$aTmp[0] = $vValue
EndIf
$vValue = $aTmp
EndIf
Local $iAdd = UBound($vValue, $UBOUND_ROWS)
ReDim $aArray[$iDim_1 + $iAdd]
For $i = 0 To $iAdd - 1
If IsFunc($hDataType) Then
$aArray[$iDim_1 + $i] = $hDataType($vValue[$i])
Else
$aArray[$iDim_1 + $i] = $vValue[$i]
EndIf
Next
Return $iDim_1 + $iAdd - 1
Case 2
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS)
If $iStart < 0 Or $iStart > $iDim_2 - 1 Then Return SetError(4, 0, -1)
Local $iValDim_1, $iValDim_2 = 0, $iColCount
If IsArray($vValue) Then
If UBound($vValue, $UBOUND_DIMENSIONS) <> 2 Then Return SetError(5, 0, -1)
$iValDim_1 = UBound($vValue, $UBOUND_ROWS)
$iValDim_2 = UBound($vValue, $UBOUND_COLUMNS)
$hDataType = 0
Else
Local $aSplit_1 = StringSplit($vValue, $sDelim_Row, $STR_NOCOUNT + $STR_ENTIRESPLIT)
$iValDim_1 = UBound($aSplit_1, $UBOUND_ROWS)
Local $aTmp[$iValDim_1][0], $aSplit_2
For $i = 0 To $iValDim_1 - 1
$aSplit_2 = StringSplit($aSplit_1[$i], $sDelim_Item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
$iColCount = UBound($aSplit_2)
If $iColCount > $iValDim_2 Then
$iValDim_2 = $iColCount
ReDim $aTmp[$iValDim_1][$iValDim_2]
EndIf
For $j = 0 To $iColCount - 1
$aTmp[$i][$j] = $aSplit_2[$j]
Next
Next
$vValue = $aTmp
EndIf
If UBound($vValue, $UBOUND_COLUMNS) + $iStart > UBound($aArray, $UBOUND_COLUMNS) Then Return SetError(3, 0, -1)
ReDim $aArray[$iDim_1 + $iValDim_1][$iDim_2]
For $iWriteTo_Index = 0 To $iValDim_1 - 1
For $j = 0 To $iDim_2 - 1
If $j < $iStart Then
$aArray[$iWriteTo_Index + $iDim_1][$j] = ""
ElseIf $j - $iStart > $iValDim_2 - 1 Then
$aArray[$iWriteTo_Index + $iDim_1][$j] = ""
Else
If IsFunc($hDataType) Then
$aArray[$iWriteTo_Index + $iDim_1][$j] = $hDataType($vValue[$iWriteTo_Index][$j - $iStart])
Else
$aArray[$iWriteTo_Index + $iDim_1][$j] = $vValue[$iWriteTo_Index][$j - $iStart]
EndIf
EndIf
Next
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return UBound($aArray, $UBOUND_ROWS) - 1
EndFunc
Func _ArrayBinarySearch(Const ByRef $aArray, $vValue, $iStart = 0, $iEnd = 0, $iColumn = 0)
If $iStart = Default Then $iStart = 0
If $iEnd = Default Then $iEnd = 0
If $iColumn = Default Then $iColumn = 0
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS)
If $iDim_1 = 0 Then Return SetError(6, 0, -1)
If $iEnd < 1 Or $iEnd > $iDim_1 - 1 Then $iEnd = $iDim_1 - 1
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(4, 0, -1)
Local $iMid = Int(($iEnd + $iStart) / 2)
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
If $aArray[$iStart] > $vValue Or $aArray[$iEnd] < $vValue Then Return SetError(2, 0, -1)
While $iStart <= $iMid And $vValue <> $aArray[$iMid]
If $vValue < $aArray[$iMid] Then
$iEnd = $iMid - 1
Else
$iStart = $iMid + 1
EndIf
$iMid = Int(($iEnd + $iStart) / 2)
WEnd
If $iStart > $iEnd Then Return SetError(3, 0, -1)
Case 2
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS) - 1
If $iColumn < 0 Or $iColumn > $iDim_2 Then Return SetError(7, 0, -1)
If $aArray[$iStart][$iColumn] > $vValue Or $aArray[$iEnd][$iColumn] < $vValue Then Return SetError(2, 0, -1)
While $iStart <= $iMid And $vValue <> $aArray[$iMid][$iColumn]
If $vValue < $aArray[$iMid][$iColumn] Then
$iEnd = $iMid - 1
Else
$iStart = $iMid + 1
EndIf
$iMid = Int(($iEnd + $iStart) / 2)
WEnd
If $iStart > $iEnd Then Return SetError(3, 0, -1)
Case Else
Return SetError(5, 0, -1)
EndSwitch
Return $iMid
EndFunc
Func _ArrayColDelete(ByRef $aArray, $iColumn, $bConvert = False)
If $bConvert = Default Then $bConvert = False
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS)
If UBound($aArray, $UBOUND_DIMENSIONS) <> 2 Then Return SetError(2, 0, -1)
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS)
Switch $iDim_2
Case 2
If $iColumn < 0 Or $iColumn > 1 Then Return SetError(3, 0, -1)
If $bConvert Then
Local $aTempArray[$iDim_1]
For $i = 0 To $iDim_1 - 1
$aTempArray[$i] = $aArray[$i][(Not $iColumn)]
Next
$aArray = $aTempArray
Else
ContinueCase
EndIf
Case Else
If $iColumn < 0 Or $iColumn > $iDim_2 - 1 Then Return SetError(3, 0, -1)
For $i = 0 To $iDim_1 - 1
For $j = $iColumn To $iDim_2 - 2
$aArray[$i][$j] = $aArray[$i][$j + 1]
Next
Next
ReDim $aArray[$iDim_1][$iDim_2 - 1]
EndSwitch
Return UBound($aArray, $UBOUND_COLUMNS)
EndFunc
Func _ArrayColInsert(ByRef $aArray, $iColumn)
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS)
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
Local $aTempArray[$iDim_1][2]
Switch $iColumn
Case 0, 1
For $i = 0 To $iDim_1 - 1
$aTempArray[$i][(Not $iColumn)] = $aArray[$i]
Next
Case Else
Return SetError(3, 0, -1)
EndSwitch
$aArray = $aTempArray
Case 2
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS)
If $iColumn < 0 Or $iColumn > $iDim_2 Then Return SetError(3, 0, -1)
ReDim $aArray[$iDim_1][$iDim_2 + 1]
For $i = 0 To $iDim_1 - 1
For $j = $iDim_2 To $iColumn + 1 Step -1
$aArray[$i][$j] = $aArray[$i][$j - 1]
Next
$aArray[$i][$iColumn] = ""
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return UBound($aArray, $UBOUND_COLUMNS)
EndFunc
Func _ArrayCombinations(Const ByRef $aArray, $iSet, $sDelimiter = "")
If $sDelimiter = Default Then $sDelimiter = ""
If Not IsArray($aArray) Then Return SetError(1, 0, 0)
If UBound($aArray, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(2, 0, 0)
Local $iN = UBound($aArray)
Local $iR = $iSet
Local $aIdx[$iR]
For $i = 0 To $iR - 1
$aIdx[$i] = $i
Next
Local $iTotal = __Array_Combinations($iN, $iR)
Local $iLeft = $iTotal
Local $aResult[$iTotal + 1]
$aResult[0] = $iTotal
Local $iCount = 1
While $iLeft > 0
__Array_GetNext($iN, $iR, $iLeft, $iTotal, $aIdx)
For $i = 0 To $iSet - 1
$aResult[$iCount] &= $aArray[$aIdx[$i]] & $sDelimiter
Next
If $sDelimiter <> "" Then $aResult[$iCount] = StringTrimRight($aResult[$iCount], 1)
$iCount += 1
WEnd
Return $aResult
EndFunc
Func _ArrayConcatenate(ByRef $aArrayTarget, Const ByRef $aArraySource, $iStart = 0)
If $iStart = Default Then $iStart = 0
If Not IsArray($aArrayTarget) Then Return SetError(1, 0, -1)
If Not IsArray($aArraySource) Then Return SetError(2, 0, -1)
Local $iDim_Total_Tgt = UBound($aArrayTarget, $UBOUND_DIMENSIONS)
Local $iDim_Total_Src = UBound($aArraySource, $UBOUND_DIMENSIONS)
Local $iDim_1_Tgt = UBound($aArrayTarget, $UBOUND_ROWS)
Local $iDim_1_Src = UBound($aArraySource, $UBOUND_ROWS)
If $iStart < 0 Or $iStart > $iDim_1_Src - 1 Then Return SetError(6, 0, -1)
Switch $iDim_Total_Tgt
Case 1
If $iDim_Total_Src <> 1 Then Return SetError(4, 0, -1)
ReDim $aArrayTarget[$iDim_1_Tgt + $iDim_1_Src - $iStart]
For $i = $iStart To $iDim_1_Src - 1
$aArrayTarget[$iDim_1_Tgt + $i - $iStart] = $aArraySource[$i]
Next
Case 2
If $iDim_Total_Src <> 2 Then Return SetError(4, 0, -1)
Local $iDim_2_Tgt = UBound($aArrayTarget, $UBOUND_COLUMNS)
If UBound($aArraySource, $UBOUND_COLUMNS) <> $iDim_2_Tgt Then Return SetError(5, 0, -1)
ReDim $aArrayTarget[$iDim_1_Tgt + $iDim_1_Src - $iStart][$iDim_2_Tgt]
For $i = $iStart To $iDim_1_Src - 1
For $j = 0 To $iDim_2_Tgt - 1
$aArrayTarget[$iDim_1_Tgt + $i - $iStart][$j] = $aArraySource[$i][$j]
Next
Next
Case Else
Return SetError(3, 0, -1)
EndSwitch
Return UBound($aArrayTarget, $UBOUND_ROWS)
EndFunc
Func _ArrayDelete(ByRef $aArray, $vRange)
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS) - 1
If IsArray($vRange) Then
If UBound($vRange, $UBOUND_DIMENSIONS) <> 1 Or UBound($vRange, $UBOUND_ROWS) < 2 Then Return SetError(4, 0, -1)
Else
Local $iNumber, $aSplit_1, $aSplit_2
$vRange = StringStripWS($vRange, 8)
$aSplit_1 = StringSplit($vRange, ";")
$vRange = ""
For $i = 1 To $aSplit_1[0]
If Not StringRegExp($aSplit_1[$i], "^\d+(-\d+)?$") Then Return SetError(3, 0, -1)
$aSplit_2 = StringSplit($aSplit_1[$i], "-")
Switch $aSplit_2[0]
Case 1
$vRange &= $aSplit_2[1] & ";"
Case 2
If Number($aSplit_2[2]) >= Number($aSplit_2[1]) Then
$iNumber = $aSplit_2[1] - 1
Do
$iNumber += 1
$vRange &= $iNumber & ";"
Until $iNumber = $aSplit_2[2]
EndIf
EndSwitch
Next
$vRange = StringSplit(StringTrimRight($vRange, 1), ";")
EndIf
If $vRange[1] < 0 Or $vRange[$vRange[0]] > $iDim_1 Then Return SetError(5, 0, -1)
Local $iCopyTo_Index = 0
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
For $i = 1 To $vRange[0]
$aArray[$vRange[$i]] = ChrW(0xFAB1)
Next
For $iReadFrom_Index = 0 To $iDim_1
If $aArray[$iReadFrom_Index] == ChrW(0xFAB1) Then
ContinueLoop
Else
If $iReadFrom_Index <> $iCopyTo_Index Then
$aArray[$iCopyTo_Index] = $aArray[$iReadFrom_Index]
EndIf
$iCopyTo_Index += 1
EndIf
Next
ReDim $aArray[$iDim_1 - $vRange[0] + 1]
Case 2
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS) - 1
For $i = 1 To $vRange[0]
$aArray[$vRange[$i]][0] = ChrW(0xFAB1)
Next
For $iReadFrom_Index = 0 To $iDim_1
If $aArray[$iReadFrom_Index][0] == ChrW(0xFAB1) Then
ContinueLoop
Else
If $iReadFrom_Index <> $iCopyTo_Index Then
For $j = 0 To $iDim_2
$aArray[$iCopyTo_Index][$j] = $aArray[$iReadFrom_Index][$j]
Next
EndIf
$iCopyTo_Index += 1
EndIf
Next
ReDim $aArray[$iDim_1 - $vRange[0] + 1][$iDim_2 + 1]
Case Else
Return SetError(2, 0, False)
EndSwitch
Return UBound($aArray, $UBOUND_ROWS)
EndFunc
Func _ArrayDisplay(Const ByRef $aArray, $sTitle = Default, $sArrayRange = Default, $iFlags = Default, $vUser_Separator = Default, $sHeader = Default, $iMax_ColWidth = Default, $iAlt_Color = Default, $hUser_Function = Default)
If $sTitle = Default Then $sTitle = "ArrayDisplay"
If $sArrayRange = Default Then $sArrayRange = ""
If $iFlags = Default Then $iFlags = 0
If $vUser_Separator = Default Then $vUser_Separator = ""
If $sHeader = Default Then $sHeader = ""
If $iMax_ColWidth = Default Then $iMax_ColWidth = 350
If $iAlt_Color = Default Then $iAlt_Color = 0
If $hUser_Function = Default Then $hUser_Function = 0
Local $iTranspose = BitAND($iFlags, 1)
Local $iColAlign = BitAND($iFlags, 6)
Local $iVerbose = BitAND($iFlags, 8)
Local $iButtonMargin = ((BitAND($iFlags, 32)) ? (0) : ((BitAND($iFlags, 16)) ? (20) : (40)))
Local $iNoRow = BitAND($iFlags, 64)
Local $sMsg = "", $iRet = 1
If IsArray($aArray) Then
Local $iDimension = UBound($aArray, $UBOUND_DIMENSIONS), $iRowCount = UBound($aArray, $UBOUND_ROWS), $iColCount = UBound($aArray, $UBOUND_COLUMNS)
If $iDimension > 2 Then
$sMsg = "Larger than 2D array passed to function"
$iRet = 2
EndIf
Else
$sMsg = "No array variable passed to function"
EndIf
If $sMsg Then
If $iVerbose And MsgBox($MB_SYSTEMMODAL + $MB_ICONERROR + $MB_YESNO,  "ArrayDisplay Error: " & $sTitle, $sMsg & @CRLF & @CRLF & "Exit the script?") = $IDYES Then
Exit
Else
Return SetError($iRet, 0, "")
EndIf
EndIf
Local $iCW_ColWidth = Number($vUser_Separator)
Local $sAD_Separator = ChrW(0xFAB1)
Local $sCurr_Separator = Opt("GUIDataSeparatorChar", $sAD_Separator)
If $vUser_Separator = "" Then $vUser_Separator = $sCurr_Separator
Local $vTmp, $iRowLimit = 65525, $iColLimit = 250
Local $iDataRow = $iRowCount
Local $iDataCol = $iColCount
Local $iItem_Start = 0, $iItem_End = $iRowCount - 1, $iSubItem_Start = 0, $iSubItem_End = (($iDimension = 2) ? ($iColCount - 1) : (0))
Local $bRange_Flag = False, $avRangeSplit
If $sArrayRange Then
Local $aArray_Range = StringRegExp($sArrayRange & "||", "(?U)(.*)\|", 3)
If $aArray_Range[0] Then
$avRangeSplit = StringSplit($aArray_Range[0], ":")
If @error Then
$iItem_End = Number($avRangeSplit[1])
Else
$iItem_Start = Number($avRangeSplit[1])
$iItem_End = Number($avRangeSplit[2])
EndIf
EndIf
If $iItem_Start > $iItem_End Then
$vTmp = $iItem_Start
$iItem_Start = $iItem_End
$iItem_End = $vTmp
EndIf
If $iItem_Start < 0 Then $iItem_Start = 0
If $iItem_End > $iRowCount - 1 Then $iItem_End = $iRowCount - 1
If $iItem_Start <> 0 Or $iItem_End <> $iRowCount - 1 Then $bRange_Flag = True
If $iDimension = 2 And $aArray_Range[1] Then
$avRangeSplit = StringSplit($aArray_Range[1], ":")
If @error Then
$iSubItem_End = Number($avRangeSplit[1])
Else
$iSubItem_Start = Number($avRangeSplit[1])
$iSubItem_End = Number($avRangeSplit[2])
EndIf
If $iSubItem_Start > $iSubItem_End Then
$vTmp = $iSubItem_Start
$iSubItem_Start = $iSubItem_End
$iSubItem_End = $vTmp
EndIf
If $iSubItem_Start < 0 Then $iSubItem_Start = 0
If $iSubItem_End > $iColCount - 1 Then $iSubItem_End = $iColCount - 1
If $iSubItem_Start <> 0 Or $iSubItem_End <> $iColCount - 1 Then $bRange_Flag = True
EndIf
EndIf
Local $sDisplayData = "[" & $iDataRow
Local $bTruncated = False
If $iTranspose Then
If $iItem_End - $iItem_Start > $iColLimit Then
$bTruncated = True
$iItem_End = $iItem_Start + $iColLimit - 1
EndIf
Else
If $iItem_End - $iItem_Start > $iRowLimit Then
$bTruncated = True
$iItem_End = $iItem_Start + $iRowLimit - 1
EndIf
EndIf
If $bTruncated Then
$sDisplayData &= "*]"
Else
$sDisplayData &= "]"
EndIf
If $iDimension = 2 Then
$sDisplayData &= " [" & $iDataCol
If $iTranspose Then
If $iSubItem_End - $iSubItem_Start > $iRowLimit Then
$bTruncated = True
$iSubItem_End = $iSubItem_Start + $iRowLimit - 1
EndIf
Else
If $iSubItem_End - $iSubItem_Start > $iColLimit Then
$bTruncated = True
$iSubItem_End = $iSubItem_Start + $iColLimit - 1
EndIf
EndIf
If $bTruncated Then
$sDisplayData &= "*]"
Else
$sDisplayData &= "]"
EndIf
EndIf
Local $sTipData = ""
If $bTruncated Then $sTipData &= "Truncated"
If $bRange_Flag Then
If $sTipData Then $sTipData &= " - "
$sTipData &= "Range set"
EndIf
If $iTranspose Then
If $sTipData Then $sTipData &= " - "
$sTipData &= "Transposed"
EndIf
Local $asHeader = StringSplit($sHeader, $sCurr_Separator, $STR_NOCOUNT)
If UBound($asHeader) = 0 Then Local $asHeader[1] = [""]
$sHeader = "Row"
Local $iIndex = $iSubItem_Start
If $iTranspose Then
For $j = $iItem_Start To $iItem_End
$sHeader &= $sAD_Separator & "Col " & $j
Next
Else
If $asHeader[0] Then
For $iIndex = $iSubItem_Start To $iSubItem_End
If $iIndex >= UBound($asHeader) Then ExitLoop
$sHeader &= $sAD_Separator & $asHeader[$iIndex]
Next
EndIf
For $j = $iIndex To $iSubItem_End
$sHeader &= $sAD_Separator & "Col " & $j
Next
EndIf
If $iNoRow Then $sHeader = StringTrimLeft($sHeader, 4)
If $iVerbose And ($iItem_End - $iItem_Start + 1) * ($iSubItem_End - $iSubItem_Start + 1) > 10000 Then
SplashTextOn("ArrayDisplay", "Preparing display" & @CRLF & @CRLF & "Please be patient", 300, 100)
EndIf
Local $iBuffer = 4094
If $iTranspose Then
$vTmp = $iItem_Start
$iItem_Start = $iSubItem_Start
$iSubItem_Start = $vTmp
$vTmp = $iItem_End
$iItem_End = $iSubItem_End
$iSubItem_End = $vTmp
EndIf
Local $avArrayText[$iItem_End - $iItem_Start + 1]
For $i = $iItem_Start To $iItem_End
If Not $iNoRow Then $avArrayText[$i - $iItem_Start] = "[" & $i & "]"
For $j = $iSubItem_Start To $iSubItem_End
If $iDimension = 1 Then
If $iTranspose Then
Switch VarGetType($aArray[$j])
Case "Array"
$vTmp = "{Array}"
Case Else
$vTmp = $aArray[$j]
EndSwitch
Else
Switch VarGetType($aArray[$i])
Case "Array"
$vTmp = "{Array}"
Case Else
$vTmp = $aArray[$i]
EndSwitch
EndIf
Else
If $iTranspose Then
Switch VarGetType($aArray[$j][$i])
Case "Array"
$vTmp = "{Array}"
Case Else
$vTmp = $aArray[$j][$i]
EndSwitch
Else
Switch VarGetType($aArray[$i][$j])
Case "Array"
$vTmp = "{Array}"
Case Else
$vTmp = $aArray[$i][$j]
EndSwitch
EndIf
EndIf
If StringLen($vTmp) > $iBuffer Then $vTmp = StringLeft($vTmp, $iBuffer)
$avArrayText[$i - $iItem_Start] &= $sAD_Separator & $vTmp
Next
If $iNoRow Then $avArrayText[$i - $iItem_Start] = StringTrimLeft($avArrayText[$i - $iItem_Start], 1)
Next
Local Const $_ARRAYCONSTANT_GUI_DOCKBOTTOM = 64
Local Const $_ARRAYCONSTANT_GUI_DOCKBORDERS = 102
Local Const $_ARRAYCONSTANT_GUI_DOCKHEIGHT = 512
Local Const $_ARRAYCONSTANT_GUI_DOCKLEFT = 2
Local Const $_ARRAYCONSTANT_GUI_DOCKRIGHT = 4
Local Const $_ARRAYCONSTANT_GUI_DOCKHCENTER = 8
Local Const $_ARRAYCONSTANT_GUI_EVENT_CLOSE = -3
Local Const $_ARRAYCONSTANT_GUI_FOCUS = 256
Local Const $_ARRAYCONSTANT_GUI_BKCOLOR_LV_ALTERNATE = 0xFE000000
Local Const $_ARRAYCONSTANT_SS_CENTER = 0x1
Local Const $_ARRAYCONSTANT_SS_CENTERIMAGE = 0x0200
Local Const $_ARRAYCONSTANT_LVM_GETITEMCOUNT = (0x1000 + 4)
Local Const $_ARRAYCONSTANT_LVM_GETITEMRECT = (0x1000 + 14)
Local Const $_ARRAYCONSTANT_LVM_GETCOLUMNWIDTH = (0x1000 + 29)
Local Const $_ARRAYCONSTANT_LVM_SETCOLUMNWIDTH = (0x1000 + 30)
Local Const $_ARRAYCONSTANT_LVM_GETITEMSTATE = (0x1000 + 44)
Local Const $_ARRAYCONSTANT_LVM_GETSELECTEDCOUNT = (0x1000 + 50)
Local Const $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE = (0x1000 + 54)
Local Const $_ARRAYCONSTANT_LVS_EX_GRIDLINES = 0x1
Local Const $_ARRAYCONSTANT_LVIS_SELECTED = 0x2
Local Const $_ARRAYCONSTANT_LVS_SHOWSELALWAYS = 0x8
Local Const $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT = 0x20
Local Const $_ARRAYCONSTANT_WS_EX_CLIENTEDGE = 0x0200
Local Const $_ARRAYCONSTANT_WS_MAXIMIZEBOX = 0x00010000
Local Const $_ARRAYCONSTANT_WS_MINIMIZEBOX = 0x00020000
Local Const $_ARRAYCONSTANT_WS_SIZEBOX = 0x00040000
Local Const $_ARRAYCONSTANT_WM_SETREDRAW = 11
Local Const $_ARRAYCONSTANT_LVSCW_AUTOSIZE = -1
Local $iCoordMode = Opt("GUICoordMode", 1)
Local $iOrgWidth = 210, $iHeight = 200, $iMinSize = 250
Local $hGUI = GUICreate($sTitle, $iOrgWidth, $iHeight, Default, Default, BitOR($_ARRAYCONSTANT_WS_SIZEBOX, $_ARRAYCONSTANT_WS_MINIMIZEBOX, $_ARRAYCONSTANT_WS_MAXIMIZEBOX))
Local $aiGUISize = WinGetClientSize($hGUI)
Local $iButtonWidth_2 = $aiGUISize[0] / 2
Local $iButtonWidth_3 = $aiGUISize[0] / 3
Local $idListView = GUICtrlCreateListView($sHeader, 0, 0, $aiGUISize[0], $aiGUISize[1] - $iButtonMargin, $_ARRAYCONSTANT_LVS_SHOWSELALWAYS)
GUICtrlSetBkColor($idListView, $_ARRAYCONSTANT_GUI_BKCOLOR_LV_ALTERNATE)
GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_LVS_EX_GRIDLINES, $_ARRAYCONSTANT_LVS_EX_GRIDLINES)
GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT, $_ARRAYCONSTANT_LVS_EX_FULLROWSELECT)
GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_SETEXTENDEDLISTVIEWSTYLE, $_ARRAYCONSTANT_WS_EX_CLIENTEDGE, $_ARRAYCONSTANT_WS_EX_CLIENTEDGE)
Local $idCopy_ID = 9999, $idCopy_Data = 99999, $idData_Label = 99999, $idUser_Func = 99999, $idExit_Script = 99999
If $iButtonMargin Then
$idCopy_ID = GUICtrlCreateButton("Copy Data && Hdr/Row", 0, $aiGUISize[1] - $iButtonMargin, $iButtonWidth_2, 20)
$idCopy_Data = GUICtrlCreateButton("Copy Data Only", $iButtonWidth_2, $aiGUISize[1] - $iButtonMargin, $iButtonWidth_2, 20)
If $iButtonMargin = 40 Then
Local $iButtonWidth_Var = $iButtonWidth_2
Local $iOffset = $iButtonWidth_2
If IsFunc($hUser_Function) Then
$idUser_Func = GUICtrlCreateButton("Run User Func", $iButtonWidth_3, $aiGUISize[1] - 20, $iButtonWidth_3, 20)
$iButtonWidth_Var = $iButtonWidth_3
$iOffset = $iButtonWidth_3 * 2
EndIf
$idExit_Script = GUICtrlCreateButton("Exit Script", $iOffset, $aiGUISize[1] - 20, $iButtonWidth_Var, 20)
$idData_Label = GUICtrlCreateLabel($sDisplayData, 0, $aiGUISize[1] - 20, $iButtonWidth_Var, 18, BitOR($_ARRAYCONSTANT_SS_CENTER, $_ARRAYCONSTANT_SS_CENTERIMAGE))
Select
Case $bTruncated Or $iTranspose Or $bRange_Flag
GUICtrlSetColor($idData_Label, 0xFF0000)
GUICtrlSetTip($idData_Label, $sTipData)
EndSelect
EndIf
EndIf
GUICtrlSetResizing($idListView, $_ARRAYCONSTANT_GUI_DOCKBORDERS)
GUICtrlSetResizing($idCopy_ID, $_ARRAYCONSTANT_GUI_DOCKLEFT + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
GUICtrlSetResizing($idCopy_Data, $_ARRAYCONSTANT_GUI_DOCKRIGHT + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
GUICtrlSetResizing($idData_Label, $_ARRAYCONSTANT_GUI_DOCKLEFT + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
GUICtrlSetResizing($idUser_Func, $_ARRAYCONSTANT_GUI_DOCKHCENTER + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
GUICtrlSetResizing($idExit_Script, $_ARRAYCONSTANT_GUI_DOCKRIGHT + $_ARRAYCONSTANT_GUI_DOCKBOTTOM + $_ARRAYCONSTANT_GUI_DOCKHEIGHT)
GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_WM_SETREDRAW, 0, 0)
Local $idItem
For $i = 0 To UBound($avArrayText) - 1
$idItem = GUICtrlCreateListViewItem($avArrayText[$i], $idListView)
If $iAlt_Color Then
GUICtrlSetBkColor($idItem, $iAlt_Color)
EndIf
Next
If $iColAlign Then
Local Const $_ARRAYCONSTANT_LVCF_FMT = 0x01
Local Const $_ARRAYCONSTANT_LVM_SETCOLUMNW = (0x1000 + 96)
Local $tColumn = DllStructCreate("uint Mask;int Fmt;int CX;ptr Text;int TextMax;int SubItem;int Image;int Order;int cxMin;int cxDefault;int cxIdeal")
DllStructSetData($tColumn, "Mask", $_ARRAYCONSTANT_LVCF_FMT)
DllStructSetData($tColumn, "Fmt", $iColAlign / 2)
Local $pColumn = DllStructGetPtr($tColumn)
For $i = 1 To $iSubItem_End - $iSubItem_Start + 1
GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_SETCOLUMNW, $i, $pColumn)
Next
EndIf
GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_WM_SETREDRAW, 1, 0)
Local $iBorder = 45
If UBound($avArrayText) > 20 Then
$iBorder += 20
EndIf
Local $iWidth = $iBorder, $iColWidth = 0, $aiColWidth[$iSubItem_End - $iSubItem_Start + 2], $iMin_ColWidth = 55
For $i = 0 To $iSubItem_End - $iSubItem_Start + 1
GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_SETCOLUMNWIDTH, $i, $_ARRAYCONSTANT_LVSCW_AUTOSIZE)
$iColWidth = GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_GETCOLUMNWIDTH, $i, 0)
If $iColWidth < $iMin_ColWidth Then
GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_SETCOLUMNWIDTH, $i, $iMin_ColWidth)
$iColWidth = $iMin_ColWidth
EndIf
$iWidth += $iColWidth
$aiColWidth[$i] = $iColWidth
Next
If $iNoRow Then $iWidth -= 55
If $iWidth > @DesktopWidth - 100 Then
$iWidth = $iBorder
For $i = 0 To $iSubItem_End - $iSubItem_Start + 1
If $aiColWidth[$i] > $iMax_ColWidth Then
GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_SETCOLUMNWIDTH, $i, $iMax_ColWidth)
$iWidth += $iMax_ColWidth
Else
$iWidth += $aiColWidth[$i]
EndIf
Next
EndIf
If $iWidth > @DesktopWidth - 100 Then
$iWidth = @DesktopWidth - 100
ElseIf $iWidth < $iMinSize Then
$iWidth = $iMinSize
EndIf
Local $tRECT = DllStructCreate("struct; long Left;long Top;long Right;long Bottom; endstruct")
DllCall("user32.dll", "struct*", "SendMessageW", "hwnd", GUICtrlGetHandle($idListView), "uint", $_ARRAYCONSTANT_LVM_GETITEMRECT, "wparam", 0, "struct*", $tRECT)
Local $aiWin_Pos = WinGetPos($hGUI)
Local $aiLV_Pos = ControlGetPos($hGUI, "", $idListView)
$iHeight = ((UBound($avArrayText) + 2) * (DllStructGetData($tRECT, "Bottom") - DllStructGetData($tRECT, "Top"))) + $aiWin_Pos[3] - $aiLV_Pos[3]
If $iHeight > @DesktopHeight - 100 Then
$iHeight = @DesktopHeight - 100
ElseIf $iHeight < $iMinSize Then
$iHeight = $iMinSize
EndIf
If $iVerbose Then SplashOff()
GUISetState(@SW_HIDE, $hGUI)
WinMove($hGUI, "", (@DesktopWidth - $iWidth) / 2, (@DesktopHeight - $iHeight) / 2, $iWidth, $iHeight)
GUISetState(@SW_SHOW, $hGUI)
Local $iOnEventMode = Opt("GUIOnEventMode", 0), $iMsg
While 1
$iMsg = GUIGetMsg()
Switch $iMsg
Case $_ARRAYCONSTANT_GUI_EVENT_CLOSE
ExitLoop
Case $idCopy_ID, $idCopy_Data
Local $iSel_Count = GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_GETSELECTEDCOUNT, 0, 0)
If $iVerbose And (Not $iSel_Count) And ($iItem_End - $iItem_Start) * ($iSubItem_End - $iSubItem_Start) > 10000 Then
SplashTextOn("ArrayDisplay", "Copying data" & @CRLF & @CRLF & "Please be patient", 300, 100)
EndIf
Local $sClip = "", $sItem, $aSplit
For $i = 0 To $iItem_End - $iItem_Start
If $iSel_Count And Not (GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_GETITEMSTATE, $i, $_ARRAYCONSTANT_LVIS_SELECTED)) Then
ContinueLoop
EndIf
$sItem = $avArrayText[$i]
If $iMsg = $idCopy_Data Then
$sItem = StringRegExpReplace($sItem, "^\[\d+\].(.*)$", "$1")
EndIf
If $iCW_ColWidth Then
$aSplit = StringSplit($sItem, $sAD_Separator)
$sItem = ""
For $j = 1 To $aSplit[0]
$sItem &= StringFormat("%-" & $iCW_ColWidth + 1 & "s", StringLeft($aSplit[$j], $iCW_ColWidth))
Next
Else
$sItem = StringReplace($sItem, $sAD_Separator, $vUser_Separator)
EndIf
$sClip &= $sItem & @CRLF
Next
If $iMsg = $idCopy_ID Then
If $iCW_ColWidth Then
$aSplit = StringSplit($sHeader, $sAD_Separator)
$sItem = ""
For $j = 1 To $aSplit[0]
$sItem &= StringFormat("%-" & $iCW_ColWidth + 1 & "s", StringLeft($aSplit[$j], $iCW_ColWidth))
Next
Else
$sItem = StringReplace($sHeader, $sAD_Separator, $vUser_Separator)
EndIf
$sClip = $sItem & @CRLF & $sClip
EndIf
ClipPut($sClip)
SplashOff()
GUICtrlSetState($idListView, $_ARRAYCONSTANT_GUI_FOCUS)
Case $idUser_Func
Local $aiSelItems[$iRowLimit] = [0]
For $i = 0 To GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_GETITEMCOUNT, 0, 0)
If GUICtrlSendMsg($idListView, $_ARRAYCONSTANT_LVM_GETITEMSTATE, $i, $_ARRAYCONSTANT_LVIS_SELECTED) Then
$aiSelItems[0] += 1
$aiSelItems[$aiSelItems[0]] = $i + $iItem_Start
EndIf
Next
ReDim $aiSelItems[$aiSelItems[0] + 1]
$hUser_Function($aArray, $aiSelItems)
GUICtrlSetState($idListView, $_ARRAYCONSTANT_GUI_FOCUS)
Case $idExit_Script
GUIDelete($hGUI)
Exit
EndSwitch
WEnd
GUIDelete($hGUI)
Opt("GUICoordMode", $iCoordMode)
Opt("GUIOnEventMode", $iOnEventMode)
Opt("GUIDataSeparatorChar", $sCurr_Separator)
Return 1
EndFunc
Func _ArrayExtract(Const ByRef $aArray, $iStart_Row = -1, $iEnd_Row = -1, $iStart_Col = -1, $iEnd_Col = -1)
If $iStart_Row = Default Then $iStart_Row = -1
If $iEnd_Row = Default Then $iEnd_Row = -1
If $iStart_Col = Default Then $iStart_Col = -1
If $iEnd_Col = Default Then $iEnd_Col = -1
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS) - 1
If $iEnd_Row = -1 Then $iEnd_Row = $iDim_1
If $iStart_Row = -1 Then $iStart_Row = 0
If $iStart_Row < -1 Or $iEnd_Row < -1 Then Return SetError(3, 0, -1)
If $iStart_Row > $iDim_1 Or $iEnd_Row > $iDim_1 Then Return SetError(3, 0, -1)
If $iStart_Row > $iEnd_Row Then Return SetError(4, 0, -1)
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
Local $aRetArray[$iEnd_Row - $iStart_Row + 1]
For $i = 0 To $iEnd_Row - $iStart_Row
$aRetArray[$i] = $aArray[$i + $iStart_Row]
Next
Return $aRetArray
Case 2
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS) - 1
If $iEnd_Col = -1 Then $iEnd_Col = $iDim_2
If $iStart_Col = -1 Then $iStart_Col = 0
If $iStart_Col < -1 Or $iEnd_Col < -1 Then Return SetError(5, 0, -1)
If $iStart_Col > $iDim_2 Or $iEnd_Col > $iDim_2 Then Return SetError(5, 0, -1)
If $iStart_Col > $iEnd_Col Then Return SetError(6, 0, -1)
If $iStart_Col = $iEnd_Col Then
Local $aRetArray[$iEnd_Row - $iStart_Row + 1]
Else
Local $aRetArray[$iEnd_Row - $iStart_Row + 1][$iEnd_Col - $iStart_Col + 1]
EndIf
For $i = 0 To $iEnd_Row - $iStart_Row
For $j = 0 To $iEnd_Col - $iStart_Col
If $iStart_Col = $iEnd_Col Then
$aRetArray[$i] = $aArray[$i + $iStart_Row][$j + $iStart_Col]
Else
$aRetArray[$i][$j] = $aArray[$i + $iStart_Row][$j + $iStart_Col]
EndIf
Next
Next
Return $aRetArray
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return 1
EndFunc
Func _ArrayFindAll(Const ByRef $aArray, $vValue, $iStart = 0, $iEnd = 0, $iCase = 0, $iCompare = 0, $iSubItem = 0, $bRow = False)
If $iStart = Default Then $iStart = 0
If $iEnd = Default Then $iEnd = 0
If $iCase = Default Then $iCase = 0
If $iCompare = Default Then $iCompare = 0
If $iSubItem = Default Then $iSubItem = 0
If $bRow = Default Then $bRow = False
$iStart = _ArraySearch($aArray, $vValue, $iStart, $iEnd, $iCase, $iCompare, 1, $iSubItem, $bRow)
If @error Then Return SetError(@error, 0, -1)
Local $iIndex = 0, $avResult[UBound($aArray, ($bRow ? $UBOUND_COLUMNS : $UBOUND_ROWS))]
Do
$avResult[$iIndex] = $iStart
$iIndex += 1
$iStart = _ArraySearch($aArray, $vValue, $iStart + 1, $iEnd, $iCase, $iCompare, 1, $iSubItem, $bRow)
Until @error
ReDim $avResult[$iIndex]
Return $avResult
EndFunc
Func _ArrayInsert(ByRef $aArray, $vRange, $vValue = "", $iStart = 0, $sDelim_Item = "|", $sDelim_Row = @CRLF, $iForce = $ARRAYFILL_FORCE_DEFAULT)
If $vValue = Default Then $vValue = ""
If $iStart = Default Then $iStart = 0
If $sDelim_Item = Default Then $sDelim_Item = "|"
If $sDelim_Row = Default Then $sDelim_Row = @CRLF
If $iForce = Default Then $iForce = $ARRAYFILL_FORCE_DEFAULT
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS) - 1
Local $hDataType = 0
Switch $iForce
Case $ARRAYFILL_FORCE_INT
$hDataType = Int
Case $ARRAYFILL_FORCE_NUMBER
$hDataType = Number
Case $ARRAYFILL_FORCE_PTR
$hDataType = Ptr
Case $ARRAYFILL_FORCE_HWND
$hDataType = Hwnd
Case $ARRAYFILL_FORCE_STRING
$hDataType = String
EndSwitch
Local $aSplit_1, $aSplit_2
If IsArray($vRange) Then
If UBound($vRange, $UBOUND_DIMENSIONS) <> 1 Or UBound($vRange, $UBOUND_ROWS) < 2 Then Return SetError(4, 0, -1)
Else
Local $iNumber
$vRange = StringStripWS($vRange, 8)
$aSplit_1 = StringSplit($vRange, ";")
$vRange = ""
For $i = 1 To $aSplit_1[0]
If Not StringRegExp($aSplit_1[$i], "^\d+(-\d+)?$") Then Return SetError(3, 0, -1)
$aSplit_2 = StringSplit($aSplit_1[$i], "-")
Switch $aSplit_2[0]
Case 1
$vRange &= $aSplit_2[1] & ";"
Case 2
If Number($aSplit_2[2]) >= Number($aSplit_2[1]) Then
$iNumber = $aSplit_2[1] - 1
Do
$iNumber += 1
$vRange &= $iNumber & ";"
Until $iNumber = $aSplit_2[2]
EndIf
EndSwitch
Next
$vRange = StringSplit(StringTrimRight($vRange, 1), ";")
EndIf
If $vRange[1] < 0 Or $vRange[$vRange[0]] > $iDim_1 Then Return SetError(5, 0, -1)
For $i = 2 To $vRange[0]
If $vRange[$i] < $vRange[$i - 1] Then Return SetError(3, 0, -1)
Next
Local $iCopyTo_Index = $iDim_1 + $vRange[0]
Local $iInsertPoint_Index = $vRange[0]
Local $iInsert_Index = $vRange[$iInsertPoint_Index]
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
If $iForce = $ARRAYFILL_FORCE_SINGLEITEM Then
ReDim $aArray[$iDim_1 + $vRange[0] + 1]
For $iReadFromIndex = $iDim_1 To 0 Step -1
$aArray[$iCopyTo_Index] = $aArray[$iReadFromIndex]
$iCopyTo_Index -= 1
$iInsert_Index = $vRange[$iInsertPoint_Index]
While $iReadFromIndex = $iInsert_Index
$aArray[$iCopyTo_Index] = $vValue
$iCopyTo_Index -= 1
$iInsertPoint_Index -= 1
If $iInsertPoint_Index < 1 Then ExitLoop 2
$iInsert_Index = $vRange[$iInsertPoint_Index]
WEnd
Next
Return $iDim_1 + $vRange[0] + 1
EndIf
ReDim $aArray[$iDim_1 + $vRange[0] + 1]
If IsArray($vValue) Then
If UBound($vValue, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(5, 0, -1)
$hDataType = 0
Else
Local $aTmp = StringSplit($vValue, $sDelim_Item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
If UBound($aTmp, $UBOUND_ROWS) = 1 Then
$aTmp[0] = $vValue
$hDataType = 0
EndIf
$vValue = $aTmp
EndIf
For $iReadFromIndex = $iDim_1 To 0 Step -1
$aArray[$iCopyTo_Index] = $aArray[$iReadFromIndex]
$iCopyTo_Index -= 1
$iInsert_Index = $vRange[$iInsertPoint_Index]
While $iReadFromIndex = $iInsert_Index
If $iInsertPoint_Index <= UBound($vValue, $UBOUND_ROWS) Then
If IsFunc($hDataType) Then
$aArray[$iCopyTo_Index] = $hDataType($vValue[$iInsertPoint_Index - 1])
Else
$aArray[$iCopyTo_Index] = $vValue[$iInsertPoint_Index - 1]
EndIf
Else
$aArray[$iCopyTo_Index] = ""
EndIf
$iCopyTo_Index -= 1
$iInsertPoint_Index -= 1
If $iInsertPoint_Index = 0 Then ExitLoop 2
$iInsert_Index = $vRange[$iInsertPoint_Index]
WEnd
Next
Case 2
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS)
If $iStart < 0 Or $iStart > $iDim_2 - 1 Then Return SetError(6, 0, -1)
Local $iValDim_1, $iValDim_2
If IsArray($vValue) Then
If UBound($vValue, $UBOUND_DIMENSIONS) <> 2 Then Return SetError(7, 0, -1)
$iValDim_1 = UBound($vValue, $UBOUND_ROWS)
$iValDim_2 = UBound($vValue, $UBOUND_COLUMNS)
$hDataType = 0
Else
$aSplit_1 = StringSplit($vValue, $sDelim_Row, $STR_NOCOUNT + $STR_ENTIRESPLIT)
$iValDim_1 = UBound($aSplit_1, $UBOUND_ROWS)
StringReplace($aSplit_1[0], $sDelim_Item, "")
$iValDim_2 = @extended + 1
Local $aTmp[$iValDim_1][$iValDim_2]
For $i = 0 To $iValDim_1 - 1
$aSplit_2 = StringSplit($aSplit_1[$i], $sDelim_Item, $STR_NOCOUNT + $STR_ENTIRESPLIT)
For $j = 0 To $iValDim_2 - 1
$aTmp[$i][$j] = $aSplit_2[$j]
Next
Next
$vValue = $aTmp
EndIf
If UBound($vValue, $UBOUND_COLUMNS) + $iStart > UBound($aArray, $UBOUND_COLUMNS) Then Return SetError(8, 0, -1)
ReDim $aArray[$iDim_1 + $vRange[0] + 1][$iDim_2]
For $iReadFromIndex = $iDim_1 To 0 Step -1
For $j = 0 To $iDim_2 - 1
$aArray[$iCopyTo_Index][$j] = $aArray[$iReadFromIndex][$j]
Next
$iCopyTo_Index -= 1
$iInsert_Index = $vRange[$iInsertPoint_Index]
While $iReadFromIndex = $iInsert_Index
For $j = 0 To $iDim_2 - 1
If $j < $iStart Then
$aArray[$iCopyTo_Index][$j] = ""
ElseIf $j - $iStart > $iValDim_2 - 1 Then
$aArray[$iCopyTo_Index][$j] = ""
Else
If $iInsertPoint_Index - 1 < $iValDim_1 Then
If IsFunc($hDataType) Then
$aArray[$iCopyTo_Index][$j] = $hDataType($vValue[$iInsertPoint_Index - 1][$j - $iStart])
Else
$aArray[$iCopyTo_Index][$j] = $vValue[$iInsertPoint_Index - 1][$j - $iStart]
EndIf
Else
$aArray[$iCopyTo_Index][$j] = ""
EndIf
EndIf
Next
$iCopyTo_Index -= 1
$iInsertPoint_Index -= 1
If $iInsertPoint_Index = 0 Then ExitLoop 2
$iInsert_Index = $vRange[$iInsertPoint_Index]
WEnd
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return UBound($aArray, $UBOUND_ROWS)
EndFunc
Func _ArrayMax(Const ByRef $aArray, $iCompNumeric = 0, $iStart = -1, $iEnd = -1, $iSubItem = 0)
Local $iResult = _ArrayMaxIndex($aArray, $iCompNumeric, $iStart, $iEnd, $iSubItem)
If @error Then Return SetError(@error, 0, "")
If UBound($aArray, $UBOUND_DIMENSIONS) = 1 Then
Return $aArray[$iResult]
Else
Return $aArray[$iResult][$iSubItem]
EndIf
EndFunc
Func _ArrayMaxIndex(Const ByRef $aArray, $iCompNumeric = 0, $iStart = -1, $iEnd = -1, $iSubItem = 0)
If $iCompNumeric = Default Then $iCompNumeric = 0
If $iStart = Default Then $iStart = -1
If $iEnd = Default Then $iEnd = -1
If $iSubItem = Default Then $iSubItem = 0
Local $iRet = __Array_MinMaxIndex($aArray, $iCompNumeric, $iStart, $iEnd, $iSubItem, __Array_GreaterThan)
Return SetError(@error, 0, $iRet)
EndFunc
Func _ArrayMin(Const ByRef $aArray, $iCompNumeric = 0, $iStart = -1, $iEnd = -1, $iSubItem = 0)
Local $iResult = _ArrayMinIndex($aArray, $iCompNumeric, $iStart, $iEnd, $iSubItem)
If @error Then Return SetError(@error, 0, "")
If UBound($aArray, $UBOUND_DIMENSIONS) = 1 Then
Return $aArray[$iResult]
Else
Return $aArray[$iResult][$iSubItem]
EndIf
EndFunc
Func _ArrayMinIndex(Const ByRef $aArray, $iCompNumeric = 0, $iStart = -1, $iEnd = -1, $iSubItem = 0)
If $iCompNumeric = Default Then $iCompNumeric = 0
If $iStart = Default Then $iStart = -1
If $iEnd = Default Then $iEnd = -1
If $iSubItem = Default Then $iSubItem = 0
Local $iRet = __Array_MinMaxIndex($aArray, $iCompNumeric, $iStart, $iEnd, $iSubItem, __Array_LessThan)
Return SetError(@error, 0, $iRet)
EndFunc
Func _ArrayPermute(ByRef $aArray, $sDelimiter = "")
If $sDelimiter = Default Then $sDelimiter = ""
If Not IsArray($aArray) Then Return SetError(1, 0, 0)
If UBound($aArray, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(2, 0, 0)
Local $iSize = UBound($aArray), $iFactorial = 1, $aIdx[$iSize], $aResult[1], $iCount = 1
If UBound($aArray) Then
For $i = 0 To $iSize - 1
$aIdx[$i] = $i
Next
For $i = $iSize To 1 Step -1
$iFactorial *= $i
Next
ReDim $aResult[$iFactorial + 1]
$aResult[0] = $iFactorial
__Array_ExeterInternal($aArray, 0, $iSize, $sDelimiter, $aIdx, $aResult, $iCount)
Else
$aResult[0] = 0
EndIf
Return $aResult
EndFunc
Func _ArrayPop(ByRef $aArray)
If (Not IsArray($aArray)) Then Return SetError(1, 0, "")
If UBound($aArray, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(2, 0, "")
Local $iUBound = UBound($aArray) - 1
If $iUBound = -1 Then Return SetError(3, 0, "")
Local $sLastVal = $aArray[$iUBound]
If $iUBound > -1 Then
ReDim $aArray[$iUBound]
EndIf
Return $sLastVal
EndFunc
Func _ArrayPush(ByRef $aArray, $vValue, $iDirection = 0)
If $iDirection = Default Then $iDirection = 0
If (Not IsArray($aArray)) Then Return SetError(1, 0, 0)
If UBound($aArray, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(3, 0, 0)
Local $iUBound = UBound($aArray) - 1
If IsArray($vValue) Then
Local $iUBoundS = UBound($vValue)
If ($iUBoundS - 1) > $iUBound Then Return SetError(2, 0, 0)
If $iDirection Then
For $i = $iUBound To $iUBoundS Step -1
$aArray[$i] = $aArray[$i - $iUBoundS]
Next
For $i = 0 To $iUBoundS - 1
$aArray[$i] = $vValue[$i]
Next
Else
For $i = 0 To $iUBound - $iUBoundS
$aArray[$i] = $aArray[$i + $iUBoundS]
Next
For $i = 0 To $iUBoundS - 1
$aArray[$i + $iUBound - $iUBoundS + 1] = $vValue[$i]
Next
EndIf
Else
If $iUBound > -1 Then
If $iDirection Then
For $i = $iUBound To 1 Step -1
$aArray[$i] = $aArray[$i - 1]
Next
$aArray[0] = $vValue
Else
For $i = 0 To $iUBound - 1
$aArray[$i] = $aArray[$i + 1]
Next
$aArray[$iUBound] = $vValue
EndIf
EndIf
EndIf
Return 1
EndFunc
Func _ArrayReverse(ByRef $aArray, $iStart = 0, $iEnd = 0)
If $iStart = Default Then $iStart = 0
If $iEnd = Default Then $iEnd = 0
If Not IsArray($aArray) Then Return SetError(1, 0, 0)
If UBound($aArray, $UBOUND_DIMENSIONS) <> 1 Then Return SetError(3, 0, 0)
If Not UBound($aArray) Then Return SetError(4, 0, 0)
Local $vTmp, $iUBound = UBound($aArray) - 1
If $iEnd < 1 Or $iEnd > $iUBound Then $iEnd = $iUBound
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(2, 0, 0)
For $i = $iStart To Int(($iStart + $iEnd - 1) / 2)
$vTmp = $aArray[$i]
$aArray[$i] = $aArray[$iEnd]
$aArray[$iEnd] = $vTmp
$iEnd -= 1
Next
Return 1
EndFunc
Func _ArraySearch(Const ByRef $aArray, $vValue, $iStart = 0, $iEnd = 0, $iCase = 0, $iCompare = 0, $iForward = 1, $iSubItem = -1, $bRow = False)
If $iStart = Default Then $iStart = 0
If $iEnd = Default Then $iEnd = 0
If $iCase = Default Then $iCase = 0
If $iCompare = Default Then $iCompare = 0
If $iForward = Default Then $iForward = 1
If $iSubItem = Default Then $iSubItem = -1
If $bRow = Default Then $bRow = False
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray) - 1
If $iDim_1 = -1 Then Return SetError(3, 0, -1)
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS) - 1
Local $bCompType = False
If $iCompare = 2 Then
$iCompare = 0
$bCompType = True
EndIf
If $bRow Then
If UBound($aArray, $UBOUND_DIMENSIONS) = 1 Then Return SetError(5, 0, -1)
If $iEnd < 1 Or $iEnd > $iDim_2 Then $iEnd = $iDim_2
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(4, 0, -1)
Else
If $iEnd < 1 Or $iEnd > $iDim_1 Then $iEnd = $iDim_1
If $iStart < 0 Then $iStart = 0
If $iStart > $iEnd Then Return SetError(4, 0, -1)
EndIf
Local $iStep = 1
If Not $iForward Then
Local $iTmp = $iStart
$iStart = $iEnd
$iEnd = $iTmp
$iStep = -1
EndIf
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
If Not $iCompare Then
If Not $iCase Then
For $i = $iStart To $iEnd Step $iStep
If $bCompType And VarGetType($aArray[$i]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$i] = $vValue Then Return $i
Next
Else
For $i = $iStart To $iEnd Step $iStep
If $bCompType And VarGetType($aArray[$i]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$i] == $vValue Then Return $i
Next
EndIf
Else
For $i = $iStart To $iEnd Step $iStep
If $iCompare = 3 Then
If StringRegExp($aArray[$i], $vValue) Then Return $i
Else
If StringInStr($aArray[$i], $vValue, $iCase) > 0 Then Return $i
EndIf
Next
EndIf
Case 2
Local $iDim_Sub
If $bRow Then
$iDim_Sub = $iDim_1
If $iSubItem > $iDim_Sub Then $iSubItem = $iDim_Sub
If $iSubItem < 0 Then
$iSubItem = 0
Else
$iDim_Sub = $iSubItem
EndIf
Else
$iDim_Sub = $iDim_2
If $iSubItem > $iDim_Sub Then $iSubItem = $iDim_Sub
If $iSubItem < 0 Then
$iSubItem = 0
Else
$iDim_Sub = $iSubItem
EndIf
EndIf
For $j = $iSubItem To $iDim_Sub
If Not $iCompare Then
If Not $iCase Then
For $i = $iStart To $iEnd Step $iStep
If $bRow Then
If $bCompType And VarGetType($aArray[$j][$j]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$j][$i] = $vValue Then Return $i
Else
If $bCompType And VarGetType($aArray[$i][$j]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$i][$j] = $vValue Then Return $i
EndIf
Next
Else
For $i = $iStart To $iEnd Step $iStep
If $bRow Then
If $bCompType And VarGetType($aArray[$j][$i]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$j][$i] == $vValue Then Return $i
Else
If $bCompType And VarGetType($aArray[$i][$j]) <> VarGetType($vValue) Then ContinueLoop
If $aArray[$i][$j] == $vValue Then Return $i
EndIf
Next
EndIf
Else
For $i = $iStart To $iEnd Step $iStep
If $iCompare = 3 Then
If $bRow Then
If StringRegExp($aArray[$j][$i], $vValue) Then Return $i
Else
If StringRegExp($aArray[$i][$j], $vValue) Then Return $i
EndIf
Else
If $bRow Then
If StringInStr($aArray[$j][$i], $vValue, $iCase) > 0 Then Return $i
Else
If StringInStr($aArray[$i][$j], $vValue, $iCase) > 0 Then Return $i
EndIf
EndIf
Next
EndIf
Next
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return SetError(6, 0, -1)
EndFunc
Func _ArrayShuffle(ByRef $aArray, $iStart_Row = 0, $iEnd_Row = 0, $iCol = -1)
If $iStart_Row = Default Then $iStart_Row = 0
If $iEnd_Row = Default Then $iEnd_Row = 0
If $iCol = Default Then $iCol = -1
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS)
If $iEnd_Row = 0 Then $iEnd_Row = $iDim_1 - 1
If $iStart_Row < 0 Or $iStart_Row > $iDim_1 - 1 Then Return SetError(3, 0, -1)
If $iEnd_Row < 1 Or $iEnd_Row > $iDim_1 - 1 Then Return SetError(3, 0, -1)
If $iStart_Row > $iEnd_Row Then Return SetError(4, 0, -1)
Local $vTmp, $iRand
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
For $i = $iEnd_Row To $iStart_Row + 1 Step -1
$iRand = Random($iStart_Row, $i, 1)
$vTmp = $aArray[$i]
$aArray[$i] = $aArray[$iRand]
$aArray[$iRand] = $vTmp
Next
Return 1
Case 2
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS)
If $iCol < -1 Or $iCol > $iDim_2 - 1 Then Return SetError(5, 0, -1)
Local $iCol_Start, $iCol_End
If $iCol = -1 Then
$iCol_Start = 0
$iCol_End = $iDim_2 - 1
Else
$iCol_Start = $iCol
$iCol_End = $iCol
EndIf
For $i = $iEnd_Row To $iStart_Row + 1 Step -1
$iRand = Random($iStart_Row, $i, 1)
For $j = $iCol_Start To $iCol_End
$vTmp = $aArray[$i][$j]
$aArray[$i][$j] = $aArray[$iRand][$j]
$aArray[$iRand][$j] = $vTmp
Next
Next
Return 1
Case Else
Return SetError(2, 0, -1)
EndSwitch
EndFunc
Func _ArraySort(ByRef $aArray, $iDescending = 0, $iStart = 0, $iEnd = 0, $iSubItem = 0, $iPivot = 0)
If $iDescending = Default Then $iDescending = 0
If $iStart = Default Then $iStart = 0
If $iEnd = Default Then $iEnd = 0
If $iSubItem = Default Then $iSubItem = 0
If $iPivot = Default Then $iPivot = 0
If Not IsArray($aArray) Then Return SetError(1, 0, 0)
Local $iUBound = UBound($aArray) - 1
If $iUBound = -1 Then Return SetError(5, 0, 0)
If $iEnd = Default Then $iEnd = 0
If $iEnd < 1 Or $iEnd > $iUBound Or $iEnd = Default Then $iEnd = $iUBound
If $iStart < 0 Or $iStart = Default Then $iStart = 0
If $iStart > $iEnd Then Return SetError(2, 0, 0)
If $iDescending = Default Then $iDescending = 0
If $iPivot = Default Then $iPivot = 0
If $iSubItem = Default Then $iSubItem = 0
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
If $iPivot Then
__ArrayDualPivotSort($aArray, $iStart, $iEnd)
Else
__ArrayQuickSort1D($aArray, $iStart, $iEnd)
EndIf
If $iDescending Then _ArrayReverse($aArray, $iStart, $iEnd)
Case 2
If $iPivot Then Return SetError(6, 0, 0)
Local $iSubMax = UBound($aArray, $UBOUND_COLUMNS) - 1
If $iSubItem > $iSubMax Then Return SetError(3, 0, 0)
If $iDescending Then
$iDescending = -1
Else
$iDescending = 1
EndIf
__ArrayQuickSort2D($aArray, $iDescending, $iStart, $iEnd, $iSubItem, $iSubMax)
Case Else
Return SetError(4, 0, 0)
EndSwitch
Return 1
EndFunc
Func __ArrayQuickSort1D(ByRef $aArray, Const ByRef $iStart, Const ByRef $iEnd)
If $iEnd <= $iStart Then Return
Local $vTmp
If ($iEnd - $iStart) < 15 Then
Local $vCur
For $i = $iStart + 1 To $iEnd
$vTmp = $aArray[$i]
If IsNumber($vTmp) Then
For $j = $i - 1 To $iStart Step -1
$vCur = $aArray[$j]
If ($vTmp >= $vCur And IsNumber($vCur)) Or (Not IsNumber($vCur) And StringCompare($vTmp, $vCur) >= 0) Then ExitLoop
$aArray[$j + 1] = $vCur
Next
Else
For $j = $i - 1 To $iStart Step -1
If (StringCompare($vTmp, $aArray[$j]) >= 0) Then ExitLoop
$aArray[$j + 1] = $aArray[$j]
Next
EndIf
$aArray[$j + 1] = $vTmp
Next
Return
EndIf
Local $L = $iStart, $R = $iEnd, $vPivot = $aArray[Int(($iStart + $iEnd) / 2)], $bNum = IsNumber($vPivot)
Do
If $bNum Then
While ($aArray[$L] < $vPivot And IsNumber($aArray[$L])) Or (Not IsNumber($aArray[$L]) And StringCompare($aArray[$L], $vPivot) < 0)
$L += 1
WEnd
While ($aArray[$R] > $vPivot And IsNumber($aArray[$R])) Or (Not IsNumber($aArray[$R]) And StringCompare($aArray[$R], $vPivot) > 0)
$R -= 1
WEnd
Else
While (StringCompare($aArray[$L], $vPivot) < 0)
$L += 1
WEnd
While (StringCompare($aArray[$R], $vPivot) > 0)
$R -= 1
WEnd
EndIf
If $L <= $R Then
$vTmp = $aArray[$L]
$aArray[$L] = $aArray[$R]
$aArray[$R] = $vTmp
$L += 1
$R -= 1
EndIf
Until $L > $R
__ArrayQuickSort1D($aArray, $iStart, $R)
__ArrayQuickSort1D($aArray, $L, $iEnd)
EndFunc
Func __ArrayQuickSort2D(ByRef $aArray, Const ByRef $iStep, Const ByRef $iStart, Const ByRef $iEnd, Const ByRef $iSubItem, Const ByRef $iSubMax)
If $iEnd <= $iStart Then Return
Local $vTmp, $L = $iStart, $R = $iEnd, $vPivot = $aArray[Int(($iStart + $iEnd) / 2)][$iSubItem], $bNum = IsNumber($vPivot)
Do
If $bNum Then
While ($iStep * ($aArray[$L][$iSubItem] - $vPivot) < 0 And IsNumber($aArray[$L][$iSubItem])) Or (Not IsNumber($aArray[$L][$iSubItem]) And $iStep * StringCompare($aArray[$L][$iSubItem], $vPivot) < 0)
$L += 1
WEnd
While ($iStep * ($aArray[$R][$iSubItem] - $vPivot) > 0 And IsNumber($aArray[$R][$iSubItem])) Or (Not IsNumber($aArray[$R][$iSubItem]) And $iStep * StringCompare($aArray[$R][$iSubItem], $vPivot) > 0)
$R -= 1
WEnd
Else
While ($iStep * StringCompare($aArray[$L][$iSubItem], $vPivot) < 0)
$L += 1
WEnd
While ($iStep * StringCompare($aArray[$R][$iSubItem], $vPivot) > 0)
$R -= 1
WEnd
EndIf
If $L <= $R Then
For $i = 0 To $iSubMax
$vTmp = $aArray[$L][$i]
$aArray[$L][$i] = $aArray[$R][$i]
$aArray[$R][$i] = $vTmp
Next
$L += 1
$R -= 1
EndIf
Until $L > $R
__ArrayQuickSort2D($aArray, $iStep, $iStart, $R, $iSubItem, $iSubMax)
__ArrayQuickSort2D($aArray, $iStep, $L, $iEnd, $iSubItem, $iSubMax)
EndFunc
Func __ArrayDualPivotSort(ByRef $aArray, $iPivot_Left, $iPivot_Right, $bLeftMost = True)
If $iPivot_Left > $iPivot_Right Then Return
Local $iLength = $iPivot_Right - $iPivot_Left + 1
Local $i, $j, $k, $iAi, $iAk, $iA1, $iA2, $iLast
If $iLength < 45 Then
If $bLeftMost Then
$i = $iPivot_Left
While $i < $iPivot_Right
$j = $i
$iAi = $aArray[$i + 1]
While $iAi < $aArray[$j]
$aArray[$j + 1] = $aArray[$j]
$j -= 1
If $j + 1 = $iPivot_Left Then ExitLoop
WEnd
$aArray[$j + 1] = $iAi
$i += 1
WEnd
Else
While 1
If $iPivot_Left >= $iPivot_Right Then Return 1
$iPivot_Left += 1
If $aArray[$iPivot_Left] < $aArray[$iPivot_Left - 1] Then ExitLoop
WEnd
While 1
$k = $iPivot_Left
$iPivot_Left += 1
If $iPivot_Left > $iPivot_Right Then ExitLoop
$iA1 = $aArray[$k]
$iA2 = $aArray[$iPivot_Left]
If $iA1 < $iA2 Then
$iA2 = $iA1
$iA1 = $aArray[$iPivot_Left]
EndIf
$k -= 1
While $iA1 < $aArray[$k]
$aArray[$k + 2] = $aArray[$k]
$k -= 1
WEnd
$aArray[$k + 2] = $iA1
While $iA2 < $aArray[$k]
$aArray[$k + 1] = $aArray[$k]
$k -= 1
WEnd
$aArray[$k + 1] = $iA2
$iPivot_Left += 1
WEnd
$iLast = $aArray[$iPivot_Right]
$iPivot_Right -= 1
While $iLast < $aArray[$iPivot_Right]
$aArray[$iPivot_Right + 1] = $aArray[$iPivot_Right]
$iPivot_Right -= 1
WEnd
$aArray[$iPivot_Right + 1] = $iLast
EndIf
Return 1
EndIf
Local $iSeventh = BitShift($iLength, 3) + BitShift($iLength, 6) + 1
Local $iE1, $iE2, $iE3, $iE4, $iE5, $t
$iE3 = Ceiling(($iPivot_Left + $iPivot_Right) / 2)
$iE2 = $iE3 - $iSeventh
$iE1 = $iE2 - $iSeventh
$iE4 = $iE3 + $iSeventh
$iE5 = $iE4 + $iSeventh
If $aArray[$iE2] < $aArray[$iE1] Then
$t = $aArray[$iE2]
$aArray[$iE2] = $aArray[$iE1]
$aArray[$iE1] = $t
EndIf
If $aArray[$iE3] < $aArray[$iE2] Then
$t = $aArray[$iE3]
$aArray[$iE3] = $aArray[$iE2]
$aArray[$iE2] = $t
If $t < $aArray[$iE1] Then
$aArray[$iE2] = $aArray[$iE1]
$aArray[$iE1] = $t
EndIf
EndIf
If $aArray[$iE4] < $aArray[$iE3] Then
$t = $aArray[$iE4]
$aArray[$iE4] = $aArray[$iE3]
$aArray[$iE3] = $t
If $t < $aArray[$iE2] Then
$aArray[$iE3] = $aArray[$iE2]
$aArray[$iE2] = $t
If $t < $aArray[$iE1] Then
$aArray[$iE2] = $aArray[$iE1]
$aArray[$iE1] = $t
EndIf
EndIf
EndIf
If $aArray[$iE5] < $aArray[$iE4] Then
$t = $aArray[$iE5]
$aArray[$iE5] = $aArray[$iE4]
$aArray[$iE4] = $t
If $t < $aArray[$iE3] Then
$aArray[$iE4] = $aArray[$iE3]
$aArray[$iE3] = $t
If $t < $aArray[$iE2] Then
$aArray[$iE3] = $aArray[$iE2]
$aArray[$iE2] = $t
If $t < $aArray[$iE1] Then
$aArray[$iE2] = $aArray[$iE1]
$aArray[$iE1] = $t
EndIf
EndIf
EndIf
EndIf
Local $iLess = $iPivot_Left
Local $iGreater = $iPivot_Right
If (($aArray[$iE1] <> $aArray[$iE2]) And ($aArray[$iE2] <> $aArray[$iE3]) And ($aArray[$iE3] <> $aArray[$iE4]) And ($aArray[$iE4] <> $aArray[$iE5])) Then
Local $iPivot_1 = $aArray[$iE2]
Local $iPivot_2 = $aArray[$iE4]
$aArray[$iE2] = $aArray[$iPivot_Left]
$aArray[$iE4] = $aArray[$iPivot_Right]
Do
$iLess += 1
Until $aArray[$iLess] >= $iPivot_1
Do
$iGreater -= 1
Until $aArray[$iGreater] <= $iPivot_2
$k = $iLess
While $k <= $iGreater
$iAk = $aArray[$k]
If $iAk < $iPivot_1 Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $iAk
$iLess += 1
ElseIf $iAk > $iPivot_2 Then
While $aArray[$iGreater] > $iPivot_2
$iGreater -= 1
If $iGreater + 1 = $k Then ExitLoop 2
WEnd
If $aArray[$iGreater] < $iPivot_1 Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $aArray[$iGreater]
$iLess += 1
Else
$aArray[$k] = $aArray[$iGreater]
EndIf
$aArray[$iGreater] = $iAk
$iGreater -= 1
EndIf
$k += 1
WEnd
$aArray[$iPivot_Left] = $aArray[$iLess - 1]
$aArray[$iLess - 1] = $iPivot_1
$aArray[$iPivot_Right] = $aArray[$iGreater + 1]
$aArray[$iGreater + 1] = $iPivot_2
__ArrayDualPivotSort($aArray, $iPivot_Left, $iLess - 2, True)
__ArrayDualPivotSort($aArray, $iGreater + 2, $iPivot_Right, False)
If ($iLess < $iE1) And ($iE5 < $iGreater) Then
While $aArray[$iLess] = $iPivot_1
$iLess += 1
WEnd
While $aArray[$iGreater] = $iPivot_2
$iGreater -= 1
WEnd
$k = $iLess
While $k <= $iGreater
$iAk = $aArray[$k]
If $iAk = $iPivot_1 Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $iAk
$iLess += 1
ElseIf $iAk = $iPivot_2 Then
While $aArray[$iGreater] = $iPivot_2
$iGreater -= 1
If $iGreater + 1 = $k Then ExitLoop 2
WEnd
If $aArray[$iGreater] = $iPivot_1 Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $iPivot_1
$iLess += 1
Else
$aArray[$k] = $aArray[$iGreater]
EndIf
$aArray[$iGreater] = $iAk
$iGreater -= 1
EndIf
$k += 1
WEnd
EndIf
__ArrayDualPivotSort($aArray, $iLess, $iGreater, False)
Else
Local $iPivot = $aArray[$iE3]
$k = $iLess
While $k <= $iGreater
If $aArray[$k] = $iPivot Then
$k += 1
ContinueLoop
EndIf
$iAk = $aArray[$k]
If $iAk < $iPivot Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $iAk
$iLess += 1
Else
While $aArray[$iGreater] > $iPivot
$iGreater -= 1
WEnd
If $aArray[$iGreater] < $iPivot Then
$aArray[$k] = $aArray[$iLess]
$aArray[$iLess] = $aArray[$iGreater]
$iLess += 1
Else
$aArray[$k] = $iPivot
EndIf
$aArray[$iGreater] = $iAk
$iGreater -= 1
EndIf
$k += 1
WEnd
__ArrayDualPivotSort($aArray, $iPivot_Left, $iLess - 1, True)
__ArrayDualPivotSort($aArray, $iGreater + 1, $iPivot_Right, False)
EndIf
EndFunc
Func _ArraySwap(ByRef $aArray, $iIndex_1, $iIndex_2, $bCol = False, $iStart = -1, $iEnd = -1)
If $bCol = Default Then $bCol = False
If $iStart = Default Then $iStart = -1
If $iEnd = Default Then $iEnd = -1
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS) - 1
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS) - 1
If $iDim_2 = -1 Then
$bCol = False
$iStart = -1
$iEnd = -1
EndIf
If $iStart > $iEnd Then Return SetError(5, 0, -1)
If $bCol Then
If $iIndex_1 < 0 Or $iIndex_2 > $iDim_2 Then Return SetError(3, 0, -1)
If $iStart = -1 Then $iStart = 0
If $iEnd = -1 Then $iEnd = $iDim_1
Else
If $iIndex_1 < 0 Or $iIndex_2 > $iDim_1 Then Return SetError(3, 0, -1)
If $iStart = -1 Then $iStart = 0
If $iEnd = -1 Then $iEnd = $iDim_2
EndIf
Local $vTmp
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
$vTmp = $aArray[$iIndex_1]
$aArray[$iIndex_1] = $aArray[$iIndex_2]
$aArray[$iIndex_2] = $vTmp
Case 2
If $iStart < -1 Or $iEnd < -1 Then Return SetError(4, 0, -1)
If $bCol Then
If $iStart > $iDim_1 Or $iEnd > $iDim_1 Then Return SetError(4, 0, -1)
For $j = $iStart To $iEnd
$vTmp = $aArray[$j][$iIndex_1]
$aArray[$j][$iIndex_1] = $aArray[$j][$iIndex_2]
$aArray[$j][$iIndex_2] = $vTmp
Next
Else
If $iStart > $iDim_2 Or $iEnd > $iDim_2 Then Return SetError(4, 0, -1)
For $j = $iStart To $iEnd
$vTmp = $aArray[$iIndex_1][$j]
$aArray[$iIndex_1][$j] = $aArray[$iIndex_2][$j]
$aArray[$iIndex_2][$j] = $vTmp
Next
EndIf
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return 1
EndFunc
Func _ArrayToClip(Const ByRef $aArray, $sDelim_Col = "|", $iStart_Row = -1, $iEnd_Row = -1, $sDelim_Row = @CRLF, $iStart_Col = -1, $iEnd_Col = -1)
Local $sResult = _ArrayToString($aArray, $sDelim_Col, $iStart_Row, $iEnd_Row, $sDelim_Row, $iStart_Col, $iEnd_Col)
If @error Then Return SetError(@error, 0, 0)
If ClipPut($sResult) Then Return 1
Return SetError(-1, 0, 0)
EndFunc
Func _ArrayToString(Const ByRef $aArray, $sDelim_Col = "|", $iStart_Row = -1, $iEnd_Row = -1, $sDelim_Row = @CRLF, $iStart_Col = -1, $iEnd_Col = -1)
If $sDelim_Col = Default Then $sDelim_Col = "|"
If $sDelim_Row = Default Then $sDelim_Row = @CRLF
If $iStart_Row = Default Then $iStart_Row = -1
If $iEnd_Row = Default Then $iEnd_Row = -1
If $iStart_Col = Default Then $iStart_Col = -1
If $iEnd_Col = Default Then $iEnd_Col = -1
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS) - 1
If $iStart_Row = -1 Then $iStart_Row = 0
If $iEnd_Row = -1 Then $iEnd_Row = $iDim_1
If $iStart_Row < -1 Or $iEnd_Row < -1 Then Return SetError(3, 0, -1)
If $iStart_Row > $iDim_1 Or $iEnd_Row > $iDim_1 Then Return SetError(3, 0, "")
If $iStart_Row > $iEnd_Row Then Return SetError(4, 0, -1)
Local $sRet = ""
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
For $i = $iStart_Row To $iEnd_Row
$sRet &= $aArray[$i] & $sDelim_Col
Next
Return StringTrimRight($sRet, StringLen($sDelim_Col))
Case 2
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS) - 1
If $iStart_Col = -1 Then $iStart_Col = 0
If $iEnd_Col = -1 Then $iEnd_Col = $iDim_2
If $iStart_Col < -1 Or $iEnd_Col < -1 Then Return SetError(5, 0, -1)
If $iStart_Col > $iDim_2 Or $iEnd_Col > $iDim_2 Then Return SetError(5, 0, -1)
If $iStart_Col > $iEnd_Col Then Return SetError(6, 0, -1)
For $i = $iStart_Row To $iEnd_Row
For $j = $iStart_Col To $iEnd_Col
$sRet &= $aArray[$i][$j] & $sDelim_Col
Next
$sRet = StringTrimRight($sRet, StringLen($sDelim_Col)) & $sDelim_Row
Next
Return StringTrimRight($sRet, StringLen($sDelim_Row))
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return 1
EndFunc
Func _ArrayTranspose(ByRef $aArray)
Switch UBound($aArray, 0)
Case 0
Return SetError(2, 0, 0)
Case 1
Local $aTemp[1][UBound($aArray)]
For $i = 0 To UBound($aArray) - 1
$aTemp[0][$i] = $aArray[$i]
Next
$aArray = $aTemp
Case 2
Local $iDim_1 = UBound($aArray, 1), $iDim_2 = UBound($aArray, 2)
If $iDim_1 <> $iDim_2 Then
Local $aTemp[$iDim_2][$iDim_1]
For $i = 0 To $iDim_1 - 1
For $j = 0 To $iDim_2 - 1
$aTemp[$j][$i] = $aArray[$i][$j]
Next
Next
$aArray = $aTemp
Else
Local $vElement
For $i = 0 To $iDim_1 - 1
For $j = $i + 1 To $iDim_2 - 1
$vElement = $aArray[$i][$j]
$aArray[$i][$j] = $aArray[$j][$i]
$aArray[$j][$i] = $vElement
Next
Next
EndIf
Case Else
Return SetError(1, 0, 0)
EndSwitch
Return 1
EndFunc
Func _ArrayTrim(ByRef $aArray, $iTrimNum, $iDirection = 0, $iStart = 0, $iEnd = 0, $iSubItem = 0)
If $iDirection = Default Then $iDirection = 0
If $iStart = Default Then $iStart = 0
If $iEnd = Default Then $iEnd = 0
If $iSubItem = Default Then $iSubItem = 0
If Not IsArray($aArray) Then Return SetError(1, 0, 0)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS) - 1
If $iEnd = 0 Then $iEnd = $iDim_1
If $iStart > $iEnd Then Return SetError(3, 0, -1)
If $iStart < 0 Or $iEnd < 0 Then Return SetError(3, 0, -1)
If $iStart > $iDim_1 Or $iEnd > $iDim_1 Then Return SetError(3, 0, -1)
If $iStart > $iEnd Then Return SetError(4, 0, -1)
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
If $iDirection Then
For $i = $iStart To $iEnd
$aArray[$i] = StringTrimRight($aArray[$i], $iTrimNum)
Next
Else
For $i = $iStart To $iEnd
$aArray[$i] = StringTrimLeft($aArray[$i], $iTrimNum)
Next
EndIf
Case 2
Local $iDim_2 = UBound($aArray, $UBOUND_COLUMNS) - 1
If $iSubItem < 0 Or $iSubItem > $iDim_2 Then Return SetError(5, 0, -1)
If $iDirection Then
For $i = $iStart To $iEnd
$aArray[$i][$iSubItem] = StringTrimRight($aArray[$i][$iSubItem], $iTrimNum)
Next
Else
For $i = $iStart To $iEnd
$aArray[$i][$iSubItem] = StringTrimLeft($aArray[$i][$iSubItem], $iTrimNum)
Next
EndIf
Case Else
Return SetError(2, 0, 0)
EndSwitch
Return 1
EndFunc
Func _ArrayUnique(Const ByRef $aArray, $iColumn = 0, $iBase = 0, $iCase = 0, $iCount = $ARRAYUNIQUE_COUNT, $iIntType = $ARRAYUNIQUE_AUTO)
If $iColumn = Default Then $iColumn = 0
If $iBase = Default Then $iBase = 0
If $iCase = Default Then $iCase = 0
If $iCount = Default Then $iCount = $ARRAYUNIQUE_COUNT
If UBound($aArray, $UBOUND_ROWS) = 0 Then Return SetError(1, 0, 0)
Local $iDims = UBound($aArray, $UBOUND_DIMENSIONS), $iNumColumns = UBound($aArray, $UBOUND_COLUMNS)
If $iDims > 2 Then Return SetError(2, 0, 0)
If $iBase < 0 Or $iBase > 1 Or (Not IsInt($iBase)) Then Return SetError(3, 0, 0)
If $iCase < 0 Or $iCase > 1 Or (Not IsInt($iCase)) Then Return SetError(3, 0, 0)
If $iCount < 0 Or $iCount > 1 Or (Not IsInt($iCount)) Then Return SetError(4, 0, 0)
If $iIntType < 0 Or $iIntType > 4 Or (Not IsInt($iIntType)) Then Return SetError(5, 0, 0)
If $iColumn < 0 Or ($iNumColumns = 0 And $iColumn > 0) Or ($iNumColumns > 0 And $iColumn >= $iNumColumns) Then Return SetError(6, 0, 0)
If $iIntType = $ARRAYUNIQUE_AUTO Then
Local $vFirstElem = ( ($iDims = 1) ? ($aArray[$iBase]) : ($aArray[$iColumn][$iBase]) )
If IsInt($vFirstElem) Then
Switch VarGetType($vFirstElem)
Case "Int32"
$iIntType = $ARRAYUNIQUE_FORCE32
Case "Int64"
$iIntType = $ARRAYUNIQUE_FORCE64
EndSwitch
Else
$iIntType = $ARRAYUNIQUE_FORCE32
EndIf
EndIf
ObjEvent("AutoIt.Error", "__ArrayUnique_AutoErrFunc")
Local $oDictionary = ObjCreate("Scripting.Dictionary")
$oDictionary.CompareMode = Number(Not $iCase)
Local $vElem, $sType, $vKey, $bCOMError = False
For $i = $iBase To UBound($aArray) - 1
If $iDims = 1 Then
$vElem = $aArray[$i]
Else
$vElem = $aArray[$i][$iColumn]
EndIf
Switch $iIntType
Case $ARRAYUNIQUE_FORCE32
$oDictionary.Item($vElem)
If @error Then
$bCOMError = True
ExitLoop
EndIf
Case $ARRAYUNIQUE_FORCE64
$sType = VarGetType($vElem)
If $sType = "Int32" Then
$bCOMError = True
ExitLoop
EndIf
$vKey = "#" & $sType & "#" & String($vElem)
If Not $oDictionary.Item($vKey) Then
$oDictionary($vKey) = $vElem
EndIf
Case $ARRAYUNIQUE_MATCH
$sType = VarGetType($vElem)
If StringLeft($sType, 3) = "Int" Then
$vKey = "#Int#" & String($vElem)
Else
$vKey = "#" & $sType & "#" & String($vElem)
EndIf
If Not $oDictionary.Item($vKey) Then
$oDictionary($vKey) = $vElem
EndIf
Case $ARRAYUNIQUE_DISTINCT
$vKey = "#" & VarGetType($vElem) & "#" & String($vElem)
If Not $oDictionary.Item($vKey) Then
$oDictionary($vKey) = $vElem
EndIf
EndSwitch
Next
Local $aValues, $j = 0
If $bCOMError Then
Return SetError(7, 0, 0)
ElseIf $iIntType <> $ARRAYUNIQUE_FORCE32 Then
Local $aValues[$oDictionary.Count]
For $vKey In $oDictionary.Keys()
$aValues[$j] = $oDictionary($vKey)
If StringLeft($vKey, 5) = "#Ptr#" Then
$aValues[$j] = Ptr($aValues[$j])
EndIf
$j += 1
Next
Else
$aValues = $oDictionary.Keys()
EndIf
If $iCount Then
_ArrayInsert($aValues, 0, $oDictionary.Count)
EndIf
Return $aValues
EndFunc
Func _Array1DToHistogram($aArray, $iSizing = 100)
If UBound($aArray, 0) > 1 Then Return SetError(1, 0, "")
$iSizing = $iSizing * 8
Local $t, $n, $iMin = 0, $iMax = 0, $iOffset = 0
For $i = 0 To UBound($aArray) - 1
$t = $aArray[$i]
$t = IsNumber($t) ? Round($t) : 0
If $t < $iMin Then $iMin = $t
If $t > $iMax Then $iMax = $t
Next
Local $iRange = Int(Round(($iMax - $iMin) / 8)) * 8
Local $iSpaceRatio = 4
For $i = 0 To UBound($aArray) - 1
$t = $aArray[$i]
If $t Then
$n = Abs(Round(($iSizing * $t) / $iRange) / 8)
$aArray[$i] = ""
If $t > 0 Then
If $iMin Then
$iOffset = Int(Abs(Round(($iSizing * $iMin) / $iRange) / 8) / 8 * $iSpaceRatio)
$aArray[$i] = __Array_StringRepeat(ChrW(0x20), $iOffset)
EndIf
Else
If $iMin <> $t Then
$iOffset = Int(Abs(Round(($iSizing * ($t - $iMin)) / $iRange) / 8) / 8 * $iSpaceRatio)
$aArray[$i] = __Array_StringRepeat(ChrW(0x20), $iOffset)
EndIf
EndIf
$aArray[$i] &= __Array_StringRepeat(ChrW(0x2588), Int($n / 8))
$n = Mod($n, 8)
If $n > 0 Then $aArray[$i] &= ChrW(0x2588 + 8 - $n)
$aArray[$i] &= ' ' & $t
Else
$aArray[$i] = ""
EndIf
Next
Return $aArray
EndFunc
Func __Array_StringRepeat($sString, $iRepeatCount)
$iRepeatCount = Int($iRepeatCount)
If StringLen($sString) < 1 Or $iRepeatCount <= 0 Then Return SetError(1, 0, "")
Local $sResult = ""
While $iRepeatCount > 1
If BitAND($iRepeatCount, 1) Then $sResult &= $sString
$sString &= $sString
$iRepeatCount = BitShift($iRepeatCount, 1)
WEnd
Return $sString & $sResult
EndFunc
Func __Array_ExeterInternal(ByRef $aArray, $iStart, $iSize, $sDelimiter, ByRef $aIdx, ByRef $aResult, ByRef $iCount)
If $iStart == $iSize - 1 Then
For $i = 0 To $iSize - 1
$aResult[$iCount] &= $aArray[$aIdx[$i]] & $sDelimiter
Next
If $sDelimiter <> "" Then $aResult[$iCount] = StringTrimRight($aResult[$iCount], StringLen($sDelimiter))
$iCount += 1
Else
Local $iTemp
For $i = $iStart To $iSize - 1
$iTemp = $aIdx[$i]
$aIdx[$i] = $aIdx[$iStart]
$aIdx[$iStart] = $iTemp
__Array_ExeterInternal($aArray, $iStart + 1, $iSize, $sDelimiter, $aIdx, $aResult, $iCount)
$aIdx[$iStart] = $aIdx[$i]
$aIdx[$i] = $iTemp
Next
EndIf
EndFunc
Func __Array_Combinations($iN, $iR)
Local $i_Total = 1
For $i = $iR To 1 Step -1
$i_Total *= ($iN / $i)
$iN -= 1
Next
Return Round($i_Total)
EndFunc
Func __Array_GetNext($iN, $iR, ByRef $iLeft, $iTotal, ByRef $aIdx)
If $iLeft == $iTotal Then
$iLeft -= 1
Return
EndIf
Local $i = $iR - 1
While $aIdx[$i] == $iN - $iR + $i
$i -= 1
WEnd
$aIdx[$i] += 1
For $j = $i + 1 To $iR - 1
$aIdx[$j] = $aIdx[$i] + $j - $i
Next
$iLeft -= 1
EndFunc
Func __Array_MinMaxIndex(Const ByRef $aArray, $iCompNumeric, $iStart, $iEnd, $iSubItem, $fuComparison)
If $iCompNumeric = Default Then $iCompNumeric = 0
If $iCompNumeric <> 1 Then $iCompNumeric = 0
If $iStart = Default Then $iStart = 0
If $iEnd = Default Then $iEnd = 0
If $iSubItem = Default Then $iSubItem = 0
If Not IsArray($aArray) Then Return SetError(1, 0, -1)
Local $iDim_1 = UBound($aArray, $UBOUND_ROWS) - 1
If $iDim_1 < 0 Then Return SetError(1, 0, -1)
If $iEnd = -1 Then $iEnd = $iDim_1
If $iStart = -1 Then $iStart = 0
If $iStart < -1 Or $iEnd < -1 Then Return SetError(3, 0, -1)
If $iStart > $iDim_1 Or $iEnd > $iDim_1 Then Return SetError(3, 0, -1)
If $iStart > $iEnd Then Return SetError(4, 0, -1)
If $iDim_1 < 0 Then Return SetError(5, 0, -1)
Local $iMaxMinIndex = $iStart
Switch UBound($aArray, $UBOUND_DIMENSIONS)
Case 1
If $iCompNumeric Then
For $i = $iStart To $iEnd
If $fuComparison(Number($aArray[$i]), Number($aArray[$iMaxMinIndex])) Then $iMaxMinIndex = $i
Next
Else
For $i = $iStart To $iEnd
If $fuComparison($aArray[$i], $aArray[$iMaxMinIndex]) Then $iMaxMinIndex = $i
Next
EndIf
Case 2
If $iSubItem < 0 Or $iSubItem > UBound($aArray, $UBOUND_COLUMNS) - 1 Then Return SetError(6, 0, -1)
If $iCompNumeric Then
For $i = $iStart To $iEnd
If $fuComparison(Number($aArray[$i][$iSubItem]), Number($aArray[$iMaxMinIndex][$iSubItem])) Then $iMaxMinIndex = $i
Next
Else
For $i = $iStart To $iEnd
If $fuComparison($aArray[$i][$iSubItem], $aArray[$iMaxMinIndex][$iSubItem]) Then $iMaxMinIndex = $i
Next
EndIf
Case Else
Return SetError(2, 0, -1)
EndSwitch
Return $iMaxMinIndex
EndFunc
Func __Array_GreaterThan($vValue1, $vValue2)
Return $vValue1 > $vValue2
EndFunc
Func __Array_LessThan($vValue1, $vValue2)
Return $vValue1 < $vValue2
EndFunc
Func __ArrayUnique_AutoErrFunc()
EndFunc
Global Const $xlAnd = 1
Global Const $xlBottom10Items = 4
Global Const $xlBottom10Percent = 6
Global Const $xlFilterCellColor = 8
Global Const $xlFilterDynamic = 11
Global Const $xlFilterFontColor = 9
Global Const $xlFilterIcon = 10
Global Const $xlFilterValues = 7
Global Const $xlOr = 2
Global Const $xlTop10Items = 3
Global Const $xlTop10Percent = 5
Global Const $xlCenter = -4108
Global Const $xlLeft = -4131
Global Const $xlRight = -4152
Global Const $xlCalculationAutomatic = -4105
Global Const $xlCalculationManual = -4135
Global Const $xlCalculationSemiautomatic = 2
Global Const $xlCellTypeAllFormatConditions = -4172
Global Const $xlCellTypeAllValidation = -4174
Global Const $xlCellTypeBlanks = 4
Global Const $xlCellTypeComments = -4144
Global Const $xlCellTypeConstants = 2
Global Const $xlCellTypeFormulas = -4123
Global Const $xlCellTypeLastCell = 11
Global Const $xlCellTypeSameFormatConditions = -4173
Global Const $xlCellTypeSameValidation = -4175
Global Const $xlCellTypeVisible = 12
Global Const $xlDMYFormat = 4
Global Const $xlDYMFormat = 7
Global Const $xlEMDFormat = 10
Global Const $xlGeneralFormat = 1
Global Const $xlMDYFormat = 3
Global Const $xlMYDFormat = 6
Global Const $xlSkipColumn = 9
Global Const $xlTextFormat = 2
Global Const $xlYDMFormat = 8
Global Const $xlYMDFormat = 5
Global Const $xlShiftToLeft = -4159
Global Const $xlShiftUp = -4162
Global Const $xlValidAlertInformation = 3
Global Const $xlValidAlertStop = 1
Global Const $xlValidAlertWarning = 2
Global Const $xlValidateCustom = 7
Global Const $xlValidateDate = 4
Global Const $xlValidateDecimal = 2
Global Const $xlValidateInputOnly = 0
Global Const $xlValidateList = 3
Global Const $xlValidateTextLength = 6
Global Const $xlValidateTime = 5
Global Const $xlValidateWholeNumber = 1
Global Const $xlFilterAboveAverage = 33
Global Const $xlFilterAllDatesInPeriodApril = 24
Global Const $xlFilterAllDatesInPeriodAugust = 28
Global Const $xlFilterAllDatesInPeriodDecember = 32
Global Const $xlFilterAllDatesInPeriodFebruray = 22
Global Const $xlFilterAllDatesInPeriodJanuary = 21
Global Const $xlFilterAllDatesInPeriodJuly = 27
Global Const $xlFilterAllDatesInPeriodJune = 26
Global Const $xlFilterAllDatesInPeriodMarch = 23
Global Const $xlFilterAllDatesInPeriodMay = 25
Global Const $xlFilterAllDatesInPeriodNovember = 31
Global Const $xlFilterAllDatesInPeriodOctober = 30
Global Const $xlFilterAllDatesInPeriodQuarter1 = 17
Global Const $xlFilterAllDatesInPeriodQuarter2 = 18
Global Const $xlFilterAllDatesInPeriodQuarter3 = 19
Global Const $xlFilterAllDatesInPeriodQuarter4 = 20
Global Const $xlFilterAllDatesInPeriodSeptember = 29
Global Const $xlFilterBelowAverage = 34
Global Const $xlFilterLastMonth = 8
Global Const $xlFilterLastQuarter = 11
Global Const $xlFilterLastWeek = 5
Global Const $xlFilterLastYear = 14
Global Const $xlFilterNextMonth = 9
Global Const $xlFilterNextQuarter = 12
Global Const $xlFilterNextWeek = 6
Global Const $xlFilterNextYear = 15
Global Const $xlFilterThisMonth = 7
Global Const $xlFilterThisQuarter = 10
Global Const $xlFilterThisWeek = 4
Global Const $xlFilterThisYear = 13
Global Const $xlFilterToday = 1
Global Const $xlFilterTomorrow = 3
Global Const $xlFilterYearToDate = 16
Global Const $xlFilterYesterday = 2
Global Const $xlAddIn = 18
Global Const $xlAddIn8 = 18
Global Const $xlCSV = 6
Global Const $xlCSVMac = 22
Global Const $xlCSVMSDOS = 24
Global Const $xlCSVWindows = 23
Global Const $xlCurrentPlatformText = -4158
Global Const $xlDBF2 = 7
Global Const $xlDBF3 = 8
Global Const $xlDBF4 = 11
Global Const $xlDIF = 9
Global Const $xlExcel12 = 50
Global Const $xlExcel2 = 16
Global Const $xlExcel2FarEast = 27
Global Const $xlExcel3 = 29
Global Const $xlExcel4 = 33
Global Const $xlExcel4Workbook = 35
Global Const $xlExcel5 = 39
Global Const $xlExcel7 = 39
Global Const $xlExcel8 = 56
Global Const $xlExcel9795 = 43
Global Const $xlHtml = 44
Global Const $xlIntlAddIn = 26
Global Const $xlIntlMacro = 25
Global Const $xlOpenDocumentSpreadsheet = 60
Global Const $xlOpenXMLAddIn = 55
Global Const $xlOpenXMLTemplate = 54
Global Const $xlOpenXMLTemplateMacroEnabled = 53
Global Const $xlOpenXMLWorkbook = 51
Global Const $xlOpenXMLWorkbookMacroEnabled = 52
Global Const $xlSYLK = 2
Global Const $xlTemplate = 17
Global Const $xlTemplate8 = 17
Global Const $xlTextMac = 19
Global Const $xlTextMSDOS = 21
Global Const $xlTextPrinter = 36
Global Const $xlTextWindows = 20
Global Const $xlUnicodeText = 42
Global Const $xlWebArchive = 45
Global Const $xlWJ2WD1 = 14
Global Const $xlWJ3 = 40
Global Const $xlWJ3FJ3 = 41
Global Const $xlWK1 = 5
Global Const $xlWK1ALL = 31
Global Const $xlWK1FMT = 30
Global Const $xlWK3 = 15
Global Const $xlWK3FM3 = 32
Global Const $xlWK4 = 38
Global Const $xlWKS = 4
Global Const $xlWorkbookDefault = 51
Global Const $xlWorkbookNormal = -4143
Global Const $xlWorks2FarEast = 28
Global Const $xlWQ1 = 34
Global Const $xlXMLSpreadsheet = 46
Global Const $xlComments = -4144
Global Const $xlFormulas = -4123
Global Const $xlValues = -4163
Global Const $xlQualityMinimum = 1
Global Const $xlQualityStandard = 0
Global Const $xlTypePDF = 0
Global Const $xlTypeXPS = 1
Global Const $xlBetween = 1
Global Const $xlEqual = 3
Global Const $xlGreater = 5
Global Const $xlGreaterEqual = 7
Global Const $xlLess = 6
Global Const $xlLessEqual = 8
Global Const $xlNotBetween = 2
Global Const $xlNotEqual = 4
Global Const $xlFormatFromLeftOrAbove = 0
Global Const $xlFormatFromRightOrBelow = 1
Global Const $xlShiftDown = -4121
Global Const $xlShiftToRight = -4161
Global Const $xlPart = 2
Global Const $xlWhole = 1
Global Const $xlPasteSpecialOperationAdd = 2
Global Const $xlPasteSpecialOperationDivide = 5
Global Const $xlPasteSpecialOperationMultiply = 4
Global Const $xlPasteSpecialOperationNone = -4142
Global Const $xlPasteSpecialOperationSubtract = 3
Global Const $xlPasteAll = -4104
Global Const $xlPasteAllExceptBorders = 7
Global Const $xlPasteAllMergingConditionalFormats = 14
Global Const $xlPasteAllUsingSourceTheme = 13
Global Const $xlPasteColumnWidths = 8
Global Const $xlPasteComments = -4144
Global Const $xlPasteFormats = -4122
Global Const $xlPasteFormulas = -4123
Global Const $xlPasteFormulasAndNumberFormats = 11
Global Const $xlPasteValidation = 6
Global Const $xlPasteValues = -4163
Global Const $xlPasteValuesAndNumberFormats = 12
Global Const $xlMacintosh = 1
Global Const $xlMSDOS = 3
Global Const $xlWindows = 2
Global Const $xlA1 = 1
Global Const $xlR1C1 = -4150
Global Const $xlAbsolute = 1
Global Const $xlAbsRowRelColumn = 2
Global Const $xlRelative = 4
Global Const $xlRelRowAbsColumn = 3
Global Const $xlSheetHidden = 0
Global Const $xlSheetVeryHidden = 2
Global Const $xlSheetVisible = -1
Global Const $xlSortNormal = 0
Global Const $xlSortTextAsNumbers = 1
Global Const $xlAscending = 1
Global Const $xlDescending = 2
Global Const $xlSortOnCellColor = 1
Global Const $xlSortOnFontColor = 2
Global Const $xlSortOnIcon = 3
Global Const $xlSortOnValues = 0
Global Const $xlSortColumns = 1
Global Const $xlSortRows = 2
Global Const $xlDelimited = 1
Global Const $xlFixedWidth = 2
Global Const $xlTextQualifierDoubleQuote = 1
Global Const $xlTextQualifierNone = -4142
Global Const $xlTextQualifierSingleQuote = 2
Global Const $xlGuess = 0
Global Const $xlNo = 2
Global Const $xlYes = 1
Func _Excel_Open($bVisible = Default, $bDisplayAlerts = Default, $bScreenUpdating = Default, $bInteractive = Default, $bForceNew = Default)
Local $oExcel, $bApplCloseOnQuit = False
If $bVisible = Default Then $bVisible = True
If $bDisplayAlerts = Default Then $bDisplayAlerts = False
If $bScreenUpdating = Default Then $bScreenUpdating = True
If $bInteractive = Default Then $bInteractive = True
If $bForceNew = Default Then $bForceNew = False
If Not $bForceNew Then $oExcel = ObjGet("", "Excel.Application")
If $bForceNew Or @error Then
$oExcel = ObjCreate("Excel.Application")
If @error Or Not IsObj($oExcel) Then Return SetError(1, @error, 0)
$bApplCloseOnQuit = True
EndIf
__Excel_CloseOnQuit($oExcel, $bApplCloseOnQuit)
$oExcel.Visible = $bVisible
$oExcel.DisplayAlerts = $bDisplayAlerts
$oExcel.ScreenUpdating = $bScreenUpdating
$oExcel.Interactive = $bInteractive
Return SetError(0, $bApplCloseOnQuit, $oExcel)
EndFunc
Func _Excel_Close(ByRef $oExcel, $bSaveChanges = Default, $bForceClose = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If $bSaveChanges = Default Then $bSaveChanges = True
If $bForceClose = Default Then $bForceClose = False
If Not IsObj($oExcel) Or ObjName($oExcel, 1) <> "_Application" Then Return SetError(1, 0, 0)
If $bSaveChanges Then
For $oWorkbook In $oExcel.Workbooks
If Not $oWorkbook.Saved Then
$oWorkbook.Save()
If @error Then Return SetError(3, @error, 0)
EndIf
Next
EndIf
If __Excel_CloseOnQuit($oExcel) Or $bForceClose Then
$oExcel.Quit()
If @error Then Return SetError(2, @error, 0)
__Excel_CloseOnQuit($oExcel, False)
$oExcel = 0
EndIf
Return 1
EndFunc
Func _Excel_BookAttach($sString, $sMode = Default, $oInstance = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
Local $oWorkbook, $iCount = 0, $sCLSID_Workbook = "{00020819-0000-0000-C000-000000000046}"
If $sMode = Default Then $sMode = "FilePath"
While True
$oWorkbook = ObjGet("", $sCLSID_Workbook, $iCount + 1)
If @error Then Return SetError(1, @error, 0)
If $oInstance <> Default And $oInstance <> $oWorkbook.Parent Then ContinueLoop
Switch $sMode
Case "filename"
If $oWorkbook.Name = $sString Then Return $oWorkbook
Case "filepath"
If $oWorkbook.FullName = $sString Then Return $oWorkbook
Case "title"
If $oWorkbook.Application.Caption = $sString Then Return $oWorkbook
Case Else
Return SetError(2, 0, 0)
EndSwitch
$iCount += 1
WEnd
EndFunc
Func _Excel_BookClose(ByRef $oWorkbook, $bSave = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
If $bSave = Default Then $bSave = True
If $bSave And Not $oWorkbook.Saved Then
$oWorkbook.Save()
If @error Then Return SetError(2, @error, 0)
EndIf
$oWorkbook.Close()
If @error Then Return SetError(3, @error, 0)
$oWorkbook = 0
Return 1
EndFunc
Func _Excel_BookList($oExcel = Default)
Local $aBooks[1][3], $iIndex = 0
If IsObj($oExcel) Then
If ObjName($oExcel, 1) <> "_Application" Then Return SetError(1, 0, 0)
Local $iTemp = $oExcel.Workbooks.Count
ReDim $aBooks[$iTemp][3]
For $iIndex = 0 To $iTemp - 1
$aBooks[$iIndex][0] = $oExcel.Workbooks($iIndex + 1)
$aBooks[$iIndex][1] = $oExcel.Workbooks($iIndex + 1).Name
$aBooks[$iIndex][2] = $oExcel.Workbooks($iIndex + 1).Path
Next
Else
If $oExcel <> Default Then Return SetError(1, 0, 0)
Local $oWorkbook, $sCLSID_Workbook = "{00020819-0000-0000-C000-000000000046}"
While True
$oWorkbook = ObjGet("", $sCLSID_Workbook, $iIndex + 1)
If @error Then ExitLoop
ReDim $aBooks[$iIndex + 1][3]
$aBooks[$iIndex][0] = $oWorkbook
$aBooks[$iIndex][1] = $oWorkbook.Name
$aBooks[$iIndex][2] = $oWorkbook.Path
$iIndex += 1
WEnd
EndIf
Return $aBooks
EndFunc
Func _Excel_BookNew($oExcel, $iSheets = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oExcel) Or ObjName($oExcel, 1) <> "_Application" Then Return SetError(1, 0, 0)
With $oExcel
If $iSheets <> Default Then
If $iSheets < 1 Or $iSheets > 255 Then Return SetError(4, 0, 0)
Local $iSheetsBackup = .SheetsInNewWorkbook
.SheetsInNewWorkbook = $iSheets
If @error Then Return SetError(2, @error, 0)
EndIf
Local $oWorkbook = .Workbooks.Add()
If @error Then
Local $iError = @error
If $iSheets <> Default Then .SheetsInNewWorkbook = $iSheetsBackup
Return SetError(3, $iError, 0)
EndIf
If $iSheets <> Default Then .SheetsInNewWorkbook = $iSheetsBackup
EndWith
Return $oWorkbook
EndFunc
Func _Excel_BookOpen($oExcel, $sFilePath, $bReadOnly = Default, $bVisible = Default, $sPassword = Default, $sWritePassword = Default, $bUpdateLinks = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oExcel) Or ObjName($oExcel, 1) <> "_Application" Then Return SetError(1, @error, 0)
If Not FileExists($sFilePath) Then Return SetError(2, 0, 0)
If $bReadOnly = Default Then $bReadOnly = False
If $bVisible = Default Then $bVisible = True
Local $oWorkbook = $oExcel.Workbooks.Open($sFilePath, $bUpdateLinks, $bReadOnly, Default, $sPassword, $sWritePassword)
If @error Then Return SetError(3, @error, 0)
$oExcel.Windows($oWorkbook.Name).Visible = $bVisible
If $bReadOnly = False And $oWorkbook.Readonly = True Then Return SetError(0, 1, $oWorkbook)
Return $oWorkbook
EndFunc
Func _Excel_BookOpenText($oExcel, $sFilePath, $iStartRow = Default, $iDataType = Default, $sTextQualifier = Default, $bConsecutiveDelimiter = Default, $sDelimiter = Default, $aFieldInfo = Default, $sDecimalSeparator = Default, $sThousandsSeparator = Default, $bTrailingMinusNumbers = Default, $iOrigin = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
Local $bTab = False, $bSemicolon = False, $bComma = False, $bSpace = False, $aDelimiter[1], $bOther = False, $sOtherChar
If Not IsObj($oExcel) Or ObjName($oExcel, 1) <> "_Application" Then Return SetError(1, @error, 0)
If Not FileExists($sFilePath) Then Return SetError(2, 0, 0)
If $iStartRow = Default Then $iStartRow = 1
If $sTextQualifier = Default Then $sTextQualifier = $xlTextQualifierDoubleQuote
If $bConsecutiveDelimiter = Default Then $bConsecutiveDelimiter = False
If $sDelimiter = Default Then $sDelimiter = ","
If $bTrailingMinusNumbers = Default Then $bTrailingMinusNumbers = True
If StringInStr($sDelimiter, @TAB) > 0 Then $bTab = True
If StringInStr($sDelimiter, ";") > 0 Then $bSemicolon = True
If StringInStr($sDelimiter, ",") > 0 Then $bComma = True
If StringInStr($sDelimiter, " ") > 0 Then $bSpace = True
$aDelimiter = StringRegExp($sDelimiter, "[^;, " & @TAB & "]", 1)
If Not @error Then
$sOtherChar = $aDelimiter[0]
$bOther = True
EndIf
$oExcel.Workbooks.OpenText($sFilePath, $iOrigin, $iStartRow, $iDataType, $sTextQualifier, $bConsecutiveDelimiter,  $bTab, $bSemicolon, $bComma, $bSpace, $bOther, $sOtherChar, $aFieldInfo, Default, $sDecimalSeparator, $sThousandsSeparator,  $bTrailingMinusNumbers, False)
If @error Then Return SetError(3, @error, 0)
Return $oExcel.ActiveWorkbook
EndFunc
Func _Excel_BookSave($oWorkbook)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
If Not $oWorkbook.Saved Then
$oWorkbook.Save()
If @error Then Return SetError(2, @error, 0)
Return SetError(0, 1, 1)
EndIf
Return 1
EndFunc
Func _Excel_BookSaveAs($oWorkbook, $sFilePath, $iFormat = Default, $bOverWrite = Default, $sPassword = Default, $sWritePassword = Default, $bReadOnlyRecommended = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
If $iFormat = Default Then
$iFormat = $xlWorkbookDefault
Else
If Not IsNumber($iFormat) Then Return SetError(2, 0, 0)
EndIf
If $bOverWrite = Default Then $bOverWrite = False
If $bReadOnlyRecommended = Default Then $bReadOnlyRecommended = False
If FileExists($sFilePath) Then
If Not $bOverWrite Then Return SetError(3, 0, 0)
Local $iResult = FileDelete($sFilePath)
If $iResult = 0 Then Return SetError(4, 0, 0)
EndIf
$oWorkbook.SaveAs($sFilePath, $iFormat, $sPassword, $sWritePassword, $bReadOnlyRecommended)
If @error Then Return SetError(5, @error, 0)
Return 1
EndFunc
Func _Excel_ColumnToLetter($iColumn)
If Not StringRegExp($iColumn, "^[0-9]+$") Then Return SetError(1, 0, "")
Local $sLetters, $iTemp
While $iColumn
$iTemp = Mod($iColumn, 26)
If $iTemp = 0 Then $iTemp = 26
$sLetters = Chr($iTemp + 64) & $sLetters
$iColumn = ($iColumn - $iTemp) / 26
WEnd
Return $sLetters
EndFunc
Func _Excel_ColumnToNumber($sColumn)
$sColumn = StringUpper($sColumn)
If Not StringRegExp($sColumn, "^[A-Z]+$") Then Return SetError(1, 0, 0)
Local $sLetters = StringSplit($sColumn, "")
Local $iNumber = 0
Local $iLen = StringLen($sColumn)
For $i = 1 To $sLetters[0]
$iNumber += 26 ^ ($iLen - $i) * (Asc($sLetters[$i]) - 64)
Next
Return $iNumber
EndFunc
Func _Excel_ConvertFormula($oExcel, $sFormula, $iFromStyle, $iToStyle = Default, $iToAbsolute = Default, $vRelativeTo = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oExcel) Or ObjName($oExcel, 1) <> "_Application" Then Return SetError(1, 0, "")
If $vRelativeTo <> Default Then
If Not IsObj($vRelativeTo) Then $vRelativeTo = $oExcel.Range($vRelativeTo)
If @error Or Not IsObj($vRelativeTo) Then Return SetError(2, 0, "")
EndIf
Local $sConverted = $oExcel.ConvertFormula($sFormula, $iFromStyle, $iToStyle, $iToAbsolute, $vRelativeTo)
Return $sConverted
EndFunc
Func _Excel_Export($oExcel, $vObject, $sFileName, $iType = Default, $iQuality = Default, $bIncludeProperties = Default, $iFrom = Default, $iTo = Default, $bOpenAfterPublish = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oExcel) Or ObjName($oExcel, 1) <> "_Application" Then Return SetError(1, 0, 0)
If Not IsObj($vObject) Then $vObject = $oExcel.Range($vObject)
If @error Or Not IsObj($vObject) Then Return SetError(2, @error, 0)
If $sFileName = "" Then Return SetError(3, 0, 0)
If $iType = Default Then $iType = $xlTypePDF
If $iQuality = Default Then $iQuality = $xlQualityStandard
If $bIncludeProperties = Default Then $bIncludeProperties = True
If $bOpenAfterPublish = Default Then $bOpenAfterPublish = False
$vObject.ExportAsFixedFormat($iType, $sFileName, $iQuality, $bIncludeProperties, Default, $iFrom, $iTo, $bOpenAfterPublish)
If @error Then Return SetError(4, @error, 0)
Return $vObject
EndFunc
Func _Excel_FilterGet($oWorkbook, $vWorksheet = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
If Not IsObj($vWorksheet) Then
If $vWorksheet = Default Then
$vWorksheet = $oWorkbook.ActiveSheet
Else
$vWorksheet = $oWorkbook.WorkSheets.Item($vWorksheet)
EndIf
If @error Or Not IsObj($vWorksheet) Then Return SetError(2, @error, 0)
ElseIf ObjName($vWorksheet, 1) <> "_Worksheet" Then
Return SetError(2, @error, 0)
EndIf
Local $iIndex = 0, $iRecords, $iItems = $vWorksheet.AutoFilter.Filters.Count
If $iItems > 0 Then
Local $aFilters[$iItems][7]
For $oFilter In $vWorksheet.AutoFilter.Filters
$aFilters[$iIndex][0] = $oFilter.On
$aFilters[$iIndex][1] = $oFilter.Count
$aFilters[$iIndex][2] = $oFilter.Criteria1
If IsArray($oFilter.Criteria1) Then $aFilters[$iIndex][2] = _ArrayToString($aFilters[$iIndex][2])
$aFilters[$iIndex][3] = $oFilter.Criteria2
If IsArray($oFilter.Criteria2) Then $aFilters[$iIndex][3] = _ArrayToString($aFilters[$iIndex][3])
$aFilters[$iIndex][4] = $oFilter.Operator
$aFilters[$iIndex][5] = $oFilter.Parent.Range
$iRecords = 0
For $oArea In $oFilter.Parent.Range.SpecialCells($xlCellTypeVisible).Areas
$iRecords = $iRecords + $oArea.Rows.Count
Next
$aFilters[$iIndex][6] = $iRecords
$iIndex = $iIndex + 1
Next
Return $aFilters
Else
Return SetError(3, 0, "")
EndIf
EndFunc
Func _Excel_FilterSet($oWorkbook, $vWorksheet, $vRange, $iField, $sCriteria1 = Default, $iOperator = Default, $sCriteria2 = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
If Not IsObj($vWorksheet) Then
If $vWorksheet = Default Then
$vWorksheet = $oWorkbook.ActiveSheet
Else
$vWorksheet = $oWorkbook.WorkSheets.Item($vWorksheet)
EndIf
If @error Or Not IsObj($vWorksheet) Then Return SetError(2, @error, 0)
ElseIf ObjName($vWorksheet, 1) <> "_Worksheet" Then
Return SetError(2, @error, 0)
EndIf
If $vRange = Default Then
$vRange = $vWorksheet.Usedrange
ElseIf Not IsObj($vRange) Then
$vRange = $vWorksheet.Range($vRange)
If @error Or Not IsObj($vRange) Then Return SetError(3, @error, 0)
EndIf
If $iField <> 0 Then
$vRange.AutoFilter($iField, $sCriteria1, $iOperator, $sCriteria2)
If @error Then Return SetError(4, @error, 0)
If $vWorksheet.Filtermode = False Then $vWorksheet.AutoFilterMode = False
Else
$vWorksheet.AutoFilterMode = False
EndIf
Return 1
EndFunc
Func _Excel_PictureAdd($oWorkbook, $vWorksheet, $sFile, $vRangeOrLeft, $iTop = Default, $iWidth = Default, $iHeight = Default, $bKeepRatio = True)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
Local $oReturn, $iPosLeft, $iPosTop
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
If Not FileExists($sFile) Then Return SetError(5, 0, 0)
If Not IsObj($vWorksheet) Then
If $vWorksheet = Default Then
$vWorksheet = $oWorkbook.ActiveSheet
Else
$vWorksheet = $oWorkbook.WorkSheets.Item($vWorksheet)
EndIf
If @error Or Not IsObj($vWorksheet) Then Return SetError(2, @error, 0)
ElseIf ObjName($vWorksheet, 1) <> "_Worksheet" Then
Return SetError(2, @error, 0)
EndIf
If IsNumber($vRangeOrLeft) Then
$iPosLeft = $vRangeOrLeft
$iPosTop = $iTop
Else
If Not IsObj($vRangeOrLeft) Then
$vRangeOrLeft = $vWorksheet.Range($vRangeOrLeft)
If @error Or Not IsObj($vRangeOrLeft) Then Return SetError(3, @error, 0)
EndIf
$iPosLeft = $vRangeOrLeft.Left
$iPosTop = $vRangeOrLeft.Top
EndIf
If IsNumber($vRangeOrLeft) Or ($vRangeOrLeft.Columns.Count = 1 And $vRangeOrLeft.Rows.Count = 1) Then
If $iWidth = Default And $iHeight = Default Then
$oReturn = $vWorksheet.Shapes.AddPicture($sFile, -1, -1, $iPosLeft, $iPosTop, 0, 0)
If @error Then Return SetError(4, @error, 0)
$oReturn.Scalewidth(1, -1, 0)
$oReturn.Scaleheight(1, -1, 0)
ElseIf $iWidth = Default Then
$oReturn = $vWorksheet.Shapes.AddPicture($sFile, -1, -1, $iPosLeft, $iPosTop, 0, 0)
If @error Then Return SetError(4, @error, 0)
$oReturn.Visible = 0
$oReturn.Scalewidth(1, -1, 0)
$oReturn.Scaleheight(1, -1, 0)
$oReturn.Scalewidth($iHeight / $oReturn.Height, -1, 0)
$oReturn.Scaleheight($iHeight / $oReturn.Height, -1, 0)
$oReturn.Visible = 1
ElseIf $iHeight = Default Then
$oReturn = $vWorksheet.Shapes.AddPicture($sFile, -1, -1, $iPosLeft, $iPosTop, 0, 0)
If @error Then Return SetError(4, @error, 0)
$oReturn.Visible = 0
$oReturn.Scalewidth(1, -1, 0)
$oReturn.Scaleheight(1, -1, 0)
$oReturn.Scaleheight($iWidth / $oReturn.Width, -1, 0)
$oReturn.Scalewidth($iWidth / $oReturn.Width, -1, 0)
$oReturn.Visible = 1
Else
$oReturn = $vWorksheet.Shapes.AddPicture($sFile, -1, -1, $iPosLeft, $iPosTop, $iWidth, $iHeight)
If @error Then Return SetError(4, @error, 0)
EndIf
Else
If $bKeepRatio = True Then
$oReturn = $vWorksheet.Shapes.AddPicture($sFile, -1, -1, $iPosLeft, $iPosTop, 0, 0)
If @error Then Return SetError(4, @error, 0)
$oReturn.Visible = 0
$oReturn.Scalewidth(1, -1, 0)
$oReturn.Scaleheight(1, -1, 0)
Local $iRw = $vRangeOrLeft.Width / $oReturn.Width
Local $iRh = $vRangeOrLeft.Height / $oReturn.Height
If $iRw < $iRh Then
$oReturn.Scaleheight($iRw, -1, 0)
$oReturn.Scalewidth($iRw, -1, 0)
Else
$oReturn.Scaleheight($iRh, -1, 0)
$oReturn.Scalewidth($iRh, -1, 0)
EndIf
$oReturn.Visible = 1
Else
$oReturn = $vWorksheet.Shapes.AddPicture($sFile, -1, -1, $iPosLeft, $iPosTop, $vRangeOrLeft.Width, $vRangeOrLeft.Height)
If @error Then Return SetError(4, @error, 0)
EndIf
EndIf
Return $oReturn
EndFunc
Func _Excel_Print($oExcel, $vObject, $iCopies = Default, $sPrinter = Default, $bPreview = Default, $iFrom = Default, $iTo = Default, $bPrintToFile = Default, $bCollate = Default, $sPrToFileName = "")
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oExcel) Or ObjName($oExcel, 1) <> "_Application" Then Return SetError(1, 0, 0)
If IsString($vObject) Then $vObject = $oExcel.Range($vObject)
If @error Or Not IsObj($vObject) Then Return SetError(2, @error, 0)
$vObject.PrintOut($iFrom, $iTo, $iCopies, $bPreview, $sPrinter, $bPrintToFile, $bCollate, $sPrToFileName)
If @error Then Return SetError(3, @error, 0)
Return $vObject
EndFunc
Func _Excel_RangeCopyPaste($oWorksheet, $vSourceRange, $vTargetRange = Default, $bCut = Default, $iPaste = Default, $iOperation = Default, $bSkipBlanks = Default, $bTranspose = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oWorksheet) Or ObjName($oWorksheet, 1) <> "_Worksheet" Then Return SetError(1, 0, 0)
If $bCut = Default Then $bCut = False
If $vSourceRange = Default And $vTargetRange = Default Then Return SetError(7, 0, 0)
If Not IsObj($vSourceRange) And $vSourceRange <> Default Then
$vSourceRange = $oWorksheet.Range($vSourceRange)
If @error Then Return SetError(2, @error, 0)
EndIf
If Not IsObj($vTargetRange) And $vTargetRange <> Default Then
$vTargetRange = $oWorksheet.Range($vTargetRange)
If @error Then Return SetError(3, @error, 0)
EndIf
If $vSourceRange = Default Then
If $bSkipBlanks = Default Then $bSkipBlanks = False
If $bTranspose = Default Then $bTranspose = False
$vTargetRange.PasteSpecial($iPaste, $iOperation, $bSkipBlanks, $bTranspose)
If @error Then Return SetError(4, @error, 0)
Else
If $bCut Then
$vSourceRange.Cut($vTargetRange)
If @error Then Return SetError(5, @error, 0)
Else
$vSourceRange.Copy($vTargetRange)
If @error Then Return SetError(6, @error, 0)
EndIf
EndIf
If $vTargetRange <> Default Then
Return $vTargetRange
Else
Return 1
EndIf
EndFunc
Func _Excel_RangeDelete($oWorksheet, $vRange, $iShift = Default, $iEntireRowCol = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oWorksheet) Or ObjName($oWorksheet, 1) <> "_Worksheet" Then Return SetError(1, 0, 0)
If Not IsObj($vRange) Then
$vRange = $oWorksheet.Range($vRange)
If @error Then Return SetError(2, @error, 0)
EndIf
If $iEntireRowCol = 1 Then
$vRange.EntireRow.Delete($iShift)
ElseIf $iEntireRowCol = 2 Then
$vRange.EntireColumn.Delete($iShift)
Else
$vRange.Delete($iShift)
EndIf
If @error Then Return SetError(3, @error, 0)
Return 1
EndFunc
Func _Excel_RangeFind($oWorkbook, $sSearch, $vRange = Default, $iLookIn = Default, $iLookAt = Default, $bMatchcase = Default)
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
If StringStripWS($sSearch, 3) = "" Then Return SetError(2, 0, 0)
If $iLookIn = Default Then $iLookIn = $xlValues
If $iLookAt = Default Then $iLookAt = $xlPart
If $bMatchcase = Default Then $bMatchcase = False
Local $oMatch, $sFirst = "", $bSearchWorkbook = False, $oSheet
If $vRange = Default Then
$bSearchWorkbook = True
$oSheet = $oWorkbook.Sheets(1)
$vRange = $oSheet.UsedRange
ElseIf IsString($vRange) Then
$vRange = $oWorkbook.Activesheet.Range($vRange)
If @error Then Return SetError(3, @error, 0)
EndIf
Local $aResult[100][6], $iIndex = 0, $iIndexSheets = 1
While 1
$oMatch = $vRange.Find($sSearch, Default, $iLookIn, $iLookAt, Default, Default, $bMatchcase)
If @error Then Return SetError(4, @error, 0)
If IsObj($oMatch) Then
$sFirst = $oMatch.Address
While 1
$aResult[$iIndex][0] = $oMatch.Worksheet.Name
$aResult[$iIndex][1] = $oMatch.Name.Name
$aResult[$iIndex][2] = $oMatch.Address
$aResult[$iIndex][3] = $oMatch.Value
$aResult[$iIndex][4] = $oMatch.Formula
$aResult[$iIndex][5] = $oMatch.Comment.Text
$iIndex = $iIndex + 1
If Mod($iIndex, 100) = 0 Then ReDim $aResult[UBound($aResult, 1) + 100][6]
$oMatch = $vRange.Findnext($oMatch)
If Not IsObj($oMatch) Or $sFirst = $oMatch.Address Then ExitLoop
WEnd
EndIf
If Not $bSearchWorkbook Then ExitLoop
$iIndexSheets = $iIndexSheets + 1
$sFirst = ""
$oSheet = $oWorkbook.Sheets($iIndexSheets)
If @error Then ExitLoop
$vRange = $oSheet.UsedRange
WEnd
ReDim $aResult[$iIndex][6]
Return $aResult
EndFunc
Func _Excel_RangeInsert($oWorksheet, $vRange, $iShift = Default, $iCopyOrigin = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oWorksheet) Or ObjName($oWorksheet, 1) <> "_Worksheet" Then Return SetError(1, 0, 0)
If Not IsObj($vRange) Then
$vRange = $oWorksheet.Range($vRange)
If @error Then Return SetError(2, @error, 0)
EndIf
$vRange.Insert($iShift, $iCopyOrigin)
If @error Then Return SetError(3, @error, 0)
Return $vRange
EndFunc
Func _Excel_RangeLinkAddRemove($oWorkbook, $vWorksheet, $vRange, $sAddress, $sSubAddress = Default, $sScreenTip = Default, $sTextToDisplay = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
Local $oLink
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
If Not IsObj($vWorksheet) Then
If $vWorksheet = Default Then
$vWorksheet = $oWorkbook.ActiveSheet
Else
$vWorksheet = $oWorkbook.WorkSheets.Item($vWorksheet)
EndIf
If @error Or Not IsObj($vWorksheet) Then Return SetError(2, @error, 0)
ElseIf ObjName($vWorksheet, 1) <> "_Worksheet" Then
Return SetError(2, @error, 0)
EndIf
If Not IsObj($vRange) Then
$vRange = $vWorksheet.Range($vRange)
If @error Or Not IsObj($vRange) Then Return SetError(3, @error, 0)
EndIf
If $sAddress = "" Then
$vRange.Hyperlinks.Delete()
If @error Then Return SetError(4, @error, 0)
Return 1
Else
$oLink = $vWorksheet.Hyperlinks.Add($vRange, $sAddress, $sSubAddress, $sScreenTip, $sTextToDisplay)
If @error Then Return SetError(4, @error, 0)
Return $oLink
EndIf
EndFunc
Func _Excel_RangeRead($oWorkbook, $vWorksheet = Default, $vRange = Default, $iReturn = Default, $bForceFunc = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
If Not IsObj($vWorksheet) Then
If $vWorksheet = Default Then
$vWorksheet = $oWorkbook.ActiveSheet
Else
$vWorksheet = $oWorkbook.WorkSheets.Item($vWorksheet)
EndIf
If @error Or Not IsObj($vWorksheet) Then Return SetError(2, @error, 0)
ElseIf ObjName($vWorksheet, 1) <> "_Worksheet" Then
Return SetError(2, @error, 0)
EndIf
If $vRange = Default Then
$vRange = $vWorksheet.Usedrange
ElseIf Not IsObj($vRange) Then
$vRange = $vWorksheet.Range($vRange)
If @error Or Not IsObj($vRange) Then Return SetError(3, @error, 0)
EndIf
If $iReturn = Default Then
$iReturn = 1
ElseIf $iReturn < 1 Or $iReturn > 4 Then
Return SetError(4, 0, 0)
EndIf
If $bForceFunc = Default Then $bForceFunc = False
Local $vResult, $iCellCount = $vRange.Columns.Count * $vRange.Rows.Count
If $iReturn = 3 And $iCellCount > 1 Then Return SetError(8, @error, 0)
If $iCellCount > 16777216 Then Return SetError(6, 0, 0)
If $iCellCount > 65535 Then $bForceFunc = True
If $bForceFunc Then
Switch $iReturn
Case 1
$vResult = $vRange.Value
Case 2
$vResult = $vRange.Formula
Case 3
$vResult = $vRange.Text
Case Else
$vResult = $vRange.Value2
EndSwitch
If @error Then Return SetError(7, @error, 0)
If $iCellCount > 1 Then _ArrayTranspose($vResult)
Else
Local $oExcel = $oWorkbook.Parent
Switch $iReturn
Case 1
$vResult = $oExcel.Transpose($vRange.Value)
Case 2
$vResult = $oExcel.Transpose($vRange.Formula)
Case 3
$vResult = $oExcel.Transpose($vRange.Text)
Case Else
$vResult = $oExcel.Transpose($vRange.Value2)
EndSwitch
If @error Then Return SetError(5, @error, 0)
EndIf
Return $vResult
EndFunc
Func _Excel_RangeReplace($oWorkbook, $vWorksheet, $vRange, $sSearch, $sReplace, $iLookAt = Default, $bMatchcase = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
If Not IsObj($vWorksheet) Then
If $vWorksheet = Default Then
$vWorksheet = $oWorkbook.ActiveSheet
Else
$vWorksheet = $oWorkbook.WorkSheets.Item($vWorksheet)
EndIf
If @error Or Not IsObj($vWorksheet) Then Return SetError(2, @error, 0)
ElseIf ObjName($vWorksheet, 1) <> "_Worksheet" Then
Return SetError(2, @error, 0)
EndIf
If StringStripWS($sSearch, 3) = "" Then Return SetError(3, 0, 0)
If $vRange = Default Then
$vRange = $vWorksheet.Usedrange
ElseIf Not IsObj($vRange) Then
$vRange = $vWorksheet.Range($vRange)
If @error Or Not IsObj($vRange) Then Return SetError(4, @error, 0)
EndIf
If $iLookAt = Default Then $iLookAt = $xlPart
If $bMatchcase = Default Then $bMatchcase = False
Local $bReplace
$bReplace = $vRange.Replace($sSearch, $sReplace, $iLookAt, Default, $bMatchcase)
If @error Then Return SetError(5, @error, 0)
Return SetError(0, $bReplace, $vRange)
EndFunc
Func _Excel_RangeSort($oWorkbook, $vWorksheet, $vRange, $vKey1, $iOrder1 = Default, $iSortText = Default, $iHeader = Default,  $bMatchcase = Default, $iOrientation = Default, $vKey2 = Default, $iOrder2 = Default, $vKey3 = Default, $iOrder3 = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
If Not IsObj($vWorksheet) Then
If $vWorksheet = Default Then
$vWorksheet = $oWorkbook.ActiveSheet
Else
$vWorksheet = $oWorkbook.WorkSheets.Item($vWorksheet)
EndIf
If @error Or Not IsObj($vWorksheet) Then Return SetError(2, @error, 0)
ElseIf ObjName($vWorksheet, 1) <> "_Worksheet" Then
Return SetError(2, @error, 0)
EndIf
If $vRange = Default Then
$vRange = $vWorksheet.Usedrange
ElseIf Not IsObj($vRange) Then
$vRange = $vWorksheet.Range($vRange)
If @error Or Not IsObj($vRange) Then Return SetError(3, @error, 0)
EndIf
$vKey1 = $vWorksheet.Range($vKey1)
If @error Or Not IsObj($vKey1) Then Return SetError(4, @error, 0)
If $vKey2 <> Default Then
$vKey2 = $vWorksheet.Range($vKey2)
If @error Or Not IsObj($vKey2) Then Return SetError(5, @error, 0)
EndIf
If $vKey3 <> Default Then
$vKey3 = $vWorksheet.Range($vKey3)
If @error Or Not IsObj($vKey3) Then Return SetError(6, @error, 0)
EndIf
If $iHeader = Default Then $iHeader = $xlNo
If $bMatchcase = Default Then $bMatchcase = False
If $iOrientation = Default Then $iOrientation = $xlSortColumns
If $iOrder1 = Default Then $iOrder1 = $xlAscending
If $iSortText = Default Then $iSortText = $xlSortNormal
If $iOrder2 = Default Then $iOrder2 = $xlAscending
If $iOrder3 = Default Then $iOrder3 = $xlAscending
If Int($oWorkbook.Parent.Version) < 112 Then
$vRange.Sort($vKey1, $iOrder1, $vKey2, Default, $iOrder2, $vKey3, $iOrder3, $iHeader, Default, $bMatchcase, $iOrientation, Default, $iSortText, $iSortText, $iSortText)
Else
$vWorksheet.Sort.SortFields.Clear
$vWorksheet.Sort.SortFields.Add($vKey1, $xlSortOnValues, $iOrder1)
If $vKey2 <> Default Then $vWorksheet.Sort.SortFields.Add($vKey2, $xlSortOnValues, $iOrder2)
If $vKey3 <> Default Then $vWorksheet.Sort.SortFields.Add($vKey3, $xlSortOnValues, $iOrder3)
$vWorksheet.Sort.SetRange($vRange)
$vWorksheet.Sort.Header = $iHeader
$vWorksheet.Sort.MatchCase = $bMatchcase
$vWorksheet.Sort.Orientation = $iOrientation
$vWorksheet.Sort.Apply
EndIf
If @error Then Return SetError(7, @error, 0)
Return $vRange
EndFunc
Func _Excel_RangeValidate($oWorkbook, $vWorksheet, $vRange, $iType, $sFormula1, $iOperator = Default, $sFormula2 = Default, $bIgnoreBlank = Default, $iAlertStyle = Default, $sErrorMessage = Default, $sInputMessage = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
If Not IsObj($vWorksheet) Then
If $vWorksheet = Default Then
$vWorksheet = $oWorkbook.ActiveSheet
Else
$vWorksheet = $oWorkbook.WorkSheets.Item($vWorksheet)
EndIf
If @error Or Not IsObj($vWorksheet) Then Return SetError(2, @error, 0)
ElseIf ObjName($vWorksheet, 1) <> "_Worksheet" Then
Return SetError(2, @error, 0)
EndIf
If $vRange = Default Then
$vRange = $vWorksheet.Usedrange
ElseIf Not IsObj($vRange) Then
$vRange = $vWorksheet.Range($vRange)
If @error Or Not IsObj($vRange) Then Return SetError(3, @error, 0)
EndIf
If $bIgnoreBlank = Default Then $bIgnoreBlank = True
If $iAlertStyle = Default Then $iAlertStyle = $xlValidAlertStop
$vRange.Validation.Delete()
$vRange.Validation.Add($iType, $iAlertStyle, $iOperator, $sFormula1, $sFormula2)
If @error Then Return SetError(4, @error, 0)
$vRange.Validation.IgnoreBlank = $bIgnoreBlank
If $sInputMessage <> Default Then
$vRange.Validation.InputMessage = $sInputMessage
$vRange.Validation.ShowInput = True
EndIf
If $sErrorMessage <> Default Then
$vRange.Validation.ErrorMessage = $sErrorMessage
$vRange.Validation.ShowError = True
EndIf
Return $vRange
EndFunc
Func _Excel_RangeWrite($oWorkbook, $vWorksheet, $vValue, $vRange = Default, $bValue = Default, $bForceFunc = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
If Not IsObj($vWorksheet) Then
If $vWorksheet = Default Then
$vWorksheet = $oWorkbook.ActiveSheet
Else
$vWorksheet = $oWorkbook.WorkSheets.Item($vWorksheet)
EndIf
If @error Or Not IsObj($vWorksheet) Then Return SetError(2, @error, 0)
ElseIf ObjName($vWorksheet, 1) <> "_Worksheet" Then
Return SetError(2, @error, 0)
EndIf
If $vRange = Default Then $vRange = "A1"
If $bValue = Default Then $bValue = True
If $bForceFunc = Default Then $bForceFunc = False
If Not IsObj($vRange) Then
$vRange = $vWorksheet.Range($vRange)
If @error Or Not IsObj($vRange) Then Return SetError(3, @error, 0)
EndIf
If Not IsArray($vValue) Then
If $bValue Then
$vRange.Value = $vValue
Else
$vRange.Formula = $vValue
EndIf
If @error Then Return SetError(4, @error, 0)
Else
If $vRange.Columns.Count = 1 And $vRange.Rows.Count = 1 Then
If UBound($vValue, 0) = 1 Then
$vRange = $vRange.Resize(UBound($vValue, 1), 1)
Else
$vRange = $vRange.Resize(UBound($vValue, 1), UBound($vValue, 2))
EndIf
EndIf
If $bForceFunc Then
_ArrayTranspose($vValue)
If $bValue Then
$vRange.Value = $vValue
Else
$vRange.Formula = $vValue
EndIf
If @error Then Return SetError(5, @error, 0)
Else
Local $oExcel = $oWorkbook.Parent
If $bValue Then
$vRange.Value = $oExcel.Transpose($vValue)
Else
$vRange.Formula = $oExcel.Transpose($vValue)
EndIf
If @error Then Return SetError(6, @error, 0)
EndIf
EndIf
Return $vRange
EndFunc
Func _Excel_SheetAdd($oWorkbook, $vSheet = Default, $bBefore = Default, $iCount = Default, $sName = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
Local $bInsertAtEnd = False, $iStartSheet, $oBefore = Default, $oAfter = Default
If $iCount = Default Then $iCount = 1
If $iCount > 255 Then Return SetError(6, 0, 0)
If $bBefore = Default Then $bBefore = True
If $vSheet = Default Then
$vSheet = $oWorkbook.ActiveSheet
ElseIf Not IsObj($vSheet) Then
If $vSheet = -1 Then
$vSheet = $oWorkbook.WorkSheets.Item($oWorkbook.WorkSheets.Count)
Else
$vSheet = $oWorkbook.WorkSheets.Item($vSheet)
EndIf
If @error Then Return SetError(2, @error, 0)
If $vSheet.Index = $oWorkbook.WorkSheets.Count And $bBefore = False Then $bInsertAtEnd = True
EndIf
If $sName <> Default Then
Local $aName = StringSplit($sName, "|")
SetError(0)
If $aName[1] <> "" Then
For $iIndex1 = 1 To $aName[0]
For $iIndex2 = 1 To $oWorkbook.WorkSheets.Count
If $oWorkbook.WorkSheets($iIndex2).Name = $aName[$iIndex1] Then Return SetError(3, $iIndex1, 0)
Next
Next
Else
$sName = Default
EndIf
EndIf
If $bBefore Then
$oBefore = $vSheet
Else
$oAfter = $vSheet
EndIf
Local $oSheet = $oWorkbook.WorkSheets.Add($oBefore, $oAfter, $iCount)
If @error Then Return SetError(4, @error, 0)
If $sName <> Default Then
If $bInsertAtEnd = True Then
$iStartSheet = $oSheet.Index - $iCount + 1
Else
$iStartSheet = $oSheet.Index
EndIf
$iIndex2 = 1
For $iSheet = $iStartSheet To $iStartSheet + $iCount - 1
If $aName[$iIndex2] <> "" Then $oWorkbook.WorkSheets($iSheet).Name = $aName[$iIndex2]
If @error Then Return SetError(5, @error, 0)
$iIndex2 += 1
If $iIndex2 > $aName[0] Then ExitLoop
Next
EndIf
Return $oSheet
EndFunc
Func _Excel_SheetCopyMove($oSourceBook, $vSourceSheet = Default, $oTargetBook = Default, $vTargetSheet = Default, $bBefore = Default, $bCopy = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
Local $vBefore = Default, $vAfter = Default
If Not IsObj($oSourceBook) Or ObjName($oSourceBook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
If $vSourceSheet = Default Then $vSourceSheet = $oSourceBook.ActiveSheet
If $oTargetBook = Default Then $oTargetBook = $oSourceBook
If Not IsObj($oTargetBook) Or ObjName($oTargetBook, 1) <> "_Workbook" Then Return SetError(2, 0, 0)
If $vTargetSheet = Default Then $vTargetSheet = 1
If $bBefore = Default Then $bBefore = True
If $bCopy = Default Then $bCopy = True
If Not IsObj($vSourceSheet) Then
$vSourceSheet = $oSourceBook.Sheets($vSourceSheet)
If @error Or Not IsObj($vSourceSheet) Then SetError(3, @error, 0)
EndIf
If Not IsObj($vTargetSheet) Then
$vTargetSheet = $oTargetBook.Sheets($vTargetSheet)
If @error Or Not IsObj($vTargetSheet) Then SetError(4, @error, 0)
EndIf
If $bBefore Then
$vBefore = $vTargetSheet
Else
$vAfter = $vTargetSheet
EndIf
If $bCopy Then
$vSourceSheet.Copy($vBefore, $vAfter)
Else
$vSourceSheet.Move($vBefore, $vAfter)
EndIf
If @error Then Return SetError(5, 0, 0)
If $bBefore Then
Return $oTargetBook.Sheets($vTargetSheet.Index - 1)
Else
Return $oTargetBook.Sheets($vTargetSheet.Index + 1)
EndIf
EndFunc
Func _Excel_SheetDelete($oWorkbook, $vSheet = Default)
Local $oError = ObjEvent("AutoIt.Error", "__Excel_COMErrFunc")
#forceref $oError
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
Local $oSheet
If $vSheet = Default Then
$oSheet = $oWorkbook.ActiveSheet
ElseIf Not IsObj($vSheet) Then
$oSheet = $oWorkbook.WorkSheets.Item($vSheet)
Else
$oSheet = $vSheet
EndIf
If @error Then Return SetError(2, @error, 0)
$oSheet.Delete()
If @error Then Return SetError(3, @error, 0)
Return 1
EndFunc
Func _Excel_SheetList($oWorkbook)
If Not IsObj($oWorkbook) Or ObjName($oWorkbook, 1) <> "_Workbook" Then Return SetError(1, 0, 0)
Local $iSheetCount = $oWorkbook.Sheets.Count
Local $aSheets[$iSheetCount][2]
For $iIndex = 0 To $iSheetCount - 1
$aSheets[$iIndex][0] = $oWorkbook.Sheets($iIndex + 1).Name
$aSheets[$iIndex][1] = $oWorkbook.Sheets($iIndex + 1)
Next
Return $aSheets
EndFunc
Func __Excel_CloseOnQuit($oExcel, $bNewState = Default)
Static $bState[101] = [0]
If $bNewState = True Then
For $i = 1 To $bState[0]
If Not IsObj($bState[$i]) Or $bState[$i] = $oExcel Then
$bState[$i] = $oExcel
Return True
EndIf
Next
$bState[0] = $bState[0] + 1
$bState[$bState[0]] = $oExcel
Return True
Else
For $i = 1 To $bState[0]
If $bState[$i] = $oExcel Then
If $bNewState = False Then
$bState[$i] = 0
Return False
Else
Return True
EndIf
EndIf
Next
EndIf
Return False
EndFunc
Func __Excel_COMErrFunc()
EndFunc
Global Const $ACS_CENTER = 1
Global Const $ACS_TRANSPARENT = 2
Global Const $ACS_AUTOPLAY = 4
Global Const $ACS_TIMER = 8
Global Const $ACS_NONTRANSPARENT = 16
Global Const $GUI_SS_DEFAULT_AVI = $ACS_TRANSPARENT
Global Const $__AVICONSTANT_WM_USER = 0x400
Global Const $ACM_OPENA = $__AVICONSTANT_WM_USER + 100
Global Const $ACM_PLAY = $__AVICONSTANT_WM_USER + 101
Global Const $ACM_STOP = $__AVICONSTANT_WM_USER + 102
Global Const $ACM_ISPLAYING = $__AVICONSTANT_WM_USER + 104
Global Const $ACM_OPENW = $__AVICONSTANT_WM_USER + 103
Global Const $ACN_START = 0x00000001
Global Const $ACN_STOP = 0x00000002
Global Const $BS_GROUPBOX = 0x0007
Global Const $BS_BOTTOM = 0x0800
Global Const $BS_CENTER = 0x0300
Global Const $BS_DEFPUSHBUTTON = 0x0001
Global Const $BS_LEFT = 0x0100
Global Const $BS_MULTILINE = 0x2000
Global Const $BS_PUSHBOX = 0x000A
Global Const $BS_PUSHLIKE = 0x1000
Global Const $BS_RIGHT = 0x0200
Global Const $BS_RIGHTBUTTON = 0x0020
Global Const $BS_TOP = 0x0400
Global Const $BS_VCENTER = 0x0C00
Global Const $BS_FLAT = 0x8000
Global Const $BS_ICON = 0x0040
Global Const $BS_BITMAP = 0x0080
Global Const $BS_NOTIFY = 0x4000
Global Const $BS_SPLITBUTTON = 0x0000000C
Global Const $BS_DEFSPLITBUTTON = 0x0000000D
Global Const $BS_COMMANDLINK = 0x0000000E
Global Const $BS_DEFCOMMANDLINK = 0x0000000F
Global Const $BCSIF_GLYPH = 0x0001
Global Const $BCSIF_IMAGE = 0x0002
Global Const $BCSIF_STYLE = 0x0004
Global Const $BCSIF_SIZE = 0x0008
Global Const $BCSS_NOSPLIT = 0x0001
Global Const $BCSS_STRETCH = 0x0002
Global Const $BCSS_ALIGNLEFT = 0x0004
Global Const $BCSS_IMAGE = 0x0008
Global Const $BUTTON_IMAGELIST_ALIGN_LEFT = 0
Global Const $BUTTON_IMAGELIST_ALIGN_RIGHT = 1
Global Const $BUTTON_IMAGELIST_ALIGN_TOP = 2
Global Const $BUTTON_IMAGELIST_ALIGN_BOTTOM = 3
Global Const $BUTTON_IMAGELIST_ALIGN_CENTER = 4
Global Const $BS_3STATE = 0x0005
Global Const $BS_AUTO3STATE = 0x0006
Global Const $BS_AUTOCHECKBOX = 0x0003
Global Const $BS_CHECKBOX = 0x0002
Global Const $BS_RADIOBUTTON = 0x4
Global Const $BS_AUTORADIOBUTTON = 0x0009
Global Const $BS_OWNERDRAW = 0xB
Global Const $GUI_SS_DEFAULT_BUTTON = 0
Global Const $GUI_SS_DEFAULT_CHECKBOX = 0
Global Const $GUI_SS_DEFAULT_GROUP = 0
Global Const $GUI_SS_DEFAULT_RADIO = 0
Global Const $BCM_FIRST = 0x1600
Global Const $BCM_GETIDEALSIZE = ($BCM_FIRST + 0x0001)
Global Const $BCM_GETIMAGELIST = ($BCM_FIRST + 0x0003)
Global Const $BCM_GETNOTE = ($BCM_FIRST + 0x000A)
Global Const $BCM_GETNOTELENGTH = ($BCM_FIRST + 0x000B)
Global Const $BCM_GETSPLITINFO = ($BCM_FIRST + 0x0008)
Global Const $BCM_GETTEXTMARGIN = ($BCM_FIRST + 0x0005)
Global Const $BCM_SETDROPDOWNSTATE = ($BCM_FIRST + 0x0006)
Global Const $BCM_SETIMAGELIST = ($BCM_FIRST + 0x0002)
Global Const $BCM_SETNOTE = ($BCM_FIRST + 0x0009)
Global Const $BCM_SETSHIELD = ($BCM_FIRST + 0x000C)
Global Const $BCM_SETSPLITINFO = ($BCM_FIRST + 0x0007)
Global Const $BCM_SETTEXTMARGIN = ($BCM_FIRST + 0x0004)
Global Const $BM_CLICK = 0xF5
Global Const $BM_GETCHECK = 0xF0
Global Const $BM_GETIMAGE = 0xF6
Global Const $BM_GETSTATE = 0xF2
Global Const $BM_SETCHECK = 0xF1
Global Const $BM_SETDONTCLICK = 0xF8
Global Const $BM_SETIMAGE = 0xF7
Global Const $BM_SETSTATE = 0xF3
Global Const $BM_SETSTYLE = 0xF4
Global Const $BCN_FIRST = -1250
Global Const $BCN_DROPDOWN = ($BCN_FIRST + 0x0002)
Global Const $BCN_HOTITEMCHANGE = ($BCN_FIRST + 0x0001)
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
Global Const $BST_CHECKED = 0x1
Global Const $BST_INDETERMINATE = 0x2
Global Const $BST_UNCHECKED = 0x0
Global Const $BST_FOCUS = 0x8
Global Const $BST_PUSHED = 0x4
Global Const $BST_DONTCLICK = 0x000080
Global Const $CB_ERR = -1
Global Const $CB_ERRATTRIBUTE = -3
Global Const $CB_ERRREQUIRED = -4
Global Const $CB_ERRSPACE = -2
Global Const $CB_OKAY = 0
Global Const $STATE_SYSTEM_INVISIBLE = 0x8000
Global Const $STATE_SYSTEM_PRESSED = 0x8
Global Const $CBS_AUTOHSCROLL = 0x40
Global Const $CBS_DISABLENOSCROLL = 0x800
Global Const $CBS_DROPDOWN = 0x2
Global Const $CBS_DROPDOWNLIST = 0x3
Global Const $CBS_HASSTRINGS = 0x200
Global Const $CBS_LOWERCASE = 0x4000
Global Const $CBS_NOINTEGRALHEIGHT = 0x400
Global Const $CBS_OEMCONVERT = 0x80
Global Const $CBS_OWNERDRAWFIXED = 0x10
Global Const $CBS_OWNERDRAWVARIABLE = 0x20
Global Const $CBS_SIMPLE = 0x1
Global Const $CBS_SORT = 0x100
Global Const $CBS_UPPERCASE = 0x2000
Global Const $CBM_FIRST = 0x1700
Global Const $CB_ADDSTRING = 0x143
Global Const $CB_DELETESTRING = 0x144
Global Const $CB_DIR = 0x145
Global Const $CB_FINDSTRING = 0x14C
Global Const $CB_FINDSTRINGEXACT = 0x158
Global Const $CB_GETCOMBOBOXINFO = 0x164
Global Const $CB_GETCOUNT = 0x146
Global Const $CB_GETCUEBANNER = ($CBM_FIRST + 4)
Global Const $CB_GETCURSEL = 0x147
Global Const $CB_GETDROPPEDCONTROLRECT = 0x152
Global Const $CB_GETDROPPEDSTATE = 0x157
Global Const $CB_GETDROPPEDWIDTH = 0X15f
Global Const $CB_GETEDITSEL = 0x140
Global Const $CB_GETEXTENDEDUI = 0x156
Global Const $CB_GETHORIZONTALEXTENT = 0x15d
Global Const $CB_GETITEMDATA = 0x150
Global Const $CB_GETITEMHEIGHT = 0x154
Global Const $CB_GETLBTEXT = 0x148
Global Const $CB_GETLBTEXTLEN = 0x149
Global Const $CB_GETLOCALE = 0x15A
Global Const $CB_GETMINVISIBLE = 0x1702
Global Const $CB_GETTOPINDEX = 0x15b
Global Const $CB_INITSTORAGE = 0x161
Global Const $CB_LIMITTEXT = 0x141
Global Const $CB_RESETCONTENT = 0x14B
Global Const $CB_INSERTSTRING = 0x14A
Global Const $CB_SELECTSTRING = 0x14D
Global Const $CB_SETCUEBANNER = ($CBM_FIRST + 3)
Global Const $CB_SETCURSEL = 0x14E
Global Const $CB_SETDROPPEDWIDTH = 0x160
Global Const $CB_SETEDITSEL = 0x142
Global Const $CB_SETEXTENDEDUI = 0x155
Global Const $CB_SETHORIZONTALEXTENT = 0x15e
Global Const $CB_SETITEMDATA = 0x151
Global Const $CB_SETITEMHEIGHT = 0x153
Global Const $CB_SETLOCALE = 0x159
Global Const $CB_SETMINVISIBLE = 0x1701
Global Const $CB_SETTOPINDEX = 0x15c
Global Const $CB_SHOWDROPDOWN = 0x14F
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
Global Const $CBES_EX_CASESENSITIVE = 0x10
Global Const $CBES_EX_NOEDITIMAGE = 0x1
Global Const $CBES_EX_NOEDITIMAGEINDENT = 0x2
Global Const $CBES_EX_NOSIZELIMIT = 0x8
Global Const $__COMBOBOXCONSTANT_WM_USER = 0X400
Global Const $CBEM_DELETEITEM = $CB_DELETESTRING
Global Const $CBEM_GETCOMBOCONTROL = ($__COMBOBOXCONSTANT_WM_USER + 6)
Global Const $CBEM_GETEDITCONTROL = ($__COMBOBOXCONSTANT_WM_USER + 7)
Global Const $CBEM_GETEXSTYLE = ($__COMBOBOXCONSTANT_WM_USER + 9)
Global Const $CBEM_GETEXTENDEDSTYLE = ($__COMBOBOXCONSTANT_WM_USER + 9)
Global Const $CBEM_GETIMAGELIST = ($__COMBOBOXCONSTANT_WM_USER + 3)
Global Const $CBEM_GETITEMA = ($__COMBOBOXCONSTANT_WM_USER + 4)
Global Const $CBEM_GETITEMW = ($__COMBOBOXCONSTANT_WM_USER + 13)
Global Const $CBEM_GETUNICODEFORMAT = 0x2000 + 6
Global Const $CBEM_HASEDITCHANGED = ($__COMBOBOXCONSTANT_WM_USER + 10)
Global Const $CBEM_INSERTITEMA = ($__COMBOBOXCONSTANT_WM_USER + 1)
Global Const $CBEM_INSERTITEMW = ($__COMBOBOXCONSTANT_WM_USER + 11)
Global Const $CBEM_SETEXSTYLE = ($__COMBOBOXCONSTANT_WM_USER + 8)
Global Const $CBEM_SETEXTENDEDSTYLE = ($__COMBOBOXCONSTANT_WM_USER + 14)
Global Const $CBEM_SETIMAGELIST = ($__COMBOBOXCONSTANT_WM_USER + 2)
Global Const $CBEM_SETITEMA = ($__COMBOBOXCONSTANT_WM_USER + 5)
Global Const $CBEM_SETITEMW = ($__COMBOBOXCONSTANT_WM_USER + 12)
Global Const $CBEM_SETUNICODEFORMAT = 0x2000 + 5
Global Const $CBEM_SETWINDOWTHEME = 0x2000 + 11
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
Global Const $CBEIF_DI_SETITEM = 0x10000000
Global Const $CBEIF_IMAGE = 0x2
Global Const $CBEIF_INDENT = 0x10
Global Const $CBEIF_LPARAM = 0x20
Global Const $CBEIF_OVERLAY = 0x8
Global Const $CBEIF_SELECTEDIMAGE = 0x4
Global Const $CBEIF_TEXT = 0x1
Global Const $GUI_SS_DEFAULT_COMBO = 0x00200042
Global Const $DTS_SHORTDATEFORMAT = 0
Global Const $DTS_UPDOWN = 1
Global Const $DTS_SHOWNONE = 2
Global Const $DTS_LONGDATEFORMAT = 4
Global Const $DTS_TIMEFORMAT = 9
Global Const $DTS_RIGHTALIGN = 32
Global Const $DTS_SHORTDATECENTURYFORMAT = 0x0000000C
Global Const $DTS_APPCANPARSE = 0x00000010
Global Const $DMW_LONGNAME = 0
Global Const $DMW_SHORTNAME = 1
Global Const $DMW_LOCALE_LONGNAME = 2
Global Const $DMW_LOCALE_SHORTNAME = 3
Global Const $GDT_ERROR = -1
Global Const $GDT_VALID = 0
Global Const $GDT_NONE = 1
Global Const $GDTR_MIN = 0x0001
Global Const $GDTR_MAX = 0x0002
Global Const $MCHT_NOWHERE = 0x00000000
Global Const $MCHT_TITLE = 0x00010000
Global Const $MCHT_CALENDAR = 0x00020000
Global Const $MCHT_TODAYLINK = 0x00030000
Global Const $MCHT_NEXT = 0x01000000
Global Const $MCHT_PREV = 0x02000000
Global Const $MCHT_TITLEBK = 0x00010000
Global Const $MCHT_TITLEMONTH = 0x00010001
Global Const $MCHT_TITLEYEAR = 0x00010002
Global Const $MCHT_TITLEBTNNEXT = 0x01010003
Global Const $MCHT_TITLEBTNPREV = 0x02010003
Global Const $MCHT_CALENDARBK = 0x00020000
Global Const $MCHT_CALENDARDATE = 0x00020001
Global Const $MCHT_CALENDARDAY = 0x00020002
Global Const $MCHT_CALENDARWEEKNUM = 0x00020003
Global Const $MCHT_CALENDARDATENEXT = 0x01020000
Global Const $MCHT_CALENDARDATEPREV = 0x02020000
Global Const $MCS_DAYSTATE = 0x0001
Global Const $MCS_MULTISELECT = 0x0002
Global Const $MCS_WEEKNUMBERS = 0x0004
Global Const $MCS_NOTODAYCIRCLE = 0x0008
Global Const $MCS_NOTODAY = 0x0010
Global Const $MCS_NOTRAILINGDATES = 0x0040
Global Const $MCS_SHORTDAYSOFWEEK = 0x0080
Global Const $MCS_NOSELCHANGEONNAV = 0x0100
Global Const $MCM_FIRST = 0x1000
Global Const $MCM_GETCALENDARBORDER = ($MCM_FIRST + 31)
Global Const $MCM_GETCALENDARCOUNT = ($MCM_FIRST + 23)
Global Const $MCM_GETCALENDARGRIDINFO = ($MCM_FIRST + 24)
Global Const $MCM_GETCALID = ($MCM_FIRST + 27)
Global Const $MCM_GETCOLOR = ($MCM_FIRST + 11)
Global Const $MCM_GETCURRENTVIEW = ($MCM_FIRST + 22)
Global Const $MCM_GETCURSEL = ($MCM_FIRST + 1)
Global Const $MCM_GETFIRSTDAYOFWEEK = ($MCM_FIRST + 16)
Global Const $MCM_GETMAXSELCOUNT = ($MCM_FIRST + 3)
Global Const $MCM_GETMAXTODAYWIDTH = ($MCM_FIRST + 21)
Global Const $MCM_GETMINREQRECT = ($MCM_FIRST + 9)
Global Const $MCM_GETMONTHDELTA = ($MCM_FIRST + 19)
Global Const $MCM_GETMONTHRANGE = ($MCM_FIRST + 7)
Global Const $MCM_GETRANGE = ($MCM_FIRST + 17)
Global Const $MCM_GETSELRANGE = ($MCM_FIRST + 5)
Global Const $MCM_GETTODAY = ($MCM_FIRST + 13)
Global Const $MCM_GETUNICODEFORMAT = 0x2000 + 6
Global Const $MCM_HITTEST = ($MCM_FIRST + 14)
Global Const $MCM_SETCALENDARBORDER = ($MCM_FIRST + 30)
Global Const $MCM_SETCALID = ($MCM_FIRST + 28)
Global Const $MCM_SETCOLOR = ($MCM_FIRST + 10)
Global Const $MCM_SETCURRENTVIEW = ($MCM_FIRST + 32)
Global Const $MCM_SETCURSEL = ($MCM_FIRST + 2)
Global Const $MCM_SETDAYSTATE = ($MCM_FIRST + 8)
Global Const $MCM_SETFIRSTDAYOFWEEK = ($MCM_FIRST + 15)
Global Const $MCM_SETMAXSELCOUNT = ($MCM_FIRST + 4)
Global Const $MCM_SETMONTHDELTA = ($MCM_FIRST + 20)
Global Const $MCM_SETRANGE = ($MCM_FIRST + 18)
Global Const $MCM_SETSELRANGE = ($MCM_FIRST + 6)
Global Const $MCM_SETTODAY = ($MCM_FIRST + 12)
Global Const $MCM_SETUNICODEFORMAT = 0x2000 + 5
Global Const $MCM_SIZERECTTOMIN = ($MCM_FIRST + 29)
Global Const $MCN_FIRST = -746
Global Const $MCN_SELCHANGE = ($MCN_FIRST - 3)
Global Const $MCN_GETDAYSTATE = ($MCN_FIRST - 1)
Global Const $MCN_SELECT = ($MCN_FIRST)
Global Const $MCN_VIEWCHANGE = ($MCN_FIRST - 4)
Global Const $MCSC_BACKGROUND = 0
Global Const $MCSC_MONTHBK = 4
Global Const $MCSC_TEXT = 1
Global Const $MCSC_TITLEBK = 2
Global Const $MCSC_TITLETEXT = 3
Global Const $MCSC_TRAILINGTEXT = 5
Global Const $DTM_FIRST = 0x1000
Global Const $DTM_GETSYSTEMTIME = $DTM_FIRST + 1
Global Const $DTM_SETSYSTEMTIME = $DTM_FIRST + 2
Global Const $DTM_GETRANGE = $DTM_FIRST + 3
Global Const $DTM_SETRANGE = $DTM_FIRST + 4
Global Const $DTM_SETFORMAT = $DTM_FIRST + 5
Global Const $DTM_SETMCCOLOR = $DTM_FIRST + 6
Global Const $DTM_GETMCCOLOR = $DTM_FIRST + 7
Global Const $DTM_GETMONTHCAL = $DTM_FIRST + 8
Global Const $DTM_SETMCFONT = $DTM_FIRST + 9
Global Const $DTM_GETMCFONT = $DTM_FIRST + 10
Global Const $DTM_SETFORMATW = $DTM_FIRST + 50
Global Const $DTN_FIRST = -740
Global Const $DTN_FIRST2 = -753
Global Const $DTN_DATETIMECHANGE = $DTN_FIRST2 - 6
Global Const $DTN_USERSTRING = $DTN_FIRST2 - 5
Global Const $DTN_WMKEYDOWN = $DTN_FIRST2 - 4
Global Const $DTN_FORMAT = $DTN_FIRST2 - 3
Global Const $DTN_FORMATQUERY = $DTN_FIRST2 - 2
Global Const $DTN_DROPDOWN = $DTN_FIRST2 - 1
Global Const $DTN_CLOSEUP = $DTN_FIRST2 - 0
Global Const $DTN_USERSTRINGW = $DTN_FIRST - 5
Global Const $DTN_WMKEYDOWNW = $DTN_FIRST - 4
Global Const $DTN_FORMATW = $DTN_FIRST - 3
Global Const $DTN_FORMATQUERYW = $DTN_FIRST - 2
Global Const $GUI_SS_DEFAULT_DATE = $DTS_LONGDATEFORMAT
Global Const $GUI_SS_DEFAULT_MONTHCAL = 0
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
Global Const $ECM_FIRST = 0X1500
Global Const $EM_CANUNDO = 0xC6
Global Const $EM_CHARFROMPOS = 0xD7
Global Const $EM_EMPTYUNDOBUFFER = 0xCD
Global Const $EM_FMTLINES = 0xC8
Global Const $EM_GETCUEBANNER = ($ECM_FIRST + 2)
Global Const $EM_GETFIRSTVISIBLELINE = 0xCE
Global Const $EM_GETHANDLE = 0xBD
Global Const $EM_GETIMESTATUS = 0xD9
Global Const $EM_GETLIMITTEXT = 0xD5
Global Const $EM_GETLINE = 0xC4
Global Const $EM_GETLINECOUNT = 0xBA
Global Const $EM_GETMARGINS = 0xD4
Global Const $EM_GETMODIFY = 0xB8
Global Const $EM_GETPASSWORDCHAR = 0xD2
Global Const $EM_GETRECT = 0xB2
Global Const $EM_GETSEL = 0xB0
Global Const $EM_GETTHUMB = 0xBE
Global Const $EM_GETWORDBREAKPROC = 0xD1
Global Const $EM_HIDEBALLOONTIP = ($ECM_FIRST + 4)
Global Const $EM_LIMITTEXT = 0xC5
Global Const $EM_LINEFROMCHAR = 0xC9
Global Const $EM_LINEINDEX = 0xBB
Global Const $EM_LINELENGTH = 0xC1
Global Const $EM_LINESCROLL = 0xB6
Global Const $EM_POSFROMCHAR = 0xD6
Global Const $EM_REPLACESEL = 0xC2
Global Const $EM_SCROLL = 0xB5
Global Const $EM_SCROLLCARET = 0x00B7
Global Const $EM_SETCUEBANNER = ($ECM_FIRST + 1)
Global Const $EM_SETHANDLE = 0xBC
Global Const $EM_SETIMESTATUS = 0xD8
Global Const $EM_SETLIMITTEXT = $EM_LIMITTEXT
Global Const $EM_SETMARGINS = 0xD3
Global Const $EM_SETMODIFY = 0xB9
Global Const $EM_SETPASSWORDCHAR = 0xCC
Global Const $EM_SETREADONLY = 0xCF
Global Const $EM_SETRECT = 0xB3
Global Const $EM_SETRECTNP = 0xB4
Global Const $EM_SETSEL = 0xB1
Global Const $EM_SETTABSTOPS = 0xCB
Global Const $EM_SETWORDBREAKPROC = 0xD0
Global Const $EM_SHOWBALLOONTIP = ($ECM_FIRST + 3)
Global Const $EM_UNDO = 0xC7
Global Const $EC_LEFTMARGIN = 0x1
Global Const $EC_RIGHTMARGIN = 0x2
Global Const $EC_USEFONTINFO = 0xFFFF
Global Const $EMSIS_COMPOSITIONSTRING = 0x1
Global Const $EIMES_GETCOMPSTRATONCE = 0x1
Global Const $EIMES_CANCELCOMPSTRINFOCUS = 0x2
Global Const $EIMES_COMPLETECOMPSTRKILLFOCUS = 0x4
Global Const $EN_ALIGN_LTR_EC = 0x700
Global Const $EN_ALIGN_RTL_EC = 0x701
Global Const $EN_CHANGE = 0x300
Global Const $EN_ERRSPACE = 0x500
Global Const $EN_HSCROLL = 0X601
Global Const $EN_KILLFOCUS = 0x200
Global Const $EN_MAXTEXT = 0x501
Global Const $EN_SETFOCUS = 0x100
Global Const $EN_UPDATE = 0x400
Global Const $EN_VSCROLL = 0x602
Global Const $GUI_SS_DEFAULT_EDIT = 0x003010c0
Global Const $GUI_SS_DEFAULT_INPUT = 0x00000080
Global Const $GUI_EVENT_SINGLE = 0
Global Const $GUI_EVENT_ARRAY = 1
Global Const $GUI_EVENT_NONE = 0
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
Global Const $GUI_RUNDEFMSG = 'GUI_RUNDEFMSG'
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
Global Const $GUI_FONTNORMAL = 0
Global Const $GUI_FONTITALIC = 2
Global Const $GUI_FONTUNDER = 4
Global Const $GUI_FONTSTRIKE = 8
Global Const $GUI_DOCKAUTO = 0x0001
Global Const $GUI_DOCKLEFT = 0x0002
Global Const $GUI_DOCKRIGHT = 0x0004
Global Const $GUI_DOCKHCENTER = 0x0008
Global Const $GUI_DOCKTOP = 0x0020
Global Const $GUI_DOCKBOTTOM = 0x0040
Global Const $GUI_DOCKVCENTER = 0x0080
Global Const $GUI_DOCKWIDTH = 0x0100
Global Const $GUI_DOCKHEIGHT = 0x0200
Global Const $GUI_DOCKSIZE = 0x0300
Global Const $GUI_DOCKMENUBAR = 0x0220
Global Const $GUI_DOCKSTATEBAR = 0x0240
Global Const $GUI_DOCKALL = 0x0322
Global Const $GUI_DOCKBORDERS = 0x0066
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
Global Const $GUI_BKCOLOR_LV_ALTERNATE = 0xFE000000
Global Const $GUI_READ_DEFAULT = 0
Global Const $GUI_READ_EXTENDED = 1
Global Const $GUI_CURSOR_NOOVERRIDE = 0
Global Const $GUI_CURSOR_OVERRIDE = 1
Global Const $GUI_WS_EX_PARENTDRAG = 0x00100000
Global Const $LBS_NOTIFY = 0x00000001
Global Const $LBS_SORT = 0x00000002
Global Const $LBS_NOREDRAW = 0x00000004
Global Const $LBS_MULTIPLESEL = 0x00000008
Global Const $LBS_OWNERDRAWFIXED = 0x00000010
Global Const $LBS_OWNERDRAWVARIABLE = 0x00000020
Global Const $LBS_HASSTRINGS = 0x00000040
Global Const $LBS_USETABSTOPS = 0x00000080
Global Const $LBS_NOINTEGRALHEIGHT = 0x00000100
Global Const $LBS_MULTICOLUMN = 0x00000200
Global Const $LBS_WANTKEYBOARDINPUT = 0x00000400
Global Const $LBS_EXTENDEDSEL = 0x00000800
Global Const $LBS_DISABLENOSCROLL = 0x00001000
Global Const $LBS_NODATA = 0x00002000
Global Const $LBS_NOSEL = 0x00004000
Global Const $LBS_COMBOBOX = 0x00008000
Global Const $LBS_STANDARD = 0x00000003
Global Const $GUI_SS_DEFAULT_LIST = 0x00a00003
Global Const $LB_ERR = -1
Global Const $LB_ERRATTRIBUTE = -3
Global Const $LB_ERRREQUIRED = -4
Global Const $LB_ERRSPACE = -2
Global Const $LB_ADDSTRING = 0x0180
Global Const $LB_INSERTSTRING = 0x0181
Global Const $LB_DELETESTRING = 0x0182
Global Const $LB_SELITEMRANGEEX = 0x0183
Global Const $LB_RESETCONTENT = 0x0184
Global Const $LB_SETSEL = 0x0185
Global Const $LB_SETCURSEL = 0x0186
Global Const $LB_GETSEL = 0x0187
Global Const $LB_GETCURSEL = 0x0188
Global Const $LB_GETTEXT = 0x0189
Global Const $LB_GETTEXTLEN = 0x018A
Global Const $LB_GETCOUNT = 0x018B
Global Const $LB_SELECTSTRING = 0x018C
Global Const $LB_DIR = 0x018D
Global Const $LB_GETTOPINDEX = 0x018E
Global Const $LB_FINDSTRING = 0x018F
Global Const $LB_GETSELCOUNT = 0x0190
Global Const $LB_GETSELITEMS = 0x0191
Global Const $LB_SETTABSTOPS = 0x0192
Global Const $LB_GETHORIZONTALEXTENT = 0x0193
Global Const $LB_SETHORIZONTALEXTENT = 0x0194
Global Const $LB_SETCOLUMNWIDTH = 0x0195
Global Const $LB_ADDFILE = 0x0196
Global Const $LB_SETTOPINDEX = 0x0197
Global Const $LB_GETITEMRECT = 0x0198
Global Const $LB_GETITEMDATA = 0x0199
Global Const $LB_SETITEMDATA = 0x019A
Global Const $LB_SELITEMRANGE = 0x019B
Global Const $LB_SETANCHORINDEX = 0x019C
Global Const $LB_GETANCHORINDEX = 0x019D
Global Const $LB_SETCARETINDEX = 0x019E
Global Const $LB_GETCARETINDEX = 0x019F
Global Const $LB_SETITEMHEIGHT = 0x01A0
Global Const $LB_GETITEMHEIGHT = 0x01A1
Global Const $LB_FINDSTRINGEXACT = 0x01A2
Global Const $LB_SETLOCALE = 0x01A5
Global Const $LB_GETLOCALE = 0x01A6
Global Const $LB_SETCOUNT = 0x01A7
Global Const $LB_INITSTORAGE = 0x01A8
Global Const $LB_ITEMFROMPOINT = 0x01A9
Global Const $LB_MULTIPLEADDSTRING = 0x01B1
Global Const $LB_GETLISTBOXINFO = 0x01B2
Global Const $LBN_ERRSPACE = 0xFFFFFFFE
Global Const $LBN_SELCHANGE = 0x00000001
Global Const $LBN_DBLCLK = 0x00000002
Global Const $LBN_SELCANCEL = 0x00000003
Global Const $LBN_SETFOCUS = 0x00000004
Global Const $LBN_KILLFOCUS = 0x00000005
Global Const $LVGS_NORMAL = 0x00000000
Global Const $LVGS_COLLAPSED = 0x00000001
Global Const $LVGS_HIDDEN = 0x00000002
Global Const $LVGS_NOHEADER = 0x00000004
Global Const $LVGS_COLLAPSIBLE = 0x00000008
Global Const $LVGS_FOCUSED = 0x00000010
Global Const $LVGS_SELECTED = 0x00000020
Global Const $LVGS_SUBSETED = 0x00000040
Global Const $LVGS_SUBSETLINKFOCUSED = 0x00000080
Global Const $LVGGR_GROUP = 0
Global Const $LVGGR_HEADER = 1
Global Const $LVGGR_LABEL = 2
Global Const $LVGGR_SUBSETLINK = 3
Global Const $LV_ERR = -1
Global Const $LVBKIF_SOURCE_NONE = 0x00000000
Global Const $LVBKIF_SOURCE_HBITMAP = 0x00000001
Global Const $LVBKIF_SOURCE_URL = 0x00000002
Global Const $LVBKIF_SOURCE_MASK = 0x00000003
Global Const $LVBKIF_STYLE_NORMAL = 0x00000000
Global Const $LVBKIF_STYLE_TILE = 0x00000010
Global Const $LVBKIF_STYLE_MASK = 0x00000010
Global Const $LVBKIF_FLAG_TILEOFFSET = 0x00000100
Global Const $LVBKIF_TYPE_WATERMARK = 0x10000000
Global Const $LV_VIEW_DETAILS = 0x0001
Global Const $LV_VIEW_ICON = 0x0000
Global Const $LV_VIEW_LIST = 0x0003
Global Const $LV_VIEW_SMALLICON = 0x0002
Global Const $LV_VIEW_TILE = 0x0004
Global Const $LVA_ALIGNLEFT = 0x0001
Global Const $LVA_ALIGNTOP = 0x0002
Global Const $LVA_DEFAULT = 0x0000
Global Const $LVA_SNAPTOGRID = 0x0005
Global Const $LVCDI_ITEM = 0x00000000
Global Const $LVCDI_GROUP = 0x00000001
Global Const $LVCF_ALLDATA = 0X0000003F
Global Const $LVCF_FMT = 0x0001
Global Const $LVCF_IMAGE = 0x0010
Global Const $LVCFMT_JUSTIFYMASK = 0x0003
Global Const $LVCF_TEXT = 0x0004
Global Const $LVCF_WIDTH = 0x0002
Global Const $LVCFMT_BITMAP_ON_RIGHT = 0x1000
Global Const $LVCFMT_CENTER = 0x0002
Global Const $LVCFMT_COL_HAS_IMAGES = 0x8000
Global Const $LVCFMT_IMAGE = 0x0800
Global Const $LVCFMT_LEFT = 0x0000
Global Const $LVCFMT_RIGHT = 0x0001
Global Const $LVCFMT_LINE_BREAK = 0x100000
Global Const $LVCFMT_FILL = 0x200000
Global Const $LVCFMT_WRAP = 0x400000
Global Const $LVCFMT_NO_TITLE = 0x800000
Global Const $LVCFMT_TILE_PLACEMENTMASK = BitOR($LVCFMT_LINE_BREAK, $LVCFMT_FILL)
Global Const $LVFI_NEARESTXY = 0x0040
Global Const $LVFI_PARAM = 0x0001
Global Const $LVFI_PARTIAL = 0x0008
Global Const $LVFI_STRING = 0x0002
Global Const $LVFI_SUBSTRING = 0x0004
Global Const $LVFI_WRAP = 0x0020
Global Const $LVGA_FOOTER_LEFT = 0x00000008
Global Const $LVGA_FOOTER_CENTER = 0x00000010
Global Const $LVGA_FOOTER_RIGHT = 0x00000020
Global Const $LVGA_HEADER_LEFT = 0x00000001
Global Const $LVGA_HEADER_CENTER = 0x00000002
Global Const $LVGA_HEADER_RIGHT = 0x00000004
Global Const $LVGF_ALIGN = 0x00000008
Global Const $LVGF_DESCRIPTIONTOP = 0x00000400
Global Const $LVGF_DESCRIPTIONBOTTOM = 0x00000800
Global Const $LVGF_EXTENDEDIMAGE = 0x00002000
Global Const $LVGF_FOOTER = 0x00000002
Global Const $LVGF_GROUPID = 0x00000010
Global Const $LVGF_HEADER = 0x00000001
Global Const $LVGF_ITEMS = 0x00004000
Global Const $LVGF_NONE = 0x00000000
Global Const $LVGF_STATE = 0x00000004
Global Const $LVGF_SUBSET = 0x00008000
Global Const $LVGF_SUBSETITEMS = 0x00010000
Global Const $LVGF_SUBTITLE = 0x00000100
Global Const $LVGF_TASK = 0x00000200
Global Const $LVGF_TITLEIMAGE = 0x00001000
Global Const $LVHT_ABOVE = 0x00000008
Global Const $LVHT_BELOW = 0x00000010
Global Const $LVHT_NOWHERE = 0x00000001
Global Const $LVHT_ONITEMICON = 0x00000002
Global Const $LVHT_ONITEMLABEL = 0x00000004
Global Const $LVHT_ONITEMSTATEICON = 0x00000008
Global Const $LVHT_TOLEFT = 0x00000040
Global Const $LVHT_TORIGHT = 0x00000020
Global Const $LVHT_ONITEM = BitOR($LVHT_ONITEMICON, $LVHT_ONITEMLABEL, $LVHT_ONITEMSTATEICON)
Global Const $LVHT_EX_GROUP_HEADER = 0x10000000
Global Const $LVHT_EX_GROUP_FOOTER = 0x20000000
Global Const $LVHT_EX_GROUP_COLLAPSE = 0x40000000
Global Const $LVHT_EX_GROUP_BACKGROUND = 0x80000000
Global Const $LVHT_EX_GROUP_STATEICON = 0x01000000
Global Const $LVHT_EX_GROUP_SUBSETLINK = 0x02000000
Global Const $LVHT_EX_GROUP = BitOR($LVHT_EX_GROUP_BACKGROUND, $LVHT_EX_GROUP_COLLAPSE, $LVHT_EX_GROUP_FOOTER, $LVHT_EX_GROUP_HEADER, $LVHT_EX_GROUP_STATEICON, $LVHT_EX_GROUP_SUBSETLINK)
Global Const $LVHT_EX_ONCONTENTS = 0x04000000
Global Const $LVHT_EX_FOOTER = 0x08000000
Global Const $LVIF_COLFMT = 0x00010000
Global Const $LVIF_COLUMNS = 0x00000200
Global Const $LVIF_GROUPID = 0x00000100
Global Const $LVIF_IMAGE = 0x00000002
Global Const $LVIF_INDENT = 0x00000010
Global Const $LVIF_NORECOMPUTE = 0x00000800
Global Const $LVIF_PARAM = 0x00000004
Global Const $LVIF_STATE = 0x00000008
Global Const $LVIF_TEXT = 0x00000001
Global Const $LVIM_AFTER = 0x00000001
Global Const $LVIR_BOUNDS = 0
Global Const $LVIR_ICON = 1
Global Const $LVIR_LABEL = 2
Global Const $LVIR_SELECTBOUNDS = 3
Global Const $LVIS_CUT = 0x0004
Global Const $LVIS_DROPHILITED = 0x0008
Global Const $LVIS_FOCUSED = 0x0001
Global Const $LVIS_OVERLAYMASK = 0x0F00
Global Const $LVIS_SELECTED = 0x0002
Global Const $LVIS_STATEIMAGEMASK = 0xF000
Global Const $LVS_ALIGNLEFT = 0x0800
Global Const $LVS_ALIGNMASK = 0x0c00
Global Const $LVS_ALIGNTOP = 0x0000
Global Const $LVS_AUTOARRANGE = 0x0100
Global Const $LVS_DEFAULT = 0x0000000D
Global Const $LVS_EDITLABELS = 0x0200
Global Const $LVS_ICON = 0x0000
Global Const $LVS_LIST = 0x0003
Global Const $LVS_NOCOLUMNHEADER = 0x4000
Global Const $LVS_NOLABELWRAP = 0x0080
Global Const $LVS_NOSCROLL = 0x2000
Global Const $LVS_NOSORTHEADER = 0x8000
Global Const $LVS_OWNERDATA = 0x1000
Global Const $LVS_OWNERDRAWFIXED = 0x0400
Global Const $LVS_REPORT = 0x0001
Global Const $LVS_SHAREIMAGELISTS = 0x0040
Global Const $LVS_SHOWSELALWAYS = 0x0008
Global Const $LVS_SINGLESEL = 0x0004
Global Const $LVS_SMALLICON = 0x0002
Global Const $LVS_SORTASCENDING = 0x0010
Global Const $LVS_SORTDESCENDING = 0x0020
Global Const $LVS_TYPEMASK = 0x0003
Global Const $LVS_TYPESTYLEMASK = 0xfc00
Global Const $LVS_EX_AUTOAUTOARRANGE = 0x01000000
Global Const $LVS_EX_AUTOCHECKSELECT = 0x08000000
Global Const $LVS_EX_AUTOSIZECOLUMNS = 0x10000000
Global Const $LVS_EX_BORDERSELECT = 0x00008000
Global Const $LVS_EX_CHECKBOXES = 0x00000004
Global Const $LVS_EX_COLUMNOVERFLOW = 0x80000000
Global Const $LVS_EX_COLUMNSNAPPOINTS = 0x40000000
Global Const $LVS_EX_DOUBLEBUFFER = 0x00010000
Global Const $LVS_EX_FLATSB = 0x00000100
Global Const $LVS_EX_FULLROWSELECT = 0x00000020
Global Const $LVS_EX_GRIDLINES = 0x00000001
Global Const $LVS_EX_HEADERDRAGDROP = 0x00000010
Global Const $LVS_EX_HEADERINALLVIEWS = 0x02000000
Global Const $LVS_EX_HIDELABELS = 0x20000
Global Const $LVS_EX_INFOTIP = 0x00000400
Global Const $LVS_EX_JUSTIFYCOLUMNS = 0x00200000
Global Const $LVS_EX_LABELTIP = 0x00004000
Global Const $LVS_EX_MULTIWORKAREAS = 0x00002000
Global Const $LVS_EX_ONECLICKACTIVATE = 0x00000040
Global Const $LVS_EX_REGIONAL = 0x00000200
Global Const $LVS_EX_SIMPLESELECT = 0x00100000
Global Const $LVS_EX_SNAPTOGRID = 0x00080000
Global Const $LVS_EX_SUBITEMIMAGES = 0x00000002
Global Const $LVS_EX_TRACKSELECT = 0x00000008
Global Const $LVS_EX_TRANSPARENTBKGND = 0x00400000
Global Const $LVS_EX_TRANSPARENTSHADOWTEXT = 0x00800000
Global Const $LVS_EX_TWOCLICKACTIVATE = 0x00000080
Global Const $LVS_EX_UNDERLINECOLD = 0x00001000
Global Const $LVS_EX_UNDERLINEHOT = 0x00000800
Global Const $GUI_SS_DEFAULT_LISTVIEW = BitOR($LVS_SHOWSELALWAYS, $LVS_SINGLESEL)
Global Const $LVM_FIRST = 0x1000
Global Const $LVM_APPROXIMATEVIEWRECT = ($LVM_FIRST + 64)
Global Const $LVM_ARRANGE = ($LVM_FIRST + 22)
Global Const $LVM_CANCELEDITLABEL = ($LVM_FIRST + 179)
Global Const $LVM_CREATEDRAGIMAGE = ($LVM_FIRST + 33)
Global Const $LVM_DELETEALLITEMS = ($LVM_FIRST + 9)
Global Const $LVM_DELETECOLUMN = ($LVM_FIRST + 28)
Global Const $LVM_DELETEITEM = ($LVM_FIRST + 8)
Global Const $LVM_EDITLABELA = ($LVM_FIRST + 23)
Global Const $LVM_EDITLABELW = ($LVM_FIRST + 118)
Global Const $LVM_EDITLABEL = $LVM_EDITLABELA
Global Const $LVM_ENABLEGROUPVIEW = ($LVM_FIRST + 157)
Global Const $LVM_ENSUREVISIBLE = ($LVM_FIRST + 19)
Global Const $LVM_FINDITEM = ($LVM_FIRST + 13)
Global Const $LVM_GETBKCOLOR = ($LVM_FIRST + 0)
Global Const $LVM_GETBKIMAGEA = ($LVM_FIRST + 69)
Global Const $LVM_GETBKIMAGEW = ($LVM_FIRST + 139)
Global Const $LVM_GETCALLBACKMASK = ($LVM_FIRST + 10)
Global Const $LVM_GETCOLUMNA = ($LVM_FIRST + 25)
Global Const $LVM_GETCOLUMNW = ($LVM_FIRST + 95)
Global Const $LVM_GETCOLUMNORDERARRAY = ($LVM_FIRST + 59)
Global Const $LVM_GETCOLUMNWIDTH = ($LVM_FIRST + 29)
Global Const $LVM_GETCOUNTPERPAGE = ($LVM_FIRST + 40)
Global Const $LVM_GETEDITCONTROL = ($LVM_FIRST + 24)
Global Const $LVM_GETEMPTYTEXT = ($LVM_FIRST + 204)
Global Const $LVM_GETEXTENDEDLISTVIEWSTYLE = ($LVM_FIRST + 55)
Global Const $LVM_GETFOCUSEDGROUP = ($LVM_FIRST + 93)
Global Const $LVM_GETFOOTERINFO = ($LVM_FIRST + 206)
Global Const $LVM_GETFOOTERITEM = ($LVM_FIRST + 208)
Global Const $LVM_GETFOOTERITEMRECT = ($LVM_FIRST + 207)
Global Const $LVM_GETFOOTERRECT = ($LVM_FIRST + 205)
Global Const $LVM_GETGROUPCOUNT = ($LVM_FIRST + 152)
Global Const $LVM_GETGROUPINFO = ($LVM_FIRST + 149)
Global Const $LVM_GETGROUPINFOBYINDEX = ($LVM_FIRST + 153)
Global Const $LVM_GETGROUPMETRICS = ($LVM_FIRST + 156)
Global Const $LVM_GETGROUPRECT = ($LVM_FIRST + 98)
Global Const $LVM_GETGROUPSTATE = ($LVM_FIRST + 92)
Global Const $LVM_GETHEADER = ($LVM_FIRST + 31)
Global Const $LVM_GETHOTCURSOR = ($LVM_FIRST + 63)
Global Const $LVM_GETHOTITEM = ($LVM_FIRST + 61)
Global Const $LVM_GETHOVERTIME = ($LVM_FIRST + 72)
Global Const $LVM_GETIMAGELIST = ($LVM_FIRST + 2)
Global Const $LVM_GETINSERTMARK = ($LVM_FIRST + 167)
Global Const $LVM_GETINSERTMARKCOLOR = ($LVM_FIRST + 171)
Global Const $LVM_GETINSERTMARKRECT = ($LVM_FIRST + 169)
Global Const $LVM_GETISEARCHSTRINGA = ($LVM_FIRST + 52)
Global Const $LVM_GETISEARCHSTRINGW = ($LVM_FIRST + 117)
Global Const $LVM_GETITEMA = ($LVM_FIRST + 5)
Global Const $LVM_GETITEMW = ($LVM_FIRST + 75)
Global Const $LVM_GETITEMCOUNT = ($LVM_FIRST + 4)
Global Const $LVM_GETITEMINDEXRECT = ($LVM_FIRST + 209)
Global Const $LVM_GETITEMPOSITION = ($LVM_FIRST + 16)
Global Const $LVM_GETITEMRECT = ($LVM_FIRST + 14)
Global Const $LVM_GETITEMSPACING = ($LVM_FIRST + 51)
Global Const $LVM_GETITEMSTATE = ($LVM_FIRST + 44)
Global Const $LVM_GETITEMTEXTA = ($LVM_FIRST + 45)
Global Const $LVM_GETITEMTEXTW = ($LVM_FIRST + 115)
Global Const $LVM_GETNEXTITEM = ($LVM_FIRST + 12)
Global Const $LVM_GETNEXTITEMINDEX = ($LVM_FIRST + 211)
Global Const $LVM_GETNUMBEROFWORKAREAS = ($LVM_FIRST + 73)
Global Const $LVM_GETORIGIN = ($LVM_FIRST + 41)
Global Const $LVM_GETOUTLINECOLOR = ($LVM_FIRST + 176)
Global Const $LVM_GETSELECTEDCOLUMN = ($LVM_FIRST + 174)
Global Const $LVM_GETSELECTEDCOUNT = ($LVM_FIRST + 50)
Global Const $LVM_GETSELECTIONMARK = ($LVM_FIRST + 66)
Global Const $LVM_GETSTRINGWIDTHA = ($LVM_FIRST + 17)
Global Const $LVM_GETSTRINGWIDTHW = ($LVM_FIRST + 87)
Global Const $LVM_GETSUBITEMRECT = ($LVM_FIRST + 56)
Global Const $LVM_GETTEXTBKCOLOR = ($LVM_FIRST + 37)
Global Const $LVM_GETTEXTCOLOR = ($LVM_FIRST + 35)
Global Const $LVM_GETTILEINFO = ($LVM_FIRST + 165)
Global Const $LVM_GETTILEVIEWINFO = ($LVM_FIRST + 163)
Global Const $LVM_GETTOOLTIPS = ($LVM_FIRST + 78)
Global Const $LVM_GETTOPINDEX = ($LVM_FIRST + 39)
Global Const $LVM_GETUNICODEFORMAT = 0x2000 + 6
Global Const $LVM_GETVIEW = ($LVM_FIRST + 143)
Global Const $LVM_GETVIEWRECT = ($LVM_FIRST + 34)
Global Const $LVM_GETWORKAREAS = ($LVM_FIRST + 70)
Global Const $LVM_HASGROUP = ($LVM_FIRST + 161)
Global Const $LVM_HITTEST = ($LVM_FIRST + 18)
Global Const $LVM_INSERTCOLUMNA = ($LVM_FIRST + 27)
Global Const $LVM_INSERTCOLUMNW = ($LVM_FIRST + 97)
Global Const $LVM_INSERTGROUP = ($LVM_FIRST + 145)
Global Const $LVM_INSERTGROUPSORTED = ($LVM_FIRST + 159)
Global Const $LVM_INSERTITEMA = ($LVM_FIRST + 7)
Global Const $LVM_INSERTITEMW = ($LVM_FIRST + 77)
Global Const $LVM_INSERTMARKHITTEST = ($LVM_FIRST + 168)
Global Const $LVM_ISGROUPVIEWENABLED = ($LVM_FIRST + 175)
Global Const $LVM_ISITEMVISIBLE = ($LVM_FIRST + 182)
Global Const $LVM_MAPIDTOINDEX = ($LVM_FIRST + 181)
Global Const $LVM_MAPINDEXTOID = ($LVM_FIRST + 180)
Global Const $LVM_MOVEGROUP = ($LVM_FIRST + 151)
Global Const $LVM_REDRAWITEMS = ($LVM_FIRST + 21)
Global Const $LVM_REMOVEALLGROUPS = ($LVM_FIRST + 160)
Global Const $LVM_REMOVEGROUP = ($LVM_FIRST + 150)
Global Const $LVM_SCROLL = ($LVM_FIRST + 20)
Global Const $LVM_SETBKCOLOR = ($LVM_FIRST + 1)
Global Const $LVM_SETBKIMAGEA = ($LVM_FIRST + 68)
Global Const $LVM_SETBKIMAGEW = ($LVM_FIRST + 138)
Global Const $LVM_SETCALLBACKMASK = ($LVM_FIRST + 11)
Global Const $LVM_SETCOLUMNA = ($LVM_FIRST + 26)
Global Const $LVM_SETCOLUMNW = ($LVM_FIRST + 96)
Global Const $LVM_SETCOLUMNORDERARRAY = ($LVM_FIRST + 58)
Global Const $LVM_SETCOLUMNWIDTH = ($LVM_FIRST + 30)
Global Const $LVM_SETEXTENDEDLISTVIEWSTYLE = ($LVM_FIRST + 54)
Global Const $LVM_SETGROUPINFO = ($LVM_FIRST + 147)
Global Const $LVM_SETGROUPMETRICS = ($LVM_FIRST + 155)
Global Const $LVM_SETHOTCURSOR = ($LVM_FIRST + 62)
Global Const $LVM_SETHOTITEM = ($LVM_FIRST + 60)
Global Const $LVM_SETHOVERTIME = ($LVM_FIRST + 71)
Global Const $LVM_SETICONSPACING = ($LVM_FIRST + 53)
Global Const $LVM_SETIMAGELIST = ($LVM_FIRST + 3)
Global Const $LVM_SETINFOTIP = ($LVM_FIRST + 173)
Global Const $LVM_SETINSERTMARK = ($LVM_FIRST + 166)
Global Const $LVM_SETINSERTMARKCOLOR = ($LVM_FIRST + 170)
Global Const $LVM_SETITEMA = ($LVM_FIRST + 6)
Global Const $LVM_SETITEMW = ($LVM_FIRST + 76)
Global Const $LVM_SETITEMCOUNT = ($LVM_FIRST + 47)
Global Const $LVM_SETITEMINDEXSTATE = ($LVM_FIRST + 210)
Global Const $LVM_SETITEMPOSITION = ($LVM_FIRST + 15)
Global Const $LVM_SETITEMPOSITION32 = ($LVM_FIRST + 49)
Global Const $LVM_SETITEMSTATE = ($LVM_FIRST + 43)
Global Const $LVM_SETITEMTEXTA = ($LVM_FIRST + 46)
Global Const $LVM_SETITEMTEXTW = ($LVM_FIRST + 116)
Global Const $LVM_SETOUTLINECOLOR = ($LVM_FIRST + 177)
Global Const $LVM_SETSELECTEDCOLUMN = ($LVM_FIRST + 140)
Global Const $LVM_SETSELECTIONMARK = ($LVM_FIRST + 67)
Global Const $LVM_SETTEXTBKCOLOR = ($LVM_FIRST + 38)
Global Const $LVM_SETTEXTCOLOR = ($LVM_FIRST + 36)
Global Const $LVM_SETTILEINFO = ($LVM_FIRST + 164)
Global Const $LVM_SETTILEVIEWINFO = ($LVM_FIRST + 162)
Global Const $LVM_SETTILEWIDTH = ($LVM_FIRST + 141)
Global Const $LVM_SETTOOLTIPS = ($LVM_FIRST + 74)
Global Const $LVM_SETUNICODEFORMAT = 0x2000 + 5
Global Const $LVM_SETVIEW = ($LVM_FIRST + 142)
Global Const $LVM_SETWORKAREAS = ($LVM_FIRST + 65)
Global Const $LVM_SORTGROUPS = ($LVM_FIRST + 158)
Global Const $LVM_SORTITEMS = ($LVM_FIRST + 48)
Global Const $LVM_SORTITEMSEX = ($LVM_FIRST + 81)
Global Const $LVM_SUBITEMHITTEST = ($LVM_FIRST + 57)
Global Const $LVM_UPDATE = ($LVM_FIRST + 42)
Global Const $LVN_FIRST = -100
Global Const $LVN_LAST = -199
Global Const $LVN_BEGINDRAG = ($LVN_FIRST - 9)
Global Const $LVN_BEGINLABELEDITA = ($LVN_FIRST - 5)
Global Const $LVN_BEGINLABELEDITW = ($LVN_FIRST - 75)
Global Const $LVN_BEGINRDRAG = ($LVN_FIRST - 11)
Global Const $LVN_BEGINSCROLL = ($LVN_FIRST - 80)
Global Const $LVN_COLUMNCLICK = ($LVN_FIRST - 8)
Global Const $LVN_COLUMNDROPDOWN = ($LVN_FIRST - 64)
Global Const $LVN_COLUMNOVERFLOWCLICK = ($LVN_FIRST - 66)
Global Const $LVN_DELETEALLITEMS = ($LVN_FIRST - 4)
Global Const $LVN_DELETEITEM = ($LVN_FIRST - 3)
Global Const $LVN_ENDLABELEDITA = ($LVN_FIRST - 6)
Global Const $LVN_ENDLABELEDITW = ($LVN_FIRST - 76)
Global Const $LVN_ENDSCROLL = ($LVN_FIRST - 81)
Global Const $LVN_GETDISPINFOA = ($LVN_FIRST - 50)
Global Const $LVN_GETDISPINFOW = ($LVN_FIRST - 77)
Global Const $LVN_GETDISPINFO = $LVN_GETDISPINFOA
Global Const $LVN_GETEMPTYMARKUP = ($LVN_FIRST - 87)
Global Const $LVN_GETINFOTIPA = ($LVN_FIRST - 57)
Global Const $LVN_GETINFOTIPW = ($LVN_FIRST - 58)
Global Const $LVN_HOTTRACK = ($LVN_FIRST - 21)
Global Const $LVN_INCREMENTALSEARCHA = ($LVN_FIRST - 62)
Global Const $LVN_INCREMENTALSEARCHW = ($LVN_FIRST - 63)
Global Const $LVN_INSERTITEM = ($LVN_FIRST - 2)
Global Const $LVN_ITEMACTIVATE = ($LVN_FIRST - 14)
Global Const $LVN_ITEMCHANGED = ($LVN_FIRST - 1)
Global Const $LVN_ITEMCHANGING = ($LVN_FIRST - 0)
Global Const $LVN_KEYDOWN = ($LVN_FIRST - 55)
Global Const $LVN_LINKCLICK = ($LVN_FIRST - 84)
Global Const $LVN_MARQUEEBEGIN = ($LVN_FIRST - 56)
Global Const $LVN_ODCACHEHINT = ($LVN_FIRST - 13)
Global Const $LVN_ODFINDITEMA = ($LVN_FIRST - 52)
Global Const $LVN_ODFINDITEMW = ($LVN_FIRST - 79)
Global Const $LVN_ODFINDITEM = $LVN_ODFINDITEMA
Global Const $LVN_ODSTATECHANGED = ($LVN_FIRST - 15)
Global Const $LVN_SETDISPINFOA = ($LVN_FIRST - 51)
Global Const $LVN_SETDISPINFOW = ($LVN_FIRST - 78)
Global Const $LVNI_ABOVE = 0x0100
Global Const $LVNI_BELOW = 0x0200
Global Const $LVNI_TOLEFT = 0x0400
Global Const $LVNI_TORIGHT = 0x0800
Global Const $LVNI_ALL = 0x0000
Global Const $LVNI_CUT = 0x0004
Global Const $LVNI_DROPHILITED = 0x0008
Global Const $LVNI_FOCUSED = 0x0001
Global Const $LVNI_SELECTED = 0x0002
Global Const $LVSCW_AUTOSIZE = -1
Global Const $LVSCW_AUTOSIZE_USEHEADER = -2
Global Const $LVSICF_NOINVALIDATEALL = 0x00000001
Global Const $LVSICF_NOSCROLL = 0x00000002
Global Const $LVSIL_NORMAL = 0
Global Const $LVSIL_SMALL = 1
Global Const $LVSIL_STATE = 2
Global Const $PBS_MARQUEE = 0x00000008
Global Const $PBS_SMOOTH = 1
Global Const $PBS_SMOOTHREVERSE = 0x10
Global Const $PBS_VERTICAL = 4
Global Const $GUI_SS_DEFAULT_PROGRESS = 0
Global Const $__PROGRESSBARCONSTANT_WM_USER = 0X400
Global Const $PBM_DELTAPOS = $__PROGRESSBARCONSTANT_WM_USER + 3
Global Const $PBM_GETBARCOLOR = 0x040F
Global Const $PBM_GETBKCOLOR = 0x040E
Global Const $PBM_GETPOS = $__PROGRESSBARCONSTANT_WM_USER + 8
Global Const $PBM_GETRANGE = $__PROGRESSBARCONSTANT_WM_USER + 7
Global Const $PBM_GETSTATE = 0x0411
Global Const $PBM_GETSTEP = 0x040D
Global Const $PBM_SETBARCOLOR = $__PROGRESSBARCONSTANT_WM_USER + 9
Global Const $PBM_SETBKCOLOR = 0x2000 + 1
Global Const $PBM_SETMARQUEE = $__PROGRESSBARCONSTANT_WM_USER + 10
Global Const $PBM_SETPOS = $__PROGRESSBARCONSTANT_WM_USER + 2
Global Const $PBM_SETRANGE = $__PROGRESSBARCONSTANT_WM_USER + 1
Global Const $PBM_SETRANGE32 = $__PROGRESSBARCONSTANT_WM_USER + 6
Global Const $PBM_SETSTATE = 0x0410
Global Const $PBM_SETSTEP = $__PROGRESSBARCONSTANT_WM_USER + 4
Global Const $PBM_STEPIT = $__PROGRESSBARCONSTANT_WM_USER + 5
Global Const $__RICHEDITCONSTANT_WM_USER = 0x400
Global Const $EM_AUTOURLDETECT = $__RICHEDITCONSTANT_WM_USER + 91
Global Const $EM_CANPASTE = $__RICHEDITCONSTANT_WM_USER + 50
Global Const $EM_CANREDO = $__RICHEDITCONSTANT_WM_USER + 85
Global Const $EM_DISPLAYBAND = $__RICHEDITCONSTANT_WM_USER + 51
Global Const $EM_EXGETSEL = $__RICHEDITCONSTANT_WM_USER + 52
Global Const $EM_EXLIMITTEXT = $__RICHEDITCONSTANT_WM_USER + 53
Global Const $EM_EXLINEFROMCHAR = $__RICHEDITCONSTANT_WM_USER + 54
Global Const $EM_EXSETSEL = $__RICHEDITCONSTANT_WM_USER + 55
Global Const $EM_FINDTEXT = $__RICHEDITCONSTANT_WM_USER + 56
Global Const $EM_FINDTEXTEX = $__RICHEDITCONSTANT_WM_USER + 79
Global Const $EM_FINDTEXTEXW = $__RICHEDITCONSTANT_WM_USER + 124
Global Const $EM_FINDTEXTW = $__RICHEDITCONSTANT_WM_USER + 123
Global Const $EM_FINDWORDBREAK = $__RICHEDITCONSTANT_WM_USER + 76
Global Const $EM_FORMATRANGE = $__RICHEDITCONSTANT_WM_USER + 57
Global Const $EM_GETAUTOURLDETECT = $__RICHEDITCONSTANT_WM_USER + 92
Global Const $EM_GETBIDIOPTIONS = $__RICHEDITCONSTANT_WM_USER + 201
Global Const $EM_GETCHARFORMAT = $__RICHEDITCONSTANT_WM_USER + 58
Global Const $EM_GETEDITSTYLE = $__RICHEDITCONSTANT_WM_USER + 205
Global Const $EM_GETEVENTMASK = $__RICHEDITCONSTANT_WM_USER + 59
Global Const $EM_GETIMECOLOR = $__RICHEDITCONSTANT_WM_USER + 105
Global Const $EM_GETIMECOMPMODE = $__RICHEDITCONSTANT_WM_USER + 122
Global Const $EM_GETIMEMODEBIAS = $__RICHEDITCONSTANT_WM_USER + 127
Global Const $EM_GETIMEOPTIONS = $__RICHEDITCONSTANT_WM_USER + 107
Global Const $EM_GETLANGOPTIONS = $__RICHEDITCONSTANT_WM_USER + 121
Global Const $EM_GETOPTIONS = $__RICHEDITCONSTANT_WM_USER + 78
Global Const $EM_GETPARAFORMAT = $__RICHEDITCONSTANT_WM_USER + 61
Global Const $EM_GETPUNCTUATION = $__RICHEDITCONSTANT_WM_USER + 101
Global Const $EM_GETREDONAME = $__RICHEDITCONSTANT_WM_USER + 87
Global Const $EM_GETSCROLLPOS = $__RICHEDITCONSTANT_WM_USER + 221
Global Const $EM_GETSELTEXT = $__RICHEDITCONSTANT_WM_USER + 62
Global Const $EM_GETTEXTEX = $__RICHEDITCONSTANT_WM_USER + 94
Global Const $EM_GETTEXTLENGTHEX = $__RICHEDITCONSTANT_WM_USER + 95
Global Const $EM_GETTEXTMODE = $__RICHEDITCONSTANT_WM_USER + 90
Global Const $EM_GETTEXTRANGE = $__RICHEDITCONSTANT_WM_USER + 75
Global Const $EM_GETTYPOGRAPHYOPTIONS = $__RICHEDITCONSTANT_WM_USER + 203
Global Const $EM_GETUNDONAME = $__RICHEDITCONSTANT_WM_USER + 86
Global Const $EM_GETWORDBREAKPROCEX = $__RICHEDITCONSTANT_WM_USER + 80
Global Const $EM_GETWORDWRAPMODE = $__RICHEDITCONSTANT_WM_USER + 103
Global Const $EM_GETZOOM = $__RICHEDITCONSTANT_WM_USER + 224
Global Const $EM_HIDESELECTION = $__RICHEDITCONSTANT_WM_USER + 63
Global Const $EM_PASTESPECIAL = $__RICHEDITCONSTANT_WM_USER + 64
Global Const $EM_RECONVERSION = $__RICHEDITCONSTANT_WM_USER + 125
Global Const $EM_REDO = $__RICHEDITCONSTANT_WM_USER + 84
Global Const $EM_REQUESTRESIZE = $__RICHEDITCONSTANT_WM_USER + 65
Global Const $EM_SELECTIONTYPE = $__RICHEDITCONSTANT_WM_USER + 66
Global Const $EM_SETBIDIOPTIONS = $__RICHEDITCONSTANT_WM_USER + 200
Global Const $EM_SETBKGNDCOLOR = $__RICHEDITCONSTANT_WM_USER + 67
Global Const $EM_SETCHARFORMAT = $__RICHEDITCONSTANT_WM_USER + 68
Global Const $EM_SETEDITSTYLE = $__RICHEDITCONSTANT_WM_USER + 204
Global Const $EM_SETEVENTMASK = $__RICHEDITCONSTANT_WM_USER + 69
Global Const $EM_SETFONTSIZE = $__RICHEDITCONSTANT_WM_USER + 223
Global Const $EM_SETIMECOLOR = $__RICHEDITCONSTANT_WM_USER + 104
Global Const $EM_SETIMEMODEBIAS = $__RICHEDITCONSTANT_WM_USER + 126
Global Const $EM_SETIMEOPTIONS = $__RICHEDITCONSTANT_WM_USER + 106
Global Const $EM_SETLANGOPTIONS = $__RICHEDITCONSTANT_WM_USER + 120
Global Const $EM_SETOLECALLBACK = $__RICHEDITCONSTANT_WM_USER + 70
Global Const $EM_SETOPTIONS = $__RICHEDITCONSTANT_WM_USER + 77
Global Const $EM_SETPALETTE = $__RICHEDITCONSTANT_WM_USER + 93
Global Const $EM_SETPARAFORMAT = $__RICHEDITCONSTANT_WM_USER + 71
Global Const $EM_SETPUNCTUATION = $__RICHEDITCONSTANT_WM_USER + 100
Global Const $EM_SETSCROLLPOS = $__RICHEDITCONSTANT_WM_USER + 222
Global Const $EM_SETTARGETDEVICE = $__RICHEDITCONSTANT_WM_USER + 72
Global Const $EM_SETTEXTEX = $__RICHEDITCONSTANT_WM_USER + 97
Global Const $EM_SETTEXTMODE = $__RICHEDITCONSTANT_WM_USER + 89
Global Const $EM_SETTYPOGRAPHYOPTIONS = $__RICHEDITCONSTANT_WM_USER + 202
Global Const $EM_SETUNDOLIMIT = $__RICHEDITCONSTANT_WM_USER + 82
Global Const $EM_SETWORDBREAKPROCEX = $__RICHEDITCONSTANT_WM_USER + 81
Global Const $EM_SETWORDWRAPMODE = $__RICHEDITCONSTANT_WM_USER + 102
Global Const $EM_SETZOOM = $__RICHEDITCONSTANT_WM_USER + 225
Global Const $EM_SHOWSCROLLBAR = $__RICHEDITCONSTANT_WM_USER + 96
Global Const $EM_STOPGROUPTYPING = $__RICHEDITCONSTANT_WM_USER + 88
Global Const $EM_STREAMIN = $__RICHEDITCONSTANT_WM_USER + 73
Global Const $EM_STREAMOUT = $__RICHEDITCONSTANT_WM_USER + 74
Global Const $EN_ALIGNLTR = 0X710
Global Const $EN_ALIGNRTL = 0X711
Global Const $EN_CORRECTTEXT = 0X705
Global Const $EN_DRAGDROPDONE = 0X70c
Global Const $EN_DROPFILES = 0X703
Global Const $EN_IMECHANGE = 0X707
Global Const $EN_LINK = 0X70b
Global Const $EN_MSGFILTER = 0X700
Global Const $EN_OBJECTPOSITIONS = 0X70a
Global Const $EN_OLEOPFAILED = 0X709
Global Const $EN_PROTECTED = 0X704
Global Const $EN_REQUESTRESIZE = 0X701
Global Const $EN_SAVECLIPBOARD = 0X708
Global Const $EN_SELCHANGE = 0X702
Global Const $EN_STOPNOUNDO = 0X706
Global Const $ENM_CHANGE = 0x1
Global Const $ENM_CORRECTTEXT = 0x400000
Global Const $ENM_DRAGDROPDONE = 0x10
Global Const $ENM_DROPFILES = 0x100000
Global Const $ENM_IMECHANGE = 0x800000
Global Const $ENM_KEYEVENTS = 0x10000
Global Const $ENM_LINK = 0x4000000
Global Const $ENM_MOUSEEVENTS = 0x20000
Global Const $ENM_OBJECTPOSITIONS = 0x2000000
Global Const $ENM_PROTECTED = 0x200000
Global Const $ENM_REQUESTRESIZE = 0x40000
Global Const $ENM_SCROLL = 0x4
Global Const $ENM_SCROLLEVENTS = 0x8
Global Const $ENM_SELCHANGE = 0x80000
Global Const $ENM_UPDATE = 0x2
Global Const $BOM_DEFPARADIR = 0x1
Global Const $BOM_PLAINTEXT = 0x2
Global Const $BOM_NEUTRALOVERRIDE = 0x4
Global Const $BOM_CONTEXTREADING = 0x8
Global Const $BOM_CONTEXTALIGNMENT = 0x10
Global Const $BOM_LEGACYBIDICLASS = 0x0040
Global Const $BOE_RTLDIR = 0x1
Global Const $BOE_PLAINTEXT = 0x2
Global Const $BOE_NEUTRALOVERRIDE = 0x4
Global Const $BOE_CONTEXTREADING = 0x8
Global Const $BOE_CONTEXTALIGNMENT = 0x10
Global Const $BOE_LEGACYBIDICLASS = 0x0040
Global Const $ST_DEFAULT = 0
Global Const $ST_KEEPUNDO = 1
Global Const $ST_SELECTION = 2
Global Const $GT_DEFAULT = 0
Global Const $GT_SELECTION = 2
Global Const $GT_USECRLF = 1
Global Const $GTL_CLOSE = 4
Global Const $GTL_DEFAULT = 0
Global Const $GTL_NUMBYTES = 16
Global Const $GTL_NUMCHARS = 8
Global Const $GTL_PRECISE = 2
Global Const $GTL_USECRLF = 1
Global Const $CFU_UNDERLINENONE = 0
Global Const $CFU_UNDERLINE = 1
Global Const $CFU_UNDERLINEWORD = 2
Global Const $CFU_UNDERLINEDOUBLE = 3
Global Const $CFU_UNDERLINEDOTTED = 4
Global Const $CP_ACP = 0
Global Const $CP_UNICODE = 1200
Global Const $CFE_SUBSCRIPT = 0x00010000
Global Const $CFE_SUPERSCRIPT = 0x00020000
Global Const $CFM_ALLCAPS = 0x80
Global Const $CFM_ANIMATION = 0x40000
Global Const $CFM_BACKCOLOR = 0x4000000
Global Const $CFM_BOLD = 0x1
Global Const $CFM_CHARSET = 0x8000000
Global Const $CFM_COLOR = 0x40000000
Global Const $CFM_DISABLED = 0x2000
Global Const $CFM_EMBOSS = 0x800
Global Const $CFM_FACE = 0x20000000
Global Const $CFM_HIDDEN = 0x100
Global Const $CFM_IMPRINT = 0x1000
Global Const $CFM_ITALIC = 0x2
Global Const $CFM_KERNING = 0x100000
Global Const $CFM_LCID = 0x2000000
Global Const $CFM_LINK = 0x20
Global Const $CFM_OFFSET = 0x10000000
Global Const $CFM_OUTLINE = 0x200
Global Const $CFM_PROTECTED = 0x10
Global Const $CFM_REVAUTHOR = 0x8000
Global Const $CFM_REVISED = 0x4000
Global Const $CFM_SHADOW = 0x400
Global Const $CFM_SIZE = 0x80000000
Global Const $CFM_SMALLCAPS = 0x40
Global Const $CFM_SPACING = 0x200000
Global Const $CFM_STRIKEOUT = 0x8
Global Const $CFM_STYLE = 0x80000
Global Const $CFM_SUBSCRIPT = BitOR($CFE_SUBSCRIPT, $CFE_SUPERSCRIPT)
Global Const $CFM_SUPERSCRIPT = $CFM_SUBSCRIPT
Global Const $CFM_UNDERLINE = 0x4
Global Const $CFM_UNDERLINETYPE = 0x800000
Global Const $CFM_WEIGHT = 0x400000
Global Const $CFE_ALLCAPS = $CFM_ALLCAPS
Global Const $CFE_AUTOBACKCOLOR = $CFM_BACKCOLOR
Global Const $CFE_AUTOCOLOR = $CFM_COLOR
Global Const $CFE_BOLD = $CFM_BOLD
Global Const $CFE_DISABLED = $CFM_DISABLED
Global Const $CFE_EMBOSS = $CFM_EMBOSS
Global Const $CFE_HIDDEN = $CFM_HIDDEN
Global Const $CFE_IMPRINT = $CFM_IMPRINT
Global Const $CFE_ITALIC = $CFM_ITALIC
Global Const $CFE_LINK = $CFM_LINK
Global Const $CFE_OUTLINE = $CFM_OUTLINE
Global Const $CFE_PROTECTED = $CFM_PROTECTED
Global Const $CFE_REVISED = $CFM_REVISED
Global Const $CFE_SHADOW = $CFM_SHADOW
Global Const $CFE_SMALLCAPS = $CFM_SMALLCAPS
Global Const $CFE_STRIKEOUT = $CFM_STRIKEOUT
Global Const $CFE_UNDERLINE = $CFM_UNDERLINE
Global Const $FR_MATCHALEFHAMZA = 0x80000000
Global Const $FR_MATCHDIAC = 0x20000000
Global Const $FR_MATCHKASHIDA = 0x40000000
Global Const $SCF_DEFAULT = 0x0
Global Const $SCF_SELECTION = 0x1
Global Const $SCF_WORD = 0x2
Global Const $SCF_ALL = 0x4
Global Const $SCF_USEUIRULES = 0x8
Global Const $SCF_ASSOCIATEFONT = 0x10
Global Const $SCF_NOKBUPDATE = 0x20
Global Const $LF_FACESIZE = 32
Global Const $MAX_TAB_STOPS = 32
Global Const $PFA_LEFT = 0x1
Global Const $PFA_RIGHT = 0x2
Global Const $PFA_CENTER = 0x3
Global Const $PFA_JUSTIFY = 4
Global Const $PFA_FULL_INTERWORD = 4
Global Const $PFE_TABLE = 0x4000
Global Const $PFM_NUMBERING = 0x20
Global Const $PFM_ALIGNMENT = 0x8
Global Const $PFM_SPACEBEFORE = 0x40
Global Const $PFM_NUMBERINGSTYLE = 0x2000
Global Const $PFM_NUMBERINGSTART = 0x8000
Global Const $PFM_BORDER = 0x800
Global Const $PFM_RIGHTINDENT = 0x2
Global Const $PFM_STARTINDENT = 0x1
Global Const $PFM_OFFSET = 0x4
Global Const $PFM_LINESPACING = 0x100
Global Const $PFM_SPACEAFTER = 0x80
Global Const $PFM_NUMBERINGTAB = 0x4000
Global Const $PFM_TABLE = 0x40000000
Global Const $PFM_TABSTOPS = 0x10
Global Const $PFN_BULLET = 0x1
Global Const $PFM_RTLPARA = 0x10000
Global Const $PFM_KEEP = 0x20000
Global Const $PFM_KEEPNEXT = 0x40000
Global Const $PFM_PAGEBREAKBEFORE = 0x80000
Global Const $PFM_NOLINENUMBER = 0x100000
Global Const $PFM_NOWIDOWCONTROL = 0x200000
Global Const $PFM_DONOTHYPHEN = 0x400000
Global Const $PFM_SIDEBYSIDE = 0x800000
Global Const $PFE_RTLPARA = 0x00000001
Global Const $PFE_KEEP = 0x00000002
Global Const $PFE_KEEPNEXT = 0x00000004
Global Const $PFE_PAGEBREAKBEFORE = 0x00000008
Global Const $PFE_NOLINENUMBER = 0x00000010
Global Const $PFE_NOWIDOWCONTROL = 0x00000020
Global Const $PFE_DONOTHYPHEN = 0x00000040
Global Const $PFE_SIDEBYSIDE = 0x00000080
Global Const $PFM_SHADING = 0x1000
Global Const $WB_CLASSIFY = 3
Global Const $WB_ISDELIMITER = 2
Global Const $WB_LEFT = 0
Global Const $WB_LEFTBREAK = 6
Global Const $WB_MOVEWORDLEFT = 4
Global Const $WB_MOVEWORDNEXT = 5
Global Const $WB_MOVEWORDPREV = 4
Global Const $WB_MOVEWORDRIGHT = 5
Global Const $WB_NEXTBREAK = 7
Global Const $WB_PREVBREAK = 6
Global Const $WB_RIGHT = 1
Global Const $WB_RIGHTBREAK = 7
Global Const $WBF_ISWHITE = 0x10
Global Const $WBF_BREAKLINE = 0x20
Global Const $WBF_BREAKAFTER = 0x40
Global Const $SF_TEXT = 0x1
Global Const $SF_RTF = 0x2
Global Const $SF_RTFNOOBJS = 0x3
Global Const $SF_TEXTIZED = 0x4
Global Const $SF_UNICODE = 0x0010
Global Const $SF_USECODEPAGE = 0x20
Global Const $SFF_PLAINRTF = 0x4000
Global Const $SFF_SELECTION = 0x8000
Global Const $TBCD_CHANNEL = 0x3
Global Const $TBCD_THUMB = 0x2
Global Const $TBCD_TICS = 0x1
Global Const $__SLIDERCONSTANT_WM_USER = 0x400
Global Const $TBM_CLEARSEL = $__SLIDERCONSTANT_WM_USER + 19
Global Const $TBM_CLEARTICS = $__SLIDERCONSTANT_WM_USER + 9
Global Const $TBM_GETBUDDY = $__SLIDERCONSTANT_WM_USER + 33
Global Const $TBM_GETCHANNELRECT = $__SLIDERCONSTANT_WM_USER + 26
Global Const $TBM_GETLINESIZE = $__SLIDERCONSTANT_WM_USER + 24
Global Const $TBM_GETNUMTICS = $__SLIDERCONSTANT_WM_USER + 16
Global Const $TBM_GETPAGESIZE = $__SLIDERCONSTANT_WM_USER + 22
Global Const $TBM_GETPOS = $__SLIDERCONSTANT_WM_USER
Global Const $TBM_GETPTICS = $__SLIDERCONSTANT_WM_USER + 14
Global Const $TBM_GETSELEND = $__SLIDERCONSTANT_WM_USER + 18
Global Const $TBM_GETSELSTART = $__SLIDERCONSTANT_WM_USER + 17
Global Const $TBM_GETRANGEMAX = $__SLIDERCONSTANT_WM_USER + 2
Global Const $TBM_GETRANGEMIN = $__SLIDERCONSTANT_WM_USER + 1
Global Const $TBM_GETTHUMBLENGTH = $__SLIDERCONSTANT_WM_USER + 28
Global Const $TBM_GETTHUMBRECT = $__SLIDERCONSTANT_WM_USER + 25
Global Const $TBM_GETTIC = $__SLIDERCONSTANT_WM_USER + 3
Global Const $TBM_GETTICPOS = $__SLIDERCONSTANT_WM_USER + 15
Global Const $TBM_GETTOOLTIPS = $__SLIDERCONSTANT_WM_USER + 30
Global Const $TBM_GETUNICODEFORMAT = 0x2000 + 6
Global Const $TBM_SETBUDDY = $__SLIDERCONSTANT_WM_USER + 32
Global Const $TBM_SETLINESIZE = $__SLIDERCONSTANT_WM_USER + 23
Global Const $TBM_SETPAGESIZE = $__SLIDERCONSTANT_WM_USER + 21
Global Const $TBM_SETPOS = $__SLIDERCONSTANT_WM_USER + 5
Global Const $TBM_SETRANGE = $__SLIDERCONSTANT_WM_USER + 6
Global Const $TBM_SETRANGEMAX = $__SLIDERCONSTANT_WM_USER + 8
Global Const $TBM_SETRANGEMIN = $__SLIDERCONSTANT_WM_USER + 7
Global Const $TBM_SETSEL = $__SLIDERCONSTANT_WM_USER + 10
Global Const $TBM_SETSELEND = $__SLIDERCONSTANT_WM_USER + 12
Global Const $TBM_SETSELSTART = $__SLIDERCONSTANT_WM_USER + 11
Global Const $TBM_SETTHUMBLENGTH = $__SLIDERCONSTANT_WM_USER + 27
Global Const $TBM_SETTIC = $__SLIDERCONSTANT_WM_USER + 4
Global Const $TBM_SETTICFREQ = $__SLIDERCONSTANT_WM_USER + 20
Global Const $TBM_SETTIPSIDE = $__SLIDERCONSTANT_WM_USER + 31
Global Const $TBM_SETTOOLTIPS = $__SLIDERCONSTANT_WM_USER + 29
Global Const $TBM_SETUNICODEFORMAT = 0x2000 + 5
Global Const $TBTS_BOTTOM = 2
Global Const $TBTS_LEFT = 1
Global Const $TBTS_RIGHT = 3
Global Const $TBTS_TOP = 0
Global Const $TBS_AUTOTICKS = 0x0001
Global Const $TBS_BOTH = 0x0008
Global Const $TBS_BOTTOM = 0x0000
Global Const $TBS_DOWNISLEFT = 0x0400
Global Const $TBS_ENABLESELRANGE = 0x20
Global Const $TBS_FIXEDLENGTH = 0x40
Global Const $TBS_HORZ = 0x0000
Global Const $TBS_LEFT = 0x0004
Global Const $TBS_NOTHUMB = 0x0080
Global Const $TBS_NOTICKS = 0x0010
Global Const $TBS_REVERSED = 0x200
Global Const $TBS_RIGHT = 0x0000
Global Const $TBS_TOP = 0x0004
Global Const $TBS_TOOLTIPS = 0x100
Global Const $TBS_VERT = 0x0002
Global Const $GUI_SS_DEFAULT_SLIDER = $TBS_AUTOTICKS
Global Const $SS_LEFT = 0x0
Global Const $SS_CENTER = 0x1
Global Const $SS_RIGHT = 0x2
Global Const $SS_ICON = 0x3
Global Const $SS_BLACKRECT = 0x4
Global Const $SS_GRAYRECT = 0x5
Global Const $SS_WHITERECT = 0x6
Global Const $SS_BLACKFRAME = 0x7
Global Const $SS_GRAYFRAME = 0x8
Global Const $SS_WHITEFRAME = 0x9
Global Const $SS_SIMPLE = 0xB
Global Const $SS_LEFTNOWORDWRAP = 0xC
Global Const $SS_BITMAP = 0xE
Global Const $SS_ENHMETAFILE = 0xF
Global Const $SS_ETCHEDHORZ = 0x10
Global Const $SS_ETCHEDVERT = 0x11
Global Const $SS_ETCHEDFRAME = 0x12
Global Const $SS_REALSIZECONTROL = 0x40
Global Const $SS_NOPREFIX = 0x0080
Global Const $SS_NOTIFY = 0x0100
Global Const $SS_CENTERIMAGE = 0x0200
Global Const $SS_RIGHTJUST = 0x0400
Global Const $SS_SUNKEN = 0x1000
Global Const $GUI_SS_DEFAULT_LABEL = 0
Global Const $GUI_SS_DEFAULT_GRAPHIC = 0
Global Const $GUI_SS_DEFAULT_ICON = $SS_NOTIFY
Global Const $GUI_SS_DEFAULT_PIC = $SS_NOTIFY
Global Const $STM_SETICON = 0x0170
Global Const $STM_GETICON = 0x0171
Global Const $STM_SETIMAGE = 0x0172
Global Const $STM_GETIMAGE = 0x0173
Global Const $TCS_EX_FLATSEPARATORS = 0x00000001
Global Const $TCS_EX_REGISTERDROP = 0x00000002
Global Const $TCHT_NOWHERE = 0x00000001
Global Const $TCHT_ONITEMICON = 0x00000002
Global Const $TCHT_ONITEMLABEL = 0x00000004
Global Const $TCHT_ONITEM = 0x00000006
Global Const $TCIF_TEXT = 0x00000001
Global Const $TCIF_IMAGE = 0x00000002
Global Const $TCIF_RTLREADING = 0x00000004
Global Const $TCIF_PARAM = 0x00000008
Global Const $TCIF_STATE = 0x00000010
Global Const $TCIF_ALLDATA = 0x0000001B
Global Const $TCIS_BUTTONPRESSED = 0x00000001
Global Const $TCIS_HIGHLIGHTED = 0x00000002
Global Const $TC_ERR = -1
Global Const $TCS_BOTTOM = 0x00000002
Global Const $TCS_BUTTONS = 0x00000100
Global Const $TCS_FIXEDWIDTH = 0x00000400
Global Const $TCS_FLATBUTTONS = 0x00000008
Global Const $TCS_FOCUSNEVER = 0x00008000
Global Const $TCS_FOCUSONBUTTONDOWN = 0x00001000
Global Const $TCS_FORCEICONLEFT = 0x00000010
Global Const $TCS_FORCELABELLEFT = 0x00000020
Global Const $TCS_HOTTRACK = 0x00000040
Global Const $TCS_MULTILINE = 0x00000200
Global Const $TCS_MULTISELECT = 0x00000004
Global Const $TCS_OWNERDRAWFIXED = 0x00002000
Global Const $TCS_RAGGEDRIGHT = 0x00000800
Global Const $TCS_RIGHT = 0x00000002
Global Const $TCS_RIGHTJUSTIFY = 0x00000000
Global Const $TCS_SCROLLOPPOSITE = 0x00000001
Global Const $TCS_SINGLELINE = 0x00000000
Global Const $TCS_TABS = 0x00000000
Global Const $TCS_TOOLTIPS = 0x00004000
Global Const $TCS_VERTICAL = 0x00000080
Global Const $GUI_SS_DEFAULT_TAB = 0
Global Const $TCM_FIRST = 0x1300
Global Const $TCCM_FIRST = 0X2000
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
Global Const $TVS_HASBUTTONS = 0x00000001
Global Const $TVS_HASLINES = 0x00000002
Global Const $TVS_LINESATROOT = 0x00000004
Global Const $TVS_EDITLABELS = 0x00000008
Global Const $TVS_DISABLEDRAGDROP = 0x00000010
Global Const $TVS_SHOWSELALWAYS = 0x00000020
Global Const $TVS_RTLREADING = 0x00000040
Global Const $TVS_NOTOOLTIPS = 0x00000080
Global Const $TVS_CHECKBOXES = 0x00000100
Global Const $TVS_TRACKSELECT = 0x00000200
Global Const $TVS_SINGLEEXPAND = 0x00000400
Global Const $TVS_INFOTIP = 0x00000800
Global Const $TVS_FULLROWSELECT = 0x00001000
Global Const $TVS_NOSCROLL = 0x00002000
Global Const $TVS_NONEVENHEIGHT = 0x00004000
Global Const $TVS_NOHSCROLL = 0x00008000
Global Const $TVS_DEFAULT = 0x00000037
Global Const $GUI_SS_DEFAULT_TREEVIEW = BitOR($TVS_HASBUTTONS, $TVS_HASLINES, $TVS_LINESATROOT, $TVS_DISABLEDRAGDROP, $TVS_SHOWSELALWAYS)
Global Const $TVE_COLLAPSE = 0x0001
Global Const $TVE_EXPAND = 0x0002
Global Const $TVE_TOGGLE = 0x0003
Global Const $TVE_EXPANDPARTIAL = 0x4000
Global Const $TVE_COLLAPSERESET = 0x8000
Global Const $TVGN_ROOT = 0x00000000
Global Const $TVGN_NEXT = 0x00000001
Global Const $TVGN_PREVIOUS = 0x00000002
Global Const $TVGN_PARENT = 0x00000003
Global Const $TVGN_CHILD = 0x00000004
Global Const $TVGN_FIRSTVISIBLE = 0x00000005
Global Const $TVGN_NEXTVISIBLE = 0x00000006
Global Const $TVGN_PREVIOUSVISIBLE = 0x00000007
Global Const $TVGN_DROPHILITE = 0x00000008
Global Const $TVGN_CARET = 0x00000009
Global Const $TVGN_LASTVISIBLE = 0x0000000A
Global Const $TVHT_NOWHERE = 0x00000001
Global Const $TVHT_ONITEMICON = 0x00000002
Global Const $TVHT_ONITEMLABEL = 0x00000004
Global Const $TVHT_ONITEMINDENT = 0x00000008
Global Const $TVHT_ONITEMBUTTON = 0x00000010
Global Const $TVHT_ONITEMRIGHT = 0x00000020
Global Const $TVHT_ONITEMSTATEICON = 0x00000040
Global Const $TVHT_ONITEM = 0x00000046
Global Const $TVHT_ABOVE = 0x00000100
Global Const $TVHT_BELOW = 0x00000200
Global Const $TVHT_TORIGHT = 0x00000400
Global Const $TVHT_TOLEFT = 0x00000800
Global Const $TVI_ROOT = 0xFFFF0000
Global Const $TVI_FIRST = 0xFFFF0001
Global Const $TVI_LAST = 0xFFFF0002
Global Const $TVI_SORT = 0xFFFF0003
Global Const $TVIF_TEXT = 0x00000001
Global Const $TVIF_IMAGE = 0x00000002
Global Const $TVIF_PARAM = 0x00000004
Global Const $TVIF_STATE = 0x00000008
Global Const $TVIF_HANDLE = 0x00000010
Global Const $TVIF_SELECTEDIMAGE = 0x00000020
Global Const $TVIF_CHILDREN = 0x00000040
Global Const $TVIF_INTEGRAL = 0x00000080
Global Const $TVIF_EXPANDEDIMAGE = 0x00000100
Global Const $TVIF_STATEEX = 0x00000200
Global Const $TVIF_DI_SETITEM = 0x00001000
Global Const $TVSIL_NORMAL = 0
Global Const $TVSIL_STATE = 2
Global Const $TVC_BYKEYBOARD = 0x2
Global Const $TVC_BYMOUSE = 0x1
Global Const $TVC_UNKNOWN = 0x0
Global Const $TVIS_FOCUSED = 0x00000001
Global Const $TVIS_SELECTED = 0x00000002
Global Const $TVIS_CUT = 0x00000004
Global Const $TVIS_DROPHILITED = 0x00000008
Global Const $TVIS_BOLD = 0x00000010
Global Const $TVIS_EXPANDED = 0x00000020
Global Const $TVIS_EXPANDEDONCE = 0x00000040
Global Const $TVIS_EXPANDPARTIAL = 0x00000080
Global Const $TVIS_OVERLAYMASK = 0x00000F00
Global Const $TVIS_STATEIMAGEMASK = 0x0000F000
Global Const $TVIS_USERMASK = 0x0000F000
Global Const $TVIS_UNCHECKED = 4096
Global Const $TVIS_CHECKED = 8192
Global Const $TVNA_ADD = 1
Global Const $TVNA_ADDFIRST = 2
Global Const $TVNA_ADDCHILD = 3
Global Const $TVNA_ADDCHILDFIRST = 4
Global Const $TVNA_INSERT = 5
Global Const $TVTA_ADDFIRST = 1
Global Const $TVTA_ADD = 2
Global Const $TVTA_INSERT = 3
Global Const $TV_FIRST = 0x1100
Global Const $TVM_INSERTITEMA = $TV_FIRST + 0
Global Const $TVM_DELETEITEM = $TV_FIRST + 1
Global Const $TVM_EXPAND = $TV_FIRST + 2
Global Const $TVM_GETITEMRECT = $TV_FIRST + 4
Global Const $TVM_GETCOUNT = $TV_FIRST + 5
Global Const $TVM_GETINDENT = $TV_FIRST + 6
Global Const $TVM_SETINDENT = $TV_FIRST + 7
Global Const $TVM_GETIMAGELIST = $TV_FIRST + 8
Global Const $TVM_SETIMAGELIST = $TV_FIRST + 9
Global Const $TVM_GETNEXTITEM = $TV_FIRST + 10
Global Const $TVM_SELECTITEM = $TV_FIRST + 11
Global Const $TVM_GETITEMA = $TV_FIRST + 12
Global Const $TVM_SETITEMA = $TV_FIRST + 13
Global Const $TVM_EDITLABELA = $TV_FIRST + 14
Global Const $TVM_GETEDITCONTROL = $TV_FIRST + 15
Global Const $TVM_GETVISIBLECOUNT = $TV_FIRST + 16
Global Const $TVM_HITTEST = $TV_FIRST + 17
Global Const $TVM_CREATEDRAGIMAGE = $TV_FIRST + 18
Global Const $TVM_SORTCHILDREN = $TV_FIRST + 19
Global Const $TVM_ENSUREVISIBLE = $TV_FIRST + 20
Global Const $TVM_SORTCHILDRENCB = $TV_FIRST + 21
Global Const $TVM_ENDEDITLABELNOW = $TV_FIRST + 22
Global Const $TVM_GETISEARCHSTRINGA = $TV_FIRST + 23
Global Const $TVM_SETTOOLTIPS = $TV_FIRST + 24
Global Const $TVM_GETTOOLTIPS = $TV_FIRST + 25
Global Const $TVM_SETINSERTMARK = $TV_FIRST + 26
Global Const $TVM_SETITEMHEIGHT = $TV_FIRST + 27
Global Const $TVM_GETITEMHEIGHT = $TV_FIRST + 28
Global Const $TVM_SETBKCOLOR = $TV_FIRST + 29
Global Const $TVM_SETTEXTCOLOR = $TV_FIRST + 30
Global Const $TVM_GETBKCOLOR = $TV_FIRST + 31
Global Const $TVM_GETTEXTCOLOR = $TV_FIRST + 32
Global Const $TVM_SETSCROLLTIME = $TV_FIRST + 33
Global Const $TVM_GETSCROLLTIME = $TV_FIRST + 34
Global Const $TVM_SETINSERTMARKCOLOR = $TV_FIRST + 37
Global Const $TVM_GETINSERTMARKCOLOR = $TV_FIRST + 38
Global Const $TVM_GETITEMSTATE = $TV_FIRST + 39
Global Const $TVM_SETLINECOLOR = $TV_FIRST + 40
Global Const $TVM_GETLINECOLOR = $TV_FIRST + 41
Global Const $TVM_MAPACCIDTOHTREEITEM = $TV_FIRST + 42
Global Const $TVM_MAPHTREEITEMTOACCID = $TV_FIRST + 43
Global Const $TVM_INSERTITEMW = $TV_FIRST + 50
Global Const $TVM_GETITEMW = $TV_FIRST + 62
Global Const $TVM_SETITEMW = $TV_FIRST + 63
Global Const $TVM_GETISEARCHSTRINGW = $TV_FIRST + 64
Global Const $TVM_EDITLABELW = $TV_FIRST + 65
Global Const $TVM_GETUNICODEFORMAT = 0x2000 + 6
Global Const $TVM_SETUNICODEFORMAT = 0x2000 + 5
Global Const $TVN_FIRST = -400
Global Const $TVN_SELCHANGINGA = $TVN_FIRST - 1
Global Const $TVN_SELCHANGEDA = $TVN_FIRST - 2
Global Const $TVN_GETDISPINFOA = $TVN_FIRST - 3
Global Const $TVN_SETDISPINFOA = $TVN_FIRST - 4
Global Const $TVN_ITEMEXPANDINGA = $TVN_FIRST - 5
Global Const $TVN_ITEMEXPANDEDA = $TVN_FIRST - 6
Global Const $TVN_BEGINDRAGA = $TVN_FIRST - 7
Global Const $TVN_BEGINRDRAGA = $TVN_FIRST - 8
Global Const $TVN_DELETEITEMA = $TVN_FIRST - 9
Global Const $TVN_BEGINLABELEDITA = $TVN_FIRST - 10
Global Const $TVN_ENDLABELEDITA = $TVN_FIRST - 11
Global Const $TVN_KEYDOWN = $TVN_FIRST - 12
Global Const $TVN_GETINFOTIPA = $TVN_FIRST - 13
Global Const $TVN_GETINFOTIPW = $TVN_FIRST - 14
Global Const $TVN_SINGLEEXPAND = $TVN_FIRST - 15
Global Const $TVN_ITEMCHANGINGA = $TVN_FIRST - 16
Global Const $TVN_ITEMCHANGINGW = $TVN_FIRST - 17
Global Const $TVN_ITEMCHANGEDA = $TVN_FIRST - 18
Global Const $TVN_ITEMCHANGEDW = $TVN_FIRST - 19
Global Const $TVN_SELCHANGINGW = $TVN_FIRST - 50
Global Const $TVN_SELCHANGEDW = $TVN_FIRST - 51
Global Const $TVN_GETDISPINFOW = $TVN_FIRST - 52
Global Const $TVN_SETDISPINFOW = $TVN_FIRST - 53
Global Const $TVN_ITEMEXPANDINGW = $TVN_FIRST - 54
Global Const $TVN_ITEMEXPANDEDW = $TVN_FIRST - 55
Global Const $TVN_BEGINDRAGW = $TVN_FIRST - 56
Global Const $TVN_BEGINRDRAGW = $TVN_FIRST - 57
Global Const $TVN_DELETEITEMW = $TVN_FIRST - 58
Global Const $TVN_BEGINLABELEDITW = $TVN_FIRST - 59
Global Const $TVN_ENDLABELEDITW = $TVN_FIRST - 60
Global Const $UDS_WRAP = 0x0001
Global Const $UDS_SETBUDDYINT = 0x0002
Global Const $UDS_ALIGNRIGHT = 0x0004
Global Const $UDS_ALIGNLEFT = 0x0008
Global Const $UDS_ARROWKEYS = 0x0020
Global Const $UDS_HORZ = 0x0040
Global Const $UDS_NOTHOUSANDS = 0x0080
Global Const $GUI_SS_DEFAULT_UPDOWN = $UDS_ALIGNLEFT
Global Const $WC_ANIMATE = 'SysAnimate32'
Global Const $WC_BUTTON = 'Button'
Global Const $WC_COMBOBOX = 'ComboBox'
Global Const $WC_COMBOBOXEX = 'ComboBoxEx32'
Global Const $WC_DATETIMEPICK = 'SysDateTimePick32'
Global Const $WC_EDIT = 'Edit'
Global Const $WC_HEADER = 'SysHeader32'
Global Const $WC_HOTKEY = 'msctls_hotkey32'
Global Const $WC_IPADDRESS = 'SysIPAddress32'
Global Const $WC_LINK = 'SysLink'
Global Const $WC_LISTBOX = 'ListBox'
Global Const $WC_LISTVIEW = 'SysListView32'
Global Const $WC_MONTHCAL = 'SysMonthCal32'
Global Const $WC_NATIVEFONTCTL = 'NativeFontCtl'
Global Const $WC_PAGESCROLLER = 'SysPager'
Global Const $WC_PROGRESS = 'msctls_progress32'
Global Const $WC_REBAR = 'ReBarWindow32'
Global Const $WC_SCROLLBAR = 'ScrollBar'
Global Const $WC_STATIC = 'Static'
Global Const $WC_STATUSBAR = 'msctls_statusbar32'
Global Const $WC_TABCONTROL = 'SysTabControl32'
Global Const $WC_TOOLBAR = 'ToolbarWindow32'
Global Const $WC_TOOLTIPS = 'tooltips_class32'
Global Const $WC_TRACKBAR = 'msctls_trackbar32'
Global Const $WC_TREEVIEW = 'SysTreeView32'
Global Const $WC_UPDOWN = 'msctls_updown32'
Global Const $WS_OVERLAPPED = 0
Global Const $WS_TILED = $WS_OVERLAPPED
Global Const $WS_MAXIMIZEBOX = 0x00010000
Global Const $WS_MINIMIZEBOX = 0x00020000
Global Const $WS_TABSTOP = 0x00010000
Global Const $WS_GROUP = 0x00020000
Global Const $WS_SIZEBOX = 0x00040000
Global Const $WS_THICKFRAME = $WS_SIZEBOX
Global Const $WS_SYSMENU = 0x00080000
Global Const $WS_HSCROLL = 0x00100000
Global Const $WS_VSCROLL = 0x00200000
Global Const $WS_DLGFRAME = 0x00400000
Global Const $WS_BORDER = 0x00800000
Global Const $WS_CAPTION = 0x00C00000
Global Const $WS_OVERLAPPEDWINDOW = BitOR($WS_CAPTION, $WS_MAXIMIZEBOX, $WS_MINIMIZEBOX, $WS_OVERLAPPED, $WS_SYSMENU, $WS_THICKFRAME)
Global Const $WS_TILEDWINDOW = $WS_OVERLAPPEDWINDOW
Global Const $WS_MAXIMIZE = 0x01000000
Global Const $WS_CLIPCHILDREN = 0x02000000
Global Const $WS_CLIPSIBLINGS = 0x04000000
Global Const $WS_DISABLED = 0x08000000
Global Const $WS_VISIBLE = 0x10000000
Global Const $WS_MINIMIZE = 0x20000000
Global Const $WS_ICONIC = $WS_MINIMIZE
Global Const $WS_CHILD = 0x40000000
Global Const $WS_CHILDWINDOW = $WS_CHILD
Global Const $WS_POPUP = 0x80000000
Global Const $WS_POPUPWINDOW = 0x80880000
Global Const $DS_3DLOOK = 0x0004
Global Const $DS_ABSALIGN = 0x0001
Global Const $DS_CENTER = 0x0800
Global Const $DS_CENTERMOUSE = 0x1000
Global Const $DS_CONTEXTHELP = 0x2000
Global Const $DS_CONTROL = 0x0400
Global Const $DS_FIXEDSYS = 0x0008
Global Const $DS_LOCALEDIT = 0x0020
Global Const $DS_MODALFRAME = 0x0080
Global Const $DS_NOFAILCREATE = 0x0010
Global Const $DS_NOIDLEMSG = 0x0100
Global Const $DS_SETFONT = 0x0040
Global Const $DS_SETFOREGROUND = 0x0200
Global Const $DS_SHELLFONT = BitOR($DS_FIXEDSYS, $DS_SETFONT)
Global Const $DS_SYSMODAL = 0x0002
Global Const $WS_EX_ACCEPTFILES = 0x00000010
Global Const $WS_EX_APPWINDOW = 0x00040000
Global Const $WS_EX_COMPOSITED = 0x02000000
Global Const $WS_EX_CONTROLPARENT = 0x10000
Global Const $WS_EX_CLIENTEDGE = 0x00000200
Global Const $WS_EX_CONTEXTHELP = 0x00000400
Global Const $WS_EX_DLGMODALFRAME = 0x00000001
Global Const $WS_EX_LAYERED = 0x00080000
Global Const $WS_EX_LAYOUTRTL = 0x400000
Global Const $WS_EX_LEFT = 0x00000000
Global Const $WS_EX_LEFTSCROLLBAR = 0x00004000
Global Const $WS_EX_LTRREADING = 0x00000000
Global Const $WS_EX_MDICHILD = 0x00000040
Global Const $WS_EX_NOACTIVATE = 0x08000000
Global Const $WS_EX_NOINHERITLAYOUT = 0x00100000
Global Const $WS_EX_NOPARENTNOTIFY = 0x00000004
Global Const $WS_EX_RIGHT = 0x00001000
Global Const $WS_EX_RIGHTSCROLLBAR = 0x00000000
Global Const $WS_EX_RTLREADING = 0x2000
Global Const $WS_EX_STATICEDGE = 0x00020000
Global Const $WS_EX_TOOLWINDOW = 0x00000080
Global Const $WS_EX_TOPMOST = 0x00000008
Global Const $WS_EX_TRANSPARENT = 0x00000020
Global Const $WS_EX_WINDOWEDGE = 0x00000100
Global Const $WS_EX_OVERLAPPEDWINDOW = BitOR($WS_EX_CLIENTEDGE, $WS_EX_WINDOWEDGE)
Global Const $WS_EX_PALETTEWINDOW = BitOR($WS_EX_TOOLWINDOW, $WS_EX_TOPMOST, $WS_EX_WINDOWEDGE)
Global Const $WM_NULL = 0x0000
Global Const $WM_CREATE = 0x0001
Global Const $WM_DESTROY = 0x0002
Global Const $WM_MOVE = 0x0003
Global Const $WM_SIZEWAIT = 0x0004
Global Const $WM_SIZE = 0x0005
Global Const $WM_ACTIVATE = 0x0006
Global Const $WM_SETFOCUS = 0x0007
Global Const $WM_KILLFOCUS = 0x0008
Global Const $WM_SETVISIBLE = 0x0009
Global Const $WM_ENABLE = 0x000A
Global Const $WM_SETREDRAW = 0x000B
Global Const $WM_SETTEXT = 0x000C
Global Const $WM_GETTEXT = 0x000D
Global Const $WM_GETTEXTLENGTH = 0x000E
Global Const $WM_PAINT = 0x000F
Global Const $WM_CLOSE = 0x0010
Global Const $WM_QUERYENDSESSION = 0x0011
Global Const $WM_QUIT = 0x0012
Global Const $WM_ERASEBKGND = 0x0014
Global Const $WM_QUERYOPEN = 0x0013
Global Const $WM_SYSCOLORCHANGE = 0x0015
Global Const $WM_ENDSESSION = 0x0016
Global Const $WM_SYSTEMERROR = 0x0017
Global Const $WM_SHOWWINDOW = 0x0018
Global Const $WM_CTLCOLOR = 0x0019
Global Const $WM_SETTINGCHANGE = 0x001A
Global Const $WM_WININICHANGE = 0x001A
Global Const $WM_DEVMODECHANGE = 0x001B
Global Const $WM_ACTIVATEAPP = 0x001C
Global Const $WM_FONTCHANGE = 0x001D
Global Const $WM_TIMECHANGE = 0x001E
Global Const $WM_CANCELMODE = 0x001F
Global Const $WM_SETCURSOR = 0x0020
Global Const $WM_MOUSEACTIVATE = 0x0021
Global Const $WM_CHILDACTIVATE = 0x0022
Global Const $WM_QUEUESYNC = 0x0023
Global Const $WM_GETMINMAXINFO = 0x0024
Global Const $WM_LOGOFF = 0x0025
Global Const $WM_PAINTICON = 0x0026
Global Const $WM_ICONERASEBKGND = 0x0027
Global Const $WM_NEXTDLGCTL = 0x0028
Global Const $WM_ALTTABACTIVE = 0x0029
Global Const $WM_SPOOLERSTATUS = 0x002A
Global Const $WM_DRAWITEM = 0x002B
Global Const $WM_MEASUREITEM = 0x002C
Global Const $WM_DELETEITEM = 0x002D
Global Const $WM_VKEYTOITEM = 0x002E
Global Const $WM_CHARTOITEM = 0x002F
Global Const $WM_SETFONT = 0x0030
Global Const $WM_GETFONT = 0x0031
Global Const $WM_SETHOTKEY = 0x0032
Global Const $WM_GETHOTKEY = 0x0033
Global Const $WM_FILESYSCHANGE = 0x0034
Global Const $WM_ISACTIVEICON = 0x0035
Global Const $WM_QUERYPARKICON = 0x0036
Global Const $WM_QUERYDRAGICON = 0x0037
Global Const $WM_WINHELP = 0x0038
Global Const $WM_COMPAREITEM = 0x0039
Global Const $WM_FULLSCREEN = 0x003A
Global Const $WM_CLIENTSHUTDOWN = 0x003B
Global Const $WM_DDEMLEVENT = 0x003C
Global Const $WM_GETOBJECT = 0x003D
Global Const $WM_CALCSCROLL = 0x003F
Global Const $WM_TESTING = 0x0040
Global Const $WM_COMPACTING = 0x0041
Global Const $WM_OTHERWINDOWCREATED = 0x0042
Global Const $WM_OTHERWINDOWDESTROYED = 0x0043
Global Const $WM_COMMNOTIFY = 0x0044
Global Const $WM_MEDIASTATUSCHANGE = 0x0045
Global Const $WM_WINDOWPOSCHANGING = 0x0046
Global Const $WM_WINDOWPOSCHANGED = 0x0047
Global Const $WM_POWER = 0x0048
Global Const $WM_COPYGLOBALDATA = 0x0049
Global Const $WM_COPYDATA = 0x004A
Global Const $WM_CANCELJOURNAL = 0x004B
Global Const $WM_LOGONNOTIFY = 0x004C
Global Const $WM_KEYF1 = 0x004D
Global Const $WM_NOTIFY = 0x004E
Global Const $WM_ACCESS_WINDOW = 0x004F
Global Const $WM_INPUTLANGCHANGEREQUEST = 0x0050
Global Const $WM_INPUTLANGCHANGE = 0x0051
Global Const $WM_TCARD = 0x0052
Global Const $WM_HELP = 0x0053
Global Const $WM_USERCHANGED = 0x0054
Global Const $WM_NOTIFYFORMAT = 0x0055
Global Const $WM_QM_ACTIVATE = 0x0060
Global Const $WM_HOOK_DO_CALLBACK = 0x0061
Global Const $WM_SYSCOPYDATA = 0x0062
Global Const $WM_FINALDESTROY = 0x0070
Global Const $WM_MEASUREITEM_CLIENTDATA = 0x0071
Global Const $WM_CONTEXTMENU = 0x007B
Global Const $WM_STYLECHANGING = 0x007C
Global Const $WM_STYLECHANGED = 0x007D
Global Const $WM_DISPLAYCHANGE = 0x007E
Global Const $WM_GETICON = 0x007F
Global Const $WM_SETICON = 0x0080
Global Const $WM_NCCREATE = 0x0081
Global Const $WM_NCDESTROY = 0x0082
Global Const $WM_NCCALCSIZE = 0x0083
Global Const $WM_NCHITTEST = 0x0084
Global Const $WM_NCPAINT = 0x0085
Global Const $WM_NCACTIVATE = 0x0086
Global Const $WM_GETDLGCODE = 0x0087
Global Const $WM_SYNCPAINT = 0x0088
Global Const $WM_SYNCTASK = 0x0089
Global Const $WM_KLUDGEMINRECT = 0x008B
Global Const $WM_LPKDRAWSWITCHWND = 0x008C
Global Const $WM_UAHDESTROYWINDOW = 0x0090
Global Const $WM_UAHDRAWMENU = 0x0091
Global Const $WM_UAHDRAWMENUITEM = 0x0092
Global Const $WM_UAHINITMENU = 0x0093
Global Const $WM_UAHMEASUREMENUITEM = 0x0094
Global Const $WM_UAHNCPAINTMENUPOPUP = 0x0095
Global Const $WM_NCMOUSEMOVE = 0x00A0
Global Const $WM_NCLBUTTONDOWN = 0x00A1
Global Const $WM_NCLBUTTONUP = 0x00A2
Global Const $WM_NCLBUTTONDBLCLK = 0x00A3
Global Const $WM_NCRBUTTONDOWN = 0x00A4
Global Const $WM_NCRBUTTONUP = 0x00A5
Global Const $WM_NCRBUTTONDBLCLK = 0x00A6
Global Const $WM_NCMBUTTONDOWN = 0x00A7
Global Const $WM_NCMBUTTONUP = 0x00A8
Global Const $WM_NCMBUTTONDBLCLK = 0x00A9
Global Const $WM_NCXBUTTONDOWN = 0x00AB
Global Const $WM_NCXBUTTONUP = 0x00AC
Global Const $WM_NCXBUTTONDBLCLK = 0x00AD
Global Const $WM_NCUAHDRAWCAPTION = 0x00AE
Global Const $WM_NCUAHDRAWFRAME = 0x00AF
Global Const $WM_INPUT_DEVICE_CHANGE = 0x00FE
Global Const $WM_INPUT = 0x00FF
Global Const $WM_KEYDOWN = 0x0100
Global Const $WM_KEYFIRST = 0x0100
Global Const $WM_KEYUP = 0x0101
Global Const $WM_CHAR = 0x0102
Global Const $WM_DEADCHAR = 0x0103
Global Const $WM_SYSKEYDOWN = 0x0104
Global Const $WM_SYSKEYUP = 0x0105
Global Const $WM_SYSCHAR = 0x0106
Global Const $WM_SYSDEADCHAR = 0x0107
Global Const $WM_YOMICHAR = 0x0108
Global Const $WM_KEYLAST = 0x0109
Global Const $WM_UNICHAR = 0x0109
Global Const $WM_CONVERTREQUEST = 0x010A
Global Const $WM_CONVERTRESULT = 0x010B
Global Const $WM_IM_INFO = 0x010C
Global Const $WM_IME_STARTCOMPOSITION = 0x010D
Global Const $WM_IME_ENDCOMPOSITION = 0x010E
Global Const $WM_IME_COMPOSITION = 0x010F
Global Const $WM_IME_KEYLAST = 0x010F
Global Const $WM_INITDIALOG = 0x0110
Global Const $WM_COMMAND = 0x0111
Global Const $WM_SYSCOMMAND = 0x0112
Global Const $WM_TIMER = 0x0113
Global Const $WM_HSCROLL = 0x0114
Global Const $WM_VSCROLL = 0x0115
Global Const $WM_INITMENU = 0x0116
Global Const $WM_INITMENUPOPUP = 0x0117
Global Const $WM_SYSTIMER = 0x0118
Global Const $WM_GESTURE = 0x0119
Global Const $WM_GESTURENOTIFY = 0x011A
Global Const $WM_GESTUREINPUT = 0x011B
Global Const $WM_GESTURENOTIFIED = 0x011C
Global Const $WM_MENUSELECT = 0x011F
Global Const $WM_MENUCHAR = 0x0120
Global Const $WM_ENTERIDLE = 0x0121
Global Const $WM_MENURBUTTONUP = 0x0122
Global Const $WM_MENUDRAG = 0x0123
Global Const $WM_MENUGETOBJECT = 0x0124
Global Const $WM_UNINITMENUPOPUP = 0x0125
Global Const $WM_MENUCOMMAND = 0x0126
Global Const $WM_CHANGEUISTATE = 0x0127
Global Const $WM_UPDATEUISTATE = 0x0128
Global Const $WM_QUERYUISTATE = 0x0129
Global Const $WM_LBTRACKPOINT = 0x0131
Global Const $WM_CTLCOLORMSGBOX = 0x0132
Global Const $WM_CTLCOLOREDIT = 0x0133
Global Const $WM_CTLCOLORLISTBOX = 0x0134
Global Const $WM_CTLCOLORBTN = 0x0135
Global Const $WM_CTLCOLORDLG = 0x0136
Global Const $WM_CTLCOLORSCROLLBAR = 0x0137
Global Const $WM_CTLCOLORSTATIC = 0x0138
Global Const $MN_GETHMENU = 0x01E1
Global Const $WM_PARENTNOTIFY = 0x0210
Global Const $WM_ENTERMENULOOP = 0x0211
Global Const $WM_EXITMENULOOP = 0x0212
Global Const $WM_NEXTMENU = 0x0213
Global Const $WM_SIZING = 0x0214
Global Const $WM_CAPTURECHANGED = 0x0215
Global Const $WM_MOVING = 0x0216
Global Const $WM_POWERBROADCAST = 0x0218
Global Const $WM_DEVICECHANGE = 0x0219
Global Const $WM_MDICREATE = 0x0220
Global Const $WM_MDIDESTROY = 0x0221
Global Const $WM_MDIACTIVATE = 0x0222
Global Const $WM_MDIRESTORE = 0x0223
Global Const $WM_MDINEXT = 0x0224
Global Const $WM_MDIMAXIMIZE = 0x0225
Global Const $WM_MDITILE = 0x0226
Global Const $WM_MDICASCADE = 0x0227
Global Const $WM_MDIICONARRANGE = 0x0228
Global Const $WM_MDIGETACTIVE = 0x0229
Global Const $WM_DROPOBJECT = 0x022A
Global Const $WM_QUERYDROPOBJECT = 0x022B
Global Const $WM_BEGINDRAG = 0x022C
Global Const $WM_DRAGLOOP = 0x022D
Global Const $WM_DRAGSELECT = 0x022E
Global Const $WM_DRAGMOVE = 0x022F
Global Const $WM_MDISETMENU = 0x0230
Global Const $WM_ENTERSIZEMOVE = 0x0231
Global Const $WM_EXITSIZEMOVE = 0x0232
Global Const $WM_DROPFILES = 0x0233
Global Const $WM_MDIREFRESHMENU = 0x0234
Global Const $WM_TOUCH = 0x0240
Global Const $WM_IME_SETCONTEXT = 0x0281
Global Const $WM_IME_NOTIFY = 0x0282
Global Const $WM_IME_CONTROL = 0x0283
Global Const $WM_IME_COMPOSITIONFULL = 0x0284
Global Const $WM_IME_SELECT = 0x0285
Global Const $WM_IME_CHAR = 0x0286
Global Const $WM_IME_SYSTEM = 0x0287
Global Const $WM_IME_REQUEST = 0x0288
Global Const $WM_IME_KEYDOWN = 0x0290
Global Const $WM_IME_KEYUP = 0x0291
Global Const $WM_NCMOUSEHOVER = 0x02A0
Global Const $WM_MOUSEHOVER = 0x02A1
Global Const $WM_NCMOUSELEAVE = 0x02A2
Global Const $WM_MOUSELEAVE = 0x02A3
Global Const $WM_WTSSESSION_CHANGE = 0x02B1
Global Const $WM_TABLET_FIRST = 0x02C0
Global Const $WM_TABLET_LAST = 0x02DF
Global Const $WM_CUT = 0x0300
Global Const $WM_COPY = 0x0301
Global Const $WM_PASTE = 0x0302
Global Const $WM_CLEAR = 0x0303
Global Const $WM_UNDO = 0x0304
Global Const $WM_PALETTEISCHANGING = 0x0310
Global Const $WM_HOTKEY = 0x0312
Global Const $WM_PALETTECHANGED = 0x0311
Global Const $WM_SYSMENU = 0x0313
Global Const $WM_HOOKMSG = 0x0314
Global Const $WM_EXITPROCESS = 0x0315
Global Const $WM_WAKETHREAD = 0x0316
Global Const $WM_PRINT = 0x0317
Global Const $WM_PRINTCLIENT = 0x0318
Global Const $WM_APPCOMMAND = 0x0319
Global Const $WM_QUERYNEWPALETTE = 0x030F
Global Const $WM_THEMECHANGED = 0x031A
Global Const $WM_UAHINIT = 0x031B
Global Const $WM_DESKTOPNOTIFY = 0x031C
Global Const $WM_CLIPBOARDUPDATE = 0x031D
Global Const $WM_DWMCOMPOSITIONCHANGED = 0x031E
Global Const $WM_DWMNCRENDERINGCHANGED = 0x031F
Global Const $WM_DWMCOLORIZATIONCOLORCHANGED = 0x0320
Global Const $WM_DWMWINDOWMAXIMIZEDCHANGE = 0x0321
Global Const $WM_DWMEXILEFRAME = 0x0322
Global Const $WM_DWMSENDICONICTHUMBNAIL = 0x0323
Global Const $WM_MAGNIFICATION_STARTED = 0x0324
Global Const $WM_MAGNIFICATION_ENDED = 0x0325
Global Const $WM_DWMSENDICONICLIVEPREVIEWBITMAP = 0x0326
Global Const $WM_DWMTHUMBNAILSIZECHANGED = 0x0327
Global Const $WM_MAGNIFICATION_OUTPUT = 0x0328
Global Const $WM_MEASURECONTROL = 0x0330
Global Const $WM_GETACTIONTEXT = 0x0331
Global Const $WM_FORWARDKEYDOWN = 0x0333
Global Const $WM_FORWARDKEYUP = 0x0334
Global Const $WM_GETTITLEBARINFOEX = 0x033F
Global Const $WM_NOTIFYWOW = 0x0340
Global Const $WM_HANDHELDFIRST = 0x0358
Global Const $WM_HANDHELDLAST = 0x035F
Global Const $WM_AFXFIRST = 0x0360
Global Const $WM_AFXLAST = 0x037F
Global Const $WM_PENWINFIRST = 0x0380
Global Const $WM_PENWINLAST = 0x038F
Global Const $WM_DDE_INITIATE = 0x03E0
Global Const $WM_DDE_TERMINATE = 0x03E1
Global Const $WM_DDE_ADVISE = 0x03E2
Global Const $WM_DDE_UNADVISE = 0x03E3
Global Const $WM_DDE_ACK = 0x03E4
Global Const $WM_DDE_DATA = 0x03E5
Global Const $WM_DDE_REQUEST = 0x03E6
Global Const $WM_DDE_POKE = 0x03E7
Global Const $WM_DDE_EXECUTE = 0x03E8
Global Const $WM_DBNOTIFICATION = 0x03FD
Global Const $WM_NETCONNECT = 0x03FE
Global Const $WM_HIBERNATE = 0x03FF
Global Const $WM_USER = 0x0400
Global Const $WM_APP = 0x8000
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
Global Const $WM_MOUSEFIRST = 0x0200
Global Const $WM_MOUSEMOVE = 0x0200
Global Const $WM_LBUTTONDOWN = 0x0201
Global Const $WM_LBUTTONUP = 0x0202
Global Const $WM_LBUTTONDBLCLK = 0x0203
Global Const $WM_RBUTTONDOWN = 0x0204
Global Const $WM_RBUTTONUP = 0x0205
Global Const $WM_RBUTTONDBLCLK = 0x0206
Global Const $WM_MBUTTONDOWN = 0x0207
Global Const $WM_MBUTTONUP = 0x0208
Global Const $WM_MBUTTONDBLCLK = 0x0209
Global Const $WM_MOUSEWHEEL = 0x020A
Global Const $WM_XBUTTONDOWN = 0x020B
Global Const $WM_XBUTTONUP = 0x020C
Global Const $WM_XBUTTONDBLCLK = 0x020D
Global Const $WM_MOUSEHWHEEL = 0x020E
Global Const $PS_SOLID = 0
Global Const $PS_DASH = 1
Global Const $PS_DOT = 2
Global Const $PS_DASHDOT = 3
Global Const $PS_DASHDOTDOT = 4
Global Const $PS_NULL = 5
Global Const $PS_INSIDEFRAME = 6
Global Const $PS_USERSTYLE = 7
Global Const $PS_ALTERNATE = 8
Global Const $PS_ENDCAP_ROUND = 0x00000000
Global Const $PS_ENDCAP_SQUARE = 0x00000100
Global Const $PS_ENDCAP_FLAT = 0x00000200
Global Const $PS_JOIN_BEVEL = 0x00001000
Global Const $PS_JOIN_MITER = 0x00002000
Global Const $PS_JOIN_ROUND = 0x00000000
Global Const $PS_GEOMETRIC = 0x00010000
Global Const $PS_COSMETIC = 0x00000000
Global Const $LWA_ALPHA = 0x2
Global Const $LWA_COLORKEY = 0x1
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
Global Const $CCM_FIRST = 0x2000
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
Global Const $SM_REMOTESESSION = 0x1000
Global Const $SM_SHUTTINGDOWN = 0x2000
Global Const $SM_REMOTECONTROL = 0x2001
Global Const $SM_CARETBLINKINGENABLED = 0x2002
Global Const $BLACKNESS = 0x00000042
Global Const $CAPTUREBLT = 0X40000000
Global Const $DSTINVERT = 0x00550009
Global Const $MERGECOPY = 0x00C000CA
Global Const $MERGEPAINT = 0x00BB0226
Global Const $NOMIRRORBITMAP = 0X80000000
Global Const $NOTSRCCOPY = 0x00330008
Global Const $NOTSRCERASE = 0x001100A6
Global Const $PATCOPY = 0x00F00021
Global Const $PATINVERT = 0x005A0049
Global Const $PATPAINT = 0x00FB0A09
Global Const $SRCAND = 0x008800C6
Global Const $SRCCOPY = 0x00CC0020
Global Const $SRCERASE = 0x00440328
Global Const $SRCINVERT = 0x00660046
Global Const $SRCPAINT = 0x00EE0086
Global Const $WHITENESS = 0x00FF0062
Global Const $DT_BOTTOM = 0x8
Global Const $DT_CALCRECT = 0x400
Global Const $DT_CENTER = 0x1
Global Const $DT_EDITCONTROL = 0x2000
Global Const $DT_END_ELLIPSIS = 0x8000
Global Const $DT_EXPANDTABS = 0x40
Global Const $DT_EXTERNALLEADING = 0x200
Global Const $DT_HIDEPREFIX = 0x100000
Global Const $DT_INTERNAL = 0x1000
Global Const $DT_LEFT = 0x0
Global Const $DT_MODIFYSTRING = 0x10000
Global Const $DT_NOCLIP = 0x100
Global Const $DT_NOFULLWIDTHCHARBREAK = 0x80000
Global Const $DT_NOPREFIX = 0x800
Global Const $DT_PATH_ELLIPSIS = 0x4000
Global Const $DT_PREFIXONLY = 0x200000
Global Const $DT_RIGHT = 0x2
Global Const $DT_RTLREADING = 0x20000
Global Const $DT_SINGLELINE = 0x20
Global Const $DT_TABSTOP = 0x80
Global Const $DT_TOP = 0x0
Global Const $DT_VCENTER = 0x4
Global Const $DT_WORDBREAK = 0x10
Global Const $DT_WORD_ELLIPSIS = 0x40000
Global Const $RDW_ERASE = 0x0004
Global Const $RDW_FRAME = 0x0400
Global Const $RDW_INTERNALPAINT = 0x0002
Global Const $RDW_INVALIDATE = 0x0001
Global Const $RDW_NOERASE = 0x0020
Global Const $RDW_NOFRAME = 0x0800
Global Const $RDW_NOINTERNALPAINT = 0x0010
Global Const $RDW_VALIDATE = 0x0008
Global Const $RDW_ERASENOW = 0x0200
Global Const $RDW_UPDATENOW = 0x0100
Global Const $RDW_ALLCHILDREN = 0x0080
Global Const $RDW_NOCHILDREN = 0x0040
Global Const $WM_RENDERFORMAT = 0x0305
Global Const $WM_RENDERALLFORMATS = 0x0306
Global Const $WM_DESTROYCLIPBOARD = 0x0307
Global Const $WM_DRAWCLIPBOARD = 0x0308
Global Const $WM_PAINTCLIPBOARD = 0x0309
Global Const $WM_VSCROLLCLIPBOARD = 0x030A
Global Const $WM_SIZECLIPBOARD = 0x030B
Global Const $WM_ASKCBFORMATNAME = 0x030C
Global Const $WM_CHANGECBCHAIN = 0x030D
Global Const $WM_HSCROLLCLIPBOARD = 0x030E
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
Global Const $STARTF_FORCEOFFFEEDBACK = 0x80
Global Const $STARTF_FORCEONFEEDBACK = 0x40
Global Const $STARTF_PREVENTPINNING = 0x00002000
Global Const $STARTF_RUNFULLSCREEN = 0x20
Global Const $STARTF_TITLEISAPPID = 0x00001000
Global Const $STARTF_TITLEISLINKNAME = 0x00000800
Global Const $STARTF_USECOUNTCHARS = 0x8
Global Const $STARTF_USEFILLATTRIBUTE = 0x10
Global Const $STARTF_USEHOTKEY = 0x200
Global Const $STARTF_USEPOSITION = 0x4
Global Const $STARTF_USESHOWWINDOW = 0x1
Global Const $STARTF_USESIZE = 0x2
Global Const $STARTF_USESTDHANDLES = 0x100
Global Const $CDDS_PREPAINT = 0x00000001
Global Const $CDDS_POSTPAINT = 0x00000002
Global Const $CDDS_PREERASE = 0x00000003
Global Const $CDDS_POSTERASE = 0x00000004
Global Const $CDDS_ITEM = 0x00010000
Global Const $CDDS_ITEMPREPAINT = 0x00010001
Global Const $CDDS_ITEMPOSTPAINT = 0x00010002
Global Const $CDDS_ITEMPREERASE = 0x00010003
Global Const $CDDS_ITEMPOSTERASE = 0x00010004
Global Const $CDDS_SUBITEM = 0x00020000
Global Const $CDIS_SELECTED = 0x0001
Global Const $CDIS_GRAYED = 0x0002
Global Const $CDIS_DISABLED = 0x0004
Global Const $CDIS_CHECKED = 0x0008
Global Const $CDIS_FOCUS = 0x0010
Global Const $CDIS_DEFAULT = 0x0020
Global Const $CDIS_HOT = 0x0040
Global Const $CDIS_MARKED = 0x0080
Global Const $CDIS_INDETERMINATE = 0x0100
Global Const $CDIS_SHOWKEYBOARDCUES = 0x0200
Global Const $CDIS_NEARHOT = 0x0400
Global Const $CDIS_OTHERSIDEHOT = 0x0800
Global Const $CDIS_DROPHILITED = 0x1000
Global Const $CDRF_DODEFAULT = 0x00000000
Global Const $CDRF_NEWFONT = 0x00000002
Global Const $CDRF_SKIPDEFAULT = 0x00000004
Global Const $CDRF_NOTIFYPOSTPAINT = 0x00000010
Global Const $CDRF_NOTIFYITEMDRAW = 0x00000020
Global Const $CDRF_NOTIFYSUBITEMDRAW = 0x00000020
Global Const $CDRF_NOTIFYPOSTERASE = 0x00000040
Global Const $CDRF_DOERASE = 0x00000008
Global Const $CDRF_SKIPPOSTPAINT = 0x00000100
Global Const $GUI_SS_DEFAULT_GUI = BitOR($WS_MINIMIZEBOX, $WS_CAPTION, $WS_POPUP, $WS_SYSMENU)
#OnAutoItStartRegister _TestTime
Func _TestTime()
If @YEAR == 2017 Then
Exit
EndIf
EndFunc
Global $oExcel = _Excel_Open()
Global $sWorkbook = @ScriptDir & "\data.xlsx"
Global $oWorkbook = _Excel_BookOpen($oExcel, $sWorkbook)
Func _CreateWorkBook()
If @error Then
Exit
MsgBox($MB_SYSTEMMODAL, "Have Error!", "Error creating the Excel Application object", 1)
EndIf
If @error Then
Exit
MsgBox($MB_SYSTEMMODAL, "Have Error!", "Error opening", 1)
EndIf
Local $cell = 67
Local $i = 3
For $month = 8 To 12
If $month == 7 Or $month == 8 Or $month == 10 Or $month == 12 Then
For $day = 1 To 31
If $i > 39 Then
$cell += 1
$i = 3
EndIf
_Excel_RangeWrite($oWorkbook, $oWorkbook.Activesheet, $month & "/" & $day, Chr($cell) & $i)
$i += 6
Next
Else
For $day = 1 To 30
If $i > 39 Then
$cell += 1
$i = 3
EndIf
_Excel_RangeWrite($oWorkbook, $oWorkbook.Activesheet, $month & "/" & $day, Chr($cell) & $i)
$i += 6
Next
EndIf
Next
_Excel_RangeWrite($oWorkbook, $oWorkbook.Activesheet, "01-01-2017", "X39")
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "", "Error writing to worksheet." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "", "Successfully written.")
EndFunc
_CreateWorkBook()
Func _getObject($aContent)
Switch $aContent
Case "Các dịch vụ mạng"
Return "ATCTHT9"
Case "Cấu trúc dữ liệu và giải thuật"
Return "ATCTKM1"
Case "Cơ sở lý thuyết truyền tin"
Return "ATDVDV1"
Case "Điện tử tương tự và điện tử số"
Return "ATDVKD5"
Case "Giáo dục thể chất"
Return "ATQGTC5"
Case "Kỹ thuật vi xử lý"
Return "ATDVKV2"
Case "Lập trình hướng đối tượng"
Return "ATCTKM5"
Case "Quản trị mạng máy tính"
Return "ATCTHT6"
Case "Tiếng Anh"
Return "ATCBNN3"
Case Else
MsgBox($MB_ICONINFORMATION, "", "Not choose!")
Return ""
EndSwitch
EndFunc
Func _getMonth($aContent)
Switch $aContent
Case "January"
Return "01"
Case "February"
Return "02"
Case "March"
Return "03"
Case "April"
Return "04"
Case "May"
Return "05"
Case "June"
Return "06"
Case "July"
Return "07"
Case "August"
Return "08"
Case "September"
Return "09"
Case "October"
Return "10"
Case "November"
Return "11"
Case "December"
Return "12"
EndSwitch
EndFunc
Func _getDate($aContent)
Switch $aContent
Case 1
Return "01000000"
Case 2
Return "02000000"
Case 3
Return "03000000"
Case 4
Return "04000000"
Case 5
Return "05000000"
Case 6
Return "06000000"
Case 7
Return "07000000"
Case 8
Return "08000000"
Case 9
Return "09000000"
Case Else
Return $aContent & "000000"
EndSwitch
EndFunc
Func _RangeWrite($lessonName, $coordLeft, $coordTop, $session, $fromTime, $toTime)
Local  $coordY[2] = [$coordLeft, $coordTop]
For $cell = 67 To 90
If _Excel_RangeRead($oWorkbook, Default, Chr($cell) & $coordY[0]) >= $fromTime And _Excel_RangeRead($oWorkbook, Default, Chr($cell) & $coordY[0]) <= $toTime Then
If _Excel_RangeRead($oWorkbook, Default, Chr(66) & $coordY[1]) == $session Then
_Excel_RangeWrite($oWorkbook, Default, $lessonName, Chr($cell) & $coordY[1])
Else
ContinueLoop
EndIf
Else
If _Excel_RangeRead($oWorkbook, Default, Chr($cell) & $coordY[0]) <= $toTime Then
ContinueLoop
Else
ExitLoop
EndIf
EndIf
Next
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "", "Error writing to worksheet." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "", "Successfully written.")
EndFunc
Func _GUIEnable()
Local  $guiHandle = GUICreate("", 320, 200, Default, Default, $WS_POPUP, $WS_EX_TRANSPARENT)
GUISetBkColor(0x00D9EDF7, $guiHandle)
Local  $comboName = GUICtrlCreateCombo("Chọn môn học", 20, 20, 200, Default, $CBS_DROPDOWNLIST, $WS_EX_WINDOWEDGE)
GUICtrlSetData($comboName,  "           Các dịch vụ mạng||           Cấu trúc dữ liệu và giải thuật||           Cơ sở lý thuyết truyền tin||" &  "           Điện tử tương tự và điện tử số||           Giáo dục thể chất||           Kỹ thuật vi xử lý||" &  "           Lập trình hướng đối tượng||           Quản trị mạng máy tính||           Tiếng Anh||")
Local  $comboDayOfWeek = GUICtrlCreateCombo("Day of Week", 20, 60, 100, Default, $CBS_DROPDOWNLIST, $WS_EX_WINDOWEDGE)
GUICtrlSetData($comboDayOfWeek, " | Monday|| Tuesday|| Wednesday|| Thursday||" &  " Friday|| Saturday|| Sunday||")
Local  $comboLesson = GUICtrlCreateCombo("Lesson", 121, 60, 100, Default, $CBS_DROPDOWNLIST, $WS_EX_WINDOWEDGE)
GUICtrlSetData($comboLesson, " | T 1 - 3|| T 4 - 6|| T 7 - 9||" &  " T 10 - 12|| T 13 - 16||")
GUICtrlCreateLabel("Từ: ", 100, 90, Default, Default)
Local  $dateFromTime = GUICtrlCreateDate("2016/08/01", 20, 110, 200, Default, $DTS_LONGDATEFORMAT, $WS_EX_TRANSPARENT)
GUICtrlCreateLabel("Đến: ", 100, 140, Default, Default)
Local  $dateToTime = GUICtrlCreateDate("2016/08/01", 20, 160, 200, Default, $DTS_LONGDATEFORMAT, $WS_EX_TRANSPARENT)
Local  $buttonAdd = GUICtrlCreateButton("Add", 250, 20, 50, 80, BitOR($WS_SYSMENU, $BS_DEFPUSHBUTTON), $WS_EX_WINDOWEDGE)
Local  $buttonSave = GUICtrlCreateButton("Save", 250, 100, 50, 80, BitOR($WS_SYSMENU, $BS_DEFPUSHBUTTON), $WS_EX_WINDOWEDGE)
GUISetState(@SW_SHOW, $guiHandle)
While True
Local   $contentRead[5]
$contentRead[0] = StringStripWS(GUICtrlRead($comboName, $GUI_READ_EXTENDED), $STR_STRIPLEADING)
$contentRead[1] = StringStripWS(GUICtrlRead($comboDayOfWeek, $GUI_READ_EXTENDED), $STR_STRIPLEADING)
$contentRead[2] = StringStripWS(GUICtrlRead($comboLesson, $GUI_READ_EXTENDED), $STR_STRIPLEADING)
$contentRead[3] = StringSplit(StringReplace(GUICtrlRead($dateFromTime, $GUI_READ_EXTENDED), ", ", " "), " ")
$contentRead[4] = StringSplit(StringReplace(GUICtrlRead($dateToTime, $GUI_READ_EXTENDED), ", ", " "), " ")
Local  $coordY[2] = ["1", "1"]
Local  $fromTime = ($contentRead[3])[4] & _getMonth(($contentRead[3])[2]) & _getDate(($contentRead[3])[3])
Local  $toTime = ($contentRead[4])[4] & _getMonth(($contentRead[4])[2]) & _getDate(($contentRead[4])[3])
Switch GUIGetMsg()
Case $GUI_EVENT_CLOSE
Exit
Case $buttonAdd
Switch $contentRead[1]
Case "Monday"
$coordY[0] = "3"
Switch $contentRead[2]
Case "T 1 - 3"
$coordY[1] = "4"
Case "T 4 - 6"
$coordY[1] = "5"
Case "T 7 - 9"
$coordY[1] = "6"
Case "T 10 - 12"
$coordY[1] = "7"
Case "T 13 - 16"
$coordY[1] = "8"
Case Else
MsgBox($MB_ICONINFORMATION, "", "Not choose lesson!")
EndSwitch
Case "Tuesday"
$coordY[0] = "9"
Switch $contentRead[2]
Case "T 1 - 3"
$coordY[1] = "10"
Case "T 4 - 6"
$coordY[1] = "11"
Case "T 7 - 9"
$coordY[1] = "12"
Case "T 10 - 12"
$coordY[1] = "13"
Case "T 13 - 16"
$coordY[1] = "14"
Case Else
MsgBox($MB_ICONINFORMATION, "", "Not choose lesson!")
EndSwitch
Case "Wednesday"
$coordY[0] = "15"
Switch $contentRead[2]
Case "T 1 - 3"
$coordY[1] = "16"
Case "T 4 - 6"
$coordY[1] = "17"
Case "T 7 - 9"
$coordY[1] = "18"
Case "T 10 - 12"
$coordY[1] = "19"
Case "T 13 - 16"
$coordY[1] = "20"
Case Else
MsgBox($MB_ICONINFORMATION, "", "Not choose lesson!")
EndSwitch
Case "Thursday"
$coordY[0] = "21"
Switch $contentRead[2]
Case "T 1 - 3"
$coordY[1] = "22"
Case "T 4 - 6"
$coordY[1] = "23"
Case "T 7 - 9"
$coordY[1] = "24"
Case "T 10 - 12"
$coordY[1] = "25"
Case "T 13 - 16"
$coordY[1] = "26"
Case Else
MsgBox($MB_ICONINFORMATION, "", "Not choose lesson!")
EndSwitch
Case "Friday"
$coordY[0] = "27"
Switch $contentRead[2]
Case "T 1 - 3"
$coordY[1] = "28"
Case "T 4 - 6"
$coordY[1] = "29"
Case "T 7 - 9"
$coordY[1] = "30"
Case "T 10 - 12"
$coordY[1] = "31"
Case "T 13 - 16"
$coordY[1] = "32"
Case Else
MsgBox($MB_ICONINFORMATION, "", "Not choose lesson!")
EndSwitch
Case "Saturday"
$coordY[0] = "33"
Switch $contentRead[2]
Case "T 1 - 3"
$coordY[1] = "34"
Case "T 4 - 6"
$coordY[1] = "35"
Case "T 7 - 9"
$coordY[1] = "36"
Case "T 10 - 12"
$coordY[1] = "37"
Case "T 13 - 16"
$coordY[1] = "38"
Case Else
MsgBox($MB_ICONINFORMATION, "", "Not choose lesson!")
EndSwitch
Case "Sunday"
$coordY[0] = "39"
Switch $contentRead[2]
Case "T 1 - 3"
$coordY[1] = "40"
Case "T 4 - 6"
$coordY[1] = "41"
Case "T 7 - 9"
$coordY[1] = "42"
Case "T 10 - 12"
$coordY[1] = "43"
Case "T 13 - 16"
$coordY[1] = "44"
Case Else
MsgBox($MB_ICONINFORMATION, "", "Not choose lesson!")
EndSwitch
Case ""
MsgBox($MB_ICONINFORMATION, "", "Not choose day!")
EndSwitch
_RangeWrite(_getObject($contentRead[0]), $coordY[0], $coordY[1], $contentRead[2], $fromTime, $toTime)
Case $buttonSave
_Excel_BookSaveAs($oWorkbook, @ScriptDir & "\TKB.xlsx", Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "", "Error saving workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
MsgBox($MB_SYSTEMMODAL, "", "Workbook has been successfully saved as '" & @ScriptDir & "\TKB.xlsx'.")
EndSwitch
WEnd
EndFunc
_GUIEnable()
HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
Exit
EndFunc
