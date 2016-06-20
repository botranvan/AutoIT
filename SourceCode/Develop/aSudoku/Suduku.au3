; created mostly by fisofo, with code scraps borrowed from all over ;)
; check "about" for credits.

#include <IE.au3>
#include <GuiConstantsEx.au3>
#include <AVIConstants.au3>
#include <TreeViewConstants.au3>
#include <WindowsConstants.au3>
#include <StaticConstants.au3>
#include <ProgressConstants.au3>


Dim $aSudArray[9][9]
Dim $aOrigArray[9][9]
Dim $aEnumArray[10]
Dim $smallbuttons[9][9][9]
Dim $largebuttons[9][9]
Dim $IDtoPosition[1000][3]
Dim $Difficulty = 1
Dim $DifficultyText = "Easy"
Dim $Progress = 0
Dim $increment = 1
Dim $ProgressBar
Dim $HelperCheckbox
Dim $PossibilityArray[9][9][10]
Dim $SolutionsArray[81][3]
Dim  $SolutionsCount = 0
Dim $isSolved = 0

_MainMenu()
;~ _StartSudoku() ; for testing

Func _MainMenu()
   DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 7)
   GuiCreate("Sudoku-It!", 222, 403,-1, -1 , BitOR($WS_OVERLAPPEDWINDOW, $WS_CLIPSIBLINGS))
   
   $Progress = 0
   $ButtonEasy = GuiCtrlCreateButton("Easy", 10, 40, 200, 50)
   GUICtrlSetFont($ButtonEasy, 12, 700)
   $ButtonMedium = GuiCtrlCreateButton("Medium", 10, 100, 200, 50)
   GUICtrlSetFont($ButtonMedium, 12, 700)
   $ButtonHard = GuiCtrlCreateButton("Hard", 10, 160, 200, 50)
   GUICtrlSetFont($ButtonHard, 12, 700)
   $ButtonInsane = GuiCtrlCreateButton("Insane", 10, 220, 200, 50)
   GUICtrlSetFont($ButtonInsane, 12, 700)
   $ButtonCustom = GuiCtrlCreateButton("Custom", 10, 280, 200, 50)
   GUICtrlSetFont($ButtonCustom, 12, 700)
   $ButtonAbout = GuiCtrlCreateButton("About", 60, 360, 100, 30)
   $Label_GUI = GuiCtrlCreateLabel("Select Difficulty Level", 10, 10, 200, 20, $SS_CENTER)
   GUICtrlSetFont($Label_GUI, 14, 700)
   DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0)
   $ProgressBar = GuiCtrlCreateProgress(10, 340, 200, 10, $PBS_SMOOTH)

   GuiSetState()
   While 1
     $msg = GuiGetMsg()
     Select
       Case $msg = $GUI_EVENT_CLOSE
         Exit
       Case $msg = $ButtonEasy
         $Difficulty = 1
         $DifficultyText = "Easy"
         ExitLoop
       Case $msg = $ButtonMedium
         $Difficulty = 2
         $DifficultyText = "Medium"
         ExitLoop
       Case $msg = $ButtonHard
         $Difficulty = 3
         $DifficultyText = "Hard"
         ExitLoop
       Case $msg = $ButtonInsane
         $Difficulty = 4
         $DifficultyText = "Insane"
         ExitLoop
       Case $msg = $ButtonCustom
         $Difficulty = 1
         $DifficultyText = "Custom!"
         For $row = 0 to 8
           For $col = 0 to 8
             $aSudArray[$row][$col] = 0
             $aOrigArray[$row][$col] = 0
           Next
         Next
         GUIDelete()
         _SudokuGUI()
       Case $msg = $ButtonAbout
         MsgBox(64, "About", "Mostly created by Fisofo..." & Chr(13) & Chr(13) & Chr(13) & _
             "But Sudokudos! to:" & Chr(13) & Chr(13) & _
             "nfwu for the Game GUI and" & Chr(13) & _
             "PsaltyDS for the Progress bar" & Chr(13) & Chr(13) & _
             "To the forum goers that" & Chr(13) & _
             "put up with my questions ;)" & Chr(13) & Chr(13) & _
             "And to my loverly wife," & Chr(13) & _
             "who lets me stay up late coding!")
       Case Else
         ;;;
     EndSelect
   WEnd
   _SetProgcolor()
   GUICtrlSetState($ButtonEasy, $GUI_DISABLE)
   _SetProgcolor()
   GUICtrlSetState($ButtonMedium, $GUI_DISABLE)
   _SetProgcolor()
   GUICtrlSetState($ButtonHard, $GUI_DISABLE)
   _SetProgcolor()
   GUICtrlSetState($ButtonInsane, $GUI_DISABLE)
   _SetProgcolor()
   GUICtrlSetState($ButtonCustom, $GUI_DISABLE)
   _SetProgcolor()
   GUICtrlSetState($ButtonAbout, $GUI_DISABLE)
   _SetProgcolor()
   _StartSudoku()
