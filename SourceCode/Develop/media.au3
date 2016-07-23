;~ #NoTrayIcon
#include<guiconstants.au3>
#include<buttonconstants.au3>
#include<sound.au3>
#include<misc.au3>
#include<date.au3>
#include<listviewconstants.au3>
#include<guilistview.au3>
#include<windowsconstants.au3>

_Singleton("Media player")


Opt("guioneventmode", 1)

#Region GUI
$mediaplayergui = GUICreate("Media player", 219, 279, -1, -1, BitOR($WS_MINIMIZEBOX, $WS_SIZEBOX, $WS_BORDER))
GUISetOnEvent($GUI_EVENT_CLOSE, "close")
GUISetBkColor(0xFFFFFF)
$menufile = GUICtrlCreateMenu("File")
$menufileopen = GUICtrlCreateMenuItem("Open", $menufile)
GUICtrlSetOnEvent(-1, "open")
$menufilequeue = GUICtrlCreateMenuItem("Queue", $menufile)
GUICtrlSetOnEvent(-1, "queue")
$menufileexit = GUICtrlCreateMenuItem("Exit", $menufile)
GUICtrlSetOnEvent(-1, "close")

$menuoptions = GUICtrlCreateMenu("Options")
$menuoptionsrepeat = GUICtrlCreateMenuItem("Repeat", $menuoptions)
GUICtrlSetOnEvent(-1, "repeat")
$menuoptionscolors = GUICtrlCreateMenuItem("Choose Colors", $menuoptions)
GUICtrlSetOnEvent(-1, "colors")
$menuoptionssave = GUICtrlCreateMenuItem("Save Options", $menuoptions)
GUICtrlSetOnEvent(-1, "saveoptions")
GUICtrlSetState(-1, $GUI_CHECKED)

$playpause = GUICtrlCreateButton("Play", 75, 5, 32, 32, $BS_BITMAP)
GUICtrlSetResizing(-1, 802)
GUICtrlSetState($playpause, $GUI_DISABLE)
GUICtrlSetOnEvent(-1, "playpause")
$stop = GUICtrlCreateButton("Stop", 110, 5, 32, 32, $BS_BITMAP)
GUICtrlSetResizing(-1, 802)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetOnEvent(-1, "stop")
$fb = GUICtrlCreateButton("FB", 40, 5, 32, 32, $BS_BITMAP)
GUICtrlSetResizing(-1, 802)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetOnEvent(-1, "fastbackward")
$ff = GUICtrlCreateButton("FF", 145, 5, 32, 32, $BS_BITMAP)
GUICtrlSetResizing(-1, 802)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetOnEvent(-1, "fastforward")
$previous = GUICtrlCreateButton("P", 5, 5, 32, 32, $BS_BITMAP)
GUICtrlSetResizing(-1, 802)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetOnEvent(-1, "previoustrack")
$next = GUICtrlCreateButton("N", 180, 5, 32, 32, $BS_BITMAP)
GUICtrlSetResizing(-1, 802)
GUICtrlSetState(-1, $GUI_DISABLE)
GUICtrlSetOnEvent(-1, "nexttrack")

$timedisplay = GUICtrlCreateLabel("0:00/0:00", 5, 40, 150, 20)
GUICtrlSetResizing(-1, 802)

$listview = GUICtrlCreateListView("Group Repeats|Current|Repeats|Current|Time|Song", 5, 60, 208, 168, BitOR($LVS_NOSORTHEADER, $LVS_SHOWSELALWAYS))
GUICtrlSetResizing(-1, 102)
_GUICtrlListView_HideColumn(-1, 0)
_GUICtrlListView_HideColumn(-1, 1)
_GUICtrlListView_SetColumnWidth(-1, 2, 21)
_GUICtrlListView_SetColumnWidth(-1, 3, 21)
_GUICtrlListView_SetColumnWidth(-1, 4, 37)
_GUICtrlListView_SetColumnWidth(-1, 5, 125)

Dim $autoplayer_AccelTable[1][2] = [["{SPACE}", $playpause]]
GUISetAccelerators($autoplayer_AccelTable)
GUIRegisterMsg($WM_NOTIFY, "WM_NOTIFY")
GUISetState()
#EndRegion GUI
#EndRegion GUI

;~ $playing = 0 - stopped, 1 - playing, 2 - paused, 3 - seeking forward playing, 4 - seeking backward playing, 5 - seeking forward paused, 6 - seeking backward paused
Global $playing, $currentsound, $repeat, $seekspeed, $currentrepeat, $listviewitem, $soundtime, $saveoptions = 1, $currentgrouprepeat = 1
Dim $sounds[1], $repeats[1], $soundopen[1], $soundinfo[1][1], $colors[6], $groups[1][1], $grouprepeats[1]

$colors[0] = 0xFFFFFF;ungrouped
$colors[1] = 0x0000FF;group 1
$colors[2] = 0xFF0000;group 2
$colors[3] = 0xFFFF00;highligt ungrouped
$colors[4] = 0xFFFF00;highlight group 1
$colors[5] = 0xFFFF00;highlight group 2


