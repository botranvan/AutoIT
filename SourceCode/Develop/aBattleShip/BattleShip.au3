Opt ('GUIONEVENTMODE',1)
#include <GUICONSTANTSEX.AU3>
#include <WINDOWSCONSTANTS.au3>
#include <STATICCONSTANTS.au3>
#include <BUTTONCONSTANTS.au3>
#include <ARRAY.au3>

Global $l_size = 40

Dim $Player_gui_parent = 0
Dim $Player_gui_grid_ships[11][11]
Dim $Player_gui_grid_explosives[11][11]

Dim $AI_grid_ships[11][11]

Dim $Player_Ships_Location[15]

Dim $Player_HitsTaken
Dim $Player_HitsTaken_Label
Dim $AI_HitsTaken
Dim $AI_HitsTaken_Label
Dim $AI_WinCount = 0
Dim $Player_WinCount = 0

Dim $CurrentShip_to_be_Set = 5
Dim $CurrentTurn = 0
Dim $Player_HitsTaken = 0
Dim $AI_HitsTaken = 0
Dim $startup = 0
Dim $Alignment = 1
Dim $AI_last_hit_on_Player = 0&':'&0

Start ()


While 1
    If $Player_HitsTaken = 15 Or $AI_HitsTaken = 15 Then
        Dim $startup = 0
        If $AI_HitsTaken = 15 Then
            $Player_WinCount += 1
            If MsgBox (4,'Game Over!', 'Player Wins!' & @CRLF & _
                                'Score:' & @CRLF & _
                                    @TAB &  'AI:' & $AI_WinCount & @CRLF & _
                                    @TAB &  'Player:' & $Player_WinCount & @CRLF & _
                                'Play Again?','',WinGetHandle ('[active]')) = 6 Then
                GUIDelete ($Player_gui_parent)
                Start ()
            Else
                QUIT ()
            EndIf
        ElseIf $Player_HitsTaken = 15 Then
            $AI_WinCount += 1
            If MsgBox (4,'Game Over!', 'AI Wins!' & @CRLF & _
                                'Score:' & @CRLF & _
                                    @TAB &  'AI:' & $AI_WinCount & @CRLF & _
                                    @TAB &  'Player:' & $Player_WinCount & @CRLF & _
                                'Play Again?','',WinGetHandle ('[active]')) = 6 Then
                GUIDelete ($Player_gui_parent)
                Start ()
            Else
                QUIT ()
            EndIf
        EndIf
    Else
        If GUICtrlRead ($AI_HitsTaken_Label) <> 'AI has ' & 15-$AI_HitsTaken & ' Hits Left Before They Loze!' Then GUICtrlSetData ($AI_HitsTaken_Label,'AI has ' & 15-$AI_HitsTaken & ' Hits Left Before They Loze!')
        If GUICtrlRead ($Player_HitsTaken_Label) <> 'You have ' & 15-$Player_HitsTaken & ' Hits Left Before You Loze!' Then GUICtrlSetData ($Player_HitsTaken_Label,'You have ' & 15-$Player_HitsTaken & ' Hits Left Before You Loze!')
    EndIf
    Sleep (100)