EndFunc   ;==>_MainMenu

Func _StartSudoku()
   _SudokuGenerator()
   GUIDelete()
   _SudokuGUI()
EndFunc

Func _SudokuGUI() ; credit to nfwu for the math behind the GUI!
   DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 0)

   Dim $GUI = GUICreate("Sudoku-It! Game - " & $DifficultyText, 3 * 230 - 10, 3 * 230 + 50)

   For $h = 0 To 8
     For $i = 0 To 8
       GUICtrlCreateGroup("", 5 + Mod($h, 3) * 230 + Mod($i, 3) * 70, _
           0 + Int($h / 3) * 230 + Int($i / 3) * 70, 70, 75)
       For $j = 0 To 8
         $smallbuttons[$h][$i][$j] = _CreateSmallButton($h, $i, $j)
         $IDtoPosition[$smallbuttons[$h][$i][$j]][0] = $h
         $IDtoPosition[$smallbuttons[$h][$i][$j]][1] = $i
         $IDtoPosition[$smallbuttons[$h][$i][$j]][2] = $j
         GUICtrlSetState($smallbuttons[$h][$i][$j],$GUI_HIDE)
       Next
     Next
   Next
   For $h = 0 To 8
     For $i = 0 To 8
       $largebuttons[$h][$i] = _CreateLargeButton($h, $i, $j)
       $IDtoPosition[$largebuttons[$h][$i]][0] = $h
       $IDtoPosition[$largebuttons[$h][$i]][1] = $i
       $IDtoPosition[$largebuttons[$h][$i]][2] = -1
       GUICtrlSetState($largebuttons[$h][$i],$GUI_HIDE)
     Next
   Next

   $Progress = 0
   $ProgressBar = GuiCtrlCreateProgress(155, 3 * 230 - 10, 290, 50, $PBS_SMOOTH)
   
   DllCall("uxtheme.dll", "none", "SetThemeAppProperties", "int", 7)
   $HelperCheckbox = GUICtrlCreateCheckbox("Helper Mode On/Off", 10, 3 * 230 - 10)
   GUICtrlSetState($HelperCheckbox, $GUI_UNCHECKED)
   $SolveButton = GUICtrlCreateButton("Solve", 10, 3 * 230 + 15)
   $ResetButton = GUICtrlCreateButton("Reset", 50, 3 * 230 + 15)
   $CheckButton = GUICtrlCreateButton("Check It!", 90, 3 * 230 + 15)
   $SudokuLabel = GUICtrlCreateLabel("Sudoku-It!", 460, 3 * 230 - 10, 3 * 230, 50)
   GUICtrlSetFont($SudokuLabel, 32, 700, 2)
   
   _InitGUI()
   _SudokuInitNormal()
   
   GuiSetState()
   While 1
     $msg = GuiGetMsg()
     Select
       Case $msg = $GUI_EVENT_CLOSE
         GUIDelete()
         _MainMenu()
       Case $msg >= $smallbuttons[0][0][0] AND $msg <= $smallbuttons[8][8][8]
         if GUICtrlRead($HelperCheckbox) = $GUI_CHECKED Then
           _SudokuEliminator($msg)
         Elseif GUICtrlRead($HelperCheckbox) = $GUI_UNCHECKED Then
           _SudokuNormalMode("small", $msg)
         EndIf
       Case $msg >= $largebuttons[0][0] AND $msg <= $largebuttons[8][8]
         GUICtrlSetData($msg, 0)
         $row = _GridConvert($IDtoPosition[$msg][0], $IDtoPosition[$msg][1], "row")
         $col = _GridConvert($IDtoPosition[$msg][0], $IDtoPosition[$msg][1], "col")
         $aSudArray[$row][$col] = 0
         if GUICtrlRead($HelperCheckbox) = $GUI_CHECKED Then
           _SudokuEliminator(-1)
         Elseif GUICtrlRead($HelperCheckbox) = $GUI_UNCHECKED Then
           _SudokuNormalMode("big", $msg)
         EndIf
       Case $msg = $HelperCheckbox
         if GUICtrlRead($HelperCheckbox) = $GUI_CHECKED Then
           _SudokuEliminator(-1)
         Elseif GUICtrlRead($HelperCheckbox) = $GUI_UNCHECKED Then
           _SudokuInitNormal()
         EndIf
       Case $msg = $SolveButton
         _SudokuSolver()
       case $msg = $CheckButton
         $isSolved = _SudokuEliminator(-1)
         if $isSolved = 81 Then
           MsgBox(0,"Congrats", "You're done!") ; obviously not done
         Else
           MsgBox(0,"Keep Going...","Have you tried the Solve Button?")
         EndIf
       Case $msg = $ResetButton
         For $row = 0 to 8
           for $col = 0 to 8
             $h = _GridConvert($row, $col, "h")
             $i = _GridConvert($row, $col, "i")
             if $aSudArray[$row][$col] <> 0 Then
               $aSudArray[$row][$col] = $aOrigArray[$row][$col]
             EndIf
           Next
         Next
         if GUICtrlRead($HelperCheckbox) = $GUI_CHECKED Then
           _SudokuEliminator(-1)
         Elseif GUICtrlRead($HelperCheckbox) = $GUI_UNCHECKED Then
           _SudokuInitNormal()
         EndIf
       Case Else
         ;
     EndSelect
   WEnd
