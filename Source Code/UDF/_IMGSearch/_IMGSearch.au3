#include-once
; ------------------------------------------------------------------------------
;
; AutoIt Version: v3.3.14.0
; Language:.......English
; Description:....UDF that assist with Image Search
;                 Require that the ImageSearchDLL.dll be loadable
;				  Remod UDF by aKiD - fb.com/tungtata
;
; ------------------------------------------------------------------------------

Global Const $SleepTime = 100
;===============================================================================
;
; Author:...........aKiD - fb.com/tungtata
; Description:......Check image appears or not
;					Find the position of an image on the desktop
; Syntax:..........._IMGSearch_Area, _IMGSearch
; Parameter(s):.....$findImage:						The image to locate on the desktop
;													May be a list of image by delimited by "|"
;													i.e: $findImage = "image1.bmp|image2.bmp|image3.bmp"
;                   $x1 $y1: 						Position of 1st point
;                   $x2 $y2:						Position of 2nd point - Default is last botton right of desktop
;                   $tolerance:						0 for no tolerance (0-255). Needed when colors of image differ from desktop. e.g GIF
;					$center:						boolen. True will return $array[1] x $array[2] is center of image found.
;															False will return top-left position
; Return Value(s):..Return an array has 3 item
; 					On Success: 					$array[0]  1
;                   On Failure: 					$array[0]  0
;					DLL not found or other error: 	$array[0] -1
;					$array[1] x $array[2]: 			position of image what found on desktop
;
; Note:.............Use _IMGSearch to search the entire desktop
;					_IMGSearch_Area to specify a desktop region to search
;					$findImage with more item need more time appear on screen before function can detect.
;					Decrease sleep time in the loop to detect faster. But less performance. I.e CPULoad increased
;
;===============================================================================
Func _IMGSearch($findImage, $tolerance = 0, $center = True)
	Return _IMGSearch_Area($findImage, 0, 0, @DesktopWidth, @DesktopHeight, $tolerance, $center)
EndFunc   ;==>_IMGSearch
Func _IMGSearch_Area($findImage, $x1, $y1, $x2 = @DesktopWidth, $y2 = @DesktopHeight, $tolerance = 0, $center = True)
	Local $return[3] = [0, 0, 0], $TempVar, $i, $findIMGX

	If $x1 > $x2 Then ; change position to default top-left and botton-right
		$TempVar = $x1
		$x1 = $x2
		$x2 = $TempVar
	EndIf
	If $y1 > $y2 Then
		$TempVar = $y1
		$y1 = $y2
		$y2 = $TempVar
	EndIf
	Local $findIMG = StringSplit($findImage, '|', 2)
	For $i = 0 To (UBound($findIMG) - 1) Step +1
		$findIMGX = $findIMG[$i]
		If $tolerance > 0 Then $findIMGX = "*" & $tolerance & " " & $findIMGX
		Local $result = DllCall("ImageSearchDLL.dll", "str", "ImageSearch", "int", $x1, "int", $y1, "int", $x2, "int", $y2, "str", $findIMGX)

		If Not IsArray($result) Then ; dll not found or other error
			$return[0] = -1
			ExitLoop
		EndIf
		If $result[0] = "0" Then ; search not found
			$return[0] = 0
			ContinueLoop
		Else
			$return[0] = 1
			Local $array = StringSplit($result[0], "|")
			If $center Then
				$return[1] = Round(Number($array[2]) + (Number($array[4]) / 2))
				$return[2] = Round(Number($array[3]) + (Number($array[5]) / 2))
			Else
				$return[1] = Number($array[2])
				$return[2] = Number($array[3])
			EndIf
			ExitLoop
		EndIf
	Next
	Return $return
EndFunc   ;==>_IMGSearch_Area

;===============================================================================
;
; Description:......Wait for a specified number of milliseconds for an image to appear
;
; Syntax:           _IMGSearch_Wait, _IMGSearch_WaitArea
; Author:...........This function copied from original UDF shared from autoitscript forum.
;					I have rename them for easy to remember
;                   I dont know who are author. Please contact me if you are author of them. I will leave a copyright
; Parameter(s):.....$findImage:		The image to locate on the desktop
;									May be a list of image by delimited by "|"
;									i.e: $findImage = "image1.bmp|image2.bmp|image3.bmp"
;					$waitmilliSecs:	Timeout wait after return "not found" result (in milliseconds)
;                   $x1 $y1: 		Position of first point
;                   $x2 $y2:		Position of second point - Default is last botton right of desktop
;                   $tolerance:		0 for no tolerance (0-255). Needed when colors of image differ from desktop. e.g GIF
;					$center:		boolen. True will return $array[1] x $array[2] is center of image found. False will return top-left position
; Return Value(s):..On Success:		Returns 1
;                   On Failure:		Returns 0
;					$findImage with more item need more time appear on screen before function can detect.
;					Decrease sleep time in the loop to detect faster. But less performance. I.e CPULoad increased
;
;===============================================================================
Func _IMGSearch_Wait($findImage, $waitmilliSecs, $tolerance = 0, $center = True)
	Local $return[3] = [0, 0, 0]
	Local $startTime = TimerInit()
	While TimerDiff($startTime) < $waitmilliSecs
		Sleep($SleepTime)
		$return = _IMGSearch_Area($findImage, 0, 0, @DesktopWidth, @DesktopHeight, $tolerance, $center)
		If $return[0] > 0 Then ExitLoop
	WEnd
	Return $return
EndFunc   ;==>_IMGSearch_Wait

Func _IMGSearch_WaitArea($findImage, $waitmilliSecs, $x1, $y1, $x2 = @DesktopWidth, $y2 = @DesktopHeight, $tolerance = 0, $center = True)
	Local $return[3] = [0, 0, 0]
	Local $startTime = TimerInit()
	While TimerDiff($startTime) < $waitmilliSecs
		Sleep($SleepTime)
		$return = _IMGSearch_Area($findImage, $x1, $y1, $x2, $y2, $tolerance, $center)
		If $return[0] > 0 Then ExitLoop
	WEnd
	Return $return
EndFunc   ;==>_IMGSearch_WaitArea