$timer = TimerInit()
While 1
    Sleep(10)
    If $playing = 1 Then
        If Floor(_SoundPos($soundopen[$currentsound], 2) / 1000) > Floor($soundtime / 1000) Then
            GUICtrlSetData($timedisplay, _trim(_SoundPos($soundopen[$currentsound])) & "/" & $soundinfo[$currentsound][0])
            $soundtime = _SoundPos($soundopen[$currentsound], 2)
        EndIf
        If _SoundPos($soundopen[$currentsound], 2) + 100 > _SoundLength($soundopen[$currentsound], 2) Then
            _SoundStop($soundopen[$currentsound])
            $soundtime = 0
            If $currentrepeat = $repeats[$currentsound] Then
                $currentrepeat = 1
                If $soundinfo[$currentsound][1] <> -1 Then
                    If $groups[$soundinfo[$currentsound][1]][$groups[$soundinfo[$currentsound][1]][0]] = $groups[$soundinfo[$currentsound][1]][$soundinfo[$currentsound][2]] Then
                        If $currentgrouprepeat <> $grouprepeats[$soundinfo[$currentsound][1]] Then
                            $currentgrouprepeat += 1
                            _SoundStop($soundopen[$currentsound])
                            GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                            GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                            $soundtime = 0
                            $currentrepeat = 1
                            $currentsound = $groups[$soundinfo[$currentsound][1]][1]
                            GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
                            GUICtrlSetData($timedisplay, "0:00/" & $soundinfo[$currentsound][0])
                            GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & $currentrepeat & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                            If $playing = 1 Or $playing = 3 Or $playing = 4 Then _SoundPlay($soundopen[$currentsound])
                            If $playing = 4 Then $playing = 1
                        Else
                            For $i = 1 To $groups[$soundinfo[$currentsound][1]][0]
                                GUICtrlSetData($listviewitem[$groups[$soundinfo[$currentsound][1]][$i]][0], $grouprepeats[$soundinfo[$currentsound][1]] & "|" & 0)
                            Next
                            $currentgrouprepeat = 1
                            If $currentsound < UBound($sounds) - 1 Then
                                GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                                GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                                $currentsound += 1
                                _SoundPlay($soundopen[$currentsound])
                            ElseIf $repeat = 1 Then
                                GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                                GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                                $currentsound = 2
                                _SoundPlay($soundopen[$currentsound])
                            Else
                                $currentrepeat = $repeats[$currentsound]
                                stop()
                            EndIf
                            GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
                        EndIf
                    Else
                        If $currentsound < UBound($sounds) - 1 Then
                            GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                            GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                            $currentsound += 1
                            _SoundPlay($soundopen[$currentsound])
                        ElseIf $repeat = 1 Then
                            GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                            GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                            $currentsound = 2
                            _SoundPlay($soundopen[$currentsound])
                        Else
                            $currentrepeat = $repeats[$currentsound]
                            stop()
                        EndIf
                        GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
                    EndIf
                Else
                    If $currentsound < UBound($sounds) - 1 Then
                        GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                        GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                        $currentsound += 1
                        _SoundPlay($soundopen[$currentsound])
                    ElseIf $repeat = 1 Then
                        GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                        GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                        $currentsound = 2
                        _SoundPlay($soundopen[$currentsound])
                    Else
                        $currentrepeat = $repeats[$currentsound]
                        stop()
                    EndIf
                    GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
                EndIf
                If $soundinfo[$currentsound][1] <> -1 Then
                    For $i = 1 To $groups[$soundinfo[$currentsound][1]][0]
                        GUICtrlSetData($listviewitem[$groups[$soundinfo[$currentsound][1]][$i]][0], $grouprepeats[$soundinfo[$currentsound][1]] & "|" & $currentgrouprepeat)
                    Next
                EndIf
            Else
                $currentrepeat += 1
                _SoundPlay($soundopen[$currentsound])
            EndIf
            GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & $currentrepeat & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
            GUICtrlSetData($timedisplay, "0:00/" & $soundinfo[$currentsound][0])
        EndIf
    ElseIf $playing = 3 Or $playing = 5 Then
        If TimerDiff($timer) > 1000 Then
            Local $hour, $min, $sec
            $temp = _SoundPos($soundopen[$currentsound], 2) + $seekspeed * 1000
            If $temp > _SoundLength($soundopen[$currentsound], 2) - 100 Then
                If $currentsound < UBound($sounds) - 1 Then
                    GUICtrlSetData($playpause, "Pause")
                    $playing = 1
                    nexttrack()
                    ContinueLoop
                ElseIf $currentrepeat < $repeats[$currentsound] Then
                    GUICtrlSetData($playpause, "Pause")
                    $playing = 1
                    nexttrack()
                    ContinueLoop
                ElseIf $currentrepeat = $repeats[$currentsound] And $repeat = 1 Then
                    GUICtrlSetData($playpause, "Pause")
                    $playing = 1
                    nexttrack()
                    ContinueLoop
                Else
                    $playing = 0
                    $soundtime = 0
                    _SoundStop($soundopen[$currentsound])
                    GUICtrlSetData($playpause, "Play")
                    GUICtrlSetData($timedisplay, "0:00/" & $soundinfo[$currentsound][0])
                EndIf
            EndIf
            _TicksToTime($temp, $hour, $min, $sec)
            _SoundSeek($soundopen[$currentsound], $hour, $min, $sec)
            $soundtime = _SoundPos($soundopen[$currentsound], 2)
            If $playing = 3 Then _SoundPlay($soundopen[$currentsound])
            GUICtrlSetData($timedisplay, _trim(_SoundPos($soundopen[$currentsound])) & "/" & $soundinfo[$currentsound][0])
            $timer = TimerInit()
        EndIf
    ElseIf $playing = 4 Or $playing = 6 Then
        If TimerDiff($timer) > 1000 Then
            Local $hour, $min, $sec
            $temp = _SoundPos($soundopen[$currentsound], 2) - $seekspeed * 1000
            If $seekspeed * 1000 > _SoundPos($soundopen[$currentsound], 2) - 100 Then
                If $currentsound - 1 >= 2 Then
                    _SoundStop($soundopen[$currentsound])
                    previoustrack()
                    $soundtime = _SoundLength($soundopen[$currentsound], 2) - 2000
                    _TicksToTime($soundtime, $hour, $min, $sec)
                    _SoundSeek($soundopen[$currentsound], $hour, $min, $sec)
                    GUICtrlSetData($timedisplay, _trim(_SoundPos($soundopen[$currentsound])) & "/" & $soundinfo[$currentsound][0])
                    ContinueLoop
                EndIf
                $playing = 0
                $soundtime = 0
                GUICtrlSetData($playpause, "Play")
                GUICtrlSetData($timedisplay, "0:00/" & $soundinfo[$currentsound][0])
                ContinueLoop
            EndIf
            _TicksToTime($temp, $hour, $min, $sec)
            _SoundSeek($soundopen[$currentsound], $hour, $min, $sec)
            $soundtime = _SoundPos($soundopen[$currentsound], 2)
            If $playing = 4 Then _SoundPlay($soundopen[$currentsound])
            GUICtrlSetData($timedisplay, _trim(_SoundPos($soundopen[$currentsound])) & "/" & $soundinfo[$currentsound][0])
            $timer = TimerInit()
        EndIf
    EndIf