EndFunc   ;==>_SudokuGUI

Func _SudokuInitNormal()
   For $row = 0 to 8
     for $col = 0 to 8
       $h = _GridConvert($row, $col, "h")
       $i = _GridConvert($row, $col, "i")
       if $aSudArray[$row][$col]= 0 Then
         GUICtrlSetState($largebuttons[$h][$i],$GUI_HIDE)
         for $aCell = 0 to 8
           GUICtrlSetState($smallbuttons[$h][$i][$aCell],$GUI_SHOW)
         Next
       Else
         GUICtrlSetData($largebuttons[$h][$i], $aSudArray[$row][$col])
         GUICtrlSetState($largebuttons[$h][$i],$GUI_SHOW)
         for $aCell = 0 to 8
           GUICtrlSetState($smallbuttons[$h][$i][$aCell],$GUI_HIDE)
         Next
       EndIf
     Next
   Next
EndFunc   ;==>_SudokuInitNormal

Func _InitGUI()
   For $row = 0 to 8
     for $col = 0 to 8
       $h = _GridConvert($row, $col, "h")
       $i = _GridConvert($row, $col, "i")
       GUICtrlSetState($largebuttons[$h][$i],$GUI_SHOW)
       GUICtrlSetFont($largebuttons[$h][$i],14,1000)
       if $aSudArray[$row][$col] <> 0 Then
         GUICtrlSetState($largebuttons[$h][$i],$GUI_DISABLE)
       EndIf
     Next
   Next
EndFunc   ;==>_InitGUI

Func _SudokuGenerator()
   $oIE = _IECreate("http://view.websudoku.com/?level=" & $Difficulty, 0, 0, 0) ; Disable for testing
