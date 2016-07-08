#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
	#AutoIt3Wrapper_Icon=..\icons\ico500.ico
	#AutoIt3Wrapper_Outfile=Gen_x86.Exe
	#AutoIt3Wrapper_Outfile_x64=Gen_x64.exe
	#AutoIt3Wrapper_Compression=4
	#AutoIt3Wrapper_UseUpx=y
	#AutoIt3Wrapper_Compile_Both=y
	#AutoIt3Wrapper_UseX64=y
	#AutoIt3Wrapper_Res_Comment=100% Khong Virus
	#AutoIt3Wrapper_Res_Description=Tao thoi khoa bieu
	#AutoIt3Wrapper_Res_Fileversion=0.0.0.2
	#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
	#AutoIt3Wrapper_Res_LegalCopyright=Bo Tran Van
	#AutoIt3Wrapper_Res_Language=1066
	#AutoIt3Wrapper_Run_Tidy=y
	#Tidy_Parameters=/gd + /rel + /ri + /sf
	#AutoIt3Wrapper_Tidy_Stop_OnError=n
	#AutoIt3Wrapper_Run_Au3Stripper=y
	#Au3Stripper_Parameters=/pe + /so + /mo + /rm
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <MsgBoxConstants.au3>
#include <Excel.au3>
#include <GUIConstants.au3>
#include <Array.au3>
#include <StringConstants.au3>
#include "functions.au3"
; #RequireAdmin
HotKeySet("{ESC}", "_Terminates")
Func _Terminates()
	Exit
EndFunc   ;==>_Terminates