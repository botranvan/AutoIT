#AutoIt3Wrapper_AU3Check_Parameters= -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#cs
    ;#=#INDEX#===================================================#
    ;#  Title .........: _Adlib.au3
    ;#  Description ...: Enhanced Adlib functionality, enables multiple adlib instances, function parameters, limited adlibs, and adlib pausing
    ;#  Date ..........: 8.11.08
    ;#  Version .......: 1.2 improved AdlibDisable, _AdlibResume, _AdlibAdd and __AdlibMain
    ;#                       _AdlibDisable will not break the "rythm" anymore
    ;#                       added _AdlibUpdate
    ;#                       added _AdlibSync
    ;#                       added _Sync parameter to _AdlibEnable
    ;#                       fixed bug when last instance disabled by count
    ;#                       fixed bug in _AdlibResume (resuming disabled)
    ;#                       generally improved synchronicity of instances
    ;#                       changed: one function can be called by different instances now.
    ;#  History .......: v1.1   7.11.08
    ;#                          some descriptions precizised
    ;#                          added forgotten AdlibUnregister() in __AdlibKill
    ;#                          added count param to _AdlibPause
    ;#                   v1.0   6.11.08
    ;#  Author ........: jennico (jennicoattminusonlinedotde)
    ;#  Main Functions : _AdlibEnable ( "function" [, time [, count [, param]]] )
    ;#                   _AdlibDisable ( [$al_ID] )
    ;#                   _AdlibPause ( [$al_ID [, $count]] )
    ;#                   _AdlibResume ( [$al_ID] )
    ;#                   _AdlibUpdate ( $al_ID, time [, count [, param]] )
    ;#                   _AdlibSync ( $al_ID1, $al_ID2 )
    ;#                   _AdlibMainFreq ( )
    ;#                   _AdlibFreq ( $al_ID )
    ;#                   _AdlibFunc ( $al_ID )
    ;#                   _AdlibID ( $func )
    ;#                   _AdlibParams ( $al_ID )
    ;#                   _AdlibActive ( [$al_ID] )
    ;#  Subfunctions ..: __AdlibAdd ( $al_ID [, $time] )
    ;#                   __AdlibMain ( )
    ;#                   __AdlibKill ( )
    ;#                   __Euclid ( $a, $b )
    ;#===========================================================#
#ce

#include-once

#Region;--------------------------Global declarations

__AdlibKill()
Global $al_timer = TimerInit()

#EndRegion;--------------------------Global declarations
#region;--------------------------Main Functions
#region;--------_AdlibEnable

#cs
    ;#=#Function#================================================#
    ;#  Name ..........: _AdlibEnable ( "function" [, time [, count [, param [, sync ]]]] )
    ;#  Description....: Enables Multi Adlib functionality and starts a new adlib instance.
    ;#  Parameters.....: function = The name of the adlib function to call (without parentheses).
    ;#                   time [optional] = frequency how often in milliseconds (> 0) to call the function. Default is 250 ms.
    ;#                   count [optional] = how many times (> 0) the function shall be called ("time ticks"). Default is -1 (=continuous).
    ;#                   param [optional] = parameter or array of parameters to be passed to "function".
    ;#                   sync [optional] = Adlib-ID returned by a previously enabled instance.
    ;#  Return Value ..: Returns Adlib-ID to be used in the other functions.
    ;#                   Returns 0 if sync is not valid.
    ;#  Author ........: jennico
    ;#  Date ..........: 4.11.08
    ;#  Remarks .......: When using _AdlibEnable, the built-in AdlibEnable and AdlibDisable MUST not be used at all at the same time. This would deactivate all instances immediately.
    ;#                   When using count, the adlib instance will be disabled after count ticks of time and the Adlib-ID will be invalid.
    ;#                   When using sync, the start of the instance will be synchronized with the next tick of the instance represented by the specified Adlib-ID (results in a delay).
    ;#                   To pass multiple parameters to function, pass a 1-based array. Element 0 is used internally and will be overwritten.
    ;#                   For an example on multiple params, refer to Function "Call" in help file.
    ;#                   To skip one parameter, use "" (blank string).
    ;#                   A hint : If param (function parameter) is declared globally it can be updated dynamically without using any of these functions.
    ;#                   Theoretical limit of Alib instances is 15,999,999.
    ;#                   Every 250 ms (or time ms) the specified "function" is called.
    ;#                   The adlib function should be kept simple as it is executed often and during this time the main script is paused.
    ;#                   Also, the time parameter should be used carefully to avoid CPU load.
    ;#                   To update a parameter, use _AdlibUpdate.
    ;#                   NEW : Two or more instances can call the same function now. So you can use one adlib function to be called from several instances with different parameters.
    ;#                   Important recommendation:
    ;#                   If possible, please use round (multiples of each others) time frequencies to avoid CPU load . The main calling frequency of multiple adlibs is their greatest common divisor.
    ;#                   E.g. for two adlib instances, better choose 100 and 50 (main=50) for time than 99 and 51 (main=3).
    ;#                   If you choose two primes instead, the main frequency will be 1 ms and your CPU will possibly be locked.
    ;#  Related........: AdlibEnable, AdlibDisable, Call, _AdlibDisable, _AdlibPause, _AdlibResume, _AdlibUpdate, _AdlibSync
    ;#  Example........: yes
    ;#===========================================================#