;~   $oIE = _IEAttach("http://view.websudoku.com/?level=4", "url")   ; for testing, open in seperate browser before running script
   _SetProgcolor()
   while 1
     if _IEPropertyGet($oIE, "readystate") = 4 Then
       ExitLoop
     Else
       _SetProgcolor()
     EndIf
   WEnd
   _SetProgcolor()
   $oSudForm = _IEFormGetObjByName($oIE, "board")
   _SetProgcolor()
   $oSudInputs = _IEFormElementGetCollection($oSudForm)
   _SetProgcolor()
   
   $row = 0
   $col = 0
   For $oSudInput in $oSudInputs
     $aSudArray[$row][$col] = _IEFormElementGetValue($oSudInput)
     $aOrigArray[$row][$col] = $aSudArray[$row][$col]
     _SetProgcolor()
     If $row = 8 and $col = 8 Then
       ExitLoop
     EndIf
     If $col = 8 Then
       $col = 0
       $row = $row + 1
     Else
       $col = $col + 1
     EndIf
   Next
   
   while $Progress < 1000
     _SetProgcolor()
   WEnd
   
   _IEQuit($oIE)   ; Disable for testing
EndFunc   ;==>_SudokuGenerator

Func _SudokuNormalMode($button, $CID)
   if $button = "small" Then
     ;----- small button clicked -----;
     ; set value in array to number from small box
     $row = _GridConvert($IDtoPosition[$CID][0], $IDtoPosition[$CID][1], "row")
     $col = _GridConvert($IDtoPosition[$CID][0], $IDtoPosition[$CID][1], "col")
     $aSudArray[$row][$col] = GUICtrlRead($CID)
     
     $h = _GridConvert($row, $col, "h")
     $i = _GridConvert($row, $col, "i")
     
     ;hide small buttons in this cell
     for $j = 0 to 8
       GUICtrlSetState($smallbuttons[$h][$i][$j],$GUI_HIDE)
     Next
     
     ;show big button in this cell
     GUICtrlSetData($largebuttons[$h][$i], $aSudArray[$row][$col])
     GUICtrlSetState($largebuttons[$h][$i],$GUI_SHOW)
   Elseif $button = "big" Then
     ;----- big button clicked -----;
     ; value is already zero in button and array
     $row = _GridConvert($IDtoPosition[$CID][0], $IDtoPosition[$CID][1], "row")
     $col = _GridConvert($IDtoPosition[$CID][0], $IDtoPosition[$CID][1], "col")
     $h = _GridConvert($row, $col, "h")
     $i = _GridConvert($row, $col, "i")
     
     ;show small buttons in this cell
     for $j = 0 to 8
       GUICtrlSetState($smallbuttons[$h][$i][$j],$GUI_SHOW)
     Next
     
     ; hide big button in this cell
     GUICtrlSetState($largebuttons[$h][$i],$GUI_HIDE)
   EndIf
EndFunc   ;==>_SudokuNormalMode

Func _SudokuSolver()
   ; Methods
   ; 1. check for cells that have one possibility
   ; 2. check boxes/rows/cols for a cell that has a possibility no other cell has
   ; 3. Not implemented:Check for cells that depend on eachother to eliminate other possibilities?
   GUICtrlSetState($HelperCheckbox, $GUI_CHECKED)
   $count = 0
   $DoneYet = _SudokuEliminator(-1)
   while 1
     _SudokuSolver1()
     _SudokuSolver2()
     $CantSolve = $DoneYet
     $DoneYet = _SudokuEliminator(-1)
     if $DoneYet = 81 Then
       ExitLoop
     ElseIf $count = 2 Then
       ExitLoop
     ElseIf $CantSolve = $DoneYet Then
       $count = $count + 1
     EndIf
   WEnd
   
   while $Progress <> 0
     _SetProgcolor()
   WEnd
EndFunc   ;==>_SudokuNormalMode

Func _SudokuSolver1()
   _SudokuEliminator(-1)
   ; done checking board, all case 1 solutions are in $SolutionsArray
   for $x = 0 to $SolutionsCount - 1
     $aSudArray[$SolutionsArray[$x][0]][$SolutionsArray[$x][1]] = $SolutionsArray[$x][2]
   Next