WEnd


Func open()
    $path = FileOpenDialog("Open Files", @MyDocumentsDir & "\My Music", "Audio (*.mp3; *.wav)", 7)
    If $path = "" Then Return
    If UBound($sounds) <= 2 Then
        GUICtrlSetState($playpause, $GUI_ENABLE)
        GUICtrlSetState($stop, $GUI_ENABLE)
        GUICtrlSetState($fb, $GUI_ENABLE)
        GUICtrlSetState($ff, $GUI_ENABLE)
        GUICtrlSetState($previous, $GUI_ENABLE)
        GUICtrlSetState($next, $GUI_ENABLE)
    EndIf
    If UBound($sounds) > 1 Then _SoundStop($soundopen[$currentsound])
    _GUICtrlListView_DeleteAllItems($listview)
    $soundtime = 0
    If StringInStr($path, "|") Then
        $sounds = StringSplit($path, "|")
        Dim $soundopen[UBound($sounds)]
        Dim $soundinfo[UBound($sounds)][4]
        For $i = 2 To UBound($sounds) - 1
            $soundopen[$i] = _SoundOpen($sounds[1] & "\" & $sounds[$i])
            $soundinfo[$i][0] = _trim(_SoundLength($soundopen[$i]));length
            $soundinfo[$i][1] = -1;group number
            $soundinfo[$i][2] = -1;song number in group
            $soundinfo[$i][3] = 0;highlight 1 or 2
        Next
    Else
        Dim $sounds[3]
        Dim $soundopen[UBound($sounds)]
        Dim $soundinfo[UBound($sounds)][4]
        $temp = StringSplit($path, "\")
        $sounds[2] = $temp[UBound($temp) - 1]
        $soundopen[2] = _SoundOpen($path)
        $soundinfo[2][0] = _trim(_SoundLength($soundopen[2]))
        $soundinfo[2][1] = -1
        $soundinfo[2][2] = -1
        $soundinfo[2][3] = 0
    EndIf
    Global $listviewitem[UBound($sounds)][7], $repeats[UBound($sounds)]
    For $i = 2 To UBound($sounds) - 1
        $listviewitem[$i][0] = GUICtrlCreateListViewItem("||" & 1 & "|" & 0 & "|" & $soundinfo[$i][0] & "|" & $sounds[$i], $listview)
        $listviewitem[$i][1] = GUICtrlCreateContextMenu($listviewitem[$i][0])
        $listviewitem[$i][2] = GUICtrlCreateMenuItem("Add Repeat", $listviewitem[$i][1])
        GUICtrlSetOnEvent(-1, "addsoundrepeat")
        $listviewitem[$i][3] = GUICtrlCreateMenuItem("Remove Repeat", $listviewitem[$i][1])
        GUICtrlSetOnEvent(-1, "removesoundrepeat")
        $listviewitem[$i][4] = GUICtrlCreateMenuItem("Remove Sound", $listviewitem[$i][1])
        GUICtrlSetOnEvent(-1, "removesound")
        $listviewitem[$i][5] = GUICtrlCreateMenuItem("Make Group", $listviewitem[$i][1])
        GUICtrlSetOnEvent(-1, "makegroup")
        $repeats[$i] = 1
    Next
    $currentsound = 2
    $currentrepeat = 1
    GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & $currentrepeat & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
    GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
    GUICtrlSetData($timedisplay, "0:00/" & $soundinfo[$currentsound][0])
    _SoundPlay($soundopen[2])
    $playing = 1
    GUICtrlSetData($playpause, "Pause")
    _GUICtrlListView_HideColumn($listview, 0)
    _GUICtrlListView_HideColumn($listview, 1)
EndFunc   ;==>open

Func queue()
    $path = FileOpenDialog("Open Files", @MyDocumentsDir & "\My Music", "Audio (*.mp3; *.wav)", 7)
    If $path = "" Then Return
    If UBound($sounds) <= 2 Then
        GUICtrlSetState($playpause, $GUI_ENABLE)
        GUICtrlSetState($stop, $GUI_ENABLE)
        GUICtrlSetState($fb, $GUI_ENABLE)
        GUICtrlSetState($ff, $GUI_ENABLE)
        GUICtrlSetState($previous, $GUI_ENABLE)
        GUICtrlSetState($next, $GUI_ENABLE)
    EndIf
    If StringInStr($path, "|") Then
        $temp = StringSplit($path, "|")
        ReDim $sounds[UBound($sounds) + UBound($temp) - 2]
        ReDim $soundopen[UBound($sounds)]
        ReDim $soundinfo[UBound($sounds)][4]
        For $i = UBound($sounds) - UBound($temp) + 2 To UBound($sounds) - 1
            $sounds[$i] = $temp[$i - UBound($sounds) + UBound($temp)]
            $soundopen[$i] = _SoundOpen($temp[1] & "\" & $sounds[$i])
            $soundinfo[$i][0] = _trim(_SoundLength($soundopen[$i]));length
            $soundinfo[$i][1] = -1;group number
            $soundinfo[$i][2] = -1;song number in group
            $soundinfo[$i][3] = 0;highlight 1 or 2
        Next
        $temp = UBound($temp) - 2
    Else
        ReDim $sounds[UBound($sounds) + 1]
        ReDim $soundopen[UBound($sounds)]
        ReDim $soundinfo[UBound($sounds)][4]
        $temp = StringSplit($path, "\")
        $sounds[UBound($sounds) - 1] = $temp[UBound($temp) - 1]
        $soundopen[UBound($sounds) - 1] = _SoundOpen($path)
        $soundinfo[UBound($sounds) - 1][0] = _trim(_SoundLength($soundopen[2]))
        $soundinfo[UBound($sounds) - 1][1] = -1
        $soundinfo[UBound($sounds) - 1][2] = -1
        $soundinfo[UBound($sounds) - 1][3] = 0
        $temp = 1
    EndIf
    ReDim $listviewitem[UBound($sounds)][7], $repeats[UBound($sounds)]
    For $i = UBound($sounds) - $temp To UBound($sounds) - 1
        $listviewitem[$i][0] = GUICtrlCreateListViewItem("||" & 1 & "|" & 0 & "|" & $soundinfo[$i][0] & "|" & $sounds[$i], $listview)
        $listviewitem[$i][1] = GUICtrlCreateContextMenu($listviewitem[$i][0])
        $listviewitem[$i][2] = GUICtrlCreateMenuItem("Add Repeat", $listviewitem[$i][1])
        GUICtrlSetOnEvent(-1, "addsoundrepeat")
        $listviewitem[$i][3] = GUICtrlCreateMenuItem("Remove Repeat", $listviewitem[$i][1])
        GUICtrlSetOnEvent(-1, "removesoundrepeat")
        $listviewitem[$i][4] = GUICtrlCreateMenuItem("Remove Sound", $listviewitem[$i][1])
        GUICtrlSetOnEvent(-1, "removesound")
        $listviewitem[$i][5] = GUICtrlCreateMenuItem("Make Group", $listviewitem[$i][1])
        GUICtrlSetOnEvent(-1, "makegroup")
        $repeats[$i] = 1
    Next
EndFunc

Func playpause()
    If $playing = 1 Then
        _SoundPause($soundopen[$currentsound])
        $playing = 2
        GUICtrlSetData($playpause, "Play")
    ElseIf $playing = 2 Then
        _SoundPlay($soundopen[$currentsound])
        _SoundResume($soundopen[$currentsound])
        GUICtrlSetData($playpause, "Pause")
        $playing = 1
    ElseIf $playing = 0 Then
        _SoundPlay($soundopen[$currentsound])
        GUICtrlSetData($playpause, "Pause")
        $playing = 1
    ElseIf $playing = 3 Or $playing = 4 Or $playing = 5 Or $playing = 6 Then
        _SoundPlay($soundopen[$currentsound])
        GUICtrlSetData($playpause, "Pause")
        $playing = 1
    EndIf
EndFunc   ;==>playpause

Func stop()
    If $playing = 3 Or $playing = 4 Or $playing = 5 Or $playing = 6 Then
        _SoundPause($soundopen[$currentsound])
        $playing = 2
    Else
        $playing = 0
        $soundtime = 0
        _SoundStop($soundopen[$currentsound])
        GUICtrlSetData($playpause, "Play")
        GUICtrlSetData($timedisplay, "0:00/" & $soundinfo[$currentsound][0])
    EndIf
EndFunc   ;==>stop

Func repeat()
    If $repeat = 0 Then
        $repeat = 1
        GUICtrlSetState($menuoptionsrepeat, $GUI_CHECKED)
    ElseIf $repeat = 1 Then
        $repeat = 0
        GUICtrlSetState($menuoptionsrepeat, $GUI_UNCHECKED)
    EndIf
EndFunc   ;==>repeat

Func nexttrack()
    _SoundStop($soundopen[$currentsound])
    $soundtime = 0
    If $currentrepeat = $repeats[$currentsound] Then
        $currentrepeat = 1
        If $soundinfo[$currentsound][1] <> -1 Then
            If $groups[$soundinfo[$currentsound][1]][$groups[$soundinfo[$currentsound][1]][0]] = $groups[$soundinfo[$currentsound][1]][$soundinfo[$currentsound][2]] Then
                If $currentgrouprepeat <> $grouprepeats[$soundinfo[$currentsound][1]] Then
                    $currentgrouprepeat += 1
                    _SoundStop($soundopen[$currentsound])
                    GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                    GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                    $soundtime = 0
                    $currentrepeat = 1
                    $currentsound = $groups[$soundinfo[$currentsound][1]][1]
                    GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
                    GUICtrlSetData($timedisplay, "0:00/" & $soundinfo[$currentsound][0])
                    GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & $currentrepeat & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                    If $playing = 1 Or $playing = 3 Or $playing = 4 Then _SoundPlay($soundopen[$currentsound])
                    If $playing = 4 Then $playing = 1
                Else
                    For $i = 1 To $groups[$soundinfo[$currentsound][1]][0]
                        GUICtrlSetData($listviewitem[$groups[$soundinfo[$currentsound][1]][$i]][0], $grouprepeats[$soundinfo[$currentsound][1]] & "|" & 0)
                    Next
                    $currentgrouprepeat = 1
                    If $currentsound < UBound($sounds) - 1 Then
                        GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                        GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                        $currentsound += 1
                    Else
                        GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                        GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                        $currentsound = 2
                    EndIf
                    GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
                EndIf
            Else
                If $currentsound < UBound($sounds) - 1 Then
                    GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                    GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                    $currentsound += 1
                Else
                    GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                    GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                    $currentsound = 2
                EndIf
                GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
            EndIf
        Else
            If $currentsound < UBound($sounds) - 1 Then
                GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                $currentsound += 1
            Else
                GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                $currentsound = 2
            EndIf
            GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
        EndIf
        If $soundinfo[$currentsound][1] <> -1 Then
            For $i = 1 To $groups[$soundinfo[$currentsound][1]][0]
                GUICtrlSetData($listviewitem[$groups[$soundinfo[$currentsound][1]][$i]][0], $grouprepeats[$soundinfo[$currentsound][1]] & "|" & $currentgrouprepeat)
            Next
        EndIf
    Else
        $currentrepeat += 1
    EndIf
    GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & $currentrepeat & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
    GUICtrlSetData($timedisplay, "0:00/" & $soundinfo[$currentsound][0])
    If $playing = 1 Or $playing = 3 Or $playing = 4 Then _SoundPlay($soundopen[$currentsound])
EndFunc   ;==>nexttrack

Func previoustrack()
    _SoundStop($soundopen[$currentsound])
    $soundtime = 0
    If $soundinfo[$currentsound][1] <> -1 Then
        If $currentsound = $groups[$soundinfo[$currentsound][1]][1] Then
            If $currentgrouprepeat > 1 Then
                If $currentrepeat = 1 Then
                    GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                    GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                    $currentsound = $groups[$soundinfo[$currentsound][1]][$groups[$soundinfo[$currentsound][1]][0]]
                    $currentgrouprepeat -= 1
                    $currentrepeat = $repeats[$currentsound]
                    GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
                    For $i = 1 To $groups[$soundinfo[$currentsound][1]][0]
                        GUICtrlSetData($listviewitem[$groups[$soundinfo[$currentsound][1]][$i]][0], $grouprepeats[$soundinfo[$currentsound][1]] & "|" & $currentgrouprepeat)
                    Next
                Else
                    $currentrepeat -= 1
                EndIf
            Else
                If $currentrepeat = 1 Then
                    For $i = 1 To $groups[$soundinfo[$currentsound][1]][0]
                        GUICtrlSetData($listviewitem[$groups[$soundinfo[$currentsound][1]][$i]][0], $grouprepeats[$soundinfo[$currentsound][1]] & "|" & 0)
                    Next
                    GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                    GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                    If $currentsound > 2 Then
                        $currentsound -= 1
                    Else
                        $currentsound = UBound($sounds) - 1
                    EndIf
                    $currentrepeat = $repeats[$currentsound]
                    GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
                    If $soundinfo[$currentsound][1] <> -1 Then
                        $currentgrouprepeat = $grouprepeats[$soundinfo[$currentsound][1]]
                        For $i = 1 To $groups[$soundinfo[$currentsound][1]][0]
                            GUICtrlSetData($listviewitem[$groups[$soundinfo[$currentsound][1]][$i]][0], $grouprepeats[$soundinfo[$currentsound][1]] & "|" & $currentgrouprepeat)
                        Next
                    EndIf
                Else
                    $currentrepeat -= 1
                EndIf
            EndIf
        Else
            If $currentrepeat = 1 Then
                GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                If $currentsound > 2 Then
                    $currentsound -= 1
                Else
                    $currentsound = UBound($sounds) - 1
                EndIf
                $currentrepeat = $repeats[$currentsound]
                GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
            Else
                $currentrepeat -= 1
            EndIf
        EndIf
    Else
        If $currentrepeat = 1 Then
            GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
            GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
            If $currentsound > 2 Then
                $currentsound -= 1
            Else
                $currentsound = UBound($sounds) - 1
            EndIf
            $currentrepeat = $repeats[$currentsound]
            GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
            If $soundinfo[$currentsound][1] <> -1 Then
                $currentgrouprepeat = $grouprepeats[$soundinfo[$currentsound][1]]
                For $i = 1 To $groups[$soundinfo[$currentsound][1]][0]
                    GUICtrlSetData($listviewitem[$groups[$soundinfo[$currentsound][1]][$i]][0], $grouprepeats[$soundinfo[$currentsound][1]] & "|" & $currentgrouprepeat)
                Next
            EndIf
        Else
            $currentrepeat -= 1
        EndIf
    EndIf
    GUICtrlSetData($timedisplay, "0:00/" & $soundinfo[$currentsound][0])
    GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & $currentrepeat & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
    If $playing = 1 Or $playing = 3 Or $playing = 4 Then _SoundPlay($soundopen[$currentsound])
EndFunc   ;==>previoustrack

Func fastforward()
    GUICtrlSetData($playpause, "Play")
    If $playing = 3 Or $playing = 5 Then
        $seekspeed *= 2
    ElseIf $playing = 1 Or $playing = 4 Then
        $seekspeed = 2
        $playing = 3
    Else
        $seekspeed = 2
        $playing = 5
    EndIf
EndFunc   ;==>fastforward

Func fastbackward()
    GUICtrlSetData($playpause, "Play")
    If $playing = 4 Or $playing = 6 Then
        $seekspeed *= 2
    ElseIf $playing = 1 Or $playing = 3 Then
        $seekspeed = 2
        $playing = 4
    Else
        $seekspeed = 2
        $playing = 6
    EndIf
EndFunc   ;==>fastbackward

Func addsoundrepeat()
    $selected = _GUICtrlListView_GetSelectedIndices($listview, True)
    For $i = 1 To UBound($selected) - 1
        $selected[$i] += 2
        $temp = 0
        If $currentsound = $selected[$i] Then $temp = $currentrepeat
        $repeats[$selected[$i]] += 1
        GUICtrlSetData($listviewitem[$selected[$i]][0], "||" & $repeats[$selected[$i]] & "|" & $temp & "|" & $soundinfo[$selected[$i]][0] & "|" & $sounds[$selected[$i]])
    Next
EndFunc   ;==>addsoundrepeat

Func removesoundrepeat()
    $selected = _GUICtrlListView_GetSelectedIndices($listview, True)
    For $i = 1 To UBound($selected) - 1
        $selected[$i] += 2
        $temp = 0
        If $currentsound = $selected[$i] Then
            If $repeats[$selected[$i]] = $currentrepeat Then
                If $repeats[$selected[$i]] <> 1 Then
                    _SoundStop($soundopen[$currentsound])
                    $currentrepeat = 1
                    If $currentsound < UBound($sounds) - 1 Then
                        $repeats[$selected[$i]] -= 1
                        GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$selected[$i]][0] & "|" & $sounds[$currentsound])
                        GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                        $currentrepeat = 1
                        $currentsound += 1
                        GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
                        GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 1 & "|" & $soundinfo[$selected[$i]][0] & "|" & $sounds[$currentsound])
                        _SoundPlay($soundopen[$currentsound])
                        ContinueLoop
                    ElseIf $repeat = 1 Then
                        $repeats[$selected[$i]] -= 1
                        GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$selected[$i]][0] & "|" & $sounds[$currentsound])
                        GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                        $currentrepeat = 1
                        $currentsound = 2
                        GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
                        GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 1 & "|" & $soundinfo[$selected[$i]][0] & "|" & $sounds[$currentsound])
                        _SoundPlay($soundopen[$currentsound])
                        ContinueLoop
                    Else
                        $currentrepeat = $repeats[$currentsound]
                        GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
                        stop()
                    EndIf
                EndIf
            EndIf
            If $repeats[$selected[$i]] > 1 Then $repeats[$selected[$i]] -= 1
            $temp = $currentrepeat
        Else
            If $repeats[$selected[$i]] > 1 Then $repeats[$selected[$i]] -= 1
        EndIf
        GUICtrlSetData($listviewitem[$selected[$i]][0], "||" & $repeats[$selected[$i]] & "|" & $temp & "|" & $soundinfo[$selected[$i]][0] & "|" & $sounds[$selected[$i]])
    Next
