Opt("PixelCoordMode", 2)
Opt("MouseCoordMode", 2)
Opt("WinTitleMatchMode", 4)
Opt("MouseClickDelay", 0)
Opt("MouseClickDownDelay", 0)

HotKeySet("{ESC}","_Exit") ;; Emergency exit
Global Const $MINE_UNKNOWN = -1 , $MINE_EMPTY = 0 , $MINE_ONE = 1 , $MINE_TWO = 2 , $MINE_THREE = 3 , $MINE_FOUR = 4 , $MINE_FIVE = 5 , $MINE_SIX = 6
Global Const $MINE_SEVEN = 7 , $MINE_BOMB = 13 , $MINE_FLAG = 12 , $MINE_QUESTION = 11
Local Const $sClass = "[Class:Minesweeper]"

Local $hWnd = 0 , $PID = 0 , $nSpeed = 1
Local $lSmileyPos
Local $mGrid[1][1]
Local $mGW = 16 ; My grid width
Local $mGH = 16 ; My grid heigth

Local $mStuck = 0

If WinExists($sClass) Then
	$hWnd = WinGetHandle($sClass)
	$PID = WinGetProcess($hWnd)
Else
	$PID = Run("winmine")
	While Not WinExists($sClass)
		Sleep(250)
	WEnd
	$hWnd = WinGetHandle($sClass)
EndIf

Sleep (50)
Send("!g") ;; Open game menu
Sleep(50 * $nSpeed)

Switch "Expert"
	Case "Beginner"
		Send("b")
		$mGW = 14
		$mGH = 14
	Case "Intermediate"
		Send("i")
		$mGW = 16
		$mGH = 16
	Case "Expert"
		Send("e")
		$mGW = 30
		$mGH = 16
EndSwitch

ReDim $mGrid[$mGW][$mGH]

Sleep(50 * $nSpeed)

$nSpeed = 0

While 1
	If Not WinActive($hWnd) Then WinActivate($hWnd)
	If Not WinExists($hWnd) Then Exit

	$a = PixelSearch(0,0,800,50,0xffff00,0,1,$hWnd)
    $b = 0

    For $i = 4 to 7
        $b += PixelGetColor($a[0],$a[1]+$i,$hWnd)
    Next

	Switch $b
		Case 50330880
			Send("{F2}")
		Case 0
			MsgBox(0x40, "Minesweeper bot", "Hey, I won! :D")
			Exit
	EndSwitch

    _WinMine_ReadMines()

    If (_WinMine_CountMines($MINE_UNKNOWN) <= (($mGW*$mGH)-100)) Then

        $mStuck += 1 ; pretends to be stuck at the moment, until something is done

        For $x = 0 to $mGW-1
            For $y = 0 to $mGH-1

                _CheckMine($x,$y)

            Next
        Next

        If ( $mStuck == 5 ) Then
            ;If ( MsgBox(0x4,"Minesweeper bot", "I appear to be stuck! Should I make a gamble?") == 0x6 ) Then

                _RandomClickMine()
                $mStuck = 0

            ;EndIf
        EndIf
    Else
        ;; Randomly open up mines

        _WinMine_ClickMine(Random(1,$mGW-1,1),Random(1,$mGH-1,1))

    EndIf
WEnd

Func _RandomClickMine()
    Local $a = 1
    While 1

        For $x = 0 to $mGW-1
            For $y = 0 to $mGH-1
                If (_WinMine_GetMine($x,$y) == $MINE_UNKNOWN) Then
                    $surrounding = _WinMine_CountSurroundingMines($x, $y, $MINE_UNKNOWN)

                    If $surrounding < $a Then
                        _WinMine_ClickMine($x,$y)

                        _WinMine_ReadMines()
                        Return
                    EndIf
                EndIf
            Next
        Next

        $a += 1

        If ( $a == 20 ) Then
            Return
        EndIf
    WEnd
EndFunc

