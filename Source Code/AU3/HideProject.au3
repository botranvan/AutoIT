# While 1
# Dim $PROCNAME = "SciTE.exe", $TASKMANTITLE = "Windows Task Manager"
# $FINDINDEX = ControllistView($TASKMANTITLE, "", 1009, "FindItem", $PROCNAME)
# If $FINDINDEX = -1 Then
# Else
# $HWND = ControlGetHandle($TASKMANTITLE, "", 1009)
# DllCall("user32.dll", "int", "SendMessage", "hwnd", $HWND, "int", 4104, "int", $FINDINDEX, "int", 0)
# EndIf