EndFunc   ;==>removesoundrepeat

Func removesound()
    $selected = _GUICtrlListView_GetSelectedIndices($listview, True)
    $cstemp = $currentsound
    $temp = $soundopen[$currentsound]
    For $i = 1 To UBound($selected) - 1
        If $selected[$i] < $cstemp - 2 Then $currentsound -= 1
        If $selected[$i] = $cstemp - 1 Then
            _SoundStop($temp)
            If $i = UBound($selected) - 1 Then $currentsound += 1
            $currentrepeat = 1
        EndIf
        _ArrayDelete($sounds, $selected[$i] + 3 - $i)
        _ArrayDelete($soundopen, $selected[$i] + 3 - $i)
        _ArrayDelete($soundinfo, $selected[$i] + 3 - $i)
        _ArrayDelete($listviewitem, $selected[$i] + 3 - $i)
        _ArrayDelete($repeats, $selected[$i] + 3 - $i)
    Next
    If $currentsound > UBound($sounds) - 1 Then $currentsound = UBound($sounds) - 1
    _GUICtrlListView_DeleteAllItems($listview)
    If UBound($sounds) = 2 Then
        GUICtrlSetState($playpause, $GUI_DISABLE)
        GUICtrlSetState($stop, $GUI_DISABLE)
        GUICtrlSetState($fb, $GUI_DISABLE)
        GUICtrlSetState($ff, $GUI_DISABLE)
        GUICtrlSetState($previous, $GUI_DISABLE)
        GUICtrlSetState($next, $GUI_DISABLE)
        GUICtrlSetData($timedisplay, "0:00/0:00")
        Return
    EndIf
    For $i = 2 To UBound($sounds) - 1
        If $i = $currentsound Then
            $listviewitem[$i][0] = GUICtrlCreateListViewItem("||" & $repeats[$i] & "|" & $currentrepeat & "|" & $soundinfo[$i][0] & "|" & $sounds[$i], $listview)
            GUICtrlSetBkColor($listviewitem[$i][0], $colors[$soundinfo[$i][3] + 3])
        Else
            $listviewitem[$i][0] = GUICtrlCreateListViewItem("||" & $repeats[$i] & "|" & 0 & "|" & $soundinfo[$i][0] & "|" & $sounds[$i], $listview)
            GUICtrlSetBkColor($listviewitem[$i][0], $colors[$soundinfo[$i][3]])
        EndIf
        $listviewitem[$i][1] = GUICtrlCreateContextMenu($listviewitem[$i][0])
        $listviewitem[$i][2] = GUICtrlCreateMenuItem("Add Repeat", $listviewitem[$i][1])
        GUICtrlSetOnEvent(-1, "addsoundrepeat")
        $listviewitem[$i][3] = GUICtrlCreateMenuItem("Remove Repeat", $listviewitem[$i][1])
        GUICtrlSetOnEvent(-1, "removesoundrepeat")
        $listviewitem[$i][4] = GUICtrlCreateMenuItem("Remove Sound", $listviewitem[$i][1])
        GUICtrlSetOnEvent(-1, "removesound")
        $listviewitem[$i][5] = GUICtrlCreateMenuItem("Make Group", $listviewitem[$i][1])
        GUICtrlSetOnEvent(-1, "makegroup")
    Next
    GUICtrlSetData($timedisplay, "0:00/" & $soundinfo[$currentsound][0])
    GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & $currentrepeat & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
    If $playing = 1 Or $playing = 3 Or $playing = 4 Then _SoundPlay($soundopen[$currentsound])
    If $playing = 3 Or $playing = 4 Then $playing = 1
