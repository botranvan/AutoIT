
#include <GuiImageList.au3>
#Include <GuiListView.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <file.au3>
#NoTrayIcon

$p_list = ProcessList() ; Lấy danh sách process
Global $num_item=$p_list[0][0]
Global $ar_path_list[$num_item+1]   ;Mảng lưu trữ danh sách đường dẫn đến file có process
Global $ar_process_list[$num_item+1]    ; Mảng lưu trữ danh sách process
Global $ar_PID[$num_item+1]
Global $ar_mem_usage[$num_item+1],$stat
For $i = 1 To $num_item
    $ar_process_list[$i] = $p_list[$i][0]               ; Nhập dữ liệu cho mảng
    $stat=ProcessGetStats($p_list[$i][0],0)
;   $ar_mem_usage[$i]=$stat[0]/1024
    $ar_PID[$i] = $p_list[$i][1]
    $ar_path_list[$i] = _WinAPI_ProcessGetFileName($p_list[$i][0],True) ; Nhập dữ liệu
Next
; Tạo GUI
$GUI = GUICreate("Process with Icon and File Name Image _ AutoItViet.com",700,500)
GUISetIcon('shell32.dll',10)
TraySetIcon('shell32.dll',10)
    $Style = BitOR($LVS_SHOWSELALWAYS, $LVS_NOSORTHEADER, $LVS_REPORT)
    $exStyles = BitOR($LVS_EX_GRIDLINES, $LVS_EX_FULLROWSELECT, $LVS_EX_SUBITEMIMAGES)  ; thêm phần mở rộng để đưa ảnh vào list view
$Listview = GUICtrlCreateListView("Process Name|PID|Mem Usage(KB)|Đường dẫn tới file chạy Process",5,2,690,400,$Style,$exStyles);Lập list
        GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 0, 150)
        GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 1, 50)
        GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 2, 70)
        GUICtrlSendMsg(-1, $LVM_SETCOLUMNWIDTH, 3, 400)
;~~>> Tạo Menu phải chuột
$cmenu = GUICtrlCreateContextMenu($Listview)
$cm_end = GUICtrlCreateMenuItem("Tắt Process",$cmenu)
$cm_goto = GUICtrlCreateMenuItem("Đến thư mục chứa Process",$cmenu)
$bt_ref = GUICtrlCreateButton("Refresh",30,420,100,50)
$bt_end = GUICtrlCreateButton("End Task",200,420,100,50)
$bt_goto = GUICtrlCreateButton("Go to Folder",380,420,100,50)
;~~> Kết thúc Menu phải chuột
;;~~> Kết thúc tạo GUI

GUISetState()
For $i = 1 To $num_item
    GUICtrlCreateListViewItem($ar_process_list[$i]&"|"&$ar_PID[$i]&"|"&$ar_mem_usage[$i]&"|"&$ar_path_list[$i],$Listview)
    If Not GUICtrlSetImage(-1,$ar_path_list[$i]) Then GUICtrlSetImage(-1,'shell32.dll',3)
Next
;;;Add Icon
while 1
    Sleep(10)
    $a = ProcessList()
    If $a[0][0] <> $num_item Then
    Sleep(1000)
    ref()
    EndIf
    Switch GUIGetMsg()
        Case $GUI_event_close
            Exit
            GUIDelete($GUI)
        Case $cm_end
            cm_end()
        Case $bt_end
            cm_end()
        Case $cm_goto
            cm_goto()
        Case $bt_goto
            cm_goto()
        Case $bt_ref
            ref()
    EndSwitch
WEnd
Func cm_end()
            For $i = 1 To $num_item
                If _GUICtrlListView_GetItemSelected($Listview,$i) Then
                    If  MsgBox(1,'Nguy hiểm nào! _ AutoItViet.com',' Bạn chắc không? ') = 1 Then
                        ProcessClose(_GUICtrlListView_GetItemText($Listview,$i))
                        ref()
                    EndIf
                EndIf
            Next
EndFunc

