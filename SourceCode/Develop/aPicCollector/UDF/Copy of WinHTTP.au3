#include "WinHttp.au3"

Opt("MustDeclareVars", 1)

; Open needed handles
Global $hOpen = _WinHttpOpen()
Global $hConnect = _WinHttpConnect($hOpen, "google.com")
; Specify the reguest:
Global $hRequest = _WinHttpOpenRequest($hConnect, Default, "search?q=3D+Girl&tbm=isch")

; Send request
_WinHttpSendRequest($hRequest)

; Wait for the response
_WinHttpReceiveResponse($hRequest)

Global $sHeader = _WinHttpReadData($hRequest) ; ...get full header

; Clean
_WinHttpCloseHandle($hRequest)
_WinHttpCloseHandle($hConnect)
_WinHttpCloseHandle($hOpen)

; Display retrieved header
MsgBox(0, "Header", $sHeader)