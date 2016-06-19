HotKeySet("{ESC}", "Quit")

$window = GUICreate("Main", @DesktopWidth+7, @DesktopHeight+50)
GUISetBkColor(0x000000)
GUISetState(@SW_SHOW)
Sleep(500+Random(1,1000))
GUISetBkColor(0x0000AA)

$text = "" & @CRLF & @CRLF
$text&= "  A problem has been detected and Windows has been shut down to prevent damage to your computer"& @CRLF & @CRLF
$text&= "  The problem seems to be caused by the following file: "& @ScriptName & @CRLF & @CRLF 
$text&= "  FILE_ERROR" & @CRLF & @CRLF
$text&= "  If this is the first time you've seen this Stop error screen," & @CRLF
$text&= "  restart your computer. If this screen appears again, follow" & @CRLF
$text&= "  these steps:" & @CRLF & @CRLF
$text&= "  Check to make sure any new hardware or software is properly installed." & @CRLF
$text&= "  If this is a new installation, ask your hardware or software manufacturer" & @CRLF
$text&= "  for any Windows updates you might need." & @CRLF & @CRLF
$text&= "  If problems continue, disable or remove any newly installed hardware" & @CRLF
$text&= "  or software. Disable BIOS memory options such as caching or shadowing." & @CRLF
$text&= "  If you need to use Safe Mode to remove or disable components, restart" & @CRLF
$text&= "  your computer, press F8 to select Advanced Startup Options, and then" & @CRLF
$text&= "  select Safe Mode." & @CRLF & @CRLF
$text&= "  Technical information:" & @CRLF & @CRLF
$text&= "  *** STOP: 0x00000000 (0xS0M3TH1NG,0x150WR0NG,0x3RR0R000,0x00000000)" & @CRLF & @CRLF & @CRLF
$text&= "  ***  " & @ScriptName & " - Address 4UT01T0V3 base at 4UT01T000, DateStamp t0d4yn0w" & @CRLF & @CRLF
$text&= "  Beginning dump of physical memory" & @CRLF
$text&= "  Physical memory dump complete." & @CRLF
$text&= "  Contact your system administrator or technical support group for further" & @CRLF
$text&= "  assistance." & @CRLF&@LF&@LF&@LF
$text&= "  (Bam ESC de thoat)"

$label = GUICtrlCreateLabel($text, 0, 0, @DesktopWidth, @DesktopHeight)
GUICtrlSetFont($label, 13, 25, -1, "Lucida Console")
GUICtrlSetColor($label, 0xFFFFFF)
Beep(1000, 250)

while $window
 MouseMove(@DesktopWidth, @DesktopHeight, 0)
wend

;~ Thoát Chương Trình
func Quit()
 Exit
endfunc