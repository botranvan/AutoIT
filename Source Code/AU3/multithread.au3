
Func ThreadProc2($lpParam)
  MsgBox(0,"MessageBox","This is From Thread 2")
  Return 0
EndFunc

Func ThreadProc3($lpParam)
  MsgBox(0,"MessageBox","This is From Thread 3")
  Return 0
EndFunc

Func ThreadProc4($lpParam)
  MsgBox(0,"MessageBox","This is From Thread 4")
  Return 0
EndFunc

Local $TP[3],$T[3],$hT=DllStructCreate("hwnd[3]"),$phT=DllStructGetPtr($hT)

MsgBox(0,"Main MessageBox","This Stops The Main Thread 1")

For $I=0 To 2
    $TP[$I]=DLLCallbackRegister("ThreadProc"&$I+2,"int","int")
    $T[$I]=DllStructCreate("int")
    $Thread=DllCall("Kernel32.dll","hwnd","CreateThread","ptr",0, _
                                                         "int",0, _
                                                         "ptr",DllCallbackGetPtr($TP[$I]), _
                                                         "int",0, _
                                                         "int",0, _
                                                         "ptr",DllStructGetPtr($T[$I]))
    DllStructSetData($hT,1,$Thread[0],$I+1)
Next

MsgBox(0,"MessageBox","This is From The Main Thread 1 Again")
DllCall("Kernel32.dll","int","WaitForMultipleObjects","int",3,"ptr",$phT,"int",True,"int",-1)
MsgBox(0,"MessageBox","All Threads Are Complete")

For $I=1 To 3
    DllCall("Kernel32.dll","int","CloseHandle","hwnd",DllStructGetData($hT,1,$I))
Next