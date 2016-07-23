#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_icon=..\program autoit\icon\Alpha Dista Icon 84.ico
#AutoIt3Wrapper_outfile=C:\Documents and Settings\Nhat Linh\Desktop\Game.exe
#AutoIt3Wrapper_Run_AU3Check=n
#AutoIt3Wrapper_Run_Obfuscator=y
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <WINAPI.au3>
#include <GuiImageList.au3>
#include <GDIPlus.au3>
#Include <Misc.au3>
#include <Sound.au3>
Global Const $OCR_APPSTARTING = 32650
Global Const $OCR_NORMAL = 32512
Global Const $OCR_CROSS = 32515
Global Const $OCR_HAND = 32649
Global Const $OCR_IBEAM = 32513
Global Const $OCR_NO = 32648
Global Const $OCR_SIZEALL = 32646
Global Const $OCR_SIZENESW = 32643
Global Const $OCR_SIZENS = 32645
Global Const $OCR_SIZENWSE = 32642
Global Const $OCR_SIZEWE = 32644
Global Const $OCR_UP = 32516
Global Const $OCR_WAIT = 32514


MsgBox(64,"Xe tang - Nhat Linh","Mong moi nguoi ung ho nha ^^ .")


Global $i1=0,$i2=0,$i4=0,$i5=0,$i6=0,$i7=0


HotKeySet("{ESC}","thoat")

if  DirGetSize(@ScriptDir&"\image") =-1 then
MsgBox (16,"Error"," Khong tim thay duong dan file .")
Exit
EndIf

Opt("guioneventmode",1)



$open=_SoundOpen(@ScriptDir&"\image\bum.wav")

_SetCursor(@ScriptDir&"\image\tam.cur", $OCR_NORMAL)

_GDIPlus_Startup()

$dll=DllOpen("user32.dll")

    $gui = GUICreate("Game ban may bay - Nhat Linh", 0, 0 , -1, -1)


		GUISetState(@SW_HIDE,$gui)
WinSetOnTop($gui,"",1)
GUISetOnEvent($gui_event_close,"thoat")

	$pngSrc = @ScriptDir&"\image\bomber.png"
$hImage2 = _GDIPlus_ImageLoadFromFile($pngSrc)

; Extract image width and height from PNG
$dai = _GDIPlus_ImageGetWidth($hImage2)
$rong = _GDIPlus_ImageGetHeight($hImage2)


	$gui2=GUICreate("", $dai, $rong, 0, 0, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $GUI)
SetBitmap($gui2,$hImage2,255)
GUISetState()



	$pngSrc = @ScriptDir&"\image\bigbomber.png"
$hImage1 = _GDIPlus_ImageLoadFromFile($pngSrc)

; Extract image width and height from PNG
$dai = _GDIPlus_ImageGetWidth($hImage1)
$rong = _GDIPlus_ImageGetHeight($hImage1)


	$gui1=GUICreate("", $dai, $rong, 0, 0, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $GUI)
SetBitmap($gui1,$hImage1,255)
GUISetState()



	$pngSrc =@ScriptDir&"\image\deltabomber.png"
$hImage4 = _GDIPlus_ImageLoadFromFile($pngSrc)

; Extract image width and height from PNG
$dai = _GDIPlus_ImageGetWidth($hImage4)
$rong = _GDIPlus_ImageGetHeight($hImage4)


	$gui4=GUICreate("", $dai, $rong,0, 0, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $GUI)
SetBitmap($gui4,$hImage4,255)
GUISetState()






	$pngSrc =@ScriptDir&"\image\deltajet.png"
$hImage5 = _GDIPlus_ImageLoadFromFile($pngSrc)

; Extract image width and height from PNG
$dai = _GDIPlus_ImageGetWidth($hImage5)
$rong = _GDIPlus_ImageGetHeight($hImage5)


	$gui5=GUICreate("", $dai, $rong, 0,0, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $GUI)
SetBitmap($gui5,$hImage5,255)
GUISetState()






	$pngSrc =@ScriptDir&"\image\pupcopter.png"
$hImage6 = _GDIPlus_ImageLoadFromFile($pngSrc)

; Extract image width and height from PNG
$dai = _GDIPlus_ImageGetWidth($hImage6)
$rong = _GDIPlus_ImageGetHeight($hImage6)


	$gui6=GUICreate("", $dai, $rong, 0,0, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $GUI)