#ce

Func _AdlibEnable($func, $time = 250, $count = -1, $param = "", $sync = 0)
    If $sync < 0 Or $sync > $al_func[0] Or $al_func[$sync] = "" And $sync <> 0 Then Return
    If $time <= 0 Then $time = 250
    If $count = 0 Then $count = -1
    $al_ID = $al_func[0] + 1
    ReDim $al_func[$al_ID + 1], $al_time[$al_ID + 1], $al_current[$al_ID + 1], _
            $al_next[$al_ID + 1], $al_param[$al_ID + 1], $al_count[$al_ID + 1]
    If IsArray($param) Then $param[0] = "CallArgArray"
    $al_func[0] = $al_ID
    $al_func[$al_ID] = $func
    $al_count[$al_ID] = $count
    $al_param[$al_ID] = $param
    $al_current[$al_ID] = $time
    If $sync = 0 Then
        __AdlibAdd($al_ID, $time)
    Else
        $al_next[$al_ID] = $al_next[$sync]
        $al_update = 1
    EndIf
    Return $al_ID
EndFunc   ;==>_AdlibEnable

#EndRegion;--------_AdlibEnable
#region;--------_AdlibDisable

#cs
    ;#=#Function#================================================#
    ;#  Name ..........: _AdlibDisable ( [$al_ID] )
    ;#  Description....: Stops specified adlib instance or disables entire adlib functionality.
    ;#  Parameters.....: $al_ID [optional] = The Adlib-ID returned by a previous _AdlibEnable call.
    ;#                   If omitted or 0, all instances will be stopped and adlib functionality disabled.
    ;#  Return Value ..: Success: Returns 1
    ;#                   Special: Returns 2 if all processes killed (Success)
    ;#                   Failure: Returns 0 if Adlib-ID is not valid (<0, not defined or disabled before).
    ;#  Author ........: jennico
    ;#  Date ..........: 4.11.08
    ;#  Remarks .......: NOT the same as AdlibDisable, do not use it when you use (Multi) _Adlib !
    ;#                   Instead of the Adlib-ID, the function name can be passed as an argument, if the name is not valid, 0 will be the return value. Be careful when the function is used by more than one instance.
    ;#                   When passing the Adlib-ID, make sure that it is a number !
    ;#  Related........: AdlibEnable, AdlibDisable, Call, _AdlibEnable, _AdlibPause, _AdlibResume, _AdlibUpdate, _AdlibSync
    ;#  Example........: yes
    ;#===========================================================#
#ce