EndFunc   ;==>removesound

Func addgrouprepeat()
    $grouprepeats[$soundinfo[$iIndex + 2][1]] += 1
    For $i = 1 To $groups[$soundinfo[$iIndex + 2][1]][0]
        GUICtrlSetData($listviewitem[$groups[$soundinfo[$iIndex + 2][1]][$i]][0], $grouprepeats[$soundinfo[$groups[$soundinfo[$iIndex + 2][1]][$i]][1]] & "|" & 0 & "|" & $repeats[$groups[$soundinfo[$iIndex + 2][1]][$i]] & "|" & 0 & "|" & $soundinfo[$groups[$soundinfo[$iIndex + 2][1]][$i]][0] & "|" & $sounds[$groups[$soundinfo[$iIndex + 2][1]][$i]])
    Next
EndFunc

Func removegrouprepeat()
    If $soundinfo[$currentsound][1] = $soundinfo[$iIndex + 2][1] Then
        If $currentgrouprepeat = $grouprepeats[$soundinfo[$iIndex + 2][1]] Then
            If $grouprepeats[$soundinfo[$iIndex + 2][1]] > 1 Then
                _SoundStop($soundopen[$currentsound])
                GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                $currentsound = $groups[$soundinfo[$currentsound][1]][$groups[$soundinfo[$currentsound][1]][0]] + 1
                $currentgrouprepeat = 1
                GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
                GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 1 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                If $playing = 1 Or $playing = 3 Or $playing = 4 Then _SoundPlay($soundopen[$currentsound])
                If $playing = 4 Then $playing = 1
            EndIf
        EndIf
    EndIf
    If $grouprepeats[$soundinfo[$iIndex + 2][1]] > 1 Then $grouprepeats[$soundinfo[$iIndex + 2][1]] -= 1
    For $i = 1 To $groups[$soundinfo[$iIndex + 2][1]][0]
        GUICtrlSetData($listviewitem[$groups[$soundinfo[$iIndex + 2][1]][$i]][0], $grouprepeats[$soundinfo[$groups[$soundinfo[$iIndex + 2][1]][$i]][1]] & "|" & 0 & "|" & $repeats[$groups[$soundinfo[$iIndex + 2][1]][$i]] & "|" & 0 & "|" & $soundinfo[$groups[$soundinfo[$iIndex + 2][1]][$i]][0] & "|" & $sounds[$groups[$soundinfo[$iIndex + 2][1]][$i]])
    Next
