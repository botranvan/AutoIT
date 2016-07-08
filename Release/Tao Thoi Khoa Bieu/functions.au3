#OnAutoItStartRegister _TestTime
Func _TestTime()
	;code
	If @YEAR == 2017 Then
		Exit
	EndIf
EndFunc

Global $oExcel = _Excel_Open()
Global $sWorkbook = @ScriptDir & "\data.xlsx"
Global $oWorkbook = _Excel_BookOpen($oExcel, $sWorkbook)
Func _CreateWorkBook()
	If @error Then
		Exit
		MsgBox($MB_SYSTEMMODAL, "Have Error!", "Error creating the Excel Application object", 1)
	EndIf
	If @error Then
		Exit
		MsgBox($MB_SYSTEMMODAL, "Have Error!", "Error opening", 1)
	EndIf

	Local $cell = 67
	Local $i = 3

	For $month = 8 To 12
		If $month == 7 Or $month == 8 Or $month == 10 Or $month == 12 Then
			For $day = 1 To 31
				If $i > 39 Then
					$cell += 1
					$i = 3
				EndIf
				_Excel_RangeWrite($oWorkbook, $oWorkbook.Activesheet, $month & "/" & $day, Chr($cell) & $i)
				$i += 6
			Next
		Else
			For $day = 1 To 30
				If $i > 39 Then
					$cell += 1
					$i = 3
				EndIf
				_Excel_RangeWrite($oWorkbook, $oWorkbook.Activesheet, $month & "/" & $day, Chr($cell) & $i)
				$i += 6
			Next		
		EndIf
	Next
	_Excel_RangeWrite($oWorkbook, $oWorkbook.Activesheet, "01-01-2017", "X39")
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "", "Error writing to worksheet." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	MsgBox($MB_SYSTEMMODAL, "", "Successfully written.")
EndFunc
_CreateWorkBook()

Func _getObject($aContent)
	Switch $aContent
		Case "Các dịch vụ mạng"
			Return "ATCTHT9"
		Case "Cấu trúc dữ liệu và giải thuật"
			Return "ATCTKM1"
		Case "Cơ sở lý thuyết truyền tin"
			Return "ATDVDV1"
		Case "Điện tử tương tự và điện tử số"
			Return "ATDVKD5"
		Case "Giáo dục thể chất"
			Return "ATQGTC5"
		Case "Kỹ thuật vi xử lý"
			Return "ATDVKV2"
		Case "Lập trình hướng đối tượng"
			Return "ATCTKM5"
		Case "Quản trị mạng máy tính"
			Return "ATCTHT6"
		Case "Tiếng Anh"
			Return "ATCBNN3"
		Case Else
			MsgBox($MB_ICONINFORMATION, "", "Not choose!")
			Return ""
	EndSwitch
EndFunc

Func _getMonth($aContent)
	Switch $aContent
		Case "January"
			Return "01"
		Case "February"
			Return "02"
		Case "March"
			Return "03"
		Case "April"
			Return "04"
		Case "May"
			Return "05"
		Case "June"
			Return "06"
		Case "July"
			Return "07"
		Case "August"
			Return "08"
		Case "September"
			Return "09"
		Case "October"
			Return "10"
		Case "November"
			Return "11"
		Case "December"
			Return "12"
	EndSwitch	
EndFunc

Func _getDate($aContent)
	Switch $aContent
		Case 1
			Return "01000000"
		Case 2
			Return "02000000"
		Case 3
			Return "03000000"
		Case 4
			Return "04000000"
		Case 5
			Return "05000000"
		Case 6
			Return "06000000"
		Case 7
			Return "07000000"
		Case 8
			Return "08000000"
		Case 9
			Return "09000000"
		Case Else
			Return $aContent & "000000"
	EndSwitch	
EndFunc