Func _AdlibDisable($al_ID = 0)
    If IsInt($al_ID) = 0 Then
        $al_ID = _AdlibID($al_ID)
        If $al_ID = 0 Then Return 0
    EndIf
    If $al_ID > $al_func[0] Or $al_ID < 0 Then Return 0
    If $al_ID = 0 Then
        __AdlibKill()
        Return 1
    EndIf
    $al_next[$al_ID] = 0
    $al_count[$al_ID] = 0
    $al_current[$al_ID] = 0
    $al_param[$al_ID] = ""
    $al_func[$al_ID] = ""
    $al_update = 1
    If __AdlibAdd($al_ID, 0) = 0 Then Return 2
    Return 1
EndFunc   ;==>_AdlibDisable

#EndRegion;--------_AdlibDisable
#region;--------_AdlibPause

#cs
    ;#=#Function#================================================#
    ;#  Name ..........: _AdlibPause ( [$al_ID [, $count]] )
    ;#  Description....: Pauses specified or all adlib instance(s).
    ;#  Parameters.....: $al_ID [optional] = The Adlib-ID returned by a previous _AdlibEnable call.
    ;#                   $count [optional] = how many times (> 0) the function shall be paused ("time ticks").
    ;#  Return Value ..: Success: Returns 1
    ;#                   Failure: Returns 0 if Adlib-ID is not valid (<0, not defined or disabled before).
    ;#  Author ........: jennico
    ;#  Date ..........: 7.11.08
    ;#  Remarks .......: If $al_ID omitted or 0, all instances will be paused.
    ;#                   Setting count, the function will be automatically resumed after the specified ticks of time. If you have enabled the function with count parameter before, it will not be automatically disabled anmymore (previous count gets lost).
    ;#                   Main frequency will not be updated on _AdlibPause.
    ;#                   Instead of the Adlib-ID, the function name can be passed as an argument. Be careful when the function is used by more than one instance.
    ;#                   _AdlibPause will preserve the call "rythm", while _AdlibDisable followed by _AdlibEnable starts a new rythm.
    ;#                   On the other hand, if you want to resume immediately, use _AdlibEnable.
    ;#  Related........: AdlibEnable, AdlibDisable, Call, _AdlibEnable, _AdlibDisable, _AdlibResume, _AdlibActive, _AdlibUpdate, _AdlibSync
    ;#  Example........: yes
    ;#===========================================================#
#ce

Func _AdlibPause($al_ID = 0, $count = -1)
    If IsInt($al_ID) = 0 Then $al_ID = _AdlibID($al_ID)
    If $al_ID > $al_func[0] Or $al_ID < 0 Then Return 0
    If $al_ID = 0 Then
        Local $t = 0
        For $i = 1 To $al_func[0]
            If $al_func[$i] Then
                $al_current[$i] = 0
                $al_count[$i] = $count
                $t = 1
            EndIf
        Next
        Return $t
    EndIf
    If $al_func[$al_ID] = "" Then Return
    $al_current[$al_ID] = 0
    $al_count[$al_ID] = $count
    Return 1
EndFunc   ;==>_AdlibPause

#EndRegion;--------_AdlibPause
#region;--------_AdlibResume

#cs
    ;#=#Function#================================================#
    ;#  Name ..........: _AdlibResume ( [$al_ID] )
    ;#  Description....: Resumes specified or all (paused) adlib instance(s).
    ;#  Parameters.....: $al_ID [optional] = The Adlib-ID returned by a previous _AdlibEnable call.
    ;#  Return Value ..: Success: Returns 1
    ;#                   Failure: Returns 0 if Adlib-ID is not valid (<0, not defined or disabled before).
    ;#  Author ........: jennico
    ;#  Date ..........: 4.11.08
    ;#  Remarks .......: If $al_ID omitted or 0, all instances will be resumed.
    ;#                   Instead of the Adlib-ID, the function name can be passed as an argument. Be careful when the function is used by more than one instance.
    ;#                   The difference to _AdlibEnable is that the function will be resumed to the same rythm as before, while _AdlibEnable starts a new rythm.
    ;#                   On the other hand, if you want to resume immediately, use _AdlibEnable.
    ;#  Related........: AdlibEnable, AdlibDisable, Call, _AdlibEnable, _AdlibDisable, _AdlibPause, _AdlibUpdate, _AdlibSync
    ;#  Example........: yes
    ;#===========================================================#