EndFunc

Func makegroup()
    If UBound($groups) = 1 Then
        _GUICtrlListView_SetColumnWidth($listview, 0, 21)
        _GUICtrlListView_SetColumnWidth($listview, 1, 21)
    EndIf
    $selected = _GUICtrlListView_GetSelectedIndices($listview, True)
    For $i = 1 To UBound($selected) - 1
        If $soundinfo[$selected[$i] + 2][1] <> -1 Then MsgBox(0, "", "That song is already in a group!")
        If $soundinfo[$selected[$i] + 2][1] <> -1 Then Return
    Next
    If UBound($selected) > UBound($groups, 2) Then ReDim $groups[UBound($groups)][UBound($selected)]
    $grouprepeats[UBound($groups) - 1] = 1
    For $i = 1 To UBound($selected) - 1
        $groups[UBound($groups) - 1][0] = UBound($selected) - 1
        $groups[UBound($groups) - 1][$i] = $selected[$i] + 2
        If Mod(UBound($groups), 2) = 0 Then
            $soundinfo[$selected[$i] + 2][3] = 2
        Else
            $soundinfo[$selected[$i] + 2][3] = 1
        EndIf
        $soundinfo[$selected[$i] + 2][1] = UBound($groups) - 1
        $soundinfo[$selected[$i] + 2][2] = $i
        GUICtrlSetBkColor($listviewitem[$selected[$i] + 2][0], $colors[$soundinfo[$selected[$i] + 2][3]])
        GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
        GUICtrlDelete($listviewitem[$selected[$i] + 2][5])
        $listviewitem[$selected[$i] + 2][5] = GUICtrlCreateMenuItem("Add Group Repeat", $listviewitem[$selected[$i] + 2][1])
        GUICtrlSetOnEvent(-1, "addgrouprepeat")
        GUICtrlSetState(-1, $GUI_ENABLE)
        $listviewitem[$selected[$i] + 2][6] = GUICtrlCreateMenuItem("Remove Group Repeat", $listviewitem[$selected[$i] + 2][1])
        GUICtrlSetOnEvent(-1, "removegrouprepeat")
        GUICtrlSetState(-1, $GUI_DISABLE)
    Next
    For $i = 1 To $groups[$soundinfo[$iIndex + 2][1]][0]
        GUICtrlSetData($listviewitem[$groups[$soundinfo[$iIndex + 2][1]][$i]][0], $grouprepeats[$soundinfo[$groups[$soundinfo[$iIndex + 2][1]][$i]][1]] & "|" & 0 & "|" & $repeats[$groups[$soundinfo[$iIndex + 2][1]][$i]] & "|" & 0 & "|" & $soundinfo[$groups[$soundinfo[$iIndex + 2][1]][$i]][0] & "|" & $sounds[$groups[$soundinfo[$iIndex + 2][1]][$i]])
    Next
    ReDim $groups[UBound($groups) + 1][UBound($groups, 2)], $grouprepeats[UBound($groups)]
