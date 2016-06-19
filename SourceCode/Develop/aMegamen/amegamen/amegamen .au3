#include <WindowsConstants.au3>
#include <WinAPI.au3>
#include "GIFAnimation.au3"
HotKeySet ("{ESC}","_exit")

Global $File = "start.gif"
Global $aGIFDimension = _GIF_GetDimension($File)

Global $Gui = GUICreate("GIF Animation", $aGIFDimension[0], $aGIFDimension[1], @DesktopWidth/2 ,@DesktopHeight/2 , $WS_POPUP, BitOR($WS_EX_LAYERED, $WS_EX_TOPMOST, $WS_EX_TOOLWINDOW))
Global $GIF = _GUICtrlCreateGIF($File, "", 0, 0)
GUISetBkColor(345)
_WinAPI_SetLayeredWindowAttributes($Gui, 345, 255)
_WinAPI_SetParent($Gui, 0)
GUISetState()
$mp=MouseGetPos()
 $left = $mp[0]
$top=0
$set=0
$set2=0
$time=TimerInit()
WinSetOnTop ($gui,"",1)
While 1
   $mp=MouseGetPos()
If $set=0 Then
   if (TimerDiff ($time)>1) Then
	  $top+=3
      $time=TimerInit()
	  WinMove($GUI,"", $left-20, $top)
   EndIf
EndIf
if $top > @DesktopHeight-50 Then
   $top=@DesktopHeight-50
   $set=1
   EndIf


If $set=1 Then
   sleep(1000)
	  Global $file="standright.gif"
	    _GIF_DeleteGIF($GIF)
  	  WinMove($GUI,"", $left-20, $top-3)
  $GIF = _GUICtrlCreateGIF($File, "", 0, 0)
  GUISetBkColor(0xffffff)
  _WinAPI_SetLayeredWindowAttributes($Gui, 0xffffff, 255)
  _WinAPI_SetParent($Gui, 0)
  GUISetState()
$set=2
$time=TimerInit()
  EndIf
If $set=2 and (TimerDiff ($time)>10) Then
  if $left > $mp[0]-25 and $left < $mp[0]-15 Then

	 	    If  $file="Runright.gif"  Then
	  	  $file="standright.gif"
	    _GIF_DeleteGIF($GIF)
  $GIF = _GUICtrlCreateGIF($File, "", 0, 0)
    GUISetBkColor(0xffffff)
    _WinAPI_SetLayeredWindowAttributes($Gui, 0xffffff, 255)
  _WinAPI_SetParent($Gui, 0)
	   GUISetState()
EndIf

  	 	    If  $file="runleft.gif"  Then
	  	  $file="standleft.gif"
	    _GIF_DeleteGIF($GIF)
  $GIF = _GUICtrlCreateGIF($File, "", 0, 0)
  GUISetBkColor(0xffffff)
  _WinAPI_SetLayeredWindowAttributes($Gui, 0xffffff, 255)
  _WinAPI_SetParent($Gui, 0)
  GUISetState()
  $set2=3
  EndIf
Else
    if $left < $mp[0]-20 Then
	    If  $set2=0 or $set2=3 Then
	  	  Global $file="runright.gif"
	    _GIF_DeleteGIF($GIF)
  $GIF = _GUICtrlCreateGIF($File, "", 0, 0)
    GUISetBkColor(0xffffff)
    _WinAPI_SetLayeredWindowAttributes($Gui, 0xffffff, 255)
  _WinAPI_SetParent($Gui, 0)
  $set2=4
  GUISetState()
  EndIf
	  $left+=3
	    	  WinMove($GUI,"", $left, $top)
      $time=TimerInit()
	  EndIf



  if $left > $mp[0]-20 Then
	 	    If  $set2=0 or $set2=4  Then
	  	  $file="runleft.gif"
	    _GIF_DeleteGIF($GIF)
  $GIF = _GUICtrlCreateGIF($File, "", 0, 0)
    GUISetBkColor(0xffffff)
    _WinAPI_SetLayeredWindowAttributes($Gui, 0xffffff, 255)
  _WinAPI_SetParent($Gui, 0)
  GUISetState()
  $set2=3
  EndIf
	  $left-=3
	    	  WinMove($GUI,"", $left, $top)

	   EndIf
      $time=TimerInit()
   EndIf


 EndIf

   WEnd

Func _Exit()
 Exit
EndFunc