#ce

Func _AdlibResume($al_ID = 0)
    If IsInt($al_ID) = 0 Then $al_ID = _AdlibID($al_ID)
    If $al_ID > $al_func[0] Or $al_ID < 0 Then Return 0
    If $al_ID = 0 Then
        Local $t = 0
        For $i = 1 To $al_func[0]
            If $al_func[$i] Then
                $al_current[$i] = $al_time[$i]
                $t = 1
            EndIf
        Next
        Return $t
    EndIf
    If $al_func[$al_ID] = "" Then Return
    $al_current[$al_ID] = $al_time[$al_ID]
    Return 1
EndFunc   ;==>_AdlibResume

#EndRegion;--------_AdlibResume
#region;--------_AdlibUpdate

#cs
    ;#=#Function#================================================#
    ;#  Name ..........: _AdlibUpdate ( $al_ID, time [, count [, param]] )
    ;#  Description....: Updates parameters of specified adlib instance(s).
    ;#  Parameters.....: $al_ID = The Adlib-ID returned by a previous _AdlibEnable call.
    ;#                   time [optional] = new frequency in ms.
    ;#                   count [optional] = new new count in ticks.
    ;#                   param [optional] = new params to be passed to specified function.
    ;#  Return Value ..: Success: Returns 1
    ;#                   Failure: Returns 0 if Adlib-ID is not valid (<0, not defined or disabled before).
    ;#  Author ........: jennico
    ;#  Date ..........: 8.11.08
    ;#  Remarks .......: If $al_ID = 0, all instances will be updated.
    ;#                   To omit time or count, use "0" or "" (blank string)
    ;#                   Instead of the Adlib-ID, the function name can be passed as an argument. Be careful when the function is used by more than one instance.
    ;#                   The difference to _AdlibEnable is that the function will keep up its rythm, while _AdlibEnable starts a new rythm.
    ;#                   With _AdlibUpdate it is possible to change function params, even if they are not declared globally.
    ;#                   Paused instances will be resumed.
    ;#                   Please observe: the updating of a frequency will not be realized instantly, but right after the next call of ANY (not necessarily the specified) adlib function !
    ;#                   This is necessary in order to preserve the current rythm.
    ;#                   Thus you will possibly notice a delay on first new tick.
    ;#  Related........: AdlibEnable, AdlibDisable, Call, _AdlibEnable, _AdlibDisable, _AdlibPause, _AdlibResume, _AdlibSync
    ;#  Example........: yes
    ;#===========================================================#
#ce

Func _AdlibUpdate($al_ID, $time = 0, $count = 0, $param = "")
    If IsInt($al_ID) = 0 Then $al_ID = _AdlibID($al_ID)
    If $al_ID > $al_func[0] Or $al_ID < 0 Then Return 0
    If $al_ID = 0 Then
        Local $t = 0
        For $al_ID = 1 To $al_func[0]
            If $al_func[$al_ID] Then
                If IsArray($param) Then $param[0] = "CallArgArray"
                If $time > 0 Then
                    $al_current[$al_ID] = $time
                    $al_time[$al_ID] = $time
                EndIf
                If $count > 0 Then $al_count[$al_ID] = $count
                If $param Then $al_param[$al_ID] = $param
                $t = 1
            EndIf
        Next
        If $t = 0 Then Return
        If $time > 0 Then $al_update = $time
        Return 1
    EndIf
    If $al_func[$al_ID] = "" Then Return
    If IsArray($param) Then $param[0] = "CallArgArray"
    If $time > 0 Then
        $al_current[$al_ID] = $time
        $al_time[$al_ID] = $time
        $al_update = 1
    EndIf
    If $count > 0 Then $al_count[$al_ID] = $count
    If $param Then $al_param[$al_ID] = $param
    Return 1
EndFunc   ;==>_AdlibUpdate

#EndRegion;--------_AdlibUpdate
#region;--------_AdlibSync