EndFunc   ;==>_SudokuSolver1

Func _SudokuSolver2()
   Dim $SolutionsArray2[81][3]
   Dim $Case2Array[10][3]

   $SolutionsCount = 0
   
   For $row = 0 to 8
     ; Check Column
     For $x = 0 to 9
       $Case2Array[$x][2] = 0
     Next
     For $inCol = 0 to 8
       For $aChoice = 1 to 9
         _SetProgcolor()
         if $PossibilityArray[$row][$inCol][$aChoice] = 1 Then
           $Case2Array[$aChoice][0] = $row
           $Case2Array[$aChoice][1] = $inCol
           $Case2Array[$aChoice][2] = $Case2Array[$aChoice][2] + 1
         EndIf
       Next
     Next
     ; done checking Column, check for $aChoice's = 1
     for $aChoice = 1 to 9
       _SetProgcolor()
       if $Case2Array[$aChoice][2] = 1 Then
         $SolutionsArray2[$SolutionsCount][0] = $Case2Array[$aChoice][0]
         $SolutionsArray2[$SolutionsCount][1] = $Case2Array[$aChoice][1]
         $SolutionsArray2[$SolutionsCount][2] = $aChoice
         $SolutionsCount = $SolutionsCount + 1
       EndIf
     Next
   Next
   
   For $col = 0 to 8
     ; Check Row
     For $x = 0 to 9
       $Case2Array[$x][2] = 0
     Next
     For $inRow = 0 to 8
       For $aChoice = 1 to 9
         _SetProgcolor()
         if $PossibilityArray[$inRow][$col][$aChoice] = 1 Then
           $Case2Array[$aChoice][0] = $inRow
           $Case2Array[$aChoice][1] = $col
           $Case2Array[$aChoice][2] = $Case2Array[$aChoice][2] + 1
         EndIf
       Next
     Next
     ; done checking Row, check for $aChoice's = 1
     for $aChoice = 1 to 9
       _SetProgcolor()
       if $Case2Array[$aChoice][2] = 1 Then
         $SolutionsArray2[$SolutionsCount][0] = $Case2Array[$aChoice][0]
         $SolutionsArray2[$SolutionsCount][1] = $Case2Array[$aChoice][1]
         $SolutionsArray2[$SolutionsCount][2] = $aChoice
         $SolutionsCount = $SolutionsCount + 1
       EndIf
     Next
   Next
   
   ; now check $PossibilityArray for each box to find case 2 solutions
   For $row = 0 to 6 step 3
     for $col = 0 to 6 step 3
       For $x = 0 to 9
         $Case2Array[$x][2] = 0
       Next
       $aStrCol = floor($col/3)*3
       $aEndCol = floor($col/3)*3+2
       $aStrRow = floor($row/3)*3
       $aEndRow = floor($row/3)*3+2
       for $inRow = $aStrRow to $aEndRow
         for $inCol = $aStrCol to $aEndCol
           for $aChoice = 1 to 9
             _SetProgcolor()
             if $PossibilityArray[$inRow][$inCol][$aChoice] = 1 Then
               $Case2Array[$aChoice][0] = $inRow
               $Case2Array[$aChoice][1] = $inCol
               $Case2Array[$aChoice][2] = $Case2Array[$aChoice][2] + 1
             EndIf
           Next
         Next
       Next
       ; done checking box, check for $aChoice's = 1
       for $aChoice = 1 to 9
         _SetProgcolor()
         if $Case2Array[$aChoice][2] = 1 Then
           $SolutionsArray2[$SolutionsCount][0] = $Case2Array[$aChoice][0]
           $SolutionsArray2[$SolutionsCount][1] = $Case2Array[$aChoice][1]
           $SolutionsArray2[$SolutionsCount][2] = $aChoice
           $SolutionsCount = $SolutionsCount + 1
         EndIf
       Next
     Next
   Next
   
   
   for $x = 0 to $SolutionsCount - 1
     $aSudArray[$SolutionsArray2[$x][0]][$SolutionsArray2[$x][1]] = $SolutionsArray2[$x][2]
   Next
