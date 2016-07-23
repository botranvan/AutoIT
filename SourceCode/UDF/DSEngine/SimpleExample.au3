;; Very simple example on DSEngine usage

#include <DSEngine.au3>
#include <gdiplus.au3>
#include <winapi.au3>

; Create GUI as usual
$hWnd=GUICreate("DirectShow Engine Example",480,320)
GUISetState()


$file=FileOpenDialog("Select video file","","All video files (*.avi;*.mpg;*.wmv;*.mov;*.3gp;*.asf;*.mp4;*.flv;*.rv;)")
FileChangeDir(@ScriptDir)

; Opens the dll and create a interface to the engine
Engine_Startup("DSEngine_UDF.dll")

; Loads a media file (this will also load the necesary filters)
Engine_LoadFile($file,$hWnd)

; Starts the playback
Engine_StartPlayback()

; Get hbitmap to example image
_GDIPlus_Startup()
$image=_GDIPlus_ImageLoadFromFile("testoverlay.png")
$hbitmap=_GDIPlus_BitmapCreateHBITMAPFromBitmap($image)

Engine_SetOverlay($hbitmap, _ 
					0,0,_GDIPlus_ImageGetWidth($image),_GDIPlus_ImageGetHeight($image), _ ; Source rectangle
					0,0.7,1,1, _ ; Destination rectangle
					0x000000, _ ; Make black transparent
					0.5) ; Make it semi-transparent
_WinAPI_DeleteObject($hbitmap)


Do
	
Until GUIGetMsg()=-3


_GDIPlus_ImageDispose($image)
_GDIPlus_Shutdown()
; Will stop directshow and close the dll
Engine_Shutdown()