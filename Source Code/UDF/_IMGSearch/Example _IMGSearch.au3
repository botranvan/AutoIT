#include "_IMGSearch.au3"
#include "_IMGSearch_Debug.au3"

; At first. You have to create 2 file test1.bmp and test2.bmp of your screen (i.e some icon)

MsgBox(0, 'Example', 'At first, use this function to create 2 file bmp, maybe a desktop icon for example')
_IMGSearch_Create_BMP(@ScriptDir & "\test1.bmp")
_IMGSearch_Create_BMP(@ScriptDir & "\test2.bmp")
$findImage1 = 'test1.bmp'
$findImage2 = 'test1.bmp|test2.bmp'

MsgBox(0, 'Example 1', 'Check if an Image appear on your screen')
Local $a = _IMGSearch($findImage1, 200)
If $a[0] == 1 Then
	MsgBox(0, 'Success', 'Image found')
Else
	MsgBox(0, 'Failed', 'Image not found')
EndIf

MsgBox(0, 'Example 2', 'Check an of list image appear on your screen. Move mouse to it')
Local $a = _IMGSearch($findImage2)
If $a[0] == 1 Then MouseMove($a[1], $a[2])

MsgBox(0, 'Example 3', 'Check if an of list image appear on your screen. Move mouse to it. Use _IMGSearchWait with timeout')
Send("#d")
Sleep(300)
Local $r = Run('notepad', '', @SW_MAXIMIZE)
MsgBox(262144, 'Example 3', 'Wait a moment then try to close notepad and show your desktop to see you icon example')
Local $a = _IMGSearch_Wait($findImage2, 10000)
If $a[0] == 1 Then
	MsgBox(0, 'Success', 'Image found')
	MouseMove($a[1], $a[2])
Else
	MsgBox(0, 'Failed', 'Image not found')
EndIf
WinClose("Untitled - Notepad")