EndFunc   ;==>_SudokuSolver2

Func _SudokuSolver3() ; doesn't quite work
   Dim $Case3Array[10][6]
   
   ; now check $PossibilityArray for each box to find case 3 solutions
   For $row = 0 to 6 step 3
     for $col = 0 to 6 step 3
       For $x = 0 to 9
         $Case3Array[$x][2] = 0
         $Case3Array[$x][5] = 0
       Next
       $aStrCol = floor($col/3)*3
       $aEndCol = floor($col/3)*3+2
       $aStrRow = floor($row/3)*3
       $aEndRow = floor($row/3)*3+2
       for $inRow = $aStrRow to $aEndRow
         for $inCol = $aStrCol to $aEndCol
           for $aChoice = 1 to 9
             _SetProgcolor()
             If $Case3Array[$aChoice][5] > 1 Then
               ;skip
             Elseif $PossibilityArray[$inRow][$inCol][$aChoice] = 1 Then
               If $Case3Array[$aChoice][2] = 0 Then
                 $Case3Array[$aChoice][0] = $inRow
                 $Case3Array[$aChoice][1] = $inCol
                 $Case3Array[$aChoice][2] = $Case3Array[$aChoice][2] + 1
               ElseIf $Case3Array[$aChoice][5] = 0 Then
                 $Case3Array[$aChoice][3] = $inRow
                 $Case3Array[$aChoice][4] = $inCol
                 $Case3Array[$aChoice][5] = $Case3Array[$aChoice][5] + 1
               Else
                 $Case3Array[$aChoice][5] = $Case3Array[$aChoice][5] + 1
               EndIf
             EndIf
           Next
         Next
       Next
       ; done checking box, check for $aChoice's = 1
       for $aChoice = 1 to 9
         _SetProgcolor()
         if $Case3Array[$aChoice][5] = 1 Then
           if $Case3Array[$aChoice][0] = $Case3Array[$aChoice][3] Then
             ; we found 2 unique in box in a row, eliminate others in this row
             For $inCol = 0 to 8
               $inRow = $Case3Array[$aChoice][0]
               if $inCol = $Case3Array[$aChoice][1] or $inCol = $Case3Array[$aChoice][4] Then
                 ; do nothing
               Else
                 $PossibilityArray[$inRow][$inCol][$aChoice] = 0
                 $h = _GridConvert($inRow, $inCol, "h")
                 $i = _GridConvert($inRow, $inCol, "i")
                 GUICtrlSetState($smallbuttons[$h][$i][$aChoice-1],$GUI_HIDE)
               EndIf
             Next
           ElseIf $Case3Array[$aChoice][1] = $Case3Array[$aChoice][4] Then
             ; we found 2 unique in box in a col, eliminate others in this col
             For $inRow = 0 to 8
               $inCol = $Case3Array[$aChoice][1]
               if $inRow = $Case3Array[$aChoice][0] or $inRow = $Case3Array[$aChoice][3] Then
                 ; do nothing
               Else
                 $PossibilityArray[$inRow][$inCol][$aChoice] = 0
                 $h = _GridConvert($inRow, $inCol, "h")
                 $i = _GridConvert($inRow, $inCol, "i")
                 GUICtrlSetState($smallbuttons[$h][$i][$aChoice-1],$GUI_HIDE)
               EndIf
             Next
           EndIf
         EndIf
       Next
     Next
   Next
EndFunc   ;==>_SudokuSolver3