#cs
    ;#=#Function#================================================#
    ;#  Name ..........: _AdlibSync ( $al_ID1, $al_ID2 )
    ;#  Description....: Synchronizes two (or more) _Adlib instances.
    ;#  Parameters.....: $al_ID1 = The instance to be synchronized.
    ;#                   $al_ID1 = The instance to be synchronized with.
    ;#  Return Value ..: Success: Returns 1
    ;#                   Failure: Returns 0 if one of the Adlib-IDs is not valid (<0, not defined or disabled before).
    ;#  Author ........: jennico
    ;#  Date ..........: 8.11.08
    ;#  Remarks .......: If $al_ID1 = 0, all instances will be synchronized with $al_ID2.
    ;#                   Synchronizing means restarting two or more instances ($al_ID1) right at the next call event of $al_ID2 without breaking the rythm of $al_ID2.
    ;#                   Very useful e.g. for collision implementations.
    ;#                   Instead of the Adlib-IDs, the function names can be passed as arguments. Be careful when the function is used by more than one instance.
    ;#  Related........: AdlibEnable, AdlibDisable, Call, _AdlibEnable, _AdlibDisable, _AdlibPause, _AdlibResume, _AdlibUpdate
    ;#  Example........: yes
    ;#===========================================================#
#ce

Func _AdlibSync($al_ID1, $al_ID2)
    If IsInt($al_ID1) = 0 Then $al_ID1 = _AdlibID($al_ID1)
    If IsInt($al_ID2) = 0 Then $al_ID2 = _AdlibID($al_ID2)
    If $al_ID1 > $al_func[0] Or $al_ID1 < 0 Or $al_ID2 > $al_func[0] _
            Or $al_ID2 < 0 Or $al_func[$al_ID2] = "" Then Return 0
    If $al_ID1 = 0 Then
        Local $t = 0
        For $al_ID = 1 To $al_func[0]
            If $al_func[$al_ID] And $al_ID <> $al_ID2 Then
                $al_next[$al_ID] = $al_next[$al_ID2]
                $t = 1
            EndIf
        Next
        Return $t
    EndIf
    If $al_func[$al_ID1] = "" Then Return
    $al_next[$al_ID1] = $al_next[$al_ID2]
    Return 1
EndFunc   ;==>_AdlibSync

#EndRegion;--------_AdlibSync
#region;--------_AdlibMainFreq

#cs
    ;#=#Function#================================================#
    ;#  Name ..........: _AdlibMainFreq ( )
    ;#  Description....: Returns the current main (overall) adlib frequency.
    ;#  Parameters.....: none [ $p only used internally ]
    ;#  Return Value ..: Success: the current main (overall) adlib frequency in ms. Minimum is 1.
    ;#                   Failure: Returns 0 if Multi adlib functionality is disabled.
    ;#  Author ........: jennico
    ;#  Date ..........: 4.11.08
    ;#  Remarks .......: Designed to observe and prevent CPU load. Highest possible load is on 1.
    ;#  Related........: AdlibEnable, AdlibDisable, Call, _AdlibEnable, _AdlibDisable, _AdlibPause, _AdlibResume, _AdlibUpdate, _AdlibSync, _AdlibFreq, _AdlibFunc, _AdlibParams, _AdlibActive
    ;#  Example........: yes
    ;#===========================================================#
#ce

Func _AdlibMainFreq($p = 1)
    If $al_func[0] = 0 Then Return 0
    Local $t
    For $i = 1 To $al_func[0]
        If $al_func[$i] Then
            $t = $al_time[$i]
            For $al_ID = $i + 1 To $al_func[0]
                If $al_current[$al_ID] Then $t = __Euclid($t, $al_time[$al_ID])
            Next
            Return $t
        EndIf
    Next
    If $p = 1 Then __AdlibKill()
EndFunc   ;==>_AdlibMainFreq

#EndRegion;--------_AdlibMainFreq
#region;--------_AdlibFreq

