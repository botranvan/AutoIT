#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         LeeSai

 Script Function:
	Excel Report

#ce ----------------------------------------------------------------------------


#include <Excel.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>

HotKeySet('{esc}','_exit')

Local $FileName = InputBox('Tên file','Nhập tên file excel cần báo cáo','DoiSoat-T7')
Local $DataSheetName = $FileName

Local $sWorkbook = @ScriptDir & '\'&$FileName&'.xls'
Local $ReportHeader = False


; Create application object
Local $oAppl = _Excel_Open()
If @error Then Exit MsgBox(16, "Excel UDF: _Excel_BookOpen Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)


; Open workbook
Local $oWorkbook = _Excel_BookOpen($oAppl, $sWorkbook, Default, Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookOpen Example 1", "Error opening '" & $sWorkbook & "'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)



_Report_Process()

Exit



;~ == Functions ===================================

;~ _exit
Func _exit()
	Exit
EndFunc


;~ _Report_Process
Func _Report_Process()

	Local $ColumnNumber = 0
	Local $Row = 0
	Local $iCol = ''
	Local $sResult = ''
	Local $Cell = ''
	Local $Day = 0
	Local $CardType = ''
	Local $CardNumber = 0

	While 1
;~ 		Sleep(72)
		$Row+=1
		$ColumnNumber+=1

		$iCol = _Excel_ColumnToLetter ( $ColumnNumber )
		$Cell = $iCol&$Row

		ConsoleWrite('=========================='&@CRLF)
		ConsoleWrite('$Cell: '&$Cell&@CRLF)

		If(Not _RowIsRight($Row)) Then ContinueLoop

		_RowFixed($Row)

	WEnd
EndFunc


;~ _RowIsRight
Func _RowIsRight($Row)
	Local $Cell = 'D'&$Row
	Local $DataCheck = 'Mua mã PIN'

	Local $sResult = _Excel_RangeRead($oWorkbook, $DataSheetName, $Cell)
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeRead Example 1", "Error reading from workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

	If $DataCheck == $sResult Then Return True

	Return false
EndFunc

;~ _RowFixed
Func _RowFixed($Row)
	Local $Cell = 'G'&$Row
	Local $CardType = ''

	Local $sResult = _Excel_RangeRead($oWorkbook, $DataSheetName, $Cell)
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeRead Example 1", "Error reading from workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

	$sResult = StringSplit($sResult,' ')
	$sResult[1] = Random(1,50,1)
	Local $NewData = ''
	For $i = 1 To $sResult[0]
		$NewData&= $sResult[$i]&' '
	Next

	_Excel_RangeWrite ( $oWorkbook, $DataSheetName, $NewData ,$Cell)

	ConsoleWrite($NewData&@CRLF)
	TrayTip ($Cell, $NewData, 1,1)
EndFunc