Func _SudokuEliminator($CID)
   Dim $SolutionsArray[81][3]
   Dim $PossibilityArray[9][9][10]
   $SolutionsCount = 0
   
   $isSolved = 0
   if $CID = -1 Then
     ;----- Eliminator/check all = will check entire board and reset as necessary
     $StartCol = 0
     $StartRow = 0
     $EndCol = 8
     $EndRow = 8
     $HideNumber = 0 ;value to run main program checks on
   Else
     ;----- Eliminator/small button clicked -----;
     ; set value in array to number from small box
     $row = _GridConvert($IDtoPosition[$CID][0], $IDtoPosition[$CID][1], "row")
     $col = _GridConvert($IDtoPosition[$CID][0], $IDtoPosition[$CID][1], "col")
     $aSudArray[$row][$col] = GUICtrlRead($CID)
     $HideNumber = $aSudArray[$row][$col]
     
     $StartCol = $col
     $StartRow = $row
     $EndCol = $col
     $EndRow = $row
   EndIf
   
   For $row = $StartRow to $EndRow
     for $col = $StartCol to $EndCol
       $h = _GridConvert($row, $col, "h")
       $i = _GridConvert($row, $col, "i")
       
       If $CID <> -1 Then ;----- Eliminator/sb clicked = hide the small buttons in this cell
         for $j = 0 to 8
           GUICtrlSetState($smallbuttons[$h][$i][$j],$GUI_HIDE)
         Next
       EndIf
       
       ; in normal mode, this "if" runs through any cell that does not have a big button
       ; in sb clicked mode, this "if" runs through just the cell that was clicked
       if $aSudArray[$row][$col]= $HideNumber Then
         
         If $CID = -1 Then ;----- Eliminator/check all = here, this cell is value 0, so hide the big button
           GUICtrlSetState($largebuttons[$h][$i],$GUI_HIDE)
           For $x = 0 to 9
             $aEnumArray[$x] = True ;----- Eliminator/check all = initialize array of possible choices
           Next
         Else ;----- Eliminator/sb clicked = replace cell w/ big button of value = sb clicked
           GUICtrlSetData($largebuttons[$h][$i], $HideNumber)
           GUICtrlSetState($largebuttons[$h][$i],$GUI_SHOW)
         EndIf
         
         for $inCol = 0 to 8
           _SetProgcolor()
           if $CID <> -1 Then ;----- Eliminator/sb clicked = hide the number clicked in this column
             $h = _GridConvert($row, $inCol, "h")
             $i = _GridConvert($row, $inCol, "i")
             GUICtrlSetState($smallbuttons[$h][$i][$HideNumber-1],$GUI_HIDE)
           ElseIf $aSudArray[$row][$inCol] <> 0 Then ;----- Eliminator/check all = check column cells that won't be possible to pick
             $aEnumArray[$aSudArray[$row][$inCol]] = False
             $PossibilityArray[$row][$inCol][$aSudArray[$row][$inCol]] = 0
           EndIf
         Next
         
         for $inRow = 0 to 8
           _SetProgcolor()
           if $CID <> -1 Then ;----- Eliminator/sb clicked = hide the number clicked in this row
             $h = _GridConvert($inRow, $col, "h")
             $i = _GridConvert($inRow, $col, "i")
             GUICtrlSetState($smallbuttons[$h][$i][$HideNumber-1],$GUI_HIDE)
           ElseIf $aSudArray[$inRow][$col] <> 0 Then ;----- Eliminator/check all = check row cells that won't be possible to pick
             $aEnumArray[$aSudArray[$inRow][$col]] = False
             $PossibilityArray[$inRow][$col][$aSudArray[$inRow][$col]] = 0
           EndIf
         Next
         
         ; define where the box starts/ends for row/col
         $aStrCol = floor($col/3)*3
         $aEndCol = floor($col/3)*3+2
         $aStrRow = floor($row/3)*3
         $aEndRow = floor($row/3)*3+2
         for $inRow = $aStrRow to $aEndRow
           for $inCol = $aStrCol to $aEndCol
             _SetProgcolor()
             if $CID <> -1 Then ;----- Eliminator/sb clicked = hide the number clicked in this box
               $h = _GridConvert($inRow, $inCol, "h")
               $i = _GridConvert($inRow, $inCol, "i")
               GUICtrlSetState($smallbuttons[$h][$i][$HideNumber-1],$GUI_HIDE)
             ElseIf $aSudArray[$inRow][$inCol] <> 0 Then ;----- Eliminator/check all = check the current box for cells that can't be picked
               $aEnumArray[$aSudArray[$inRow][$inCol]] = False
               $PossibilityArray[$inRow][$inCol][$aSudArray[$inRow][$inCol]] = 0
             EndIf
           Next
         Next
         
         if $CID = -1 Then
           
           $count = 0
           for $aCell = 1 to 9
             _SetProgcolor()
             if $aEnumArray[$aCell] = True Then  ;----- Eliminator/ check all = show/hide sb's for every cell in sudoku
               GUICtrlSetState($smallbuttons[$h][$i][$aCell-1],$GUI_SHOW)
               ; for first case solution:
               $count = $count + 1
               $SolutionsArray[$SolutionsCount][0] = $row
               $SolutionsArray[$SolutionsCount][1] = $col
               $SolutionsArray[$SolutionsCount][2] = $aCell
               
               ; for second case solution:
               $PossibilityArray[$row][$col][$aCell] = 1
             Else
               GUICtrlSetState($smallbuttons[$h][$i][$aCell-1],$GUI_HIDE)
               $PossibilityArray[$row][$col][$aCell] = 0
             EndIf
           Next
           
           if $count = 1 Then ; we found a cell that only has only one possibility!
             $SolutionsCount = $SolutionsCount + 1
           Else
             $SolutionsArray[$SolutionsCount][2] = -1
           EndIf
           
         EndIf
       Else
         ; only get here in Eliminator/check all = set data and show large buttons for every cell that has been clicked.
         ; also hide all small buttons for these same cells so that there's no overlap.
         $isSolved = $isSolved + 1
         GUICtrlSetData($largebuttons[$h][$i], $aSudArray[$row][$col])
         GUICtrlSetState($largebuttons[$h][$i],$GUI_SHOW)
         For $aCell = 1 to 9
           GUICtrlSetState($smallbuttons[$h][$i][$aCell-1],$GUI_HIDE)
           $PossibilityArray[$row][$col][$aCell] = 0
         Next
       EndIf
     Next
   Next
   while $Progress <> 0
     _SetProgcolor()
   WEnd
   Return $isSolved