SetBitmap($gui6,$hImage6,255)
GUISetState()


	$pngSrc = @ScriptDir&"\image\blimp.png"
$hImage7 = _GDIPlus_ImageLoadFromFile($pngSrc)

; Extract image width and height from PNG
$dai = _GDIPlus_ImageGetWidth($hImage7)
$rong = _GDIPlus_ImageGetHeight($hImage7)


	$gui7=GUICreate("", $dai, $rong, 0,0, $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_MDICHILD), $GUI)
SetBitmap($gui7,$hImage7,255)
GUISetState()


$y1=Random(0,@DesktopHeight-100)
$y2=Random(0,@DesktopHeight-100)
$y4=Random(0,@DesktopHeight-100)
$y5=Random(0,@DesktopHeight-100)
$y6=Random(0,@DesktopHeight-100)
$y7=Random(0,@DesktopHeight-100)


 while 1
	 sleep(50)
	 $i1+=Random(10,15)
	 $i2+=Random(10,15)
	$i4+=Random(10,15)
	$i5+=Random(10,15)
	$i6+=Random(10,15)
$i7+=Random(10,15)


WinMove($gui1,"",$i1,$y1)
WinMove($gui2,"",$i2,$y2)
WinMove($gui4,"",$i4,$y4)
WinMove($gui5,"",$i5,$y5)
WinMove($gui6,"",$i6,$y6)
WinMove($gui7,"",$i7,$y7)


if $i1-100>@DesktopWidth then
	SetBitmap($gui1,$hImage1,0)
$y1=Random(0,@DesktopHeight-100)
WinMove($gui1,"",0,$y1,$y1)
$i1=0
SetBitmap($gui1,$hImage1,255)

EndIf

if	$i2-100>@DesktopWidth  Then
SetBitmap($gui2,$hImage2,0)
	$y2=Random(0,@DesktopHeight-100)
WinMove($gui2,"",0,$y2,$y2)
$i2=0
SetBitmap($gui2,$hImage2,255)
EndIf

If	$i4-100>@DesktopWidth Then
	SetBitmap($gui4,$hImage4,0)
	$y4=Random(0,@DesktopHeight-100)
WinMove($gui4,"",0,$y4,$y4)
$i4=0
	SetBitmap($gui4,$hImage4,255)

EndIf
If	$i5-100>@DesktopWidth then
	SetBitmap($gui5,$hImage5,0)
	$y5=Random(0,@DesktopHeight-100)
WinMove($gui5,"",0,$y5,$y5)
$i5=0
SetBitmap($gui5,$hImage5,255)

EndIf

If	$i6-100>@DesktopWidth then
	SetBitmap($gui6,$hImage6,0)
	$y6=Random(0,@DesktopHeight-100)
WinMove($gui6,"",0,$y6,$y6)
$i6=0
SetBitmap($gui6,$hImage6,255)

EndIf

If	$i7-100>@DesktopWidth then
	SetBitmap($gui7,$hImage7,0)
	$y7=Random(0,@DesktopHeight-100)
WinMove($gui7,"",0,$y7,$y7)
$i7=0
SetBitmap($gui7,$hImage7,255)

EndIf
if _IsPressed(01,$dll) then

_SoundPlay($open)

EndIf
if hander()=$gui7 and _IsPressed(01,$dll) then  gui7()
if hander()=$gui6 and _IsPressed(01,$dll) then  gui6()
if hander()=$gui1 and _IsPressed(01,$dll) then gui1()
if hander()=$gui2 and _IsPressed(01,$dll)then gui2()
if hander()=$gui4 and _IsPressed(01,$dll)then gui4()
if hander()=$gui5 and _IsPressed(01,$dll)then gui5()


WEnd


