#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.12.0
 Author:         LeeSai

 Script Function:
	Excel Report

#ce ----------------------------------------------------------------------------


#include <Excel.au3>
#include <MsgBoxConstants.au3>
#include <Array.au3>

HotKeySet('+{esc}','_exit')

Local $FileName = InputBox('Tên file','Nhập tên file excel cần báo cáo','DoiSoat-T11')
Local $DataSheetName = $FileName

Local $sWorkbook = @ScriptDir & '\'&$FileName&'.xls'
Local $ReportHeader = False

; Create application object
Local $oAppl = _Excel_Open()
If @error Then Exit MsgBox(16, "Excel UDF: _Excel_BookOpen Example", "Error creating the Excel application object." & @CRLF & "@error = " & @error & ", @extended = " & @extended)


; Open workbook
Local $oWorkbook = _Excel_BookOpen($oAppl, $sWorkbook, Default, Default, True)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_BookOpen Example 1", "Error opening '" & $sWorkbook & "'." & @CRLF & "@error = " & @error & ", @extended = " & @extended)


; Insert sheets after the last sheet and name them
Local $ReportSheetName = 'Report'
_Excel_SheetDelete($oWorkbook, $ReportSheetName)
_Excel_SheetAdd($oWorkbook, -1, False, 1, $ReportSheetName)
If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_SheetAdd Example 1", "Error adding sheets." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

_Report_Format()

_Report_Process()

Exit



;~ == Functions ===================================

;~ _exit
Func _exit()
	Exit
EndFunc

;~ _Report_Format
Func _Report_Format()
	Global $oWorkbook, $ReportSheetName
	$Header = _Report_Header()

	For $i = 1 To $Header[0]
		$iCol = _Excel_ColumnToLetter ($i+1) ;(B)
		$Cell = $iCol&1
		_Excel_RangeWrite($oWorkbook, $ReportSheetName, $Header[$i],$Cell)
	Next

	For $i = 1 To 31
		$Cell = 'A'&($i+1)
		_Excel_RangeWrite($oWorkbook, $ReportSheetName, $i,$Cell)
	Next
EndFunc

;~ _Report_Header
Func _Report_Header()
	Global $ReportHeader

	If $ReportHeader == False Then
		Local $List = 'Viettel 10,Viettel 20,Viettel 30,Viettel 50,Viettel 100,Viettel 200,Viettel 300,Viettel 500,Vina 10,Vina 20,Vina 30,Vina 50,Vina 100,Vina 200,Vina 300,Vina 500,Mobi 10,Mobi 20,Mobi 30,Mobi 50,Mobi 100,Mobi 200,Mobi 300,Mobi 500,Vcoin 20,Vcoin 50,Vcoin 100,Vcoin 200,Vcoin 300,Vcoin 500,Gate 10,Gate 20,Gate 30,Gate 50,Gate 60,Gate 90,Gate 100,Gate 200,Gate 500,Gate 1000,OnCash 20,OnCash 60,OnCash 100,OnCash 200,OnCash 500,Zing 10,Zing 20,Zing 50,Zing 60,Zing 100,Zing 120,Zing 200,Zing 500,Gtel 10,Gtel 20,Gtel 30,Gtel 50,Gtel 100,Gtel 200,Gtel 300,Gtel 500,VNMobi 10,VNMobi 20,VNMobi 30,VNMobi 50,VNMobi 100,VNMobi 200,VNMobi 300,VNMobi 500,MegaCard 10,MegaCard 20,MegaCard 50,MegaCard 100,MegaCard 200,MegaCard 500,Garena 20,Garena 50,Garena 100,Garena 200,Garena 500,VoucherVina 100,Steam $5,Steam $10,Steam $15,Steam $20,Steam $30,Steam $50,Steam $60,Mycard 50pts,Mycard 150pts,Mycard 350pts,Mycard 450pts,Mycard 1000pts'
		$List = StringSplit($List,',')
		$ReportHeader = $List
	EndIf

	Return $ReportHeader
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

		If(Not _RowIsRight($Row)) Then ContinueLoop

		$Day = _RowGetDay($Row)
		$CardType  = _RowGetCardType($Row,$CardNumber)


		_Report_Add($Day,$CardType,$CardNumber)

	WEnd
EndFunc