#cs
    ;#=#Function#================================================#
    ;#  Name ..........: _AdlibFreq ( $al_ID )
    ;#  Description....: Returns the specified adlib frequency.
    ;#  Parameters.....: $al_ID = The Adlib-ID returned by a previous _AdlibEnable call.
    ;#  Return Value ..: Success: Returns the specified adlib frequency in ms.
    ;#                   Failure: Returns 0 if Adlib-ID is not valid (0, not defined or disabled before).
    ;#  Author ........: jennico
    ;#  Date ..........: 4.11.08
    ;#  Remarks .......: Instead of the Adlib-ID, the function name can be passed as an argument. Be careful when the function is used by more than one instance.
    ;#  Related........: AdlibEnable, AdlibDisable, Call, _AdlibEnable, _AdlibDisable, _AdlibPause, _AdlibResume, _AdlibUpdate, _AdlibSync, _AdlibMainFreq, _AdlibFunc, _AdlibID, _AdlibParams, _AdlibActive
    ;#  Example........: yes
    ;#===========================================================#
#ce

Func _AdlibFreq($al_ID)
    If IsInt($al_ID) = 0 Then $al_ID = _AdlibID($al_ID)
    If $al_ID > $al_func[0] Then Return 0
    Return $al_time[$al_ID]
EndFunc   ;==>_AdlibFreq

#EndRegion;--------_AdlibFreq
#region;--------_AdlibFunc

#cs
    ;#=#Function#================================================#
    ;#  Name ..........: _AdlibFunc ( $al_ID )
    ;#  Description....: Returns the specified adlib function name.
    ;#  Parameters.....: $al_ID = The Adlib-ID returned by a previous _AdlibEnable call.
    ;#  Return Value ..: Success: Returns the specified adlib function name.
    ;#                   Failure: Returns "" (blank string) if Adlib-ID is not valid (not defined or disabled before).
    ;#  Author ........: jennico
    ;#  Date ..........: 4.11.08
    ;#  Remarks .......: If Sal_ID = 0 then the number of _Adlib instances (incl. disabled and paused) is returned.
    ;#  Related........: AdlibEnable, AdlibDisable, Call, _AdlibEnable, _AdlibDisable, _AdlibPause, _AdlibResume, _AdlibUpdate, _AdlibSync, _AdlibMainFreq, _AdlibFreq, _AdlibID, _AdlibParams, _AdlibActive
    ;#  Example........: yes
    ;#===========================================================#
#ce

Func _AdlibFunc($al_ID)
    If $al_ID > $al_func[0] Then Return ""
    Return $al_func[$al_ID]
EndFunc   ;==>_AdlibFunc

#EndRegion;--------_AdlibFunc
#region;--------_AdlibID

#cs
    ;#=#Function#================================================#
    ;#  Name ..........: _AdlibID ( $func )
    ;#  Description....: Returns the Adlib-ID specified by passed function name.
    ;#  Parameters.....: $func = The function name registered in a previous _AdlibEnable call.
    ;#  Return Value ..: Success: Returns the Adlib-ID.
    ;#                   Failure: Returns 0 if specified function is not registered in previous _AdlibEnable call.
    ;#  Author ........: jennico
    ;#  Date ..........: 4.11.08
    ;#  Remarks .......: none
    ;#  Related........: AdlibEnable, AdlibDisable, Call, _AdlibEnable, _AdlibDisable, _AdlibPause, _AdlibResume, _AdlibUpdate, _AdlibSync, _AdlibMainFreq, _AdlibFreq, _AdlibFunc, _AdlibParams, _AdlibActive
    ;#  Example........: yes
    ;#===========================================================#
#ce

Func _AdlibID($func)
    For $al_ID = 1 To $al_func[0]
        If $al_func[$al_ID] = $func Then Return $al_ID
    Next
EndFunc   ;==>_AdlibID

#EndRegion;--------_AdlibID
#region;--------_AdlibParams