Func _CheckMine($x,$y)
    $thisMine = _WinMine_GetMine($x,$y)

    Switch $thisMine
        Case $MINE_BOMB, $MINE_EMPTY, $MINE_UNKNOWN

            Return

        Case $MINE_ONE

            $mines_nearby = _WinMine_CountSurroundingMines($x,$y,$MINE_UNKNOWN)
            $flags_nearby = _WinMine_CountSurroundingMines($x,$y,$MINE_FLAG)

            If ( $mines_nearby == 0) Then Return ;; Some speed improvement

            If ( $mines_nearby == 1 AND $flags_nearby == 0 ) Then
                $mStuck = 0
                _WinMine_FlagSurroundingMines($x,$y)
            ElseIf ($flags_nearby == 1) Then
                $mStuck = 0
                _WinMine_OpenSurroundingMines($x,$y)
            EndIf

        Case $MINE_TWO

            $mines_nearby = _WinMine_CountSurroundingMines($x,$y,$MINE_UNKNOWN)
            $flags_nearby = _WinMine_CountSurroundingMines($x,$y,$MINE_FLAG)

            If ( $mines_nearby == 0) Then Return ;; Some speed improvement

            If ($mines_nearby == 1 AND $flags_nearby == 1) Then
                $mStuck = 0
                _WinMine_FlagSurroundingMines($x,$y)
            ElseIf ($mines_nearby = 2 AND $flags_nearby == 0) Then
                $mStuck = 0
                _WinMine_FlagSurroundingMines($x,$y)
            ElseIf ($flags_nearby == 2) Then
                $mStuck = 0
                _WinMine_OpenSurroundingMines($x,$y)
            EndIf

        Case $MINE_THREE

            $mines_nearby = _WinMine_CountSurroundingMines($x,$y,$MINE_UNKNOWN)
            $flags_nearby = _WinMine_CountSurroundingMines($x,$y,$MINE_FLAG)

            If ( $mines_nearby == 0) Then Return ;; Some speed improvement

            If ($mines_nearby == 1 AND $flags_nearby == 2) Then
                $mStuck = 0
                _WinMine_FlagSurroundingMines($x,$y)
            ElseIf ($mines_nearby == 2 AND $flags_nearby == 1) Then
                $mStuck = 0
                _WinMine_FlagSurroundingMines($x,$y)
            ElseIf ($mines_nearby == 3 AND $flags_nearby == 0) Then
                $mStuck = 0
                _WinMine_FlagSurroundingMines($x,$y)
            ElseIf ($flags_nearby == 3) Then
                $mStuck = 0
                _WinMine_OpenSurroundingMines($x,$y)
            EndIf

        Case $MINE_FOUR

            $mines_nearby = _WinMine_CountSurroundingMines($x,$y,$MINE_UNKNOWN)
            $flags_nearby = _WinMine_CountSurroundingMines($x,$y,$MINE_FLAG)

            If ( $mines_nearby == 0) Then Return ;; Some speed improvement

            If ($mines_nearby == 1 AND $flags_nearby == 3) Then
                $mStuck = 0
                _WinMine_FlagSurroundingMines($x,$y)
            ElseIf ($mines_nearby == 2 AND $flags_nearby == 2) Then
                $mStuck = 0
                _WinMine_FlagSurroundingMines($x,$y)
            ElseIf ($mines_nearby == 3 AND $flags_nearby == 1) Then
                $mStuck = 0
                _WinMine_FlagSurroundingMines($x,$y)
            ElseIf ($mines_nearby == 4 AND $flags_nearby == 0) Then
                $mStuck = 0
                _WinMine_FlagSurroundingMines($x,$y)
            ElseIf ($flags_nearby == 4) Then
                $mStuck = 0
                _WinMine_OpenSurroundingMines($x,$y)
            EndIf

    EndSwitch
EndFunc

;; A function for emergency exit
Func _Exit()
    Exit
EndFunc

Func _WinMine_CountSurroundingMines($x,$y,$lMine)
    Local $lReturn = 0
    For $n = $x-1 To $x+1
        For $m = $y-1 To $y+1
            If ( _WinMine_GetMine($n,$m) == $lMine ) Then
                $lReturn += 1
            EndIf
        Next
    Next
    Return $lReturn
EndFunc