EndFunc   ;==>makegroup

Func colors()
    Opt("guioneventmode", 0)

    $colorsgui = GUICreate("Choose Colors", 141, 156, 192, 124)
    $ungroupedcolorbutton = GUICtrlCreateButton("Ungrouped Color", 5, 5, 131, 21)
    GUICtrlSetBkColor(-1, $colors[0])
    $group1colorbutton = GUICtrlCreateButton("Group 1 Color", 5, 30, 131, 21)
    GUICtrlSetBkColor(-1, $colors[1])
    $group2colorbutton = GUICtrlCreateButton("Group 2 Color", 5, 55, 131, 21)
    GUICtrlSetBkColor(-1, $colors[2])
    $highlight1button = GUICtrlCreateButton("Highlight 1 Color", 5, 105, 131, 21)
    GUICtrlSetBkColor(-1, $colors[4])
    $highlight2button = GUICtrlCreateButton("Highlight 2 Color", 5, 130, 131, 21)
    GUICtrlSetBkColor(-1, $colors[5])
    $highlightungroupedbutton = GUICtrlCreateButton("Ungrouped Highlight Color", 5, 80, 131, 21)
    GUICtrlSetBkColor(-1, $colors[3])
    GUISetState()

    While 1
        If WinActive($mediaplayergui) Then WinActivate($colorsgui)
        Switch GUIGetMsg()
            Case $ungroupedcolorbutton
                $colors[0] = _ChooseColor(2)
                GUICtrlSetBkColor($ungroupedcolorbutton, $colors[0])
            Case $group1colorbutton
                $colors[1] = _ChooseColor(2)
                GUICtrlSetBkColor($group1colorbutton, $colors[1])
            Case $group2colorbutton
                $colors[2] = _ChooseColor(2)
                GUICtrlSetBkColor($group2colorbutton, $colors[2])
            Case $highlightungroupedbutton
                If $colors[3] = $colors[4] = $colors[5] Then
                    $colors[3] = _ChooseColor(2)
                    $colors[4] = $colors[3]
                    $colors[5] = $colors[3]
                Else
                    $colors[3] = _ChooseColor(2)
                EndIf
                GUICtrlSetBkColor($highlightungroupedbutton, $colors[3])
                GUICtrlSetBkColor($highlight1button, $colors[4])
                GUICtrlSetBkColor($highlight2button, $colors[5])
            Case $highlight1button
                If $colors[4] = $colors[5] Then
                    $colors[4] = _ChooseColor(2)
                    $colors[5] = $colors[4]
                Else
                    $colors[4] = _ChooseColor(2)
                EndIf
                GUICtrlSetBkColor($highlight1button, $colors[4])
                GUICtrlSetBkColor($highlight2button, $colors[5])
            Case $highlight2button
                $colors[5] = _ChooseColor(2)
                GUICtrlSetBkColor($highlight2button, $colors[5])
            Case $GUI_EVENT_CLOSE
                GUIDelete($colorsgui)
                Opt("guioneventmode", 1)
                ExitLoop
        EndSwitch
    WEnd
    For $i = 2 To UBound($sounds) - 1
        GUICtrlSetBkColor($listviewitem[$i][0], $colors[$soundinfo[$i][3]])
    Next
    GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