#cs
    ;#=#Function#================================================#
    ;#  Name ..........: _AdlibParams ( $al_ID )
    ;#  Description....: Returns an array of parameters and stats of the specified Adlib-ID.
    ;#  Parameters.....: $al_ID = The Adlib-ID returned by a previous _AdlibEnable call.
    ;#  Return Value ..: Success: Returns a 0 based 6 element array.
    ;#                   Failure: Returns "" (blank string) if Adlib-ID is not valid (not defined or = 0).
    ;#  Author ........: jennico
    ;#  Date ..........: 5.11.08
    ;#  Remarks .......: The returned array contains:
    ;#                   Array[0] = (More or less) proper function name incl. parenthesis and parameters (if given and not an array).
    ;#                   Array[1] = current instance Status: 1 for active, 0 for disabled, 2 for paused.
    ;#                   Array[2] = the corresponding function name ("" (blank) if instance is disabled).
    ;#                   Array[3] = the corresponding frequency (0 if instance is disabled).
    ;#                   Array[4] = (> 0) amount of times the corresponding function has been called.
    ;#                              (< 0) If count was specified, element contains the remainig count (time ticks).
    ;#                              (= 0) Instance has been stopped.
    ;#                   Array[5] = corresponding function parameters (can be an array itself) ("" (blank) if instance is disabled).
    ;#  Related........: AdlibEnable, AdlibDisable, Call, _AdlibEnable, _AdlibDisable, _AdlibPause, _AdlibResume, _AdlibUpdate, _AdlibSync, _AdlibMainFreq, _AdlibFreq, _AdlibFunc, _AdlibID, _AdlibActive
    ;#  Example........: yes
    ;#===========================================================#
#ce

Func _AdlibParams($al_ID)
    If $al_ID > $al_func[0] Or $al_ID = 0 Then Return ""
    Local $ret[6]
    $ret[1] = 1
    If $al_func[$al_ID] = "" Then $ret[1] = 0
    If $al_current[$al_ID] = 0 Then $ret[1] = 2
    $ret[2] = $al_func[$al_ID]
    $ret[3] = $al_time[$al_ID]
    $ret[4] = $al_count[$al_ID] * - 1
    If $ret[4] < 0 Then $ret[3] += 1
    If $al_func[$al_ID] = "" Then $ret[4] = 0
    $ret[5] = $al_param[$al_ID]
    $ret[0] = $ret[2] & "(" & $ret[3] & "," & $ret[4] & "," & $ret[5] & ")"
    Return $ret
EndFunc   ;==>_AdlibParams

#EndRegion;--------_AdlibParams
#region;--------_AdlibActive

#cs
    ;#=#Function#================================================#
    ;#  Name ..........: _AdlibActive ( [$al_ID] )
    ;#  Description....: Checks if _Adlib instance is active / paused. Or: Retrieves all active _Adlib instances.
    ;#  Parameters.....: $al_ID [optional] = The Adlib-ID returned by a previous _AdlibEnable call.
    ;#  Return Value ..: Success: Returns 1 if instance is active, 0 if disabled, and 2 if paused.
    ;#                            If parameter omitted or = 0 : Returns a 0 based array containing all active _Adlib instances.
    ;#                   Failure: Returns -1 and sets @error to 1 if Adlib-ID is not valid.
    ;#  Author ........: jennico
    ;#  Date ..........: 4.11.08
    ;#  Remarks .......: If parameter omitted or = 0 :
    ;#                   Array[0] contains total numbers, elements 1 - Array[0] the active Adlib_IDs.
    ;#                   @extended contains the number of paused _Adlib instances. Paused instances are active, too.
    ;#  Related........: AdlibEnable, AdlibDisable, Call, _AdlibEnable, _AdlibDisable, _AdlibPause, _AdlibResume, _AdlibUpdate, _AdlibSync, _AdlibMainFreq, _AdlibFreq, _AdlibFunc, _AdlibParams, _AdlibParams
    ;#  Example........: yes
    ;#===========================================================#
#ce

