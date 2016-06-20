#include <GDIPlus.au3>

Opt("GuiOnEventMode", 1)
$hwnd = GUICreate("Test", 300, 300)
GUISetState()
GUISetOnEvent(-3, "close")
_GDIPlus_Startup()

$graphics = _GDIPlus_GraphicsCreateFromHWND($hwnd)
$bitmap = _GDIPlus_BitmapCreateFromGraphics(300, 300, $graphics)
$backbuffer = _GDIPlus_ImageGetGraphicsContext($bitmap)
$pen = _GDIPlus_PenCreate(0xFF00FF00, 2)
$hImage=_GDIPlus_ImageLoadFromFile(@ScriptDir & "\missile\m.png")
$matrix = _GDIPlus_MatrixCreate()
_GDIPlus_MatrixTranslate($matrix, 150, 150)



$inc = 0
Do
    _GDIPlus_GraphicsClear($backbuffer)
    _GDIPlus_MatrixRotate($matrix,1)
    _GDIPlus_GraphicsSetTransform($backbuffer,$matrix)
    _GDIPlus_GraphicsDrawImageRect($backbuffer,$hImage,-150,-150,300,300)
    _GDIPlus_GraphicsDrawImageRect($graphics,$bitmap,0,0,300,300)
    Sleep(10)
Until 0


Func close()
    Exit
EndFunc  ;==>close
