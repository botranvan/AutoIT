#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

; Script Start - Add your code below here

$file = FileOpen("item.txt")
$data = FileRead($file)
$data = StringReplace($data,@CRLF,"")
$data = StringReplace($data,"id: ",@CRLF&"[")
$data = StringReplace($data,"width: ","][")
$data = StringReplace($data,"height: ","][")
$data = StringReplace($data,@CRLF,"]"&@CRLF)
$data&= "]"

FileClose($file)
$items = StringSplit($data,@CRLF,1)

$filename = "item.ini"
$file = FileOpen($filename,2+8)
FileClose($file)
For $i=2 To $items[0]
	tooltip(@sec&@msec&" "&$i,0,0)
	IniWrite($filename,"items",$i-2,$items[$i])
Next