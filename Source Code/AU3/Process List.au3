#include <array.au3>; Only for _ArrayDisplay()

$avProcProps = _ProcessListProperties()
_ArrayDisplay($avProcProps, "$avProcProps")

;===============================================================================
; Function Name:    _ProcessListProperties()
; Description:   Get various properties of a process, or all processes
; Call With:       _ProcessListProperties( [$Process [, $sComputer]] )
; Parameter(s):     (optional) $Process - PID or name of a process, default is all
;           (optional) $sComputer - remote computer to get list from, default is local
; Requirement(s):   AutoIt v3.2.4.9+
; Return Value(s):  On Success - Returns a 2D array of processes, as in ProcessList()
;             with additional columns added:
;             [0][0] - Number of processes listed (can be 0 if no matches found)
;             [1][0] - 1st process name
;             [1][1] - 1st process PID
;             [1][2] - 1st process Parent PID
;             [1][3] - 1st process owner
;             [1][4] - 1st process priority (0 = low, 31 = high)
;             [1][5] - 1st process executable path
;             [1][6] - 1st process CPU usage
;             [1][7] - 1st process memory usage
;             [1][8] - 1st process creation date/time = "MM/DD/YYY hh:mm:ss" (hh = 00 to 23)
;             [1][9] - 1st process command line string
;             ...
;             [n][0] thru [n][8] - last process properties
; On Failure:       Returns array with [0][0] = 0 and sets @Error to non-zero (see code below)
; Author(s):        PsaltyDS at http://www.autoitscript.com/forum
; Date/Version:   05/07/2008  --  v1.0.1
; Notes:            If a numeric PID or string process name is provided and no match is found,
;             then [0][0] = 0 and @error = 0 (not treated as an error, same as ProcessList)
;           This function requires admin permissions to the target computer.
;           All properties come from the Win32_Process class in WMI.
;===============================================================================
Func _ProcessListProperties($Process = "", $sComputer = ".")
    Local $sUserName, $sMsg, $sUserDomain, $avProcs
    If $Process = "" Then
        $avProcs = ProcessList()
    Else
        $avProcs = ProcessList($Process)
    EndIf

; Return for no matches
    If $avProcs[0][0] = 0 Then Return $avProcs

; ReDim array for additional property columns
    ReDim $avProcs[$avProcs[0][0] + 1][10]

; Connect to WMI and get process objects
    $oWMI = ObjGet("winmgmts:{impersonationLevel=impersonate}!\\" & $sComputer & "\root\cimv2")
    If IsObj($oWMI) Then
    ; Get collection of all processes from Win32_Process
        $colProcs = $oWMI.ExecQuery("select * from win32_process")
        If IsObj($colProcs) Then
        ; For each process...
            For $oProc In $colProcs
                $sObjName = ObjName($oProc, 1)
                If @error Then ContinueLoop; Skip if process no longer exists
            ; Find it in the array
                For $n = 1 To $avProcs[0][0]
                    If $avProcs[$n][1] = $oProc.ProcessId Then

                    ; [n][2] = Parent PID
                        $avProcs[$n][2] = $oProc.ParentProcessId
                    ; [n][3] = Owner
                        If $oProc.GetOwner($sUserName, $sUserDomain) = 0 Then $avProcs[$n][3] = $sUserDomain & "\" & $sUserName
                    ; [n][4] = Priority
                        $avProcs[$n][4] = $oProc.Priority
                    ; [n][5] = Executable path
                        $avProcs[$n][5] = $oProc.ExecutablePath
                    ; [n][8] = Creation date/time
                        Local $dtmDate = $oProc.CreationDate
                        If $dtmDate <> "" Then
                            $dtmDate = StringMid($dtmDate, 5, 2) & "/" & _
                                    StringMid($dtmDate, 7, 2) & "/" & _
                                    StringLeft($dtmDate, 4) & " " & _
                                    StringMid($dtmDate, 9, 2) & ":" & _
                                    StringMid($dtmDate, 11, 2) & ":" & _
                                    StringMid($dtmDate, 13, 2)
                        EndIf
                        $avProcs[$n][8] = $dtmDate
                    ; [n][9] = Command line string
                        $avProcs[$n][9] = $oProc.CommandLine

                        ExitLoop
                    EndIf
                Next
            Next
        Else
            SetError(2); Error getting process collection from WMI
        EndIf

    ; Get collection of all processes from Win32_PerfFormattedData_PerfProc_Process
    ; Have to use an SWbemRefresher to pull the collection, or all Perf data will be zeros
        Local $oRefresher = ObjCreate("WbemScripting.SWbemRefresher")
        $colProcs = $oRefresher.AddEnum($oWMI, "Win32_PerfFormattedData_PerfProc_Process" ).objectSet
        $oRefresher.Refresh

    ; Time delay before calling refresher
        Local $iTime = TimerInit()
        Do
            Sleep(10)
        Until TimerDiff($iTime) > 100
        $oRefresher.Refresh

    ; Get PerfProc data
        For $oProc In $colProcs
        ; Find it in the array
            For $n = 1 To $avProcs[0][0]
                If $avProcs[$n][1] = $oProc.IDProcess Then
                ; [n][6] = CPU usage
                    $avProcs[$n][6] = $oProc.PercentProcessorTime
                ; [n][7] = memory usage
                    $avProcs[$n][7] = $oProc.WorkingSet
                    ExitLoop
                EndIf
            Next
        Next
    Else
        SetError(1); Error connecting to WMI
    EndIf

; Return array
    Return $avProcs
EndFunc  ;==>_ProcessListProperties