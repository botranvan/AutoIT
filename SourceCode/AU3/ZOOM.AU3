#include <GuiConstantsEx.au3>
#include <GDIPlus.au3>
#include <ScreenCapture.au3>
#include <WindowsConstants.au3>
Opt('MustDeclareVars', 1)
_Zoom()

Func _Zoom()
	Global $hGUI1, $hGUI2, $hImage, $hGraphic1, $hGraphic2, $pos, $x ,$y, $z
	$hGUI2 = GUICreate("Zoom - ESC to exit", 200, 200, @DesktopWidth/2, @DesktopHeight/2,$WS_GROUP)
	GUISetState()
	$x = 120
	$y = 50
	$z = 100
	WinSetOnTop('Zoom','',1)

	while 1
		HotKeySet('{ESC}','_Exit')
		HotKeySet('{F5}','_up')
		HotKeySet('{F6}','_down')
		$pos = MouseGetPos()
		_ScreenCapture_Capture (@WindowsDir&"\zoom.jpe", $pos[0]-$y, $pos[1]-$y, $pos[0]+$z, $pos[1]+$z)
		_GDIPlus_Startup ()
		$hImage = _GDIPlus_ImageLoadFromFile (@WindowsDir&"\zoom.jpe")
		$hGraphic1 = _GDIPlus_GraphicsCreateFromHWND ($hGUI1)
		_GDIPlus_GraphicsDrawImage ($hGraphic1, $hImage, 0, 0)
		$hGraphic2 = _GDIPlus_GraphicsCreateFromHWND ($hGUI2)
		_GDIPlus_GraphicsDrawImageRectRect ($hGraphic2, $hImage,0, 0,$x, $x,0 ,0,200, 200)
		_GDIPlus_GraphicsDispose ($hGraphic1)
		_GDIPlus_GraphicsDispose ($hGraphic2)
		_GDIPlus_ImageDispose ($hImage)
		_GDIPlus_Shutdown ()
		FileDelete(@WindowsDir&"\dat.jpe")
	WEnd
EndFunc

Func _Exit()
	Exit
EndFunc

Func _Up()
	$x = $x + 2
	$y = $y + 1
	$z = $z + 1
EndFunc

Func _Down()
	$x = $x - 2
	$y = $y - 1
	$z = $z - 1
EndFunc