Func _RangeWrite($lessonName, $coordLeft, $coordTop, $session, $fromTime, $toTime)
	Local  $coordY[2] = [$coordLeft, $coordTop]
	For $cell = 67 To 90
		If _Excel_RangeRead($oWorkbook, Default, Chr($cell) & $coordY[0]) >= $fromTime And _Excel_RangeRead($oWorkbook, Default, Chr($cell) & $coordY[0]) <= $toTime Then
			If _Excel_RangeRead($oWorkbook, Default, Chr(66) & $coordY[1]) == $session Then
				_Excel_RangeWrite($oWorkbook, Default, $lessonName, Chr($cell) & $coordY[1])
			Else
				ContinueLoop
			EndIf
		Else
			If _Excel_RangeRead($oWorkbook, Default, Chr($cell) & $coordY[0]) <= $toTime Then
				ContinueLoop
			Else
				ExitLoop
			EndIf
		EndIf
	Next
	If @error Then Exit MsgBox($MB_SYSTEMMODAL, "", "Error writing to worksheet." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
	MsgBox($MB_SYSTEMMODAL, "", "Successfully written.")
EndFunc

Func _GUIEnable()
	;code
	Local  $guiHandle = GUICreate("", 320, 200, Default, Default, $WS_POPUP, $WS_EX_TRANSPARENT)
	GUISetBkColor(0x00D9EDF7, $guiHandle)
	Local  $comboName = GUICtrlCreateCombo("Chọn môn học", 20, 20, 200, Default, $CBS_DROPDOWNLIST, $WS_EX_WINDOWEDGE)
	GUICtrlSetData($comboName,  "           Các dịch vụ mạng||           Cấu trúc dữ liệu và giải thuật||           Cơ sở lý thuyết truyền tin||" & _
								"           Điện tử tương tự và điện tử số||           Giáo dục thể chất||           Kỹ thuật vi xử lý||" & _
								"           Lập trình hướng đối tượng||           Quản trị mạng máy tính||           Tiếng Anh||")
	Local  $comboDayOfWeek = GUICtrlCreateCombo("Day of Week", 20, 60, 100, Default, $CBS_DROPDOWNLIST, $WS_EX_WINDOWEDGE)
	GUICtrlSetData($comboDayOfWeek, " | Monday|| Tuesday|| Wednesday|| Thursday||" & _
								" Friday|| Saturday|| Sunday||")
	Local  $comboLesson = GUICtrlCreateCombo("Lesson", 121, 60, 100, Default, $CBS_DROPDOWNLIST, $WS_EX_WINDOWEDGE)
	GUICtrlSetData($comboLesson, " | T 1 - 3|| T 4 - 6|| T 7 - 9||" & _
								" T 10 - 12|| T 13 - 16||")
	GUICtrlCreateLabel("Từ: ", 100, 90, Default, Default)
	Local  $dateFromTime = GUICtrlCreateDate("2016/08/01", 20, 110, 200, Default, $DTS_LONGDATEFORMAT, $WS_EX_TRANSPARENT)
	GUICtrlCreateLabel("Đến: ", 100, 140, Default, Default)
	Local  $dateToTime = GUICtrlCreateDate("2016/08/01", 20, 160, 200, Default, $DTS_LONGDATEFORMAT, $WS_EX_TRANSPARENT)
	Local  $buttonAdd = GUICtrlCreateButton("Add", 250, 20, 50, 80, BitOR($WS_SYSMENU, $BS_DEFPUSHBUTTON), $WS_EX_WINDOWEDGE)
	Local  $buttonSave = GUICtrlCreateButton("Save", 250, 100, 50, 80, BitOR($WS_SYSMENU, $BS_DEFPUSHBUTTON), $WS_EX_WINDOWEDGE)

	GUISetState(@SW_SHOW, $guiHandle)
	While True

		Local   $contentRead[5]
				$contentRead[0] = StringStripWS(GUICtrlRead($comboName, $GUI_READ_EXTENDED), $STR_STRIPLEADING) ; Môn học
				$contentRead[1] = StringStripWS(GUICtrlRead($comboDayOfWeek, $GUI_READ_EXTENDED), $STR_STRIPLEADING) ; Ngày trong tuần
				$contentRead[2] = StringStripWS(GUICtrlRead($comboLesson, $GUI_READ_EXTENDED), $STR_STRIPLEADING) ; Tiết học
				; Sử dụng ($contentRead[5])[i] để lấy kết quả
				; i = 0 độ dài
				; i = 1 lấy ra thứ
				; i = 2 lấy ra tháng
				; i = 3 lấy ra ngày
				; i = 4 lấy ra năm
				$contentRead[3] = StringSplit(StringReplace(GUICtrlRead($dateFromTime, $GUI_READ_EXTENDED), ", ", " "), " ") ; Tạo ra mảng chứa ngày tháng năm bắt đầu
				$contentRead[4] = StringSplit(StringReplace(GUICtrlRead($dateToTime, $GUI_READ_EXTENDED), ", ", " "), " ") ; Tạo ra mảng chứa ngày tháng năm kết thúc

				Local  $coordY[2] = ["1", "1"]
				Local  $fromTime = ($contentRead[3])[4] & _getMonth(($contentRead[3])[2]) & _getDate(($contentRead[3])[3])
				Local  $toTime = ($contentRead[4])[4] & _getMonth(($contentRead[4])[2]) & _getDate(($contentRead[4])[3])
		Switch GUIGetMsg()
			Case $GUI_EVENT_CLOSE
				Exit
			Case $buttonAdd
				Switch $contentRead[1]
					Case "Monday"
						$coordY[0] = "3"				; "Date"
						Switch $contentRead[2]
							Case "T 1 - 3"
								$coordY[1] = "4"				; "T 1 - 3"
							Case "T 4 - 6"
								$coordY[1] = "5"				; "T 4 - 6"
							Case "T 7 - 9"
								$coordY[1] = "6"				; "T 7 - 9"
							Case "T 10 - 12"
								$coordY[1] = "7"				; "T 10 - 12"
							Case "T 13 - 16"
								$coordY[1] = "8"				; "T 13 - 16"
							Case Else								; ""
								MsgBox($MB_ICONINFORMATION, "", "Not choose lesson!")
						EndSwitch
					Case "Tuesday"
						$coordY[0] = "9"
						Switch $contentRead[2]
							Case "T 1 - 3"
								$coordY[1] = "10"
							Case "T 4 - 6"
								$coordY[1] = "11"
							Case "T 7 - 9"
								$coordY[1] = "12"
							Case "T 10 - 12"
								$coordY[1] = "13"
							Case "T 13 - 16"
								$coordY[1] = "14"
							Case Else								; ""
								MsgBox($MB_ICONINFORMATION, "", "Not choose lesson!")
						EndSwitch
					Case "Wednesday"
						$coordY[0] = "15"
						Switch $contentRead[2]
							Case "T 1 - 3"
								$coordY[1] = "16"
							Case "T 4 - 6"
								$coordY[1] = "17"
							Case "T 7 - 9"
								$coordY[1] = "18"
							Case "T 10 - 12"
								$coordY[1] = "19"
							Case "T 13 - 16"
								$coordY[1] = "20"
							Case Else								; ""
								MsgBox($MB_ICONINFORMATION, "", "Not choose lesson!")
						EndSwitch
					Case "Thursday"
						$coordY[0] = "21"
						Switch $contentRead[2]
							Case "T 1 - 3"
								$coordY[1] = "22"
							Case "T 4 - 6"
								$coordY[1] = "23"
							Case "T 7 - 9"
								$coordY[1] = "24"
							Case "T 10 - 12"
								$coordY[1] = "25"
							Case "T 13 - 16"
								$coordY[1] = "26"
							Case Else								; ""
								MsgBox($MB_ICONINFORMATION, "", "Not choose lesson!")
						EndSwitch
					Case "Friday"
						$coordY[0] = "27"
						Switch $contentRead[2]
							Case "T 1 - 3"
								$coordY[1] = "28"
							Case "T 4 - 6"
								$coordY[1] = "29"
							Case "T 7 - 9"
								$coordY[1] = "30"
							Case "T 10 - 12"
								$coordY[1] = "31"
							Case "T 13 - 16"
								$coordY[1] = "32"
							Case Else								; ""
								MsgBox($MB_ICONINFORMATION, "", "Not choose lesson!")
						EndSwitch
					Case "Saturday"
						$coordY[0] = "33"
						Switch $contentRead[2]
							Case "T 1 - 3"
								$coordY[1] = "34"
							Case "T 4 - 6"
								$coordY[1] = "35"
							Case "T 7 - 9"
								$coordY[1] = "36"
							Case "T 10 - 12"
								$coordY[1] = "37"
							Case "T 13 - 16"
								$coordY[1] = "38"
							Case Else								; ""
								MsgBox($MB_ICONINFORMATION, "", "Not choose lesson!")
						EndSwitch
					Case "Sunday"
						$coordY[0] = "39"
						Switch $contentRead[2]
							Case "T 1 - 3"
								$coordY[1] = "40"
							Case "T 4 - 6"
								$coordY[1] = "41"
							Case "T 7 - 9"
								$coordY[1] = "42"
							Case "T 10 - 12"
								$coordY[1] = "43"
							Case "T 13 - 16"
								$coordY[1] = "44"
							Case Else								; ""
								MsgBox($MB_ICONINFORMATION, "", "Not choose lesson!")
						EndSwitch
					Case ""
						MsgBox($MB_ICONINFORMATION, "", "Not choose day!")
				EndSwitch
				_RangeWrite(_getObject($contentRead[0]), $coordY[0], $coordY[1], $contentRead[2], $fromTime, $toTime)
			Case $buttonSave
				_Excel_BookSaveAs($oWorkbook, @ScriptDir & "\TKB.xlsx", Default, True)
				If @error Then Exit MsgBox($MB_SYSTEMMODAL, "", "Error saving workbook." & @CRLF & "@error = " & @error & ", @extended = " & @extended)
				MsgBox($MB_SYSTEMMODAL, "", "Workbook has been successfully saved as '" & @ScriptDir & "\TKB.xlsx'.")

		EndSwitch
	WEnd
EndFunc
_GUIEnable()