Func cm_goto()
            For $i = 1 To $num_item
                If _GUICtrlListView_GetItemSelected($Listview,$i) Then
                    $path = $ar_path_list[$i+1]
                    ExitLoop
                Else
                    $path=''
                EndIf
            Next
            If $path = '' Then
                MsgBox(0,'Thong bao...','Bạn chưa chọn đường dẫn nào!')
            Else
                Dim $Drive, $Dir, $FName, $Ext
                Local $s = _PathSplit($path, $Drive, $Dir, $FName, $Ext)
                TrayTip('',"Đang đến thư mục "&$s[1]&$s[2],5)
                ShellExecute('','',$s[1]&$s[2])
            EndIf
EndFunc

Func ref()
    _GUICtrlListView_DeleteAllItems($Listview)
    $p_list = ProcessList() ; Lấy danh sách process
    $num_item=$p_list[0][0]
ReDim $ar_path_list[$num_item+1]    ;Mảng lưu trữ danh sách đường dẫn đến file có process
ReDim $ar_process_list[$num_item+1] ; Mảng lưu trữ danh sách process
ReDim $ar_PID[$num_item+1]
ReDim $ar_mem_usage[$num_item+1]
    For $i = 1 To $num_item
        $ar_process_list[$i] = $p_list[$i][0]
        $stat=ProcessGetStats($p_list[$i][0],0)
;       $ar_mem_usage[$i]=$stat[0]/1024
        $ar_PID[$i] = $p_list[$i][1]
        $ar_path_list[$i] = _WinAPI_ProcessGetFileName($p_list[$i][0],True)
        GUICtrlCreateListViewItem($ar_process_list[$i]&"|"&$ar_PID[$i]&"|"&$ar_mem_usage[$i]&"|"&$ar_path_list[$i],$Listview)
        If Not GUICtrlSetImage(-1,$ar_path_list[$i]) Then GUICtrlSetImage(-1,'shell32.dll',3)
    Next
EndFunc

;; ==> Còn đây là hàm lấy đường dẫn process (LVAC đã chia sẻ)
Func _WinAPI_ProcessGetFilename($vProcessID, $bFullPath = False)
; Not a Process ID? Must be a Process Name
If Not IsNumber($vProcessID) Then
$vProcessID = ProcessExists($vProcessID)
; Process Name not found (or invalid parameter?)
If $vProcessID == 0 Then Return SetError(1, 0, "")
EndIf

Local $hProcess, $stFilename, $aRet, $sFilename, $sDLLFunctionName

; Since the parameters and returns are the same for both of these DLL calls, we can keep it all in one function
If $bFullPath Then
$sDLLFunctionName = "GetModuleFileNameEx"
Else
$sDLLFunctionName = "GetModuleBaseName"
EndIf

; Get process handle (lod3n)
Local $hProcess = DllCall("kernel32.dll", "ptr", "OpenProcess", "int", BitOR(0x400, 0x10), "int", 0, "int", $vProcessID)
If @error Or Not IsArray($hProcess) Then Return SetError(2, 0, "")

; Create 'receiving' string buffers and make the call
$stFilename = DllStructCreate("wchar[32767]")
$aRet = DllCall("psapi.dll", "dword", $sDLLFunctionName & "W", "ptr", $hProcess[0], "ptr", Chr(0), "ptr", DllStructGetPtr($stFilename), "dword", 32767)

; Error from either call? Cleanup and exit with error
If @error Or Not IsArray($aRet) Then
; Close the process handle
DllCall("kernel32.dll", "ptr", "CloseHandle", "ptr", $hProcess[0])
; DLLStructDelete()'s:
$stFilename = 0
$hProcess = 0
Return SetError(2, 0, "")
EndIf

;$aRet[0] = size of string copied over, minus null-terminator
;$stFilename should now contain either the filename or full path string (based on $bFullPath)
$sFilename = DllStructGetData($stFilename, 1)

DllCall("kernel32.dll", "ptr", "CloseHandle", "ptr", $hProcess[0])
; DLLStructDelete()'s
$stFilename = 0
$hProcess = 0

Return SetError(0, 0, $sFilename)
EndFunc ;==>_WinAPI_ProcessGetFilename