Func SetBitmap($hGUI, $hImage, $iOpacity)
	Local $hScrDC, $hMemDC, $hBitmap, $hOld, $pSize, $tSize, $pSource, $tSource, $pBlend, $tBlend

	$hScrDC = _WinAPI_GetDC(0)
	$hMemDC = _WinAPI_CreateCompatibleDC($hScrDC)
	$hBitmap = _GDIPlus_BitmapCreateHBITMAPFromBitmap($hImage)
	$hOld = _WinAPI_SelectObject($hMemDC, $hBitmap)
	$tSize = DllStructCreate($tagSIZE)
	$pSize = DllStructGetPtr($tSize)
	DllStructSetData($tSize, "X", _GDIPlus_ImageGetWidth($hImage))
	DllStructSetData($tSize, "Y", _GDIPlus_ImageGetHeight($hImage))
	$tSource = DllStructCreate($tagPOINT)
	$pSource = DllStructGetPtr($tSource)
	$tBlend = DllStructCreate($tagBLENDFUNCTION)
	$pBlend = DllStructGetPtr($tBlend)
	DllStructSetData($tBlend, "Alpha", $iOpacity)
	DllStructSetData($tBlend, "Format",1)
	_WinAPI_UpdateLayeredWindow($hGUI, $hScrDC, 0, $pSize, $hMemDC, $pSource, 0, $pBlend, $ULW_ALPHA)
	_WinAPI_ReleaseDC(0, $hScrDC)
	_WinAPI_SelectObject($hMemDC, $hOld)
	_WinAPI_DeleteObject($hBitmap)
	_WinAPI_DeleteDC($hMemDC)
EndFunc ;==>SetBitmap



func thoat()

_SetCursor(@ScriptDir&"\image\arrow_i.cur", $OCR_NORMAL)
	Exit
EndFunc



Func hander()
    Local $iRet = DllCall("user32.dll", "int", "WindowFromPoint", "long", MouseGetPos(0), "long", MouseGetPos(1))
    If IsArray($iRet) Then Return HWnd($iRet[0])
    Return SetError(1, 0, 0)
EndFunc



func gui1()
	$open1=_SoundOpen(@ScriptDir&"\image\bum2.wav")
	_SoundPlay($open1)
	SetBitmap($gui1,$hImage1,0)
$y1=Random(0,@DesktopHeight-100)
WinMove($gui1,"",-10,$y1)
$i1=0
SetBitmap($gui1,$hImage1,255)

EndFunc
func gui2()
	$open1=_SoundOpen(@ScriptDir&"\image\bum2.wav")
	_SoundPlay($open1)
		SetBitmap($gui2,$hImage2,0)
	$y2=Random(0,@DesktopHeight-100)
WinMove($gui2,"",-10,$y2)

$i2=0
SetBitmap($gui2,$hImage2,255)

EndFunc
func gui4()
	$open1=_SoundOpen(@ScriptDir&"\image\bum2.wav")
	_SoundPlay($open1)
		SetBitmap($gui4,$hImage4,0)
	$y4=Random(0,@DesktopHeight-100)
WinMove($gui4,"",-10,$y4)
$i4=0
	SetBitmap($gui4,$hImage4,255)

EndFunc
func gui5()
	$open1=_SoundOpen(@ScriptDir&"\image\bum2.wav")
	_SoundPlay($open1)
		SetBitmap($gui5,$hImage5,0)
	$y5=Random(0,@DesktopHeight-100)
WinMove($gui5,"",-10,$y5)
$i5=0
SetBitmap($gui5,$hImage5,255)

	EndFunc



func gui6()
	$open1=_SoundOpen(@ScriptDir&"\image\bum2.wav")
	_SoundPlay($open1)
		SetBitmap($gui6,$hImage6,0)
	$y6=Random(0,@DesktopHeight-100)
WinMove($gui6,"",-10,$y6)
$i6=0
SetBitmap($gui6,$hImage6,255)

	EndFunc

func gui7()
	$open1=_SoundOpen(@ScriptDir&"\image\bum2.wav")
	_SoundPlay($open1)
		SetBitmap($gui7,$hImage7,0)
	$y7=Random(0,@DesktopHeight-100)
WinMove($gui7,"",-10,$y7)
$i7=0
SetBitmap($gui7,$hImage7,255)

	EndFunc



	Func _SetCursor($s_file, $i_cursor)
   Local $newhcurs, $lResult
   $newhcurs = DllCall("user32.dll", "int", "LoadCursorFromFile", "str", $s_file)
   If Not @error Then
      $lResult = DllCall("user32.dll", "int", "SetSystemCursor", "int", $newhcurs[0], "int", $i_cursor)
      If Not @error Then
         $lResult = DllCall("user32.dll", "int", "DestroyCursor", "int", $newhcurs[0])
      Else
         MsgBox(0, "Error", "Failed SetSystemCursor")
      EndIf
   Else
      MsgBox(0, "Error", "Failed LoadCursorFromFile")
   EndIf
EndFunc ;==>_SetCursor