Func _WinMine_FlagSurroundingMines($x,$y)
    For $n = $x-1 To $x+1
        For $m = $y-1 To $y+1
            If ( _WinMine_GetMine($n,$m) == $MINE_UNKNOWN ) Then
                _WinMine_FlagMine($n,$m)
            EndIf
        Next
    Next

    _WinMine_ReadMines()
EndFunc

Func _WinMine_OpenSurroundingMines($x,$y)
    For $n = $x-1 To $x+1
        For $m = $y-1 To $y+1
            If ( _WinMine_GetMine($n,$m) == $MINE_UNKNOWN ) Then
                _WinMine_ClickMine($n,$m)
            EndIf
        Next
    Next

    _WinMine_ReadMines()
EndFunc

Func _WinMine_CountMines($lMine)
    $lReturn = 0

    For $x = 0 to $mGW-1
        For $y = 0 to $mGH-1
            If ( _WinMine_GetMine($x,$Y) == $lMine ) Then
                $lReturn += 1
            EndIf
        Next
    Next

    Return $lReturn
EndFunc

Func _WinMine_GetMine($x,$y)
    If Not _WinMine_IsInBound($x, $y) Then Return $MINE_QUESTION

    Return $mGrid[$x][$y]
EndFunc

Func _WinMine_ReadMines()
    For $x = 0 to $mGW-1
        For $y = 0 to $mGH-1
            $mGrid[$x][$y] = _WinMine_ReadMine($x, $y)
        Next
    Next
EndFunc

Func _WinMine_IsInBound($x,$y)
    If ($x < 0 OR $x > $mGW-1) Then
        Return 0
    ElseIf ($y < 0 OR $y > $mGH-1) Then
        Return 0
    Else
        Return 1
    EndIf
EndFunc

Func _WinMine_ReadMine($x, $y)

    If Not _WinMine_IsInBound($x, $y) Then Return $MINE_QUESTION

    $lColor = PixelGetColor(($x * 16) + 15, ($y * 16) + 55,$hWnd)

    $lMineChecksum = PixelChecksum(($x * 16)+15,($y * 16)+55,($x * 16) + 25, ($y * 16) + 65, 1, $hWnd)
;~ 	tooltip(@sec&@msec&" ",($x * 16)+15,($y * 16)+55)
    Switch $lMineChecksum
        Case 39198862 ; Unknown
            Return $MINE_UNKNOWN
        Case 1084229648 ; Empty
            Return $MINE_EMPTY
        Case 2517165927 ; Number 1
            Return $MINE_ONE
        Case 1440528705 ; Number 2
            Return $MINE_TWO
        Case 326160918 ; Number 3
            Return $MINE_THREE
        Case 1564389505
            Return $MINE_FOUR
        Case 437628609
            Return $MINE_FIVE
        Case 572048513
            Return $MINE_SIX
        Case 2443509166 ; Flag
            Return $MINE_FLAG
        Case 258470783 ; Question mark
            Return $MINE_QUESTION
        Case 1965262389, 2770815814
            Return $MINE_BOMB
        Case Else
            ConsoleWrite("! Unknown mine detected (Mine number 7 still undetected):" & $lMineChecksum & @CRLF )
            Return SetError(1,0,-10)
    EndSwitch
EndFunc

Func _WinMine_ClickMine($x, $y)
    If Not _WinMine_IsInBound($x, $y) Then Return

    MouseClick("Primary", ($x * 16) + 15, ($y * 16) + 55, 1, 0)

    Sleep(50 * $nSpeed) ; Gives the game some time to update
EndFunc

Func _WinMine_FlagMine($x, $y)
    If Not _WinMine_IsInBound($x, $y) Then Return

    MouseClick("Secondary",($x * 16) + 15, ($y * 16) + 55, 1, 0)

    Sleep(50 * $nSpeed) ; Gives the game some time to update
EndFunc

Func _WinMine_PointAtMine($x, $y)
    If Not _WinMine_IsInBound($x, $y) Then Return

    MouseMove( ($x * 16) + 15, ($y * 16) + 55 )

    Sleep(50 * $nSpeed) ; Gives the game some time to update
EndFunc