WEnd
Func Start ()
    Local $y, $x, $AI_Alignment
    If $startup = 1 Then Return
    $startup = 1
    $CurrentShip_to_be_Set = 5
    $CurrentTurn = 0
    $Player_HitsTaken = 0
    $AI_HitsTaken = 0
    $Player_gui_parent = GUICreate ('BATTLESHIPS',(($l_size*10)*2)+30,($l_size*10)+(6*$l_size)+10)
    GUISetFont (10,999,'','Tahoma',$Player_gui_parent)
    GUICtrlSetDefBkColor (0xABCDEF,$Player_gui_parent)
    GUISetBkColor (0xABCDEF)
            GUICtrlCreateLabel ('Carrier :',10,($l_size*10)+$l_size,$l_size*5,$l_size,BitOR ($SS_CENTERIMAGE,$SS_CENTER))
            GUICtrlCreateLabel ('BattleShip :',10,($l_size*10)+(2*$l_size),$l_size*5,$l_size,BitOR ($SS_CENTERIMAGE,$SS_CENTER))
            GUICtrlCreateLabel ('Submarine :',10,($l_size*10)+(3*$l_size),$l_size*5,$l_size,BitOR ($SS_CENTERIMAGE,$SS_CENTER))
            GUICtrlCreateLabel ('Destroyer :',10,($l_size*10)+(4*$l_size),$l_size*5,$l_size,BitOR ($SS_CENTERIMAGE,$SS_CENTER))
            GUICtrlCreateLabel ('PatrolBoat :',10,($l_size*10)+(5*$l_size),$l_size*5,$l_size,BitOR ($SS_CENTERIMAGE,$SS_CENTER))

            GUICtrlCreateLabel ('',10+($l_size*5),($l_size*10)+$l_size,$l_size*5,$l_size, $WS_BORDER)
            GUICtrlCreateLabel ('',10+($l_size*5),($l_size*10)+(2*$l_size),$l_size*4,$l_size, $WS_BORDER)
            GUICtrlCreateLabel ('',10+($l_size*5),($l_size*10)+(3*$l_size),$l_size*3,$l_size, $WS_BORDER)
            GUICtrlCreateLabel ('',10+($l_size*5),($l_size*10)+(4*$l_size),$l_size*2,$l_size, $WS_BORDER)
            GUICtrlCreateLabel ('',10+($l_size*5),($l_size*10)+(5*$l_size),$l_size*1,$l_size, $WS_BORDER)



            GUICtrlCreateRadio ('Horizontal Positioning',20+($l_size*10),($l_size*10)+(1*$l_size),$l_size*5,$l_size)
                GUICtrlSetState(-1, $GUI_CHECKED)
                GUICtrlSetOnEvent (-1,'ChangeAlignment')
            GUICtrlCreateRadio ('Vertical Positioning',20+($l_size*10),($l_size*10)+(2*$l_size),$l_size*5,$l_size)
                GUICtrlSetOnEvent (-1,'ChangeAlignment')


            $AI_HitsTaken_Label = GUICtrlCreateLabel  ('',20+($l_size*10),($l_size*10)+(4*$l_size),$l_size*10,$l_size)
            $Player_HitsTaken_Label = GUICtrlCreateLabel( '',20+($l_size*10),($l_size*10)+(5*$l_size),$l_size*10,$l_size)

    GUISetOnEvent (-3,'QUIT',$Player_gui_parent)
    GUISetState ()
    MsgBox (0,'BATTLESHIPS','Hello.' & @CRLF & 'Before We Can Start, You Must Position Your Ships On Your Left Grid.','',WinGetHandle ('[active]'))


    $Player_gui_grid_ships[0][0] = GUICreate ('Player:Ships',$l_size*10,$l_size*10,10,10,$WS_POPUPWINDOW,$WS_EX_MDICHILD,$Player_gui_parent)
        For $y = 1 To 10
            For $x = 1 To 10
                $AI_grid_ships[$y][$x] = 0
                $Player_gui_grid_ships[$y][$x] = GUICtrlCreateLabel ('',(($x-1)*$l_size),(($y-1)*$l_size),$l_size,$l_size,BitOR ($SS_CENTERIMAGE,$SS_CENTER,$WS_BORDER))
                GUICtrlSetBkColor ($Player_gui_grid_ships[$y][$x],0xABCDEF)
                GUICtrlSetOnEvent ($Player_gui_grid_ships[$y][$x],'PositionShip')
                GUICtrlSetCursor ($Player_gui_grid_ships[$y][$x],0)
            Next
        Next
    GUISetState ()




While $CurrentShip_to_be_Set >= 1
    Sleep (100)
WEnd


    $Player_gui_grid_explosives[0][0] = GUICreate ('Player:Explosives',$l_size*10,$l_size*10,($l_size*10)+20,10,$WS_POPUPWINDOW,$WS_EX_MDICHILD,$Player_gui_parent)
        For $y = 1 To 10
            For $x = 1 To 10
                $Player_gui_grid_explosives[$y][$x] = GUICtrlCreateLabel ($y&':'&$x,($x-1) * $l_size,($y - 1) * $l_size,$l_size,$l_size,BitOR ($SS_CENTERIMAGE,$SS_CENTER,$WS_BORDER))
                GUICtrlSetBkColor ($Player_gui_grid_explosives[$y][$x],0xABCDEF)
                GUICtrlSetOnEvent ($Player_gui_grid_explosives[$y][$x],'Attack')
                GUICtrlSetCursor ($Player_gui_grid_explosives[$y][$x],3)
            Next
        Next
    GUISetState ()


    For $N = 5 To 1 Step -1
        While 1
            $error = 0
            $x = Random(1,10,1)
            $y = Random (1,10,1)
            $AI_Alignment = Random (0,1,1)
            If $AI_grid_ships[$y][$x] = 0 Then
                If $AI_Alignment = 0 Then ;VERTICAL
                    If ($y-1)+$N <= 10 Then

                        For $U = 0 To $N-1
                            If $AI_grid_ships[$y+$U][$x] = 1 Then $error = 1
                        Next
                        If $error <> 1 Then
                            For $U = 0 To $N-1
                                $AI_grid_ships[$y+$U][$x] = 1
                            Next
                            ExitLoop
                        EndIf
                    EndIf
                ElseIf $AI_Alignment = 1 Then ;HORIZONTAL
                    If ($x-1)+$N <= 10 Then

                        For $U = 0 To $N-1
                            If $AI_grid_ships[$y][$x+$U] = 1 Then $error = 1
                        Next
                        If $error <> 1 Then
                            For $U = 0 To $N-1
                                $AI_grid_ships[$y][$x+$U] = 1
                            Next
                            ExitLoop
                        EndIf
                    EndIf
                EndIf
            EndIf
        WEnd
    Next
