#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_UseUpx=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <ButtonConstants.au3>
#include <EditConstants.au3>
#include <GUIConstantsEx.au3>
#include <SliderConstants.au3>
#include <WindowsConstants.au3>
;Opt("GUIOnEventMode", 1)
Global $Voice=1
#Region ### START Koda GUI section ### Form=C:\Program Files\AutoIt3\SciTE\Koda\Forms\Speech.kxf
$Form1 = GUICreate("AVT Speech v0.1 Beta", 633, 416, 192, 124)
;GUISetOnEvent(-3,"_Exit")
$Edit1 = GUICtrlCreateEdit("Input your text here", 8, 8, 617, 345)
$Button1 = GUICtrlCreateButton("Speech", 160, 368, 75, 33, $WS_GROUP)
GUICtrlSetFont(-1,13,"Tahoma")
;GUISetOnEvent(-1,"_Speak")
$Button2 = GUICtrlCreateButton("About", 248, 368, 75, 33, $WS_GROUP)
GUICtrlSetFont(-1,13,"Tahoma")
;GUISetOnEvent(-1,"_Stop")
$Slider1 = GUICtrlCreateSlider(416, 368, 150, 45)
GUICtrlSetData(-1,100)
SoundPlay(100)
;GUISetOnEvent(-1,"_Sound")
$Checkbox1 = GUICtrlCreateCheckbox("Mute", 340, 375, 50, 17)
;GUISetOnEvent(-1,"_Mute")
GUISetState(@SW_SHOW)
#EndRegion ### END Koda GUI section ###

While 1
	$msg=GUIGetMsg()
	Switch $msg
		Case -3
			Exit

		Case $Button1
			If GUICtrlRead($Edit1)="" Then
				MsgBox(48,"Error","No text to speech")
			Else
			    Speak_Now(GUICtrlRead($Edit1))
			EndIf

		Case $Button2
			MsgBox(64,"About","            AVT Speech 0.1 Beta" & @CRLF & "" & @CRLF & "            http://autoit.72ls.net/" & @CRLF & "" & @CRLF & "Copyright (c) 2009-2010 by AutoIT VN Team")

		Case $Checkbox1
			SoundSetWaveVolume(0)
			GUICtrlSetState($Slider1,$GUI_DISABLE)

		Case $Slider1
			SoundSetWaveVolume(GUICtrlRead($Slider1))
	EndSwitch
WEnd

Func Speak_Now($Now_text)
	If $Voice = 0 Then Return
	Local $oi_speech = ObjCreate("SAPI.SpVoice")
	$oi_speech.Speak ($Now_text)
	$oi_speech = ""
EndFunc   ;==>Speak_Now



















