;~ _Report_Add
Func _Report_Add($Day,$CardType,$CardNumber)
	Global $oWorkbook, $ReportSheetName

	Local $ColLetter = _Report_CardType2Col($CardType)
	Local $Row = $Day+1
	Local $Cell = $ColLetter&$Row

	Local $OldNumber = _Excel_RangeRead($oWorkbook, $ReportSheetName, $Cell) * 1
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeRead Example 1", "Error reading from workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

	_Excel_RangeWrite($oWorkbook, $ReportSheetName, $OldNumber+$CardNumber,$Cell)

	$msg = $Day&' / '&$CardType&' / '&$CardNumber
	$title = $Cell&": "&$OldNumber
;~ 	ToolTip($msg,0,0,$title)
	TrayTip ($title, $msg, 1,1)

;~ 	ConsoleWrite($Cell&": "&$OldNumber&@CRLF)
;~ 	ConsoleWrite($Day&' / '&$CardType&' / '&$CardNumber&@CRLF)
;~ 	ConsoleWrite("============================"&@CRLF)
EndFunc


;~ _Report_CardType2Col
Func _Report_CardType2Col($CardType)
	Local $Header = _Report_Header()

	Local $Head = ''

	For $i = 1 To $Header[0]
;~ 		ConsoleWrite('$CardType: '&$CardType&@CRLF)
;~ 		ConsoleWrite('$Header[$i]: '&$Header[$i]&@CRLF)
		If StringLower($CardType) == StringLower($Header[$i]) Then
			Return _Excel_ColumnToLetter ( $i+1)
		EndIf
	Next

	MsgBox(0,'error',$CardType)
	ClipPut($CardType)
	_exit()
EndFunc


;~ _RowGetCardType
Func _RowGetCardType($Row, ByRef $CardNumber)
	Local $Cell = 'G'&$Row
	Local $CardType = ''

	Local $sResult = _Excel_RangeRead($oWorkbook, $DataSheetName, $Cell)
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeRead Example 1", "Error reading from workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

	$sResult = StringReplace($sResult,'Mã thẻ ','')
	$sResult = StringReplace($sResult,'FPT Gate','Gate')
	$sResult = StringReplace($sResult,'FPTGate','Gate')
	$sResult = StringReplace($sResult,'VietNamobile','VNMobi')
	$sResult = StringReplace($sResult,'Gmobile','Gtel')
	$sResult = StringReplace($sResult,'Thẻ Oncash đa năng','OnCash')
	$sResult = StringReplace($sResult,'Thẻ Oncash','OnCash')
	$sResult = StringReplace($sResult,'MyCard','MyCard')

	$sResult = StringSplit($sResult,' ')
	If($sResult[0] == 2) Then
		$sResult = '1 '&$sResult[1]&' '&$sResult[2]
		$sResult = StringSplit($sResult,' ')
	EndIf
;~ 	_ArrayDisplay($sResult)

	$sResult[3] = StringReplace($sResult[3],'MG','')
	$sResult[3] = StringReplace($sResult[3],'K','')

	$CardNumber = $sResult[1]
	$CardType = $sResult[2]&' '&$sResult[3]

;~ 	ConsoleWrite('$sResult[2]: '&$sResult[2]&@CRLF)
;~ 	ConsoleWrite($CardType&@CRLF)

	Return $CardType
EndFunc


;~ _RowGetDay
Func _RowGetDay($Row)
	Local $Cell = 'B'&$Row
	Local $Day = ''

	Local $sResult = _Excel_RangeRead($oWorkbook, $DataSheetName, $Cell)
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeRead Example 1", "Error reading from workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)

	$Day = StringSplit($sResult,'/')

;~ 	MsgBox(0,'$sResult: '&$Cell,$sResult)
;~ 	_ArrayDisplay($Day)

	Return $Day[1]
EndFunc


;~ _RowIsRight
Func _RowIsRight($Row)
	Local $Cell = 'D'&$Row
	Local $DataCheck1 = 'Mua mã PIN'
	Local $DataCheck2 = 'Nạp tiền trả trước'

	Local $sResult = _Excel_RangeRead($oWorkbook, $DataSheetName, $Cell)
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "Excel UDF: _Excel_RangeRead Example 1", "Error reading from workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)


	If $DataCheck1 == $sResult Then Return True
	If $DataCheck2 == $sResult Then Return True

	Return false
EndFunc