EndFunc   ;==>_SudokuEliminator

Func _SetProgcolor() ; credit to PsaltyDS!
   if $Progress = 1000 Then
     $increment = -1
   elseif $Progress = 0 Then
     $increment = +1
   EndIf
   
   $Progress = $Progress + $increment
   If $Progress < 0 Then $Progress = 0
   If $Progress > 1000 Then $Progress = 1000
   GUICtrlSetData($ProgressBar, Int($Progress / 10))

   $Redness = Int(255 - ($Progress / 1000 * 512))
   If $Redness < 0 Then $Redness = 0

   $Greeness = Int(($Progress / 1000 * 512) - 257)
   If $Greeness < 0 Then $Greeness = 0

   $Blueness = Int(255 - ($Redness + $Greeness))

   $Progcolor = ($Redness * 256 * 256) + ($Greeness * 256) + $Blueness
   GUICtrlSetcolor($ProgressBar, $Progcolor)
EndFunc   ;==>_SetProgcolor

Func _GridConvert($x, $y, $var) ;$x = $row = $h, $y = $col = $i
   If $var = "row" or $var = "h" Then
     Return floor($x / 3)*3 + floor($y / 3)
   ElseIf $var = "col" or $var = "i" Then
     Return ($x - floor($x/3)*3) * 3 + $y - floor($y/3)*3
   EndIf
EndFunc   ;==>_GridConvert

Func _CreateSmallButton($h, $i, $j)
   Return GUICtrlCreateButton($j + 1, 10 + Mod($h, 3) * 230 + Mod($i, 3) * 70 + Mod($j, 3) * 20, _
       10 + Int($h / 3) * 230 + Int($i / 3) * 70 + Int($j / 3) * 20, 20, 20)
EndFunc   ;==>_CreateSmallButton

Func _CreateLargeButton($h, $i, $j)
   Return GUICtrlCreateButton($j + 1, 10 + Mod($h, 3) * 230 + Mod($i, 3) * 70, _
       10 + Int($h / 3) * 230 + Int($i / 3) * 70, 60, 60)
EndFunc   ;==>_CreateLargeButton