EndFunc
Func ChangeAlignment ()
    If $Alignment = 0 Then ;if vertical then make horizontal
        $Alignment = 1
        Return
    ElseIf $Alignment = 1 Then ;if horizontal then make vertical
        $Alignment = 0
        Return
    EndIf
EndFunc
Func CheckVertical ($y,$x,$length)
    Local $Count
    If ($y-1)+$length <= 10  Then
        For $Count = 1 To $length
            If GUICtrlRead ($Player_gui_grid_ships[($y-1)+$Count][$x]) == ' ' Then Return -1
        Next
        Return 1
    EndIf
EndFunc
Func CheckHorizontal ($y,$x,$length)
    Local $Count
    If ($x-1)+$length <= 10 Then
        For $Count = 1 To $length
            If GUICtrlRead ($Player_gui_grid_ships[$y][($x-1)+$Count]) == ' ' Then Return -1
        Next
        Return 1
    EndIf
EndFunc
Func Attack ()
    Local $y, $x, $Count
    For $y = 1 To 10
        For $x = 1 To 10
            If @GUI_CtrlId = $Player_gui_grid_explosives[$y][$x] Then
                If GUICtrlRead ($Player_gui_grid_explosives[$y][$x]) <> ' ' Then
                    If $AI_grid_ships[$y][$x] = 1 Then
                        GUICtrlSetOnEvent (@GUI_CtrlId,'')
                        GUICtrlSetBkColor (@GUI_CtrlId,0xFF0000)
                        $AI_HitsTaken += 1
                    Else
                        GUICtrlSetBkColor (@GUI_CtrlId,0xFFFFFF)
                    EndIf
                    GUICtrlSetOnEvent (@GUI_CtrlId,'')
                    GUICtrlSetData (@GUI_CtrlId, ' ')
                    GUICtrlSetCursor (@GUI_CtrlId,7)
                    AI_Attack ()
                EndIf
            EndIf
        Next
    Next
EndFunc
Func AI_Attack ()
    Local $x, $y, $status = 0
    While $status = 0
        $x = Random (1,10,1)
        $y = Random (1,10,1)
        If GUICtrlRead ($Player_gui_grid_ships[$y][$x]) <> ' ' Then
            If  GUICtrlRead ($Player_gui_grid_ships[$y][$x]) <> '' Then
                GUICtrlSetBkColor ($Player_gui_grid_ships[$y][$x],0xFF0000)
                $Player_HitsTaken += 1
                $AI_last_hit_on_Player = $y&':'&$x
                Return
            Else
                GUICtrlSetBkColor ($Player_gui_grid_ships[$y][$x],0xFFFFFF)
                Return
            EndIf
        EndIf
    WEnd
EndFunc
Func PositionShip ()
    Local $y, $x, $Count
    For $y = 1 To 10
        For $x = 1 To 10
            If @GUI_CtrlId = $Player_gui_grid_ships[$y][$x] Then
                If $CurrentShip_to_be_Set < 1 Then
                    For $y = 1 To 10
                        For $x = 1 To 10
                            GUICtrlSetOnEvent ( $Player_gui_grid_ships[$y][$x],'')
                            GUICtrlSetCursor ($Player_gui_grid_ships[$y][$x],2)
                        Next
                    Next
                    Return
                Else
                    If $Alignment = 0 Then ;VERTICAL PLACEMENT
                        If CheckVertical ($y,$x,$CurrentShip_to_be_Set) <> -1 Then
                            If $y <= (10-($CurrentShip_to_be_Set-1)) Then
                                For $Count = 0 To $CurrentShip_to_be_Set-1
                                    GUICtrlSetData ($Player_gui_grid_ships[$y+$Count][$x],$CurrentShip_to_be_Set)
                                    GUICtrlSetBkColor ($Player_gui_grid_ships[$y+$Count][$x],0x0)
                                    GUICtrlSetOnEvent ( $Player_gui_grid_ships[$y+$Count][$x],'')
                                Next
                                $CurrentShip_to_be_Set = ($CurrentShip_to_be_Set - 1)
                                Return
                            EndIf
                        EndIf
                    ElseIf $Alignment = 1 Then ;HORIZONTAL PLACEMENT
                        If CheckHorizontal ($y,$x,$CurrentShip_to_be_Set) <> -1 Then
                            If $x <= (10-($CurrentShip_to_be_Set-1)) Then
                                For $Count = 0 To $CurrentShip_to_be_Set-1
                                    GUICtrlSetData ($Player_gui_grid_ships[$y][$x+$Count],$CurrentShip_to_be_Set)
                                    GUICtrlSetBkColor ($Player_gui_grid_ships[$y][$x+$Count],0x0)
                                    GUICtrlSetOnEvent ( $Player_gui_grid_ships[$y][$x+$Count],'')
                                Next
                                $CurrentShip_to_be_Set = ($CurrentShip_to_be_Set - 1)
                                Return
                            EndIf
                        EndIf
                    EndIf
                EndIf
            EndIf
        Next
    Next
EndFunc
Func QUIT ()
    Exit
EndFunc