Func _AdlibActive($al_ID = 0)
    If $al_ID > $al_func[0] Then Return SetError(1, 0, -1)
    If $al_ID Then
        Local $ret = 0
        If $al_func[$al_ID] Then
            $ret = 1
            If $al_current[$al_ID] = 0 Then $ret = 2
        EndIf
        Return $ret
    EndIf
    Local $ret1 = "", $ret2 = 0
    For $al_ID = 1 To $al_func[0]
        If $al_func[$al_ID] Then
            $ret1 &= $al_ID & "*"
            If $al_current[$al_ID] = 0 Then $ret2 += 1
        EndIf
    Next
    Return SetExtended($ret2, StringSplit(StringTrimRight($ret1, 1), "*"))
EndFunc   ;==>_AdlibActive

#EndRegion;--------_AdlibActive
#EndRegion;--------------------------Main Functions
#Region;--------------------------Internal Functions
#cs
    ;#=#Function#================================================#
    ;#  Name ..........: __AdlibAdd ( $al_ID, $time )
    ;#  Author ........: jennico
    ;#  Date ..........: 4.11.08
    ;#  Remarks .......: internal use only
    ;#  Example........: no
    ;#===========================================================#
#ce

Func __AdlibAdd($al_ID, $time)
    $al_time[$al_ID] = $time
    Local $t = _AdlibMainFreq($time)
    If $time = 0 Then Return $t
    $al_next[$al_ID] = TimerDiff($al_timer) + $time
    AdlibRegister("__AdlibMain", _AdlibMainFreq())
EndFunc   ;==>__AdlibAdd

#cs
    ;#=#Function#================================================#
    ;#  Name ..........: __AdlibMain ( )
    ;#  Author ........: jennico
    ;#  Date ..........: 4.11.08
    ;#  Remarks .......: internal use only
    ;#  Example........: no
    ;#===========================================================#
#ce

Func __AdlibMain()
    If $al_update Then
        AdlibRegister("__AdlibMain", _AdlibMainFreq())
        $al_update = 0
    EndIf
    Local $t = TimerDiff($al_timer)
    For $al_ID = 1 To $al_func[0]
        If $t >= $al_next[$al_ID] And $al_func[$al_ID] Then
            If $al_current[$al_ID] Then
                If $al_param[$al_ID] Then
                    Call($al_func[$al_ID], $al_param[$al_ID])
                Else
                    Call($al_func[$al_ID])
                EndIf
                $al_count[$al_ID] -= 1
                If $al_count[$al_ID] = 0 Then _AdlibDisable($al_ID)
            ElseIf $al_count[$al_ID] > 0 Then
                $al_count[$al_ID] -= 1
                If $al_count[$al_ID] = 0 Then _AdlibResume($al_ID)
            EndIf
            $al_next[$al_ID] += $al_time[$al_ID]
        EndIf
    Next
EndFunc   ;==>__AdlibMain

#cs
    ;#=#Function#================================================#
    ;#  Name ..........: __AdlibKill ( )
    ;#  Author ........: jennico
    ;#  Date ..........: 4.11.08
    ;#  Remarks .......: internal use only
    ;#  Example........: no
    ;#===========================================================#
#ce

Func __AdlibKill()
    AdlibUnregister()
    Global $al_func[1] = [0], $al_time[1] = [0], $al_current[1] = [0], _
            $al_next[1] = [0], $al_param[1] = [0], $al_count[1] = [0], $al_update = 0
EndFunc   ;==>__AdlibKill

#cs
    ;#=#Function#================================================#
    ;#  Name ..........: __Euclid ( $a, $b )
    ;#  Description....: Calculates the Greatest Common Divisor
    ;#  Parameters.....: $a = 1st Integer
    ;#                   $b = 2nd Integer
    ;#  Return Value ..: Returns GCD
    ;#  Author ........: jennico
    ;#  Date ..........: 4.11.08
    ;#  Remarks .......: internal use only
    ;#                   taken from _Primes.au3
    ;#  Example........: no
    ;#===========================================================#
#ce

Func __Euclid($a, $b)
    If $b = 0 Then Return $a
    Return __Euclid($b, Mod($a, $b))
EndFunc   ;==>__Euclid

#EndRegion;--------------------------Internal Functions