EndFunc   ;==>colors

Func saveoptions()
    If $saveoptions = 0 Then
        $saveoptions = 1
        GUICtrlSetState($menuoptionssave, $GUI_CHECKED)
    ElseIf $saveoptions = 1 Then
        $saveoptions = 0
        GUICtrlSetState($menuoptionssave, $GUI_UNCHECKED)
    EndIf
EndFunc   ;==>saveoptions

Func WM_NOTIFY($hWnd, $iMsg, $iwParam, $ilParam)
    #forceref $hWnd, $iMsg, $iwParam
    Local $hWndFrom, $iIDFrom, $iCode, $tNMHDR, $hWndListView, $tInfo
;~  Local $tBuffer
    $hWndListView = $listview
    If Not IsHWnd($listview) Then $hWndListView = GUICtrlGetHandle($listview)
    $tNMHDR = DllStructCreate($tagNMHDR, $ilParam)
    $hWndFrom = HWnd(DllStructGetData($tNMHDR, "hWndFrom"))
    $iIDFrom = DllStructGetData($tNMHDR, "IDFrom")
    $iCode = DllStructGetData($tNMHDR, "Code")
    Switch $hWndFrom
        Case $hWndListView
            Switch $iCode
                Case $NM_DBLCLK
                    $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
                    $iIndex = DllStructGetData($tInfo, "Index")
                    If $iIndex = -1 Then Return
                    If $soundinfo[$currentsound][1] <> -1 Then
                        If $iIndex + 2 = $currentsound Then
                            $currentgrouprepeat += 1
                        Else
                            For $i = 1 To $groups[$soundinfo[$currentsound][1]][0]
                                GUICtrlSetData($listviewitem[$groups[$soundinfo[$currentsound][1]][$i]][0], $grouprepeats[$soundinfo[$currentsound][1]] & "|" & 0)
                            Next
                            $currentgrouprepeat = 1
                            _SoundStop($soundopen[$currentsound])
                            GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                            GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                            $soundtime = 0
                            $currentrepeat = 1
                            $currentsound = $iIndex + 2
                            GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
                            GUICtrlSetData($timedisplay, "0:00/" & $soundinfo[$currentsound][0])
                            GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & $currentrepeat & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                            If $playing = 1 Or $playing = 3 Or $playing = 4 Then _SoundPlay($soundopen[$currentsound])
                            If $playing = 4 Then $playing = 1
                        EndIf
                    Else
                        $currentgrouprepeat = 1
                        _SoundStop($soundopen[$currentsound])
                        GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & 0 & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                        GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3]])
                        $soundtime = 0
                        $currentrepeat = 1
                        $currentsound = $iIndex + 2
                        GUICtrlSetBkColor($listviewitem[$currentsound][0], $colors[$soundinfo[$currentsound][3] + 3])
                        GUICtrlSetData($timedisplay, "0:00/" & $soundinfo[$currentsound][0])
                        GUICtrlSetData($listviewitem[$currentsound][0], "||" & $repeats[$currentsound] & "|" & $currentrepeat & "|" & $soundinfo[$currentsound][0] & "|" & $sounds[$currentsound])
                        If $playing = 1 Or $playing = 3 Or $playing = 4 Then _SoundPlay($soundopen[$currentsound])
                        If $playing = 4 Then $playing = 1
                    EndIf
                    If $soundinfo[$currentsound][1] <> -1 Then
                        For $i = 1 To $groups[$soundinfo[$currentsound][1]][0]
                            GUICtrlSetData($listviewitem[$groups[$soundinfo[$currentsound][1]][$i]][0], $grouprepeats[$soundinfo[$currentsound][1]] & "|" & $currentgrouprepeat)
                        Next
                    EndIf
                Case $NM_RCLICK
                    $tInfo = DllStructCreate($tagNMITEMACTIVATE, $ilParam)
                    Global $iIndex = DllStructGetData($tInfo, "Index")

                    GUICtrlSetState($listviewitem[$iIndex + 2][3], $GUI_DISABLE)
                    GUICtrlSetState($listviewitem[$iIndex + 2][6], $GUI_DISABLE)
                    $selected = _GUICtrlListView_GetSelectedIndices($listview, True)
                    If UBound($selected) > 2 Then
                        GUICtrlSetState($listviewitem[$iIndex + 2][3], $GUI_ENABLE)
                        GUICtrlSetState($listviewitem[$iIndex + 2][5], $GUI_ENABLE)
                        If $soundinfo[$iIndex + 2][1] <> -1 And $grouprepeats[$soundinfo[$iIndex + 2][1]] > 1 Then GUICtrlSetState($listviewitem[$iIndex + 2][6], $GUI_ENABLE)
                    Else
                        If $repeats[$iIndex + 2] > 1 Then GUICtrlSetState($listviewitem[$iIndex + 2][3], $GUI_ENABLE)
                        If $soundinfo[$iIndex + 2][1] = -1 Then
                            GUICtrlSetState($listviewitem[$iIndex + 2][5], $GUI_DISABLE)
                        Else
                            GUICtrlSetState($listviewitem[$iIndex + 2][5], $GUI_ENABLE)
                            If $grouprepeats[$soundinfo[$iIndex + 2][1]] > 1 Then GUICtrlSetState($listviewitem[$iIndex + 2][6], $GUI_ENABLE)
                        EndIf
                    EndIf
            EndSwitch
    EndSwitch
EndFunc   ;==>WM_NOTIFY

Func _trim($string)
    For $i = 1 To 4
        $temp = StringLeft($string, 1)
        If $temp = '0' Or $temp = ':' Then
            $string = StringTrimLeft($string, 1)
        Else
            Return $string
        EndIf
    Next
    Return $string
EndFunc   ;==>_trim

Func close()
    Exit
EndFunc   ;==>close
