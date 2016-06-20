;.......script written by trancexx (trancexx at yahoo dot com)
;.......no limitations, use it as it fits you


#NoTrayIcon
#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Outfile=Resources.exe
#AutoIt3Wrapper_UseUpx=n
#AutoIt3Wrapper_Au3Check_Parameters=-d -w 2 -w 4 -w 6
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
Opt("MustDeclareVars", 1)

DllOpen("gdiplus.dll")

Global Const $RT_CURSOR = 1
Global Const $RT_BITMAP = 2
Global Const $RT_ICON = 3
Global Const $RT_MENU = 4
Global Const $RT_DIALOG = 5
Global Const $RT_STRING = 6
Global Const $RT_FONTDIR = 7
Global Const $RT_FONT = 8
Global Const $RT_ACCELERATOR = 9
Global Const $RT_RCDATA = 10
Global Const $RT_MESSAGETABLE = 11
Global Const $RT_GROUP_CURSOR = 12
Global Const $RT_GROUP_ICON = 14
Global Const $RT_VERSION = 16
Global Const $RT_DLGINCLUDE = 17
Global Const $RT_PLUGPLAY = 19
Global Const $RT_VXD = 20
Global Const $RT_ANICURSOR = 21
Global Const $RT_ANIICON = 22
Global Const $RT_HTML = 23
Global Const $RT_MANIFEST = 24

Global $ARRAY_MODULE_STRUCTURE[1][1][1]
Global $global_names_count, $name_count
Global $global_langs_count, $lang_count
Global $global_types_count
Global $LangCodeCurrent, $langNameCurrent[2]
Global $TypeCurrent, $TypeNameCurrent[2]
Global $sFileLoaded
Global $iDroppedOnFirstRun, $iFirstRun = 1
Global $iPopulateArray

Global $hGui, $hTab, $hTabResources, $hTabMisc, $hTreeMisc
Global $hGeneralInfoTree, $hExportedFuncTree, $hImportsTree, $hSectionsTree

Global $hButton, $hProgress, $hTreeView, $hFileMenu, $hFileOpenItem, $hExitItem, $hEdit, $hEditHeader, $hPic, $hIco, $hListView, $aListViewItem[1]
Global $hButtonPlayMedia, $hButtonPauseSound, $hButtonStopSound, $iPlayed = 3, $hMCI, $iLength, $sMediaTempFile, $aMediaResource[9], $hInfoSoundEdit, $hLabelAviInfo
Global $hDialogWindow, $iDestroyDialogWindow, $iDialogIsChild
Global $hMenuGui, $hMenuLoaded, $iMenuIs
Global $hNameLabel, $hLineLabel

Global $hActionMenu, $hActionItem, $hGenerateItem, $hSaveItem, $hAddItem
Global $hDeleteButton, $hAddButton

Global $hContext, $hContextExpCol

Global $hOptionsMenu, $hRestoreDefaultSettings

Global $hPicCompressed, $iBinaryImageDataOK

Global $iMultipleFramesGIF, $aHGIFBitmaps, $iGIFFrameSwitch, $iDestroyGIFBitmapHandles, $iFrame, $iTransparentGIF

Global $hImageList, $iImageListDestroy

Global $sRawDLL, $iCompilerEnabled
Global $iChild, $iSkipOne

Global $iInstanceCurrent
Global $iInstancesOverall

Global $iEasterEgg, $iSoundPlaying

HotKeySet("{F5}", "_ToggleEasterEgg") ; F5

_NumInst("{FA151046-C493-4B54-8BFA-E0B1CC98DF52}")
Global $iMessage = _RegisterWindowMessage("{279442A4-9F45-4A52-A10D-5F0EB447296F}")

Global $sParent = _GetParent()
If Not $sParent Then
	$sParent = _ProcessGetParent(@AutoItPID)
EndIf

If @Compiled Then
	Switch $sParent
		Case "explorer.exe"
			$iDroppedOnFirstRun = $CmdLineRaw = True
			_Main(StringReplace($CmdLineRaw, '"', ''))
		Case Else
			_ExecuteCommandLine()
	EndSwitch
Else
	_Main()
EndIf


Func _Main($sFile = "")

	$iPlayed = 3
	$iDestroyDialogWindow = 1
	GUICtrlSetState($hProgress, 16)
	GUICtrlSetData($hProgress, 10)
	GUISetCursor(15, 1, $hGui)

	Local $sTempModule
	Local $iToDeleteTempModule

	If $sFile Then

		If $iCompilerEnabled Then

			$iToDeleteTempModule = 0
			$sTempModule = $sFile

		Else

			$iToDeleteTempModule = 1
			Local $aShortcut = FileGetShortcut($sFile)
			If Not @error Then
				$sFile = $aShortcut[0]
			EndIf

			Local $hFile = FileOpen($sFile, 16)
			If $hFile = -1 Then
				GUISetCursor(-1, 1, $hGui)
				GUICtrlSetState($hProgress, 32)
				MsgBox(48, "Error", "Inernal error", 0, $hGui)
				Return
			EndIf
			Local $bFile = FileRead($hFile)
			FileClose($hFile)

			If Not (BinaryToString(BinaryMid($bFile, 1, 2)) == "MZ") Then
				GUICtrlSetState($hProgress, 32)
				GUISetCursor(-1, 1, $hGui)
				MsgBox(48, "Error", "Invalid file type! Choose another.", 0, $hGui)
				Return
			EndIf

			$sTempModule = @TempDir & "\" & _GenerateGUID() & ".dll" ; choosing .dll extension
			If @error Then
				GUISetCursor(-1, 1, $hGui)
				GUICtrlSetState($hProgress, 32)
				MsgBox(48, "Error", "Inernal error", 0, $hGui)
				Return
			EndIf

			$hFile = FileOpen($sTempModule, 18)
			If $hFile = -1 Then
				GUISetCursor(-1, 1, $hGui)
				GUICtrlSetState($hProgress, 32)
				MsgBox(48, "Error", "Inernal error", 0, $hGui)
				Return
			EndIf
			FileWrite($hFile, $bFile)
			FileClose($hFile)

		EndIf

		$iPopulateArray = 0
		ReDim $ARRAY_MODULE_STRUCTURE[1][1][1]

		_ResourceEnumerate($sTempModule) ; to determine $ARRAY_MODULE_STRUCTURE size
		Switch @error
			Case 2, 4, 6
				GUISetCursor(-1, 1, $hGui)
				GUICtrlSetState($hProgress, 32)
				FileDelete($sTempModule)
				MsgBox(48, "Error", "Inernal error", 0, $hGui)
				Return
			Case 3
				GUISetCursor(-1, 1, $hGui)
				GUICtrlSetState($hProgress, 32)
				FileDelete($sTempModule)
				MsgBox(48, "Error", "Unable to load " & FileGetLongName($sFile), 0, $hGui)
				Return
			Case 5
				GUISetCursor(-1, 1, $hGui)
				GUICtrlSetState($hProgress, 32)
				FileDelete($sTempModule)
				MsgBox(48, "Error", "Error enumerating", 0, $hGui)
				Return
		EndSwitch

		$iPopulateArray = 1
		ReDim $ARRAY_MODULE_STRUCTURE[$global_types_count][$global_names_count][$global_langs_count]

		_ResourceEnumerate($sTempModule)
		Switch @error
			Case 2, 4, 6
				GUISetCursor(-1, 1, $hGui)
				GUICtrlSetState($hProgress, 32)
				FileDelete($sTempModule)
				MsgBox(48, "Error", "Inernal error", 0, $hGui)
				Return
			Case 3
				GUISetCursor(-1, 1, $hGui)
				GUICtrlSetState($hProgress, 32)
				FileDelete($sTempModule)
				MsgBox(48, "Error", "Unable to load " & FileGetLongName($sFile), 0, $hGui)
				Return
			Case 5
				GUISetCursor(-1, 1, $hGui)
				GUICtrlSetState($hProgress, 32)
				FileDelete($sTempModule)
				MsgBox(48, "Error", "Error enumerating", 0, $hGui)
				Return
		EndSwitch

		If $iToDeleteTempModule Then
			FileDelete($sTempModule)
		EndIf

	EndIf

	$sFileLoaded = $sFile
	_GuiShow()
	If @error Then
		MsgBox(48, "Error", "Unexpected error occurred." & @CRLF & @CRLF & "Need to close...", 3, $hGui)
		Exit
	EndIf

EndFunc   ;==>_Main


Func _GuiShow()

	Local $iTypeSize = UBound($ARRAY_MODULE_STRUCTURE, 1)
	Local $hTypeItem[$iTypeSize]

	Local $iNameSize = 1
	Local $iLangSize = 1

	For $i = 0 To $iTypeSize - 1
		For $j = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
			If $ARRAY_MODULE_STRUCTURE[$i][$j][0] Then
				$iNameSize += 1
			EndIf
			For $k = 1 To UBound($ARRAY_MODULE_STRUCTURE, 3) - 1
				$iLangSize += IsNumber($ARRAY_MODULE_STRUCTURE[$i][$j][$k])
			Next
		Next
	Next

	Local $hNameItem[$iNameSize]

	Local $hLanguageItem[$iLangSize][3]

	GUICtrlSetData($hProgress, 75)


	If $iFirstRun Then

		If Not $iDroppedOnFirstRun Then
			$sFileLoaded = ""
		EndIf

		$hGui = GUICreate("Resources [" & $iInstanceCurrent & " of " & $iInstancesOverall & "]", 670, 400, -1, -1, 13565952, 16)

		$hLineLabel = GUICtrlCreateLabel("", 0, 349, 670, 2, 0x8001000)
		GUICtrlSetResizing($hLineLabel, 576)
		$hNameLabel = GUICtrlCreateLabel("  ResourcesViewerAndCompiler", 500, 342, 155, 15, 0x8000000)
		GUICtrlSetResizing($hNameLabel, 832)

		$hTab = GUICtrlCreateTab(2, 0, 315, 346)
		GUICtrlSetResizing($hTab, 354)

		$hTabResources = GUICtrlCreateTabItem("Resources")

		$hTreeView = GUICtrlCreateTreeView(5, 24, 307, 317)
		GUICtrlSetState($hTreeView, 8) ; $GUI_DROPACCEPTED
		GUICtrlSetImage($hTreeView, @SystemDir & "\shell32.dll", 4)
		GUICtrlSetFont($hTreeView, 9)
		GUICtrlSendMsg($hTreeView, 4379, 22, 0) ; set size
		GUICtrlSetResizing($hTreeView, 354)

		$hTabMisc = GUICtrlCreateTabItem("Misc")

		$hTreeMisc = GUICtrlCreateTreeView(5, 24, 307, 317)
		GUICtrlSetState($hTreeMisc, 8) ; $GUI_DROPACCEPTED
		GUICtrlSetFont($hTreeMisc, 9)
		GUICtrlSetResizing($hTreeMisc, 354)
		If $sFileLoaded Then
			_PopulateMiscTreeView($hTreeMisc, $sFileLoaded)
		EndIf

		GUICtrlCreateTabItem("")
		GUICtrlSetState($hTabResources, 16)

		$hProgress = GUICtrlCreateProgress(350, 357, 225, 18)
		GUICtrlSetState($hProgress, 32)
		GUICtrlSetResizing($hProgress, 582)

		$hContext = GUICtrlCreateContextMenu($hTreeView)
		$hContextExpCol = GUICtrlCreateMenuItem("Expand All Types", $hContext)
		GUICtrlSetState($hContextExpCol, 128)

		$hEditHeader = GUICtrlCreateInput("Offset  0  1  2  3  4  5  6  7   8  9  a  b  c  d  e  f         ASCII", 318, 0, 351, 23, 2048)
		GUICtrlSetFont($hEditHeader, 9, 700, 0, "Courier New")
		GUICtrlSetResizing($hEditHeader, 518)
		GUICtrlSetColor($hEditHeader, 0xC0C0C0)
		GUICtrlSetBkColor($hEditHeader, 0x000000)
		GUICtrlSetState($hEditHeader, 32)

		$hEdit = GUICtrlCreateEdit("", 318, 21, 351, 320)
		GUICtrlSetFont($hEdit, 9, 400, 0, "Courier New") ; Lucida Console
		GUICtrlSetState($hEdit, 32)
		GUICtrlSetResizing($hEdit, 102)

		$hPic = GUICtrlCreatePic("", 0, 0, 0, 0)
		GUICtrlSetState($hPic, 32)
		GUICtrlSetResizing($hPic, 770)

		$hIco = GUICtrlCreateIcon("", "", 0, 0, 0, 0)
		GUICtrlSetState($hIco, 32)
		GUICtrlSetResizing($hIco, 770)

		$hListView = GUICtrlCreateListView("", 318, 170, 351, 172)
		GUICtrlSetFont($hListView, 8)
		GUICtrlSetColor($hListView, 0x0000C0)
		GUICtrlSetState($hListView, 32)
		GUICtrlSetResizing($hListView, 70)

		$hInfoSoundEdit = GUICtrlCreateEdit("", 350, 80, 220, 160)
		GUICtrlSetFont($hInfoSoundEdit, 9, 700, 0, "Courier New")
		GUICtrlSetColor($hInfoSoundEdit, 0x0000C0)
		GUICtrlSetState($hInfoSoundEdit, 32)
		GUICtrlSetResizing($hInfoSoundEdit, 258)
		$hButtonPlayMedia = GUICtrlCreateButton("Play", 385, 255, 62, 20)
		GUICtrlSetFont($hButtonPlayMedia, 7, 400)
		GUICtrlSetState($hButtonPlayMedia, 32)
		GUICtrlSetResizing($hButtonPlayMedia, 770)
		$hButtonPauseSound = GUICtrlCreateButton("Pause", 452, 255, 38, 20)
		GUICtrlSetFont($hButtonPauseSound, 7, 400)
		GUICtrlSetState($hButtonPauseSound, 32)
		GUICtrlSetResizing($hButtonPauseSound, 770)
		$hButtonStopSound = GUICtrlCreateButton("Stop", 495, 255, 50, 20)
		GUICtrlSetFont($hButtonStopSound, 7, 400)
		GUICtrlSetState($hButtonStopSound, 32)
		GUICtrlSetResizing($hButtonStopSound, 770)

		$hLabelAviInfo = GUICtrlCreateLabel("", 0, 0, 100, 100)
		GUICtrlSetFont($hLabelAviInfo, 8, 700)
		GUICtrlSetColor($hLabelAviInfo, 0x0000C0)
		GUICtrlSetState($hLabelAviInfo, 32)

		$hFileMenu = GUICtrlCreateMenu("File")
		$hFileOpenItem = GUICtrlCreateMenuItem("Open", $hFileMenu)
		GUICtrlSetState($hFileOpenItem, 512)
		$hSaveItem = GUICtrlCreateMenuItem("Save As...", $hFileMenu)
		GUICtrlSetState($hSaveItem, 128)
		GUICtrlCreateMenuItem("", $hFileMenu)
		$hExitItem = GUICtrlCreateMenuItem("Exit", $hFileMenu)

		$hActionMenu = GUICtrlCreateMenu("Action")
		$hActionItem = GUICtrlCreateMenuItem("Initialize Compiler", $hActionMenu)
		GUICtrlCreateMenuItem("", $hActionMenu)
		$hGenerateItem = GUICtrlCreateMenuItem("Generate Initial DLL", $hActionMenu)
		GUICtrlSetState($hGenerateItem, 128)
		$hAddItem = GUICtrlCreateMenuItem("Add resource", $hActionMenu)
		GUICtrlSetState($hAddItem, 128)

		$hOptionsMenu = GUICtrlCreateMenu("Options")
		$hRestoreDefaultSettings = GUICtrlCreateMenuItem("Restore Defaults", $hOptionsMenu)

		$hButton = GUICtrlCreateButton("Save selected", 220, 354, 80, 21)
		GUICtrlSetTip($hButton, "Save selected resource")
		GUICtrlSetState($hButton, 128)
		GUICtrlSetResizing($hButton, 834)

		$hDeleteButton = GUICtrlCreateButton("Delete selected", 120, 354, 80, 21)
		GUICtrlSetTip($hDeleteButton, "Delete selected resource")
		GUICtrlSetState($hDeleteButton, 32)
		GUICtrlSetResizing($hDeleteButton, 834)

		$hAddButton = GUICtrlCreateButton("Add resource", 20, 354, 80, 21)
		GUICtrlSetTip($hAddButton, "Browse for new resource to add")
		GUICtrlSetState($hAddButton, 32)
		GUICtrlSetResizing($hAddButton, 834)

		Local $bBinaryImage = _BinaryImageData()
		Local $iWidthImageCompressed, $iHeightImageCompressed
		Local $hImageCompressed = _CreateHBitmapFromBinaryImage($bBinaryImage, $iWidthImageCompressed, $iHeightImageCompressed)
		If $hImageCompressed Then
			$hPicCompressed = GUICtrlCreatePic("", 302, 356, $iWidthImageCompressed, $iHeightImageCompressed)
			GUICtrlSetResizing($hPicCompressed, 834)
			GUICtrlSetState($hPicCompressed, 32)
			GUICtrlSendMsg($hPicCompressed, 370, 0, $hImageCompressed)
			DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $hImageCompressed)
			$iBinaryImageDataOK = 1
		EndIf

		GUIRegisterMsg(5, "_AdjustMediaViewPos") ; WM_SIZE
		GUIRegisterMsg(36, "_SetMinMax") ; WM_GETMINMAXINFO
		GUIRegisterMsg(522, "_ResizePic") ; WM_MOUSEWHEEL

	Else

		If $iCompilerEnabled Then
			GUICtrlSetState($hAddButton, 16)
			GUICtrlSetState($hDeleteButton, 144)
			GUICtrlSetState($hAddItem, 64)
		Else
			Local $sTitle = FileGetLongName($sFileLoaded) & " - Resources [" & $iInstanceCurrent & " of " & $iInstancesOverall & "]"
			Local $aClientSize = WinGetClientSize($hGui)

			Local $a_iCall = DllCall("shlwapi.dll", "int", "PathCompactPathW", _
					"hwnd", 0, _
					"wstr", $sTitle, _
					"dword", $aClientSize[0] - 100)

			If @error Then
				WinSetTitle($hGui, 0, $sTitle)
			Else
				WinSetTitle($hGui, 0, $a_iCall[2])
			EndIf

			GUICtrlSetState($hAddButton, 32)
			GUICtrlSetState($hDeleteButton, 32)
			GUICtrlSetState($hAddItem, 128)
		EndIf

		Local $aTreeViewPos = ControlGetPos($hGui, 0, $hTreeView)
		If @error Then
			Return SetError(32, 0, "")
		EndIf

		GUICtrlDelete($hTabResources)
		$hTabResources = GUICtrlCreateTabItem("Resources")

		GUICtrlDelete($hTreeView) ; otherwise leaks
		$hTreeView = GUICtrlCreateTreeView($aTreeViewPos[0], $aTreeViewPos[1], $aTreeViewPos[2], $aTreeViewPos[3])
		GUICtrlSetState($hTreeView, 8) ; $GUI_DROPACCEPTED
		GUICtrlSetImage($hTreeView, @SystemDir & "\shell32.dll", 4)
		GUICtrlSetFont($hTreeView, 9)
		GUICtrlSendMsg($hTreeView, 4379, 22, 0) ; set size
		GUICtrlSetResizing($hTreeView, 354)

		GUICtrlDelete($hTabMisc)
		$hTabMisc = GUICtrlCreateTabItem("Misc")

		GUICtrlDelete($hTreeMisc)
		$hTreeMisc = GUICtrlCreateTreeView($aTreeViewPos[0], $aTreeViewPos[1], $aTreeViewPos[2], $aTreeViewPos[3], 63)
		GUICtrlSetState($hTreeMisc, 8) ; $GUI_DROPACCEPTED
		GUICtrlSetFont($hTreeMisc, 9)
		GUICtrlSendMsg($hTreeMisc, 4379, 22, 0) ; set size
		GUICtrlSetResizing($hTreeMisc, 354)
		_PopulateMiscTreeView($hTreeMisc, $sFileLoaded)

		GUICtrlCreateTabItem("")
		GUICtrlSetState($hTabResources, 16)

		GUICtrlDelete($hContext)
		$hContext = GUICtrlCreateContextMenu($hTreeView)
		$hContextExpCol = GUICtrlCreateMenuItem("Expand All Types", $hContext)
		GUICtrlSetState($hContextExpCol, 128)

		GUICtrlSetState($hPicCompressed, 32)
		GUICtrlSetState($hPic, 32)
		GUICtrlSetState($hIco, 32)
		GUICtrlSetState($hEditHeader, 32)
		GUICtrlSetState($hEdit, 32)
		GUICtrlSetState($hListView, 32)
		GUICtrlSetState($hButtonPlayMedia, 32)
		GUICtrlSetState($hInfoSoundEdit, 32)
		GUICtrlSetState($hButtonPauseSound, 32)
		GUICtrlSetState($hButtonStopSound, 32)
		GUICtrlSetState($hLabelAviInfo, 32)
		GUICtrlSetState($hButton, 128)
		GUICtrlSetData($hFileOpenItem, "Open New")
		GUICtrlSetState($hContextExpCol, 64)
	EndIf

	GUICtrlSendMsg($hTreeView, 11, 0, 0) ; disable treeview changes

	Local $iLangItem = -1
	Local $iNameItem = -1
	Local $iTypeItem = -1
	Local $iExtractionOrdinal

	GUICtrlSetData($hProgress, 95)

	For $f = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1

		If $ARRAY_MODULE_STRUCTURE[$f][0][0] Then
			$iTypeItem += 1
			$hTypeItem[$iTypeItem] = GUICtrlCreateTreeViewItem(_ResTypes($ARRAY_MODULE_STRUCTURE[$f][0][0]) & " (" & _ResTypes($ARRAY_MODULE_STRUCTURE[$f][0][0], 0) & ")", $hTreeView)

			For $g = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1

				If $ARRAY_MODULE_STRUCTURE[$f][$g][0] Then
					If $ARRAY_MODULE_STRUCTURE[$f][0][0] = $RT_GROUP_ICON Then
						$iExtractionOrdinal -= 1
					EndIf
					$iNameItem += 1
					$hNameItem[$iNameItem] = GUICtrlCreateTreeViewItem($ARRAY_MODULE_STRUCTURE[$f][$g][0], $hTypeItem[$iTypeItem])

					For $h = 1 To UBound($ARRAY_MODULE_STRUCTURE, 3) - 1

						If IsNumber($ARRAY_MODULE_STRUCTURE[$f][$g][$h]) Then
							$iLangItem += 1
							$hLanguageItem[$iLangItem][0] = GUICtrlCreateTreeViewItem($ARRAY_MODULE_STRUCTURE[$f][$g][$h] & " - " & _LanguageCode($ARRAY_MODULE_STRUCTURE[$f][$g][$h]), $hNameItem[$iNameItem])
							$hLanguageItem[$iLangItem][1] = StringFormat("%u:%u:%u", $f, $g, $h)
							GUICtrlSetImage($hLanguageItem[$iLangItem][0], @SystemDir & "\shell32.dll", 274) ; this slows down
							If $ARRAY_MODULE_STRUCTURE[$f][0][0] = $RT_GROUP_ICON Then
								$hLanguageItem[$iLangItem][2] = $iExtractionOrdinal
							EndIf
						EndIf

					Next

				EndIf

			Next

		EndIf

	Next

	GUICtrlSetData($hProgress, 100)
	GUISetCursor(-1, 1, $hGui)
	GUICtrlSendMsg($hTreeView, 11, 1, 0); allow changes again

	If $iFirstRun Then
		If $iDroppedOnFirstRun Then
			GUICtrlSetData($hFileOpenItem, "Open New")
		Else
			GUICtrlSendMsg($hTreeView, 4353, 0, 0xFFFF0000); delete treeview
		EndIf
		GUISetState()
		$iFirstRun = 0
	EndIf

	GUICtrlSetState($hProgress, 32)

	GUICtrlSetData($hContextExpCol, "Expand All Types")
	If $iTypeItem = -1 Then
		GUICtrlSetState($hContextExpCol, 128)
	EndIf

	Local $aMsg, $iViewed, $a_Call
	Local $hHandle, $iExpanded
	Local $hTimer = TimerInit() ; GIF animation requirement
	Local $iPosXEgg, $iMovEgg = 1, $aNameLabelPos, $iDown, $iTimesDone, $aCliSize

	While 1

		$aMsg = GUIGetMsg(1)

		If $aMsg[1] = $hGui Then

			Switch $aMsg[0]

				Case $hPic
					GUICtrlSetState($hPic, 256) ; $GUI_FOCUS. Taking focus for resizing to do.

				Case $hIco
					GUICtrlSetState($hIco, 256) ; $GUI_FOCUS. Taking focus for resizing to do.

				Case - 3, $hExitItem
					_CheckSave() ; handle saving if necessary and exit afterward

				Case $hTab
					If Not (GUICtrlRead($hTab) = 0) Then
						GUICtrlSetState($hButton, 128)
						GUICtrlSetState($hDeleteButton, 128)
					Else
						$iViewed = 0 ; trigger
					EndIf

				Case - 13
					Switch $iCompilerEnabled
						Case 0
							$iPlayed = 3
							$iDestroyDialogWindow = 1
							$iMenuIs = 0
							$hMenuLoaded = ""
							$iMultipleFramesGIF = 0
							$iDestroyGIFBitmapHandles = 1
							$iImageListDestroy = 1
							_Main(@GUI_DragFile)
						Case 1
							; Code missing
						Case 2
							If _ProcessFile(@GUI_DragFile) Then
								$iPlayed = 3
								$iDestroyDialogWindow = 1
								$iMenuIs = 0
								$hMenuLoaded = ""
								$iMultipleFramesGIF = 0
								$iDestroyGIFBitmapHandles = 1
								$iImageListDestroy = 1
								_Main($sFileLoaded)
							EndIf
					EndSwitch

				Case $hContextExpCol
					If $iTypeItem <> -1 Then
						$hHandle = GUICtrlGetHandle($hTreeView)
						If $iExpanded Then
							For $x = 0 To $iTypeItem
								ControlTreeView($hGui, 0, $hHandle, "Collapse", "#" & $x)
							Next
							GUICtrlSetData($hContextExpCol, "Expand All Types")
							$iExpanded = 0
						Else
							For $x = 0 To $iTypeItem
								ControlTreeView($hGui, 0, $hHandle, "Expand", "#" & $x)
							Next
							GUICtrlSetData($hContextExpCol, "Collapse Types")
							$iExpanded = 1
						EndIf
					EndIf

				Case $hFileOpenItem
					$iPlayed = 3
					GUICtrlSetState($hButton, 128)
					GUICtrlSetState($hDeleteButton, 32)
					GUICtrlSetState($hAddButton, 32)
					GUICtrlSetState($hAddItem, 128)
					Local $sFile = FileOpenDialog("Choose file", "", "(*.exe; *.dll; *.scr; *.ocx; *.cpl; *.icl)| All files(*.*)", 1, "", $hGui)
					If Not @error Then
						$iMultipleFramesGIF = 0
						$iDestroyGIFBitmapHandles = 1
						$iDestroyDialogWindow = 1
						$iImageListDestroy = 1
						$iMenuIs = 0
						$hMenuLoaded = ""
						_Main($sFile)
					EndIf

				Case $hRestoreDefaultSettings
					_RestoreDefaultSettings()

				Case $hButton
					_SaveSelected($iViewed, $hLanguageItem)
					Switch @error
						Case 22
							MsgBox(48, "Error", "Unsupported Bitmap format", 0, $hGui)
						Case 24, 25
							MsgBox(48, "Error", "Error occurred." & @CRLF & "Saving canceled.", 0, $hGui)
						Case 31
							MsgBox(48, "Error", "Couldn't obtain writing rights." & @CRLF & "Saving canceled.", 0, $hGui)
					EndSwitch

				Case $hButtonPauseSound
					DllCall("user32.dll", "dword", "SendMessage", "hwnd", $hMCI, "dword", 2057, "dword", 0, "dword", 0) ; pause
					$iPlayed = 1
					GUICtrlSetState($hButtonPlayMedia, 64)
					GUICtrlSetState($hButtonPauseSound, 128)
					GUICtrlSetState($hButtonStopSound, 64)

				Case $hButtonStopSound
					DllCall("user32.dll", "dword", "SendMessage", "hwnd", $hMCI, "dword", 2056, "dword", 0, "dword", 0) ; stop
					$iPlayed = 2
					GUICtrlSetState($hButtonPlayMedia, 64)
					GUICtrlSetState($hButtonPauseSound, 128)
					GUICtrlSetState($hButtonStopSound, 128)

				Case $hButtonPlayMedia
					If $hMCI Then
						Switch $iPlayed
							Case 1
								DllCall("user32.dll", "dword", "SendMessage", "hwnd", $hMCI, "dword", 2054, "dword", 0, "dword", 0) ; resume play
							Case 2
								DllCall("user32.dll", "dword", "SendMessage", "hwnd", $hMCI, "dword", 1146, "dword", 0, "dword", 0) ; play from start
						EndSwitch
						$iPlayed = 0
						GUICtrlSetState($hButtonPlayMedia, 128)
						GUICtrlSetState($hButtonPauseSound, 64)
						GUICtrlSetState($hButtonStopSound, 64)
					Else
						_PlayResource($aMediaResource)
					EndIf

				Case $hActionItem
					$iCompilerEnabled = 1
					$sFileLoaded = ""
					$iViewed = ""
					$iPlayed = 3
					$iDestroyDialogWindow = 1
					$iMenuIs = 0
					$hMenuLoaded = ""
					$iMultipleFramesGIF = 0
					$iDestroyGIFBitmapHandles = 1
					$iImageListDestroy = 1
					GUICtrlSetData($hContextExpCol, "Expand All Types")
					GUICtrlSetState($hContextExpCol, 128)
					GUICtrlSetState($hFileOpenItem, 128)
					GUICtrlSetState($hActionItem, 128)
					GUICtrlSetState($hGenerateItem, 64)
					WinSetTitle($hGui, 0, "Resources [" & $iInstanceCurrent & " of " & $iInstancesOverall & "] - Compiler Enabled")
					GUICtrlSendMsg($hTreeView, 4353, 0, 0xFFFF0000); delete treeview, This is not freeing memory. That is below (when deleting).
					GUICtrlSendMsg($hTreeMisc, 4353, 0, 0xFFFF0000)
					GUICtrlSetState($hButton, 128)
					GUICtrlSetState($hDeleteButton, 32)
					GUICtrlSetState($hPic, 32)
					GUICtrlSetState($hPicCompressed, 32)
					GUICtrlSetState($hIco, 32)
					GUICtrlSetState($hListView, 32)
					GUICtrlSetState($hEditHeader, 32)
					GUICtrlSetState($hEdit, 32)
					GUICtrlSetState($hButtonPlayMedia, 32)
					GUICtrlSetState($hInfoSoundEdit, 32)
					GUICtrlSetState($hButtonPauseSound, 32)
					GUICtrlSetState($hButtonStopSound, 32)
					GUICtrlSetState($hLabelAviInfo, 32)

				Case $hGenerateItem
					GUICtrlSetState($hGenerateItem, 128)
					$sRawDLL = _GenerateInitialDLL()
					If Not @error Then
						GUICtrlSetState($hAddButton, 16)
						GUICtrlSetState($hDeleteButton, 144)
						GUICtrlSetState($hSaveItem, 64)
						GUICtrlSetState($hAddItem, 64)
						$iCompilerEnabled = 2
						_Main($sRawDLL)
					EndIf

				Case $hSaveItem
					Local $sSaveFile

					While 1
						$sSaveFile = FileSaveDialog("Save Resource DLL", @DesktopDir, "Resource DLL (*.dll)", 2, "", $hGui)
						If Not $sSaveFile Then
							ExitLoop
						EndIf
						If Not (StringRight($sSaveFile, 4) = ".dll") Then
							$sSaveFile &= ".dll"
						EndIf
						If FileExists($sSaveFile) Then
							If MsgBox(52, "Save Resource", FileGetLongName($sSaveFile) & " already exists." & @CRLF & "Do you want to replace it?", 0, $hGui) = 6 Then
								ExitLoop
							EndIf
						Else
							ExitLoop
						EndIf
					WEnd
					If $sSaveFile Then
						Local $iOffsetPadding = StringInStr(FileRead($sRawDLL), "PADDING", 1, -1) ; will truncate first if necessary
						If $iOffsetPadding Then
							$iOffsetPadding += 6
							$iOffsetPadding = 512 * Floor(($iOffsetPadding + 511) / 512) ; alignment

							Local $hFile = FileOpen($sRawDLL, 16)
							Local $bFile = FileRead($hFile, $iOffsetPadding)
							FileClose($hFile)
							If $bFile Then
								$hFile = FileOpen($sRawDLL, 18)
								If Not ($hFile = -1) Then
									FileWrite($hFile, $bFile)
									FileClose($hFile)
								EndIf
							EndIf
						EndIf

						If FileCopy($sRawDLL, $sSaveFile, 9) Then
							FileDelete($sRawDLL)
							$sRawDLL = ""
							$iPlayed = 3
							$iDestroyDialogWindow = 1
							$iMenuIs = 0
							$hMenuLoaded = ""
							$iMultipleFramesGIF = 0
							$iDestroyGIFBitmapHandles = 1
							$iImageListDestroy = 1
							GUICtrlSetState($hGenerateItem, 128)
							GUICtrlSetState($hSaveItem, 128)
							GUICtrlSetState($hActionItem, 64)
							GUICtrlSetState($hFileOpenItem, 512)
							WinSetTitle($hGui, 0, "Resources [" & $iInstanceCurrent & " of " & $iInstancesOverall & "]")
							$iCompilerEnabled = 0
							_Main($sSaveFile)
						Else
							MsgBox(48, "Error", "Saving Failed!", 0, $hGui)
						EndIf
					EndIf

				Case $hAddButton, $hAddItem
					Local $sFile = FileOpenDialog("Choose file to add", "", "All files(*.*)", 1, "", $hGui)
					If Not @error Then
						_ProcessFile($sFile)
						Switch @error
							Case 100
								MsgBox(48, "Error", "Targeted module is missing." & @CRLF & "Adding canceled.", 0, $hGui)
							Case 101
								MsgBox(48, "Error", "Couldn't obtain writing rights." & @CRLF & "Adding canceled.", 0, $hGui)
							Case False
								$iPlayed = 3
								$iDestroyDialogWindow = 1
								_Main($sFileLoaded)
						EndSwitch
					EndIf

				Case $hDeleteButton
					_DeleteSelected($iViewed, $hLanguageItem)
					Switch @error
						Case 100
							MsgBox(48, "Error", "Targeted module is missing." & @CRLF & "Deleting canceled.", 0, $hGui)
						Case 101
							MsgBox(48, "Error", "Couldn't obtain writing rights." & @CRLF & "Deleting canceled.", 0, $hGui)
						Case False
							$iPlayed = 3
							$iDestroyDialogWindow = 1
							_Main($sFileLoaded)
					EndSwitch

			EndSwitch

		EndIf

		If GUICtrlRead($hTreeView) <> $iViewed Then
			$iPlayed = 3
			$iDestroyDialogWindow = 1
			$iMenuIs = 0
			$hMenuLoaded = ""
			$iMultipleFramesGIF = 0
			$iDestroyGIFBitmapHandles = 1
			$iImageListDestroy = 1
			GUICtrlSetState($hButton, 128)
			GUICtrlSetState($hDeleteButton, 128)
			If $iBinaryImageDataOK Then
				GUICtrlSetState($hPicCompressed, 32)
			EndIf
			GUICtrlSetState($hPic, 32)
			GUICtrlSetState($hIco, 32)
			GUICtrlSetState($hListView, 32)
			GUICtrlSetState($hEditHeader, 32)
			GUICtrlSetState($hEdit, 32)
			GUICtrlSetState($hButtonPlayMedia, 32)
			GUICtrlSetState($hInfoSoundEdit, 32)
			GUICtrlSetState($hButtonPauseSound, 32)
			GUICtrlSetState($hButtonStopSound, 32)
			GUICtrlSetState($hLabelAviInfo, 32)
			$iViewed = GUICtrlRead($hTreeView)
			_ViewSelected($iViewed, $hLanguageItem)
		EndIf

		If $hMCI Then
			Switch $iPlayed
				Case 0
					$a_Call = DllCall("user32.dll", "dword", "SendMessage", "hwnd", $hMCI, "dword", 1226, "dword", 0, "dword", 0)
					If $a_Call[0] = $iLength Then
						$iPlayed = 1
						GUICtrlSetState($hButtonPlayMedia, 64)
						GUICtrlSetState($hButtonPauseSound, 128)
						GUICtrlSetState($hButtonStopSound, 128)
						$iPlayed = 2
					EndIf
					Sleep(10)
				Case 3
					$a_Call = DllCall("user32.dll", "int", "DestroyWindow", "hwnd", $hMCI)
					If @error Or Not $a_Call[0] Then
						Return SetError(1, 0, "")
					EndIf
					GUICtrlSetState($hLabelAviInfo, 32)
					FileDelete($sMediaTempFile)
					$sMediaTempFile = ""
					$hMCI = ""
			EndSwitch
		EndIf

		If $hDialogWindow Then
			If $iDestroyDialogWindow Then
				$a_Call = DllCall("user32.dll", "int", "DestroyWindow", "hwnd", $hDialogWindow)
				If @error Or Not $a_Call[0] Then
					Return SetError(1, 0, "")
				EndIf
				$hDialogWindow = ""
			EndIf
		EndIf

		If $hMenuGui Then
			If Not $iMenuIs Then
				$a_Call = DllCall("user32.dll", "int", "DestroyMenu", "hwnd", $hMenuLoaded)
				GUIDelete($hMenuGui)
				$hMenuGui = ""
			EndIf
		EndIf

		If $iMultipleFramesGIF Then ; GIF animation follows
			If Mod(Floor(TimerDiff($hTimer) / ($aHGIFBitmaps[$iFrame][1] / 2)), 2) Then
				If $iGIFFrameSwitch Then
					$iFrame += 1
					If $iFrame = UBound($aHGIFBitmaps) Then
						$iFrame = 0
					EndIf
					Local $iHMsg = GUICtrlSendMsg($hPic, 370, 0, $aHGIFBitmaps[$iFrame][0])
					If $iTransparentGIF Then
						GUICtrlSetStyle($hPic, 270) ; SS_BITMAP|SS_NOTIFY (default) - 'refreshing'. Or maybe GUICtrlSetState($hPic, 64), or 16.
					EndIf
					If $iHMsg Then
						DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $iHMsg)
					EndIf
					$iGIFFrameSwitch = 0
				EndIf
			Else
				If Not $iGIFFrameSwitch Then
					$iGIFFrameSwitch = 1
				EndIf
			EndIf
			$iDestroyGIFBitmapHandles = 1
		Else
			If $iDestroyGIFBitmapHandles Then
				For $i = 0 To UBound($aHGIFBitmaps) - 1
					DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $aHGIFBitmaps[$i][0])
				Next
				$iFrame = 0
				$aHGIFBitmaps = 0
				$iMultipleFramesGIF = 0
				$iDestroyGIFBitmapHandles = 0
			EndIf
		EndIf

		If $hImageList Then
			If $iImageListDestroy Then
				DllCall("comctl32.dll", "int", "ImageList_Destroy", "hwnd", $hImageList)
				$hImageList = 0
			EndIf
			$iImageListDestroy = 0
		EndIf

		If $iEasterEgg Then ; just fooling arround
			If Not $iTimesDone Then
				$aCliSize = WinGetClientSize($hGui)
				If @error Then
					$iEasterEgg = 0
					$iTimesDone = 0
				Else
					$iPosXEgg = $aCliSize[0] - 170
				EndIf
			EndIf
			If $iEasterEgg Then
				If Mod(Floor(TimerDiff($hTimer) / (50 / 2)), 2) Then
					If $iMovEgg Then
						If $iPosXEgg < $aCliSize[0] - 190 Then
							$iDown = 1
						ElseIf $iPosXEgg > $aCliSize[0] - 165 Then
							$iDown = 0
						EndIf
						If $iDown Then
							$iPosXEgg += 2
						Else
							$iPosXEgg -= 2
						EndIf
						$iTimesDone += 1
						$aNameLabelPos = ControlGetPos($hGui, 0, $hNameLabel)
						If @error Then
							$iEasterEgg = 0
							$iTimesDone = 0
						Else
							If $iTimesDone > 30 And ($aNameLabelPos[0] = $aCliSize[0] - 170 Or $aNameLabelPos[0] = $aCliSize[0] - 169) Then
								$iEasterEgg = 0
								$iTimesDone = 0
							Else
								If $iPosXEgg < 320 Then $iPosXEgg = 320
								$aCliSize = WinGetClientSize($hGui)
								If Not @error Then
									GUICtrlSetPos($hNameLabel, $iPosXEgg, $aCliSize[1] - 38)
								EndIf
								$iMovEgg = 0
							EndIf
						EndIf
					EndIf
				Else
					If Not $iMovEgg Then
						$iMovEgg = 1
					EndIf
				EndIf
			EndIf
		EndIf

	WEnd

EndFunc   ;==>_GuiShow


Func _ViewSelected($iSelected, $aArray)

	Local $aArrayIndexes
	Local $iIconOrdinal
	For $i = 0 To UBound($aArray) - 1
		If $aArray[$i][0] = $iSelected Then
			$aArrayIndexes = StringSplit($aArray[$i][1], ":")
			$iIconOrdinal = $aArray[$i][2]
			ExitLoop
		EndIf
	Next

	If Not UBound($aArrayIndexes) = 4 Then
		Return SetError(1, 0, "")
	EndIf

	GUICtrlSetState($hPic, 32)
	GUICtrlSetState($hPicCompressed, 32)
	GUICtrlSetState($hIco, 32)
	GUICtrlSetState($hListView, 32)
	GUICtrlSetState($hEditHeader, 32)
	GUICtrlSetState($hEdit, 32)
	GUICtrlSetState($hButtonPlayMedia, 32)
	GUICtrlSetState($hInfoSoundEdit, 32)
	GUICtrlSetState($hButtonPauseSound, 32)
	GUICtrlSetState($hButtonStopSound, 32)
	GUICtrlSetState($hLabelAviInfo, 32)
	GUICtrlSetData($hEdit, "")
	GUICtrlSetColor($hEdit, 0x000000)
	GUICtrlSetBkColor($hEdit, 0xFFFFFF)
	GUICtrlSetFont($hEdit, 9, 400, 0, "Courier New")

	Local $aClientSize = WinGetClientSize($hGui)

	Switch $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0]


		Case $RT_CURSOR

			Local $iWidth, $iHeight

			For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1

				If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_GROUP_CURSOR Then

					Local $bRTGroupCursor

					For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
						$bRTGroupCursor = _ResourceGetAsRaw($RT_GROUP_CURSOR, $ARRAY_MODULE_STRUCTURE[$m][$n][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
						If @error Then
							ContinueLoop
						EndIf

						If $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] = _LittleEndianBinaryToInt(BinaryMid($bRTGroupCursor, 19, 2)) Then

							Local $tBinaryRTCursorGroup = DllStructCreate("byte[" & BinaryLen($bRTGroupCursor) & "]")
							DllStructSetData($tBinaryRTCursorGroup, 1, $bRTGroupCursor)
							Local $tRTCursorGroup = DllStructCreate("ushort;" & _
									"ushort Type;" & _
									"ushort ImageCount;" & _
									"ushort Width;" & _
									"ushort Height;" & _
									"ushort Planes;" & _
									"ushort BitPerPixel;" & _
									"ushort;" & _
									"ushort;" & _
									"ushort OrdinalName", _
									DllStructGetPtr($tBinaryRTCursorGroup))

							Local $bBinary = _ResourceGetAsRaw($RT_CURSOR, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
							If @error Then
								Return SetError(2, 0, "")
							EndIf

							Local $tBinaryRTCursor = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
							DllStructSetData($tBinaryRTCursor, 1, $bBinary)

							Local $tRTCursor = DllStructCreate("ushort Xhotspot;" & _
									"ushort Yhotspot;" & _
									"byte Body[" & DllStructGetSize($tBinaryRTCursor) - 4 & "]", _
									DllStructGetPtr($tBinaryRTCursor))

							Local $tCursor = DllStructCreate("align 2;ushort;" & _
									"ushort Type;" & _
									"ushort ImageCount;" & _
									"ubyte Width;" & _
									"ubyte Height;" & _
									"ubyte Colors;" & _
									"ubyte;" & _
									"ushort Xhotspot;" & _
									"ushort Yhotspot;" & _
									"dword BitmapSize;" & _
									"dword BitmapOffset;" & _
									"byte Body[" & DllStructGetSize($tBinaryRTCursor) - 4 & "]")

							$iWidth = DllStructGetData($tRTCursorGroup, "Width")
							If $iWidth > 32 Then
								$iWidth = 32
							EndIf
							$iHeight = $iWidth
							Local $iXhotspot = DllStructGetData($tRTCursor, "Xhotspot")
							Local $iYhotspot = DllStructGetData($tRTCursor, "Yhotspot")
							Local $iBitmapSize = DllStructGetSize($tRTCursor) - 4

							DllStructSetData($tCursor, "Type", 2)
							DllStructSetData($tCursor, "ImageCount", 1)
							DllStructSetData($tCursor, "Width", $iWidth)
							DllStructSetData($tCursor, "Height", $iHeight)
							DllStructSetData($tCursor, "Xhotspot", $iXhotspot)
							DllStructSetData($tCursor, "Yhotspot", $iYhotspot)
							DllStructSetData($tCursor, "BitmapSize", $iBitmapSize)
							DllStructSetData($tCursor, "BitmapOffset", 22)
							DllStructSetData($tCursor, "Body", DllStructGetData($tRTCursor, "Body"))

							Local $tBinaryCursor = DllStructCreate("byte[" & DllStructGetSize($tCursor) & "]", DllStructGetPtr($tCursor))

							Local $sTempFile = @TempDir & "\" & _GenerateGUID() & ".cur"
							If @error Then
								Return SetError(3, 0, "")
							EndIf
							Local $hTempFile = FileOpen($sTempFile, 26)
							FileWrite($hTempFile, DllStructGetData($tBinaryCursor, 1))
							FileClose($hTempFile)

							Local $iNewXPos = ($aClientSize[0] + 318 - $iWidth) / 2
							Local $iNewYPos = (.8 * $aClientSize[1] - $iHeight) / 2
							If $iNewXPos < 318 Then $iNewXPos = 318
							If $iNewYPos < 0 Then $iNewYPos = 0

							GUICtrlSetPos($hIco, $iNewXPos, $iNewYPos, $iWidth, $iHeight)
							GUICtrlSetImage($hIco, $sTempFile, -1)
							GUICtrlSetPos($hIco, $iNewXPos, $iNewYPos, $iWidth, $iHeight)
							FileDelete($sTempFile)
							GUICtrlSetTip($hIco, " Width: " & $iWidth & @LF & _
									" Height: " & $iHeight & @LF & _
									" Xhotspot: " & $iXhotspot & @LF & _
									" Yhotspot: " & $iYhotspot & @LF & _
									" BitmapSize: " & $iBitmapSize & " bytes")

							GUICtrlSetState($hIco, 16)
							GUICtrlSetState($hButton, 64)

							If $iCompilerEnabled Then
								GUICtrlSetState($hDeleteButton, 80)
							EndIf

							ExitLoop 2

						Else
							; compressor used
						EndIf

					Next

					ExitLoop

				EndIf

			Next

			$aMediaResource[4] = ".cur"
			$aMediaResource[6] = $iWidth
			$aMediaResource[7] = $iHeight

			Return SetError(0, 0, 1)


		Case $RT_BITMAP

			Local $iWidth, $iHeight, $sTip

			Local $hBitmap = _GetBitmapHandle($RT_BITMAP, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, $iWidth, $iHeight, $sTip)
			Switch @error
				Case 3
					Local $sData = _HexEncode($hBitmap) ; $hBitmap is raw binary data in this case
					GUICtrlSetColor($hEdit, 0xC0C0C0)
					GUICtrlSetBkColor($hEdit, 0x000000)
					GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
					GUICtrlSetData($hEdit, $sData)
					GUICtrlSetState($hEditHeader, 16)
					GUICtrlSetState($hEdit, 16)
					GUICtrlSetState($hButton, 128)
					If $iCompilerEnabled Then
						GUICtrlSetState($hDeleteButton, 80)
					EndIf
					Return SetError(1, 0, 1)
				Case True
					Return SetError(2, 0, "")
			EndSwitch

			Local $iNewXPos = ($aClientSize[0] + 318 - $iWidth) / 2
			Local $iNewYPos = ($aClientSize[1] - 32 - $iHeight) / 2

			If $iNewXPos < 318 Then $iNewXPos = 318
			If $iNewYPos < 0 Then $iNewYPos = 0

			GUICtrlSetPos($hPic, $iNewXPos, $iNewYPos, $iWidth, $iHeight)
			GUICtrlSetTip($hPic, $sTip)

			Local $iHMsg = GUICtrlSendMsg($hPic, 370, 0, $hBitmap); STM_SETIMAGE
			If $iHMsg Then
				DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $iHMsg)
			EndIf

			GUICtrlSetState($hPic, 16)
			GUICtrlSetState($hButton, 64)

			If $iCompilerEnabled Then
				GUICtrlSetState($hDeleteButton, 80)
			EndIf

			$aMediaResource[4] = ".bmp"
			$aMediaResource[6] = $iWidth
			$aMediaResource[7] = $iHeight

			Return SetError(0, 0, 1)


		Case $RT_ICON

			Local $bBinary = _ResourceGetAsRaw($RT_ICON, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
			If @error Then
				Return SetError(2, 0, "")
			EndIf
			Local $tBinary = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
			DllStructSetData($tBinary, 1, $bBinary)

			Local $tBitmap = DllStructCreate("dword HeaderSize", DllStructGetPtr($tBinary))

			Local $iHeaderSize = DllStructGetData($tBitmap, "HeaderSize")
			Local $iWidth, $iHeight
			Local $iColors, $iPlanes, $iBitPerPixel
			Local $iPNGIcon

			Switch $iHeaderSize

				Case 40
					$tBitmap = DllStructCreate("dword HeaderSize;" & _
							"dword Width;" & _
							"dword Height;" & _
							"ushort Planes;" & _
							"ushort BitPerPixel;" & _
							"dword CompressionMethod;" & _
							"dword Size;" & _
							"dword Hresolution;" & _
							"dword Vresolution;" & _
							"dword Colors;" & _
							"dword ImportantColors;", _
							DllStructGetPtr($tBinary))
					$iWidth = DllStructGetData($tBitmap, "Width")
					$iHeight = DllStructGetData($tBitmap, "Height")
					$iColors = DllStructGetData($tBitmap, "Colors")
					$iPlanes = DllStructGetData($tBitmap, "Planes")
					$iBitPerPixel = DllStructGetData($tBitmap, "BitPerPixel")

				Case 12
					$tBitmap = DllStructCreate("dword HeaderSize;" & _
							"ushort Width;" & _
							"ushort Height;" & _
							"ushort Planes;" & _
							"ushort BitPerPixel;", _
							DllStructGetPtr($tBinary))
					$iWidth = DllStructGetData($tBitmap, "Width")
					$iHeight = DllStructGetData($tBitmap, "Height")
					$iPlanes = DllStructGetData($tBitmap, "Planes")
					$iBitPerPixel = DllStructGetData($tBitmap, "BitPerPixel")

				Case Else
					Local $tPNG = DllStructCreate("ubyte; char PNG[3]", DllStructGetPtr($tBinary))
					If Not (DllStructGetData($tPNG, 1) = 137 And DllStructGetData($tPNG, "PNG") == "PNG") Then
						Return SetError(0, 1, "")
					EndIf

					Local $iIHDROffset = StringInStr(BinaryToString($bBinary), "IHDR", 1)
					If $iIHDROffset Then
						Local $tBinaryIHDR = DllStructCreate("byte[13]")
						DllStructSetData($tBinaryIHDR, 1, BinaryMid($bBinary, $iIHDROffset + 4, 13))
						Local $tIHDR = DllStructCreate("byte Width[4];" & _
								"byte Height[4];" & _
								"ubyte BitDepth;" & _
								"ubyte ColorType;" & _
								"ubyte CompressionMethod;" & _
								"ubyte FilterMethod;" & _
								"ubyte InterlaceMethod", _
								DllStructGetPtr($tBinaryIHDR))
						$iWidth = Dec(Hex(DllStructGetData($tIHDR, "Width")))
						$iHeight = Dec(Hex(DllStructGetData($tIHDR, "Height")))
						$iBitPerPixel = DllStructGetData($tIHDR, "BitDepth") ; !! not if ColorType = 3 !!
						$iPlanes = 1 ; almost irrelevant
						$iPNGIcon = 1
					EndIf

			EndSwitch

			Local $tIcon = DllStructCreate("align 2;ushort;" & _
					"ushort Type;" & _
					"ushort ImageCount;" & _
					"ubyte Width;" & _
					"ubyte Height;" & _
					"ubyte Colors;" & _
					"byte;" & _
					"ushort Planes;" & _
					"ushort BitPerPixel;" & _
					"dword BitmapSize;" & _
					"dword BitmapOffset;" & _
					"byte Body[" & DllStructGetSize($tBinary) & "]")

			DllStructSetData($tIcon, "Type", 1)
			DllStructSetData($tIcon, "ImageCount", 1)
			DllStructSetData($tIcon, "Width", $iWidth)
			DllStructSetData($tIcon, "Height", $iHeight)
			DllStructSetData($tIcon, "Colors", $iColors)
			DllStructSetData($tIcon, "Planes", $iPlanes)
			DllStructSetData($tIcon, "BitPerPixel", $iBitPerPixel)
			DllStructSetData($tIcon, "BitmapSize", DllStructGetSize($tBinary))
			DllStructSetData($tIcon, "BitmapOffset", 22)
			DllStructSetData($tIcon, "Body", DllStructGetData($tBinary, 1))

			$tBinary = DllStructCreate("byte[" & DllStructGetSize($tIcon) & "]", DllStructGetPtr($tIcon))

			Local $sTempFile = @TempDir & "\" & _GenerateGUID() & ".ico"
			If @error Then
				Return SetError(3, 0, "")
			EndIf
			Local $hTempFile = FileOpen($sTempFile, 26)
			FileWrite($hTempFile, DllStructGetData($tBinary, 1))
			FileClose($hTempFile)

			If Not $iWidth Then
				$iWidth = 256
			EndIf
			$iHeight = $iWidth

			Local $iNewXPos = ($aClientSize[0] + 318 - $iWidth) / 2
			Local $iNewYPos = (.6 * $aClientSize[1] - $iHeight) / 2
			If $iNewXPos < 318 Then $iNewXPos = 318
			If $iNewYPos < 0 Then $iNewYPos = 0

			GUICtrlSetPos($hIco, $iNewXPos, $iNewYPos, $iWidth, $iHeight)
			GUICtrlSetImage($hIco, $sTempFile, -1)
			FileDelete($sTempFile)
			GUICtrlSetPos($hIco, $iNewXPos, $iNewYPos, $iWidth, $iHeight)
			GUICtrlSetTip($hIco, $iWidth & " x " & $iHeight)

			GUICtrlSetState($hIco, 16)
			GUICtrlSetState($hButton, 64)

			If $iCompilerEnabled Then
				GUICtrlSetState($hDeleteButton, 144)
			EndIf

			If $iBinaryImageDataOK And $iPNGIcon Then
				GUICtrlSetState($hPicCompressed, 16)
				GUICtrlSetTip($hPicCompressed, "This icon is compressed", "PNG Icon", 1)
			EndIf

			$aMediaResource[4] = ".ico"
			$aMediaResource[6] = $iWidth
			$aMediaResource[7] = $iHeight

			Return SetError(0, 0, 1)


		Case $RT_MENU

			$hMenuLoaded = _GetMenuHandle($RT_MENU, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded)

			If @error Then
				Local $bData = _ResourceGetAsRaw($RT_MENU, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
				If @error Then
					Return SetError(2, 0, "")
				EndIf

				Local $sData = _HexEncode($bData)
				GUICtrlSetColor($hEdit, 0xC0C0C0)
				GUICtrlSetBkColor($hEdit, 0x000000)
				GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
				GUICtrlSetData($hEdit, $sData)
				GUICtrlSetState($hEditHeader, 16)
				GUICtrlSetState($hEdit, 16)
				GUICtrlSetState($hButton, 128)
				If $iCompilerEnabled Then
					GUICtrlSetState($hDeleteButton, 80)
				EndIf

				Return SetError(1, 0, 1)
			EndIf

			If $hMenuGui Then
				Local $a_Call = DllCall("user32.dll", "int", "DestroyMenu", "hwnd", $hMenuLoaded)
				GUIDelete($hMenuGui)
				$hMenuGui = ""
			EndIf

			$hMenuGui = GUICreate("Menu: " & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], 430, 70, @DesktopWidth - 445, @DesktopHeight - 165, 281018368, -1, $hGui) ; WS_CAPTION|WS_VISIBLE

			Local $a_iCall = DllCall("user32.dll", "int", "SetMenu", "hwnd", $hMenuGui, "hwnd", $hMenuLoaded)

			If @error Or Not $a_iCall[0] Then
				GUIDelete($hMenuGui)
				$hMenuGui = ""
				$iMenuIs = 0
				Return SetError(3, 0, "")
			EndIf

			$iMenuIs = 1

			Return SetError(0, 0, 1)


		Case $RT_DIALOG

			$hDialogWindow = _GetDialogWindowHandle($RT_DIALOG, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded)

			Switch @error
				Case 5, 6, 7, 8
					Local $bData = $hDialogWindow ; _GetDialogWindowHandle returns raw binary in this case
					Local $sData = _HexEncode($bData)
					GUICtrlSetColor($hEdit, 0xC0C0C0)
					GUICtrlSetBkColor($hEdit, 0x000000)
					GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
					GUICtrlSetData($hEdit, $sData)
					GUICtrlSetState($hEditHeader, 16)
					GUICtrlSetState($hEdit, 16)
					GUICtrlSetState($hButton, 128)
					If $iCompilerEnabled Then
						GUICtrlSetState($hDeleteButton, 80)
					EndIf
					$hDialogWindow = ""
					Return SetError(0, 0, 1)
			EndSwitch

			$iDestroyDialogWindow = 0

			Local $aDialogClientSize = WinGetClientSize($hDialogWindow)

			If $iDialogIsChild Then
				Local $iNewXPos = ($aClientSize[0] + 318 - $aDialogClientSize[0]) / 2
				Local $iNewYPos = (.8 * $aClientSize[1] - $aDialogClientSize[1]) / 2
				If $iNewXPos < 335 Then $iNewXPos = 335
				If $iNewYPos < 60 Then $iNewYPos = 60
			Else
				Local $iNewXPos = @DesktopWidth - $aDialogClientSize[0] - 15
				Local $iNewYPos = @DesktopHeight - $aDialogClientSize[1] - 93
			EndIf

			WinMove($hDialogWindow, 0, $iNewXPos, $iNewYPos)
			WinSetState($hDialogWindow, 0, @SW_SHOW)

			Return SetError(0, 0, 1)


		Case $RT_STRING

			Local $bBinary = _ResourceGetAsRaw($RT_STRING, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
			If @error Then
				Return SetError(2, 0, "")
			EndIf

			Local $iMainId = ($ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] - 1) * 16
			Local $iStringSize
			Local $iString
			Local $sString
			Local $iOffset = 1
			Local $iBinaryLen = BinaryLen($bBinary)
			Local $sData = @CRLF & "{{{" & @CRLF

			While $iOffset < $iBinaryLen
				$iStringSize = 2 * _LittleEndianBinaryToInt(BinaryMid($bBinary, $iOffset, 2))
				$iOffset += 2

				$sString = StringReplace(StringStripCR(BinaryToString(BinaryMid($bBinary, $iOffset, $iStringSize), 2)), @LF, "\n")
				$iString += 1
				If $iString > 16 Then
					$iString = 16
					ExitLoop ; ...to be on the safe side.
				EndIf

				If $sString Then
					$sData &= "    Id " & $iMainId + $iString - 1 & ":  " & @TAB & $sString & @CRLF
				EndIf

				$iOffset += $iStringSize
			WEnd

			$sData &= "}}}"

			If Not ($iString = 16) Then ; check for compression
				$sData = _HexEncode($bBinary)
				GUICtrlSetColor($hEdit, 0xC0C0C0)
				GUICtrlSetBkColor($hEdit, 0x000000)
				GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
				GUICtrlSetState($hEditHeader, 16)
			EndIf

			GUICtrlSetData($hEdit, $sData)
			GUICtrlSetState($hEdit, 16)
			GUICtrlSetState($hButton, 128)
			If $iCompilerEnabled Then
				GUICtrlSetState($hDeleteButton, 144)
			EndIf


		Case $RT_ACCELERATOR

			Local $bBinary = _ResourceGetAsRaw($RT_ACCELERATOR, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
			If @error Then
				Return SetError(2, 0, "")
			EndIf

			Local $iTable[BinaryLen($bBinary) / 8]
			Local $tBinaryTableEntryMember = DllStructCreate("byte[8]")
			Local $tTableEntryMember
			Local $iFlag
			Local $sData = @CRLF & "{{{" & @CRLF

			For $i = 1 To BinaryLen($bBinary) Step 8

				DllStructSetData($tBinaryTableEntryMember, 1, BinaryMid($bBinary, $i, 8))
				$tTableEntryMember = DllStructCreate("ushort Flags;" & _
						"ushort Ansi;" & _
						"ushort Id;" & _
						"short", _
						DllStructGetPtr($tBinaryTableEntryMember))

				$iFlag = DllStructGetData($tTableEntryMember, "Flags")

				$sData &= @TAB & "Id " & DllStructGetData($tTableEntryMember, "Id") & ":  " & @TAB & _
						_AcceleratorTableFlag($iFlag) & _
						_VirtualKey(DllStructGetData($tTableEntryMember, "Ansi"), (Not $iFlag)) & @CRLF

			Next

			$sData &= "}}}"

			GUICtrlSetData($hEdit, $sData)
			GUICtrlSetState($hEdit, 16)
			GUICtrlSetState($hButton, 128)
			If $iCompilerEnabled Then
				GUICtrlSetState($hDeleteButton, 144)
			EndIf


		Case $RT_GROUP_CURSOR

			Local $bBinary = _ResourceGetAsRaw($RT_GROUP_CURSOR, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
			If @error Then
				Return SetError(2, 0, "")
			EndIf
			Local $tBinary = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
			DllStructSetData($tBinary, 1, $bBinary)

			Local $tCursorGroup = DllStructCreate("ushort;" & _
					"ushort Type;" & _
					"ushort ImageCount;" & _
					"ushort Width;" & _
					"ushort Height;" & _
					"ushort Planes;" & _
					"ushort BitPerPixel;" & _
					"ushort;" & _
					"ushort;" & _
					"ushort OrdinalName", _
					DllStructGetPtr($tBinary))

			Local $iWidth = DllStructGetData($tCursorGroup, "Width")
			If $iWidth > 32 Then
				$iWidth = 32
			EndIf
			Local $iHeight = $iWidth
			Local $sTip = " Width: " & $iWidth & @LF & _
					" Height: " & $iHeight & @LF & _
					" Planes: " & DllStructGetData($tCursorGroup, "Planes") & @LF & _
					" BitPerPixel: " & DllStructGetData($tCursorGroup, "BitPerPixel") & @LF & _
					" RTCursor name: " & DllStructGetData($tCursorGroup, "OrdinalName")

			Local $hCursor = _GetCursorHandle($RT_GROUP_CURSOR, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded)
			Switch @error
				Case True
					Local $sData = _HexEncode($bBinary)
					GUICtrlSetColor($hEdit, 0xC0C0C0)
					GUICtrlSetBkColor($hEdit, 0x000000)
					GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
					GUICtrlSetState($hEditHeader, 16)
					GUICtrlSetData($hEdit, $sData)
					GUICtrlSetState($hEdit, 16)
					GUICtrlSetState($hButton, 128)
					If $iCompilerEnabled Then
						GUICtrlSetState($hDeleteButton, 144)
					EndIf
					Return SetError(0, 1, 1)
				Case Else
			EndSwitch

			Local $iNewXPos = ($aClientSize[0] + 318 - $iWidth) / 2
			Local $iNewYPos = (.8 * $aClientSize[1] - $iHeight) / 2
			If $iNewXPos < 318 Then $iNewXPos = 318
			If $iNewYPos < 0 Then $iNewYPos = 0

			GUICtrlSetTip($hIco, $sTip)
			GUICtrlSetPos($hIco, $iNewXPos, $iNewYPos, $iWidth, $iHeight)

			Local $iHMsg = GUICtrlSendMsg($hIco, 370, 2, $hCursor)
			If $iHMsg Then
				DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $iHMsg)
			EndIf

			GUICtrlSetPos($hIco, $iNewXPos, $iNewYPos, $iWidth, $iHeight)

			GUICtrlSetState($hIco, 16)
			GUICtrlSetState($hButton, 64)

			If $iCompilerEnabled Then
				GUICtrlSetState($hDeleteButton, 80)
			EndIf

			$aMediaResource[4] = ".cur"
			$aMediaResource[6] = $iWidth
			$aMediaResource[7] = $iHeight

			Return SetError(0, 0, 1)


		Case $RT_GROUP_ICON

			Local $aIconData = _CrackIcon($ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded)
			If @error Then
				Return SetError(2, 0, "")
			EndIf

			If Not IsArray($aIconData) Then
				Return SetError(0, 1, "")
			EndIf

			Local $iWidth
			Local $iHeight
			For $i = 0 To UBound($aIconData) - 1
				$iWidth = $aIconData[$i][0]
				$iHeight = $aIconData[$i][1]
				If $iWidth Then
					ExitLoop
				EndIf
			Next

			Local $iNewXPos = ($aClientSize[0] + 318 - $iWidth) / 2
			Local $iNewYPos = (.6 * $aClientSize[1] - $iHeight) / 2
			If $iNewXPos < 318 Then $iNewXPos = 318
			If $iNewYPos < 0 Then $iNewYPos = 0

			GUICtrlSetPos($hIco, $iNewXPos, $iNewYPos, $iWidth, $iHeight)

			If GUICtrlSetImage($hIco, $sFileLoaded, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0]) Then
				GUICtrlSetTip($hIco, " - name:   " & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] & @LF & _
						" - ordinal:   " & $iIconOrdinal, "Extraction Values", 1)
			Else
				GUICtrlSetTip($hIco, "")
			EndIf

			GUICtrlSetPos($hIco, $iNewXPos, $iNewYPos, $iWidth, $iHeight)

			If $hMenuGui Then
				Local $a_Call = DllCall("user32.dll", "int", "DestroyMenu", "hwnd", $hMenuLoaded)
				GUIDelete($hMenuGui)
				$hMenuGui = ""
			EndIf

			Local $aListViewPos = ControlGetPos($hGui, 0, $hListView)
			If @error Then
				Return SetError(31, 0, "")
			EndIf

			GUICtrlDelete($hListView) ; the easiest way to stop leak
			$hListView = 0
			$hListView = GUICtrlCreateListView("ww", $aListViewPos[0], $aListViewPos[1], $aListViewPos[2], $aListViewPos[3])

			GUICtrlSetFont($hListView, 8)
			GUICtrlSetColor($hListView, 0x0000C0)
			GUICtrlSetResizing($hListView, 70)

			GUICtrlSetStyle($hListView, 256) ; LVS_ICON|LVS_AUTOARRANGE
			GUICtrlSetState($hListView, 32)

			$aMediaResource[4] = ".ico"
			$aMediaResource[6] = $iWidth
			$aMediaResource[7] = $iHeight

			ReDim $aListViewItem[UBound($aIconData)]

			Local $bBinary
			Local $tBinary
			Local $tIcon, $iPNGIcon
			Local $sTempFile = @TempDir & "\" & _GenerateGUID() & ".ico"
			If @error Then
				Return SetError(3, 0, "")
			EndIf
			Local $hTempFile
			Local $iBitmapSize

			For $i = 0 To UBound($aIconData) - 1

				$bBinary = _ResourceGetAsRaw($RT_ICON, $aIconData[$i][6], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
				If @error Then
					ContinueLoop
				EndIf

				$iBitmapSize = BinaryLen($bBinary)
				$tBinary = DllStructCreate("byte[" & $iBitmapSize & "]")
				DllStructSetData($tBinary, 1, $bBinary)

				$tIcon = DllStructCreate("align 2;ushort;" & _
						"ushort Type;" & _
						"ushort ImageCount;" & _
						"ubyte Width;" & _
						"ubyte Height;" & _
						"ubyte Colors;" & _
						"ubyte;" & _
						"ushort Planes;" & _
						"ushort BitPerPixel;" & _
						"dword BitmapSize;" & _
						"dword BitmapOffset;" & _
						"byte Body[" & $iBitmapSize & "]")

				DllStructSetData($tIcon, "Type", 1)
				DllStructSetData($tIcon, "ImageCount", 1)
				DllStructSetData($tIcon, "Width", $aIconData[$i][0])
				DllStructSetData($tIcon, "Height", $aIconData[$i][1])
				DllStructSetData($tIcon, "Colors", $aIconData[$i][2])
				DllStructSetData($tIcon, "Planes", $aIconData[$i][3])
				DllStructSetData($tIcon, "BitPerPixel", $aIconData[$i][4])
				DllStructSetData($tIcon, "BitmapSize", $iBitmapSize) ; $aIconData[$i][5])
				DllStructSetData($tIcon, "BitmapOffset", 22)
				DllStructSetData($tIcon, "Body", DllStructGetData($tBinary, 1))

				$tBinary = DllStructCreate("byte[" & DllStructGetSize($tIcon) & "]", DllStructGetPtr($tIcon))

				$hTempFile = FileOpen($sTempFile, 26)
				FileWrite($hTempFile, DllStructGetData($tBinary, 1))
				FileClose($hTempFile)

				If $aIconData[$i][6] Then
					If Not $aIconData[$i][2] Then
						$aIconData[$i][2] = ">256"
					EndIf
					If Not $aIconData[$i][0] Then
						$aIconData[$i][0] = 256
					EndIf
					If Not $aIconData[$i][1] Then
						$aIconData[$i][1] = 256
					EndIf
				EndIf

				$aListViewItem[$i] = GUICtrlCreateListViewItem("Width: " & $aIconData[$i][0] & @LF & _
						"Height: " & $aIconData[$i][1] & @LF & _
						"Colors: " & $aIconData[$i][2] & @LF & _
						"Planes: " & $aIconData[$i][3] & @LF & _
						"BitPerPixel: " & $aIconData[$i][4] & @LF & _
						"ImageSize: " & $aIconData[$i][5] & " bytes" & @LF & _
						"RTIcon name: " & $aIconData[$i][6], _
						$hListView)

				If Not GUICtrlSetImage($aListViewItem[$i], $sTempFile, -1) Then
					$iPNGIcon += 1
				EndIf

			Next

			FileDelete($sTempFile)

			GUICtrlSetState($hIco, 16)
			GUICtrlSetState($hListView, 16)
			GUICtrlSetState($hButton, 64)

			If $iCompilerEnabled Then
				GUICtrlSetState($hDeleteButton, 80)
			EndIf

			If $iBinaryImageDataOK And $iPNGIcon Then
				GUICtrlSetState($hPicCompressed, 16)
				If $iPNGIcon = 1 Then
					GUICtrlSetTip($hPicCompressed, "One icon is compressed. You are not able to view it", "PNG Icon", 1)
				Else
					GUICtrlSetTip($hPicCompressed, $iPNGIcon & " icons are compressed. You are not able to view them", "PNG Icon", 1)
				EndIf
			EndIf

			Return SetError(0, 0, 1)


		Case $RT_ANIICON

			Local $hIcon = _GetIconHandle($RT_ANIICON, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded)
			Switch @error
				Case 3
					; Code missing
				Case True
					Return SetError(2, 0, "")
			EndSwitch

			Local $bBinary = _ResourceGetAsRaw($RT_ANIICON, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
			If @error Then
				Return SetError(3, 0, "")
			EndIf

			Local $sTip

			Local $iAnihOffset = StringInStr(BinaryToString($bBinary), "anih", 1)
			If $iAnihOffset Then
				Local $bBinaryAnih = BinaryMid($bBinary, $iAnihOffset, 44)
				Local $tBinaryAnih = DllStructCreate("byte[44]")
				DllStructSetData($tBinaryAnih, 1, $bBinaryAnih)

				Local $tAnih = DllStructCreate("byte anih[4];" & _
						"dword Size;" & _
						"dword HeaderSize;" & _
						"dword NumFrames;" & _
						"dword NumSteps;" & _
						"dword;" & _
						"dword;" & _
						"dword;" & _
						"dword;" & _
						"dword DisplayRate;" & _
						"dword Flags", _
						DllStructGetPtr($tBinaryAnih))

				$sTip &= " Frames: " & DllStructGetData($tAnih, "NumFrames") & @LF & _
						" Steps: " & DllStructGetData($tAnih, "NumSteps")

				Local $iDisplayRate = DllStructGetData($tAnih, "DisplayRate")
				If $iDisplayRate Then
					If $iDisplayRate = 1 Then
						$sTip &= @LF & " DisplayRate: " & $iDisplayRate & " jiffy"
					Else
						$sTip &= @LF & " DisplayRate: " & $iDisplayRate & " jiffies"
					EndIf
				EndIf

			EndIf

			Local $iINAMOffset = StringInStr(BinaryToString($bBinary), "INAM", 1)
			If $iINAMOffset Then
				Local $bBinaryINAMLen = BinaryMid($bBinary, $iINAMOffset + 4)
				Local $tBinaryINAMLen = DllStructCreate("byte[4]")
				DllStructSetData($tBinaryINAMLen, 1, BinaryMid($bBinary, $iINAMOffset + 4, 4))
				Local $tINAMLen = DllStructCreate("dword", DllStructGetPtr($tBinaryINAMLen))
				Local $iInamLength = DllStructGetData($tINAMLen, 1)
				Local $InamData = BinaryToString(BinaryMid($bBinary, $iINAMOffset + 8, $iInamLength - 1))
				$sTip &= @LF & " Title: " & $InamData
			EndIf

			Local $iIARTOffset = StringInStr(BinaryToString($bBinary), "IART", 1)
			If $iIARTOffset Then
				Local $bBinaryIARTLen = BinaryMid($bBinary, $iIARTOffset + 4)
				Local $tBinaryIARTLen = DllStructCreate("byte[4]")
				DllStructSetData($tBinaryIARTLen, 1, BinaryMid($bBinary, $iIARTOffset + 4, 4))
				Local $tIARTLen = DllStructCreate("dword", DllStructGetPtr($tBinaryIARTLen))
				Local $iIartLength = DllStructGetData($tIARTLen, 1)
				Local $IartData = BinaryToString(BinaryMid($bBinary, $iIARTOffset + 8, $iIartLength - 1))
				$sTip &= @LF & " Author: " & $IartData
			EndIf

			Local $iFramIconOffset = StringInStr(BinaryToString($bBinary), "framicon", 1)
			If Not $iFramIconOffset Then
				Return SetError(0, 1, "")
			EndIf

			Local $bBinaryIcons = BinaryMid($bBinary, $iFramIconOffset + 4)

			Local $tBinaryDimensions = DllStructCreate("byte[2]")
			DllStructSetData($tBinaryDimensions, 1, BinaryMid($bBinaryIcons, 15, 2))
			Local $tDimensions = DllStructCreate("ubyte Width; ubyte Height", DllStructGetPtr($tBinaryDimensions))
			Local $iWidth = DllStructGetData($tDimensions, "Width")
			Local $iHeight = DllStructGetData($tDimensions, "Height")

			$sTip &= @LF & " Width: " & $iWidth & @LF & _
					" Height: " & $iHeight

			GUICtrlSetTip($hIco, $sTip)

			Local $iNewXPos = ($aClientSize[0] + 318 - $iWidth) / 2
			Local $iNewYPos = (.6 * $aClientSize[1] - $iHeight) / 2
			If $iNewXPos < 318 Then $iNewXPos = 318
			If $iNewYPos < 0 Then $iNewYPos = 0

			GUICtrlSetPos($hIco, $iNewXPos, $iNewYPos, $iWidth, $iHeight)

			Local $iHMsg = GUICtrlSendMsg($hIco, 370, 2, $hIcon)
			If $iHMsg Then
				DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $iHMsg)
			EndIf

			GUICtrlSetPos($hIco, $iNewXPos, $iNewYPos, $iWidth, $iHeight)
			GUICtrlSetState($hIco, 16)

			$aMediaResource[4] = ".ico"
			$aMediaResource[6] = $iWidth
			$aMediaResource[7] = $iHeight

			Local $iIconOffset = 5
			Local $i = 1

			Local $sTempFile = @TempDir & "\" & _GenerateGUID() & ".cur"
			If @error Then
				Return SetError(4, 0, "")
			EndIf
			Local $hTempFile

			Local $tBinaryIconLength
			Local $tIconLength
			Local $iIconLength

			If $hMenuGui Then
				Local $a_Call = DllCall("user32.dll", "int", "DestroyMenu", "hwnd", $hMenuLoaded)
				GUIDelete($hMenuGui)
				$hMenuGui = ""
			EndIf

			Local $aListViewPos = ControlGetPos($hGui, 0, $hListView)
			If @error Then
				FileDelete($sTempFile)
				Return SetError(31, 0, "")
			EndIf
			GUICtrlDelete($hListView)
			$hListView = GUICtrlCreateListView("", $aListViewPos[0], $aListViewPos[1], $aListViewPos[2], $aListViewPos[3])
			GUICtrlSetFont($hListView, 8)
			GUICtrlSetColor($hListView, 0x0000C0)
			GUICtrlSetResizing($hListView, 70)

			GUICtrlSetStyle($hListView, 256) ; LVS_ICON|LVS_AUTOARRANGE
			GUICtrlSetState($hListView, 32)

			While $iIconOffset - 4

				$tBinaryIconLength = DllStructCreate("byte[4]")
				DllStructSetData($tBinaryIconLength, 1, BinaryMid($bBinaryIcons, $iIconOffset, 4))
				$tIconLength = DllStructCreate("dword", DllStructGetPtr($tBinaryIconLength))
				$iIconLength = DllStructGetData($tIconLength, 1)

				$hTempFile = FileOpen($sTempFile, 26)
				FileWrite($hTempFile, BinaryMid($bBinaryIcons, $iIconOffset + 4, $iIconLength))
				FileClose($hTempFile)

				ReDim $aListViewItem[$i]

				$aListViewItem[$i - 1] = GUICtrlCreateListViewItem("Frame " & $i, $hListView)
				GUICtrlSetImage($aListViewItem[$i - 1], $sTempFile, -1)

				$i += 1
				$iIconOffset = StringInStr(BinaryToString($bBinaryIcons), "icon", 1, $i) + 4

			WEnd

			GUICtrlSetState($hListView, 16)
			GUICtrlSetState($hButton, 64)

			If $iCompilerEnabled Then
				GUICtrlSetState($hDeleteButton, 80)
			EndIf

			FileDelete($sTempFile)

			Return SetError(0, 0, 1)


		Case $RT_ANICURSOR

			Local $hCursor = _GetCursorHandle($RT_ANICURSOR, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded)
			Switch @error
				Case True
					Local $sData = _HexEncode($bBinary)
					GUICtrlSetColor($hEdit, 0xC0C0C0)
					GUICtrlSetBkColor($hEdit, 0x000000)
					GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
					GUICtrlSetState($hEditHeader, 16)
					GUICtrlSetData($hEdit, $sData)
					GUICtrlSetState($hEdit, 16)
					GUICtrlSetState($hButton, 128)
					If $iCompilerEnabled Then
						GUICtrlSetState($hDeleteButton, 144)
					EndIf
					Return SetError(0, 1, 1)
				Case Else
			EndSwitch

			Local $iWidth = 32
			Local $iHeight = $iWidth
			Local $iNewXPos = ($aClientSize[0] + 318 - $iWidth) / 2
			Local $iNewYPos = (.6 * $aClientSize[1] - $iHeight) / 2
			If $iNewXPos < 318 Then $iNewXPos = 318
			If $iNewYPos < 0 Then $iNewYPos = 0

			GUICtrlSetTip($hIco, "")
			GUICtrlSetPos($hIco, $iNewXPos, $iNewYPos, $iWidth, $iHeight)

			Local $iHMsg = GUICtrlSendMsg($hIco, 370, 2, $hCursor)
			If $iHMsg Then
				DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $iHMsg)
			EndIf

			GUICtrlSetPos($hIco, $iNewXPos, $iNewYPos, $iWidth, $iHeight)

			$aMediaResource[4] = ".ani"
			$aMediaResource[6] = $iWidth
			$aMediaResource[7] = $iHeight

			GUICtrlSetState($hIco, 16)
			GUICtrlSetState($hButton, 64)

			If $iCompilerEnabled Then
				GUICtrlSetState($hDeleteButton, 80)
			EndIf

			Local $bBinary = _ResourceGetAsRaw($RT_ANICURSOR, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
			If @error Then
				Return SetError(3, 0, "")
			EndIf

			Local $sTip

			Local $iAnihOffset = StringInStr(BinaryToString($bBinary), "anih", 1)
			If $iAnihOffset Then
				Local $bBinaryAnih = BinaryMid($bBinary, $iAnihOffset, 44)
				Local $tBinaryAnih = DllStructCreate("byte[44]")
				DllStructSetData($tBinaryAnih, 1, $bBinaryAnih)

				Local $tAnih = DllStructCreate("byte anih[4];" & _
						"dword Size;" & _
						"dword HeaderSize;" & _
						"dword NumFrames;" & _
						"dword NumSteps;" & _
						"dword Width;" & _
						"dword Height;" & _
						"dword BitCount;" & _
						"dword NumPlanes;" & _
						"dword DisplayRate;" & _
						"dword Flags", _
						DllStructGetPtr($tBinaryAnih))

				Local $iWidthRead = DllStructGetData($tAnih, "Width")
				If Not $iWidthRead Then
					$iWidthRead = 32
				EndIf
				Local $iHeightRead = DllStructGetData($tAnih, "Height")
				If Not $iHeightRead Then
					$iHeightRead = 32
				EndIf

				If Not ($iWidth = $iWidthRead) Then

					Local $iNewXPos = ($aClientSize[0] + 318 - $iWidth) / 2
					Local $iNewYPos = (.6 * $aClientSize[1] - $iHeight) / 2
					If $iNewXPos < 318 Then $iNewXPos = 318
					If $iNewYPos < 0 Then $iNewYPos = 0

					GUICtrlSetPos($hIco, $iNewXPos, $iNewYPos, $iWidthRead, $iWidthRead)

				EndIf

				$sTip &= " Frames: " & DllStructGetData($tAnih, "NumFrames") & @LF & _
						" Steps: " & DllStructGetData($tAnih, "NumSteps") & @LF & _
						" Width: " & $iWidthRead & @LF & _
						" Height: " & $iHeightRead

				Local $iBitCount = DllStructGetData($tAnih, "BitCount")
				If $iBitCount Then
					$sTip &= @LF & " BitCount: " & $iBitCount
				EndIf

				Local $iDisplayRate = DllStructGetData($tAnih, "DisplayRate")
				If $iDisplayRate Then
					If $iDisplayRate = 1 Then
						$sTip &= @LF & " DisplayRate: " & $iDisplayRate & " jiffy"
					Else
						$sTip &= @LF & " DisplayRate: " & $iDisplayRate & " jiffies"
					EndIf
				EndIf

			EndIf

			Local $iINAMOffset = StringInStr(BinaryToString($bBinary), "INAM", 1)
			If $iINAMOffset Then
				Local $bBinaryINAMLen = BinaryMid($bBinary, $iINAMOffset + 4)
				Local $tBinaryINAMLen = DllStructCreate("byte[4]")
				DllStructSetData($tBinaryINAMLen, 1, BinaryMid($bBinary, $iINAMOffset + 4, 4))
				Local $tINAMLen = DllStructCreate("dword", DllStructGetPtr($tBinaryINAMLen))
				Local $iInamLength = DllStructGetData($tINAMLen, 1)
				Local $InamData = BinaryToString(BinaryMid($bBinary, $iINAMOffset + 8, $iInamLength - 1))
				$sTip &= @LF & " Title: " & $InamData
			EndIf

			Local $iIARTOffset = StringInStr(BinaryToString($bBinary), "IART", 1)
			If $iIARTOffset Then
				Local $bBinaryIARTLen = BinaryMid($bBinary, $iIARTOffset + 4)
				Local $tBinaryIARTLen = DllStructCreate("byte[4]")
				DllStructSetData($tBinaryIARTLen, 1, BinaryMid($bBinary, $iIARTOffset + 4, 4))
				Local $tIARTLen = DllStructCreate("dword", DllStructGetPtr($tBinaryIARTLen))
				Local $iIartLength = DllStructGetData($tIARTLen, 1)
				Local $IartData = BinaryToString(BinaryMid($bBinary, $iIARTOffset + 8, $iIartLength - 1))
				$sTip &= @LF & " Author: " & $IartData
			EndIf

			GUICtrlSetTip($hIco, $sTip)

			Local $iFramIconOffset = StringInStr(BinaryToString($bBinary), "framicon", 1)
			If Not $iFramIconOffset Then
				Return SetError(0, 1, "")
			EndIf

			Local $bBinaryIcons = BinaryMid($bBinary, $iFramIconOffset + 4)
			Local $iIconOffset = 5
			Local $i = 1

			Local $sTempFile = @TempDir & "\" & _GenerateGUID() & ".cur"
			If @error Then
				Return SetError(4, 0, "")
			EndIf
			Local $hTempFile

			Local $tBinaryIconLength
			Local $tIconLength
			Local $iIconLength

			If $hMenuGui Then
				Local $a_Call = DllCall("user32.dll", "int", "DestroyMenu", "hwnd", $hMenuLoaded)
				GUIDelete($hMenuGui)
				$hMenuGui = ""
			EndIf

			Local $aListViewPos = ControlGetPos($hGui, 0, $hListView)
			If @error Then
				FileDelete($sTempFile)
				Return SetError(31, 0, "")
			EndIf
			GUICtrlDelete($hListView)
			$hListView = GUICtrlCreateListView("", $aListViewPos[0], $aListViewPos[1], $aListViewPos[2], $aListViewPos[3])
			GUICtrlSetFont($hListView, 8)
			GUICtrlSetColor($hListView, 0x0000C0)
			GUICtrlSetResizing($hListView, 70)

			GUICtrlSetStyle($hListView, 256) ; LVS_ICON|LVS_AUTOARRANGE
			GUICtrlSetState($hListView, 32)

			While $iIconOffset - 4

				$tBinaryIconLength = DllStructCreate("byte[4]")
				DllStructSetData($tBinaryIconLength, 1, BinaryMid($bBinaryIcons, $iIconOffset, 4))
				$tIconLength = DllStructCreate("dword", DllStructGetPtr($tBinaryIconLength))
				$iIconLength = DllStructGetData($tIconLength, 1)

				$hTempFile = FileOpen($sTempFile, 26)
				FileWrite($hTempFile, BinaryMid($bBinaryIcons, $iIconOffset + 4, $iIconLength))
				FileClose($hTempFile)

				ReDim $aListViewItem[$i]

				$aListViewItem[$i - 1] = GUICtrlCreateListViewItem("Frame " & $i, $hListView)
				GUICtrlSetImage($aListViewItem[$i - 1], $sTempFile, -1)

				$i += 1
				$iIconOffset = StringInStr(BinaryToString($bBinaryIcons), "icon", 1, $i) + 4

			WEnd

			GUICtrlSetState($hListView, 16)

			FileDelete($sTempFile)

			Return SetError(0, 0, 1)


		Case $RT_VERSION

			Local $bBinary = _ResourceGetAsRaw($RT_VERSION, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
			If @error Then
				Return SetError(2, 0, "")
			EndIf

			Local $sData = _GetVersionInformation($bBinary)

			GUICtrlSetData($hEdit, $sData)
			GUICtrlSetState($hEdit, 16)

			If $iCompilerEnabled Then
				GUICtrlSetState($hDeleteButton, 80)
			EndIf

			Return SetError(0, 0, 1)


		Case $RT_HTML, $RT_MANIFEST

			Local $sData = _ResourceGetAsRaw($ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded)
			If @error Then
				Return SetError(2, 0, "")
			EndIf

			GUICtrlSetData($hEdit, @CRLF & StringAddCR($sData))
			GUICtrlSetState($hEdit, 16)
			GUICtrlSetState($hButton, 64)

			If $iCompilerEnabled Then
				GUICtrlSetState($hDeleteButton, 80)
			EndIf

			Return SetError(0, 0, 1)


		Case Else

			If IsString($ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0]) Or $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0] > $RT_MANIFEST Or $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0] = $RT_RCDATA Then

				Local $bBinaryHeader = _ResourceGetAsRaw($ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1, 128)
				If @error Then
					Return SetError(2, 0, "")
				EndIf

				Local $tBinaryHeader = DllStructCreate("byte[128]")
				DllStructSetData($tBinaryHeader, 1, $bBinaryHeader)

				Local $tChecker = DllStructCreate("char[4]", DllStructGetPtr($tBinaryHeader))

				If DllStructGetData($tChecker, 1) == "RIFF" Then

					Local $tWavHeader = DllStructCreate("char RIFF[4];" & _
							"dword ChunkSize;" & _
							"char Format[4];" & _
							"char Subchunk1ID[4];" & _
							"dword Subchunk1Size;" & _
							"ushort AudioFormat;" & _
							"ushort NumChannels;" & _
							"dword SampleRate;" & _
							"dword ByteRate;" & _
							"ushort BlockAlign;" & _
							"ushort BitsPerSample;" & _
							"byte Subchunk2ID[4];" & _
							"dword Subchunk2Size", _
							DllStructGetPtr($tBinaryHeader))

					If DllStructGetData($tWavHeader, "Format") == "WAVE" And _
							DllStructGetData($tWavHeader, "Subchunk1ID") == "fmt " Then

						Local $sAudioFormat
						Switch DllStructGetData($tWavHeader, "AudioFormat")
							Case 1
								$sAudioFormat = "None"
							Case Else
								$sAudioFormat = "Compressed"
						EndSwitch

						Local $sTip = "Size: " & DllStructGetData($tWavHeader, "ChunkSize") + 8 & " bytes" & @CRLF & _
								"Format: WAVE" & @CRLF & _
								"Compression: " & $sAudioFormat & @CRLF & _
								"Channels: " & DllStructGetData($tWavHeader, "NumChannels") & @CRLF & _
								"SampleRate: " & DllStructGetData($tWavHeader, "SampleRate") & " Hz" & @CRLF & _
								"ByteRate: " & DllStructGetData($tWavHeader, "ByteRate") & @CRLF & _
								"BitsPerSample: " & DllStructGetData($tWavHeader, "BitsPerSample")

						$aMediaResource[0] = $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0]
						$aMediaResource[1] = $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0]
						$aMediaResource[2] = $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]]
						$aMediaResource[3] = $sFileLoaded
						$aMediaResource[4] = ".wav"
						$aMediaResource[5] = 1073790976 ; style
						$aMediaResource[8] = $sTip

						GUICtrlSetData($hInfoSoundEdit, $sTip)
						GUICtrlSetState($hInfoSoundEdit, 16)
						GUICtrlSetState($hButtonPlayMedia, 80)
						GUICtrlSetState($hButtonPauseSound, 144)
						GUICtrlSetState($hButtonStopSound, 144)
						GUICtrlSetState($hButton, 64)

						If $iCompilerEnabled Then
							GUICtrlSetState($hDeleteButton, 80)
						EndIf

					Else

						Local $iAviHeaderOffset = StringInStr(BinaryToString($bBinaryHeader), "avih", 1)
						If $iAviHeaderOffset Then
							Local $bBinaryAviHeader = BinaryMid($bBinaryHeader, $iAviHeaderOffset + 4)
							Local $tBinaryAviHeader = DllStructCreate("byte[" & BinaryLen($bBinaryAviHeader) & "]")
							DllStructSetData($tBinaryAviHeader, 1, $bBinaryAviHeader)
							Local $tAviHeader = DllStructCreate("dword;" & _
									"dword MicroSecPerFrame;" & _
									"dword MaxBytesPerSec;" & _
									"dword;" & _
									"dword Flags;" & _
									"dword TotalFrames;" & _
									"dword InitialFrames;" & _
									"dword Streams;" & _
									"dword SuggestedBufferSize;" & _
									"dword Width;" & _
									"dword Height;" & _
									"dword Scale;" & _
									"dword Rate;" & _
									"dword Start;" & _
									"dword Length", _
									DllStructGetPtr($tBinaryAviHeader))

							Local $iFramesPerSec = 1E6 / DllStructGetData($tAviHeader, "MicroSecPerFrame")
							Local $sTip = "Length: " & Round(DllStructGetData($tAviHeader, "TotalFrames") / $iFramesPerSec, 2) & " sec" & @CRLF & _
									"FramesPerSec: " & Int($iFramesPerSec) & @CRLF & _
									"MaxBytesPerSec: " & DllStructGetData($tAviHeader, "MaxBytesPerSec") & @CRLF & _
									"TotalFrames: " & DllStructGetData($tAviHeader, "TotalFrames") & @CRLF & _
									"Streams: " & DllStructGetData($tAviHeader, "Streams") & @CRLF & _
									"Width: " & DllStructGetData($tAviHeader, "Width") & @CRLF & _
									"Height: " & DllStructGetData($tAviHeader, "Height")

							GUICtrlSetData($hLabelAviInfo, $sTip)

							$aMediaResource[0] = $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0]
							$aMediaResource[1] = $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0]
							$aMediaResource[2] = $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]]
							$aMediaResource[3] = $sFileLoaded
							$aMediaResource[4] = ".avi"
							$aMediaResource[5] = 1342177288 ; style
							$aMediaResource[6] = DllStructGetData($tAviHeader, "Width") ; width
							$aMediaResource[7] = DllStructGetData($tAviHeader, "Height") ; height
							$aMediaResource[8] = $sTip

							_PlayResource($aMediaResource) ; initializing video
							GUICtrlSetState($hLabelAviInfo, 16)
							GUICtrlSetState($hButton, 64)

							If $iCompilerEnabled Then
								GUICtrlSetState($hDeleteButton, 80)
							EndIf

						EndIf

					EndIf

				Else

					Local $tPNG = DllStructCreate("ubyte; char PNG[3]", DllStructGetPtr($tBinaryHeader))

					If (DllStructGetData($tPNG, 1) = 137 And DllStructGetData($tPNG, "PNG") == "PNG") Then

						Local $iIHDROffset = StringInStr(BinaryToString($bBinaryHeader), "IHDR", 1)
						If $iIHDROffset Then
							Local $tBinaryIHDR = DllStructCreate("byte[13]")
							DllStructSetData($tBinaryIHDR, 1, BinaryMid($bBinaryHeader, $iIHDROffset + 4, 13))
							Local $tIHDR = DllStructCreate("byte Width[4];" & _
									"byte Height[4];" & _
									"ubyte BitDepth;" & _
									"ubyte ColorType;" & _
									"ubyte CompressionMethod;" & _
									"ubyte FilterMethod;" & _
									"ubyte InterlaceMethod", _
									DllStructGetPtr($tBinaryIHDR))
							Local $iWidth = Dec(Hex(DllStructGetData($tIHDR, "Width")))
							Local $iHeight = Dec(Hex(DllStructGetData($tIHDR, "Height")))
							Local $iBitPerPixel = DllStructGetData($tIHDR, "BitDepth")
							Local $iColorType = DllStructGetData($tIHDR, "ColorType")
							Local $iCompressionMethod = DllStructGetData($tIHDR, "CompressionMethod")
							Local $iFilterMethod = DllStructGetData($tIHDR, "FilterMethod")
							Local $iInterlaceMethod = DllStructGetData($tIHDR, "InterlaceMethod")

							Local $bData = _ResourceGetAsRaw($ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
							If @error Then
								Return SetError(2, 0, "")
							EndIf

							Local $iWidthGDI
							Local $iHeightGDI

							Local $hBitmap = _CreateHBitmapFromBinaryImage($bData, $iWidthGDI, $iHeightGDI)

							If $iWidthGDI = $iWidth And $iHeightGDI = $iHeight And Not @error Then ; this is ok.
								Local $sTip = " PNG Image    " & @LF & _
										" Size: " & BinaryLen($bData) & " bytes" & @LF & _
										" Width: " & $iWidth & @LF & _
										" Height: " & $iHeight & @LF & _
										" BitDepth: " & $iBitPerPixel & @LF & _
										" ColorType: " & $iColorType

								If Not $iCompressionMethod Then
									$sTip &= @LF & " CompressionMethod: deflate/inflate"
								EndIf

								If Not $iFilterMethod Then
									$sTip &= @LF & " FilterMethod: adaptive filtering"
								EndIf

								Switch $iInterlaceMethod
									Case 0
										$sTip &= @LF & " InterlaceMethod: no interlace"
									Case 1
										$sTip &= @LF & " InterlaceMethod: Adam7"
								EndSwitch

								Local $iNewXPos = ($aClientSize[0] + 318 - $iWidth) / 2
								Local $iNewYPos = ($aClientSize[1] - 32 - $iHeight) / 2

								If $iNewXPos < 318 Then $iNewXPos = 318
								If $iNewYPos < 0 Then $iNewYPos = 0

								GUICtrlSetPos($hPic, $iNewXPos, $iNewYPos, $iWidth, $iHeight)
								GUICtrlSetTip($hPic, $sTip)

								Local $iHMsg = GUICtrlSendMsg($hPic, 370, 0, $hBitmap); draw it

								If $iHMsg Then
									DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $iHMsg)
								EndIf

								DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $hBitmap)

								GUICtrlSetState($hPic, 16)
								GUICtrlSetState($hButton, 64)

								If $iCompilerEnabled Then
									GUICtrlSetState($hDeleteButton, 80)
								EndIf

								If $iBinaryImageDataOK Then
									GUICtrlSetState($hPicCompressed, 16)
									GUICtrlSetTip($hPicCompressed, "Viewing compressed image", "PNG Image", 1)
								EndIf

								$aMediaResource[4] = ".png"
								$aMediaResource[6] = $iWidth
								$aMediaResource[7] = $iHeight

								Return SetError(0, 0, 1)

							Else ; gdi problems. Will process it like any other undefined resource.

								Local $sData = String(BinaryToString($bData))
								If BinaryLen($bData) - StringLen($sData) < 3 Then
									If StringRegExp($sData, "[^[:space:][:print:]]", 0) Then
										$sData = _HexEncode($bData)
										GUICtrlSetColor($hEdit, 0xC0C0C0)
										GUICtrlSetBkColor($hEdit, 0x000000)
										GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
										GUICtrlSetState($hEditHeader, 16)
									Else
										$sData = StringAddCR($sData)
									EndIf
								Else
									$sData = String(BinaryToString($bData, 2))
									If BinaryLen($bData) = 2 * StringLen($sData) Then
										Local $aCheck = StringRegExp($sData, "[^[:space:][:print:]]", 1)
										If UBound($aCheck) > 1 Then
											$sData = _HexEncode($bData)
											GUICtrlSetColor($hEdit, 0xC0C0C0)
											GUICtrlSetBkColor($hEdit, 0x000000)
											GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
											GUICtrlSetState($hEditHeader, 16)
										Else
											$sData = StringAddCR(StringReplace($sData, Chr(0), ""))
										EndIf
									Else
										$sData = _HexEncode($bData)
										GUICtrlSetColor($hEdit, 0xC0C0C0)
										GUICtrlSetBkColor($hEdit, 0x000000)
										GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
										GUICtrlSetState($hEditHeader, 16)
									EndIf
								EndIf

								GUICtrlSetData($hEdit, $sData)
								GUICtrlSetState($hEdit, 16)
								GUICtrlSetState($hButton, 128)
								If $iCompilerEnabled Then
									GUICtrlSetState($hDeleteButton, 80)
								EndIf

								Return SetError(1, 0, 1)

							EndIf

						EndIf

					Else

						Local $tJPEG = DllStructCreate("ushort SOI;" & _
								"ushort JFIF;" & _
								"ushort Length;" & _
								"char Identifier[4]", _
								DllStructGetPtr($tBinaryHeader))

						If DllStructGetData($tJPEG, "SOI") = 55551 And DllStructGetData($tJPEG, "JFIF") = 57599 And DllStructGetData($tJPEG, "Identifier") == "JFIF" Then

							Local $bData = _ResourceGetAsRaw($ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
							If @error Then
								Return SetError(2, 0, "")
							EndIf

							Local $iWidthGDI
							Local $iHeightGDI

							Local $hBitmap = _CreateHBitmapFromBinaryImage($bData, $iWidthGDI, $iHeightGDI)

							If @error Then ; gdi problems. Will process it like any other undefined resource.

								Local $sData = String(BinaryToString($bData))
								If BinaryLen($bData) - StringLen($sData) < 3 Then
									If StringRegExp($sData, "[^[:space:][:print:]]", 0) Then
										$sData = _HexEncode($bData)
										GUICtrlSetColor($hEdit, 0xC0C0C0)
										GUICtrlSetBkColor($hEdit, 0x000000)
										GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
										GUICtrlSetState($hEditHeader, 16)
									Else
										$sData = StringAddCR($sData)
									EndIf
								Else
									$sData = String(BinaryToString($bData, 2))
									If BinaryLen($bData) = 2 * StringLen($sData) Then
										Local $aCheck = StringRegExp($sData, "[^[:space:][:print:]]", 1)
										If UBound($aCheck) > 1 Then
											$sData = _HexEncode($bData)
											GUICtrlSetColor($hEdit, 0xC0C0C0)
											GUICtrlSetBkColor($hEdit, 0x000000)
											GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
											GUICtrlSetState($hEditHeader, 16)
										Else
											$sData = StringAddCR(StringReplace($sData, Chr(0), ""))
										EndIf
									Else
										$sData = _HexEncode($bData)
										GUICtrlSetColor($hEdit, 0xC0C0C0)
										GUICtrlSetBkColor($hEdit, 0x000000)
										GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
										GUICtrlSetState($hEditHeader, 16)
									EndIf
								EndIf

								GUICtrlSetData($hEdit, $sData)
								GUICtrlSetState($hEdit, 16)
								GUICtrlSetState($hButton, 128)
								If $iCompilerEnabled Then
									GUICtrlSetState($hDeleteButton, 80)
								EndIf

								Return SetError(1, 0, 1)

							EndIf

							Local $sTip = " JPEG Image    " & @LF & _
									" Size: " & BinaryLen($bData) & " bytes" & @LF & _
									" Width: " & $iWidthGDI & @LF & _
									" Height: " & $iHeightGDI

							Local $iNewXPos = ($aClientSize[0] + 318 - $iWidthGDI) / 2
							Local $iNewYPos = ($aClientSize[1] - 32 - $iHeightGDI) / 2

							If $iNewXPos < 318 Then $iNewXPos = 318
							If $iNewYPos < 0 Then $iNewYPos = 0

							GUICtrlSetPos($hPic, $iNewXPos, $iNewYPos, $iWidthGDI, $iHeightGDI)
							GUICtrlSetTip($hPic, $sTip)

							Local $iHMsg = GUICtrlSendMsg($hPic, 370, 0, $hBitmap); draw it

							If $iHMsg Then
								DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $iHMsg)
							EndIf

							DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $hBitmap)

							GUICtrlSetState($hPic, 16)
							GUICtrlSetState($hButton, 64)

							If $iCompilerEnabled Then
								GUICtrlSetState($hDeleteButton, 80)
							EndIf

							If $iBinaryImageDataOK Then
								GUICtrlSetState($hPicCompressed, 16)
								GUICtrlSetTip($hPicCompressed, "Viewing compressed image", "JPEG Image", 1)
							EndIf

							$aMediaResource[4] = ".jpg"
							$aMediaResource[6] = $iWidthGDI
							$aMediaResource[7] = $iHeightGDI

							Return SetError(0, 0, 1)

						Else

							Local $tGIF = DllStructCreate("char Signature[3];" & _
									"char Version[3]", _
									DllStructGetPtr($tBinaryHeader))

							If DllStructGetData($tGIF, "Signature") == "GIF" And (DllStructGetData($tGIF, "Version") == "87a" Or DllStructGetData($tGIF, "Version") == "89a") Then

								Local $bData = _ResourceGetAsRaw($ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
								If @error Then
									Return SetError(2, 0, "")
								EndIf

								Local $iWidthGDI
								Local $iHeightGDI
								Local $iTransparency

								Local $aHBitmaps = _CreateArrayHBitmapsFromGIFBinaryImage($bData, $iWidthGDI, $iHeightGDI, $iTransparency)

								If @error Then ; gdi problems. Will process it like any other undefined resource.

									Local $sData = String(BinaryToString($bData))
									If BinaryLen($bData) - StringLen($sData) < 3 Then
										If StringRegExp($sData, "[^[:space:][:print:]]", 0) Then
											$sData = _HexEncode($bData)
											GUICtrlSetColor($hEdit, 0xC0C0C0)
											GUICtrlSetBkColor($hEdit, 0x000000)
											GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
											GUICtrlSetState($hEditHeader, 16)
										Else
											$sData = StringAddCR($sData)
										EndIf
									Else
										$sData = String(BinaryToString($bData, 2))
										If BinaryLen($bData) = 2 * StringLen($sData) Then
											Local $aCheck = StringRegExp($sData, "[^[:space:][:print:]]", 1)
											If UBound($aCheck) > 1 Then
												$sData = _HexEncode($bData)
												GUICtrlSetColor($hEdit, 0xC0C0C0)
												GUICtrlSetBkColor($hEdit, 0x000000)
												GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
												GUICtrlSetState($hEditHeader, 16)
											Else
												$sData = StringAddCR(StringReplace($sData, Chr(0), ""))
											EndIf
										Else
											$sData = _HexEncode($bData)
											GUICtrlSetColor($hEdit, 0xC0C0C0)
											GUICtrlSetBkColor($hEdit, 0x000000)
											GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
											GUICtrlSetState($hEditHeader, 16)
										EndIf
									EndIf

									GUICtrlSetData($hEdit, $sData)
									GUICtrlSetState($hEdit, 16)
									GUICtrlSetState($hButton, 128)
									If $iCompilerEnabled Then
										GUICtrlSetState($hDeleteButton, 80)
									EndIf

									Return SetError(1, 0, 1)

								EndIf

								If $iTransparency Then
									$iTransparentGIF = 1
								Else
									$iTransparentGIF = 0
								EndIf

								Local $sTip = " GIF Image    " & @LF & _
										" Size: " & BinaryLen($bData) & " bytes" & @LF & _
										" Width: " & $iWidthGDI & @LF & _
										" Height: " & $iHeightGDI

								If $iCompilerEnabled Then
									GUICtrlSetState($hDeleteButton, 80)
								EndIf

								If $iBinaryImageDataOK Then
									GUICtrlSetState($hPicCompressed, 16)
									GUICtrlSetTip($hPicCompressed, "Viewing compressed image", "GIF Image", 1)
								EndIf

								$aMediaResource[4] = ".gif"
								$aMediaResource[6] = $iWidthGDI
								$aMediaResource[7] = $iHeightGDI

								If UBound($aHBitmaps) = 1 Then ; just one frame

									Local $iNewXPos = ($aClientSize[0] + 318 - $iWidthGDI) / 2
									Local $iNewYPos = ($aClientSize[1] - 32 - $iHeightGDI) / 2

									If $iNewXPos < 318 Then $iNewXPos = 318
									If $iNewYPos < 0 Then $iNewYPos = 0

									GUICtrlSetPos($hPic, $iNewXPos, $iNewYPos, $iWidthGDI, $iHeightGDI)

									Local $hBitmap = $aHBitmaps[0][0]
									Local $iHMsg = GUICtrlSendMsg($hPic, 370, 0, $hBitmap)
									If $iHMsg Then
										DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $iHMsg)
									EndIf
									DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $hBitmap)

									$iMultipleFramesGIF = 0

									GUICtrlSetTip($hPic, $sTip)
									GUICtrlSetState($hPic, 16)
									GUICtrlSetState($hButton, 64)

									Return SetError(0, 0, 1)

								Else

									Local $iNewXPos = ($aClientSize[0] + 318 - $iWidthGDI) / 2
									Local $iNewYPos = ($aClientSize[1] * .5 - 32 - $iHeightGDI) / 2

									If $iNewXPos < 318 Then $iNewXPos = 318
									If $iNewYPos < 0 Then $iNewYPos = 0

									GUICtrlSetPos($hPic, $iNewXPos, $iNewYPos, $iWidthGDI, $iHeightGDI)

									If IsArray($aHGIFBitmaps) Then ; dealing with old handles
										For $i = 0 To UBound($aHGIFBitmaps) - 1
											DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $aHGIFBitmaps[$i][0])
										Next
									EndIf

									$iFrame = 0 ; initial frame
									$aHGIFBitmaps = $aHBitmaps ; new array
									$iMultipleFramesGIF = 1

									Local $iHMsg = GUICtrlSendMsg($hPic, 370, 0, $aHGIFBitmaps[0][0]) ; draw initial frame
									If $iHMsg Then
										DllCall("gdi32.dll", "int", "DeleteObject", "hwnd", $iHMsg)
									EndIf

									$sTip &= @LF & " Frames: " & UBound($aHGIFBitmaps)

									GUICtrlSetTip($hPic, $sTip)
									GUICtrlSetState($hPic, 16)
									GUICtrlSetState($hButton, 64)

									If $hMenuGui Then
										Local $a_Call = DllCall("user32.dll", "int", "DestroyMenu", "hwnd", $hMenuLoaded)
										GUIDelete($hMenuGui)
										$hMenuGui = ""
									EndIf

									Local $aListViewPos = ControlGetPos($hGui, 0, $hListView)
									If @error Then
										Return SetError(31, 0, "")
									EndIf
									GUICtrlDelete($hListView)
									$hListView = GUICtrlCreateListView("", $aListViewPos[0], $aListViewPos[1], $aListViewPos[2], $aListViewPos[3])
									GUICtrlSetFont($hListView, 8)
									GUICtrlSetColor($hListView, 0x0000C0)
									GUICtrlSetResizing($hListView, 70)

									GUICtrlSetStyle($hListView, 259) ; LVS_LIST|LVS_AUTOARRANGE
									GUICtrlSetState($hListView, 32)

									Local $a_iCall = DllCall("comctl32.dll", "hwnd", "ImageList_Create", _
											"int", $iWidthGDI, _
											"int", $iHeightGDI, _
											"dword", 32, _ ; ILC_COLOR32
											"int", UBound($aHGIFBitmaps), _
											"int", 0)

									If @error Or Not $a_iCall[0] Then
										Return SetError(1, 0, "")
									EndIf

									$hImageList = $a_iCall[0]

									Local $tItem, $sText, $tText, $iImage

									For $i = 0 To UBound($aHGIFBitmaps) - 1

										$a_iCall = DllCall("comctl32.dll", "int", "ImageList_Add", _
												"hwnd", $hImageList, _
												"hwnd", $aHGIFBitmaps[$i][0], _
												"hwnd", 0)

										If @error Or $a_iCall[0] = -1 Then
											ContinueLoop
										EndIf

										$iImage = $a_iCall[0]

										$tItem = DllStructCreate("dword Mask;" & _
												"int Item;" & _
												"int SubItem;" & _
												"dword State;" & _
												"dword StateMask;" & _
												"ptr Text;" & _
												"int TextMax;" & _
												"int Image;" & _
												"int Param;" & _
												"int Indent;" & _
												"int GroupId;" & _
												"dword Columns;" & _
												"ptr pColumns")

										$sText = "Frame " & $i + 1 & ", delay time: " & $aHGIFBitmaps[$i][2] & " ms"
										$tText = DllStructCreate("wchar Text[" & StringLen($sText) + 1 & "]")
										DllStructSetData($tText, "Text", $sText)

										DllStructSetData($tItem, "Mask", 3) ; LVIF_TEXT|LVIF_IMAGE
										DllStructSetData($tItem, "Item", $i)
										DllStructSetData($tItem, "Text", DllStructGetPtr($tText))
										DllStructSetData($tItem, "Image", $iImage)

										GUICtrlSendMsg($hListView, 4173, 0, DllStructGetPtr($tItem)) ; LVM_INSERTITEMW

									Next

									GUICtrlSendMsg($hListView, 4099, 1, $hImageList) ; LVM_SETIMAGELIST
									GUICtrlSetState($hListView, 16)
									$iImageListDestroy = 0

									Return SetError(0, 0, 1)

								EndIf

							Else

								Local $bData = _ResourceGetAsRaw($ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
								If @error Then
									Return SetError(2, 0, "")
								EndIf
								Local $sData = String(BinaryToString($bData))
								If BinaryLen($bData) - StringLen($sData) < 3 Then ; string is possibly null-terminated or even double null-terminated
									If StringRegExp($sData, "[^[:space:][:print:]]", 0) Then
										$sData = _HexEncode($bData)
										GUICtrlSetColor($hEdit, 0xC0C0C0)
										GUICtrlSetBkColor($hEdit, 0x000000)
										GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
										GUICtrlSetState($hEditHeader, 16)
									Else
										$sData = StringAddCR($sData)
									EndIf
								Else
									$sData = String(BinaryToString($bData, 2))
									If BinaryLen($bData) = 2 * StringLen($sData) Then
										Local $aCheck = StringRegExp($sData, "[^[:space:][:print:]]", 1)
										If UBound($aCheck) > 1 Then
											$sData = _HexEncode($bData)
											GUICtrlSetColor($hEdit, 0xC0C0C0)
											GUICtrlSetBkColor($hEdit, 0x000000)
											GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
											GUICtrlSetState($hEditHeader, 16)
										Else
											$sData = StringAddCR(StringReplace($sData, Chr(0), ""))
										EndIf
									Else
										$sData = _HexEncode($bData)
										GUICtrlSetColor($hEdit, 0xC0C0C0)
										GUICtrlSetBkColor($hEdit, 0x000000)
										GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
										GUICtrlSetState($hEditHeader, 16)
									EndIf
								EndIf

								GUICtrlSetData($hEdit, $sData)
								GUICtrlSetState($hEdit, 16)
								GUICtrlSetState($hButton, 128)
								If $iCompilerEnabled Then
									GUICtrlSetState($hDeleteButton, 80)
								EndIf
							EndIf
						EndIf
					EndIf
				EndIf

			Else

				Local $bData = _ResourceGetAsRaw($ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
				If @error Then
					Return SetError(2, 0, "")
				EndIf

				Local $sData = String(BinaryToString($bData))
				If BinaryLen($bData) = StringLen($sData) Then
					If StringRegExp($sData, "[^[:space:][:print:]]", 0) Then
						$sData = _HexEncode($bData)
						GUICtrlSetColor($hEdit, 0xC0C0C0)
						GUICtrlSetBkColor($hEdit, 0x000000)
						GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
						GUICtrlSetState($hEditHeader, 16)
					Else
						$sData = StringAddCR($sData)
					EndIf
				Else
					$sData = _HexEncode($bData)
					GUICtrlSetColor($hEdit, 0xC0C0C0)
					GUICtrlSetBkColor($hEdit, 0x000000)
					GUICtrlSetFont($hEdit, 9, 700, 0, "Courier New")
					GUICtrlSetState($hEditHeader, 16)
				EndIf

				GUICtrlSetData($hEdit, $sData)
				GUICtrlSetState($hEdit, 16)
				GUICtrlSetState($hButton, 128)
				If $iCompilerEnabled Then
					GUICtrlSetState($hDeleteButton, 80)
				EndIf

			EndIf

			If $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0] = $RT_RCDATA Then
				$aMediaResource[4] = ""
				GUICtrlSetState($hButton, 64)
				If $iCompilerEnabled Then
					GUICtrlSetState($hDeleteButton, 80)
				EndIf
			EndIf

			Return SetError(0, 0, 1)

	EndSwitch

EndFunc   ;==>_ViewSelected



Func _ResTypes($iType, $iColumn = 1)

	If $iType = $TypeCurrent Then
		Return SetError(0, 0, $TypeNameCurrent[$iColumn = 1])
	EndIf

	Local $aArrayTypes[24][3] = [["RT_CURSOR", "Cursor", $RT_CURSOR], _
			["RT_BITMAP", "Bitmap", $RT_BITMAP], _
			["RT_ICON", "Icon", $RT_ICON], _
			["RT_MENU", "Menu", $RT_MENU], _
			["RT_DIALOG", "Dialog box", $RT_DIALOG], _
			["RT_STRING", "String-table", $RT_STRING], _
			["RT_FONTDIR", "Font Directory", $RT_FONTDIR], _
			["RT_FONT", "Font", $RT_FONT], _
			["RT_ACCELERATOR", "Accelerator table", $RT_ACCELERATOR], _
			["RT_RCDATA", "Resource Data", $RT_RCDATA], _
			["RT_MESSAGETABLE", "Message-table", $RT_MESSAGETABLE], _
			["RT_GROUP_CURSOR", "Hardware-independent Cursor", $RT_GROUP_CURSOR], _
			["13", "13", 13], _
			["RT_GROUP_ICON", "Hardware-independent Icon", $RT_GROUP_ICON], _
			["15", "15", 15], _
			["RT_VERSION", "Version Info", $RT_VERSION], _
			["RT_DLGINCLUDE", "Include", $RT_DLGINCLUDE], _
			["18", "18", 18], _
			["RT_PLUGPLAY", "Plug and Play", $RT_PLUGPLAY], _
			["RT_VXD", "VXD", $RT_VXD], _
			["RT_ANICURSOR", "Animated cursor", $RT_ANICURSOR], _
			["RT_ANIICON", "Animated icon", $RT_ANIICON], _
			["RT_HTML", "HTML", $RT_HTML], _
			["RT_MANIFEST", "XML Manifest", $RT_MANIFEST]]

	If $iType > 0 And $iType <= 24 Then
		$TypeCurrent = $iType
		$TypeNameCurrent[0] = $aArrayTypes[$iType - 1][0]
		$TypeNameCurrent[1] = $aArrayTypes[$iType - 1][1]
		Return SetError(0, 0, $aArrayTypes[$iType - 1][$iColumn])
	Else
		Return SetError(0, 0, $iType)
	EndIf

EndFunc   ;==>_ResTypes


Func _LanguageCode($iCode, $iColumn = 1, $iMode = 1)

	If $iMode Then
		If $iCode == $LangCodeCurrent Then
			Return SetError(0, 0, $langNameCurrent[$iColumn = 1])
		EndIf

		If Not $iCode Then
			Return SetError(0, 0, "Neutral")
		EndIf
	EndIf

	Local $CountryTable[122][3] = [["af", "Afrikaans", 1078], _
			["sq", "Albanian", 1052], _
			["ar-dz", "Arabic (Algeria)", 5121], _
			["ar-bh", "Arabic (Bahrain)", 15361], _
			["ar-eg", "Arabic (Egypt)", 3073], _
			["ar-iq", "Arabic (Iraq)", 2049], _
			["ar-jo", "Arabic (Jordan)", 11265], _
			["ar-kw", "Arabic (Kuwait)", 13313], _
			["ar-lb", "Arabic (Lebanon)", 12289], _
			["ar-ly", "Arabic (Libya)", 4097], _
			["ar-ma", "Arabic (Morocco)", 6145], _
			["ar-om", "Arabic (Oman)", 8193], _
			["ar-qa", "Arabic (Qatar)", 16385], _
			["ar-sa", "Arabic (Saudi Arabia)", 1025], _
			["ar-sy", "Arabic (Syria)", 10241], _
			["ar-tn", "Arabic (Tunisia)", 7169], _
			["ar-ae", "Arabic (U.A.E.)", 14337], _
			["ar-ye", "Arabic (Yemen)", 9217], _
			["eu", "Basque", 1069], _
			["be", "Belarusian", 1059], _
			["bg", "Bulgarian", 1026], _
			["ca", "Catalan", 1027], _
			["zh-hk", "Chinese (Hong Kong SAR)", 3076], _
			["zh-cn", "Chinese (PRC)", 2052], _
			["zh-sg", "Chinese (Singapore)", 4100], _
			["zh-tw", "Chinese (Taiwan)", 1028], _
			["hr", "Croatian", 1050], _
			["cs", "Czech", 1029], _
			["da", "Danish", 1030], _
			["nl", "Dutch", 1043], _
			["nl-be", "Dutch (Belgium)", 2067], _
			["en-au", "English (Australia)", 3081], _
			["en-bz", "English (Belize)", 10249], _
			["en-ca", "English (Canada)", 4105], _
			["en", "English (Caribbean)", 9225], _
			["en-ie", "English (Ireland)", 6153], _
			["en-jm", "English (Jamaica)", 8201], _
			["en-nz", "English (New Zealand)", 5129], _
			["en-za", "English (South Africa)", 7177], _
			["en-tt", "English (Trinidad)", 11273], _
			["en-gb", "English (United Kingdom)", 2057], _
			["en-us", "English (United States)", 1033], _
			["et", "Estonian", 1061], _
			["fo", "Faeroese", 1080], _
			["fa", "Farsi", 1065], _
			["fi", "Finnish", 1035], _
			["fr", "French", 1036], _
			["fr-be", "French (Belgium)", 2060], _
			["fr-ca", "French (Canada)", 3084], _
			["fr-lu", "French (Luxembourg)", 5132], _
			["fr-ch", "French (Switzerland)", 4108], _
			["gd", "Gaelic (Scotland)", 1084], _
			["de", "German", 1031], _
			["de-at", "German (Austria)", 3079], _
			["de-li", "German (Liechtenstein)", 5127], _
			["de-lu", "German (Luxembourg)", 4103], _
			["de-ch", "German (Switzerland)", 2055], _
			["el", "Greek", 1032], _
			["he", "Hebrew", 1037], _
			["hi", "Hindi", 1081], _
			["hu", "Hungarian", 1038], _
			["is", "Icelandic", 1039], _
			["id", "Indonesian", 1057], _
			["ga", "Irish", 1039], _
			["it", "Italian", 1040], _
			["it-ch", "Italian (Switzerland)", 2064], _
			["ja", "Japanese", 1041], _
			["ko", "Korean", 1042], _
			["lv", "Latvian", 1062], _
			["lt", "Lithuanian", 1063], _
			["mk", "Macedonian", 1071], _
			["ma", "Malaysian", 1086], _
			["mt", "Maltese", 1082], _
			["no", "Norwegian (Nynorsk)", 2068], _
			["no", "Norwegian (Bokmal)", 1044], _
			["pl", "Polish", 1045], _
			["pt-br", "Portuguese (Brazil)", 1046], _
			["pt", "Portuguese", 2070], _
			["rm", "Rhaeto-Romanic", 1047], _
			["ro", "Romanian", 1048], _
			["ro-mo", "Romanian (Moldova)", 2072], _
			["ru", "Russian", 1049], _
			["ru-mo", "Russian (Moldova)", 2073], _
			["sz", "Sami (Lappish)", 9275], _
			["sr", "Serbian (Cyrillic)", 3098], _
			["sr", "Serbian (Latin)", 2074], _
			["sk", "Slovak", 1051], _
			["sl", "Slovenian", 1060], _
			["sb", "Sorbian", 1070], _
			["es-ar", "Spanish (Argentina)", 11274], _
			["es-bo", "Spanish (Bolivia)", 16394], _
			["es-cl", "Spanish (Chile)", 13322], _
			["es-co", "Spanish (Colombia)", 9226], _
			["es-cr", "Spanish (Costa Rica)", 5130], _
			["es-do", "Spanish (Dominican Republic)", 7178], _
			["es-ec", "Spanish (Ecuador)", 12298], _
			["es-sv", "Spanish (El Salvador)", 17418], _
			["es-gt", "Spanish (Guatemala)", 4106], _
			["es-hn", "Spanish (Honduras)", 18442], _
			["es-mx", "Spanish (Mexico)", 2058], _
			["es-ni", "Spanish (Nicaragua)", 19466], _
			["es-pa", "Spanish (Panama)", 6154], _
			["es-py", "Spanish (Paraguay)", 15370], _
			["es-pe", "Spanish (Peru)", 10250], _
			["es-pr", "Spanish (Puerto Rico)", 20490], _
			["es", "Spanish", 1034], _
			["es-uy", "Spanish (Uruguay)", 14346], _
			["es-ve", "Spanish (Venezuela)", 8202], _
			["sx", "Sutu", 1072], _
			["sv", "Swedish", 1053], _
			["sv-fi", "Swedish (Finland)", 2077], _
			["th", "Thai", 1054], _
			["tr", "Turkish", 1055], _
			["ts", "Tsonga", 1073], _
			["tn", "Tswana", 1074], _
			["uk", "Ukrainian", 1058], _
			["ur", "Urdu", 1056], _
			["vi", "Vietnamese", 1066], _
			["xh", "Xhosa", 1076], _
			["ji", "Yiddish", 1085], _
			["zu", "Zulu", 1077]]

	If $iMode Then
		For $i = 0 To UBound($CountryTable) - 1
			If $CountryTable[$i][2] = $iCode Then
				$LangCodeCurrent = $iCode
				$langNameCurrent[0] = $CountryTable[$i][0]
				$langNameCurrent[1] = $CountryTable[$i][1]
				Return SetError(0, 0, $CountryTable[$i][$iColumn])
			EndIf
		Next
		Return SetError(0, 0, "Unknown")
	Else
		Return SetError(0, 0, $CountryTable[$iCode - 1][2] & " - " & $CountryTable[$iCode - 1][$iColumn])
	EndIf

EndFunc   ;==>_LanguageCode


Func _ResourceEnumerate(ByRef $sModule)

	If $iPopulateArray Then
		GUICtrlSetData($hProgress, 15)
	EndIf

	DllCall("kernel32.dll", "dword", "SetErrorMode", "dword", 1) ; SEM_FAILCRITICALERRORS

	Local $iLoaded
	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "GetModuleHandleW", "wstr", $sModule)

	If @error Then
		Return SetError(2, 0, "")
	EndIf

	If Not $a_hCall[0] Then
		$a_hCall = DllCall("kernel32.dll", "hwnd", "LoadLibraryExW", "wstr", $sModule, "hwnd", 0, "int", 34) ; LOAD_LIBRARY_AS_IMAGE_RESOURCE|LOAD_LIBRARY_AS_DATAFILE
		If @error Or Not $a_hCall[0] Then
			Return SetError(3, 0, "")
		EndIf
		$iLoaded = 1
	EndIf

	Local $hModule = $a_hCall[0]

	$ARRAY_MODULE_STRUCTURE[0][0][0] = ""
	$global_names_count = 1
	$name_count = 0
	$global_langs_count = 1
	$lang_count = 0
	$global_types_count = 1

	Local $h_CB = DllCallbackRegister("_CallbackEnumResTypeProc", "int", "hwnd;ptr;ptr")

	If Not $h_CB Then
		Return SetError(4, 0, "")
	EndIf

	Local $h_CB1 = DllCallbackRegister("_CallbackEnumResNameProc", "int", "hwnd;ptr;ptr;ptr")

	If Not $h_CB1 Then
		Return SetError(4, 0, "")
	EndIf

	Local $a_iCall = DllCall("kernel32.dll", "int", "EnumResourceTypesW", _
			"hwnd", $hModule, _
			"ptr", DllCallbackGetPtr($h_CB), _
			"ptr", DllCallbackGetPtr($h_CB1)) ; 0

	If @error Then
		DllCallbackFree($h_CB)
		If $iLoaded Then
			$a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(6, 0, "")
			EndIf
		EndIf
		Return SetError(5, 0, "")
	EndIf

	DllCallbackFree($h_CB1)

	DllCallbackFree($h_CB)

	If $iPopulateArray Then
		GUICtrlSetData($hProgress, 70)
	EndIf

	If $iLoaded Then
		$a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
		If @error Or Not $a_iCall[0] Then
			Return SetError(6, 0, "")
		EndIf
	EndIf

	Return SetError(0, 0, 1)

EndFunc   ;==>_ResourceEnumerate


Func _CallbackEnumResTypeProc($hModule, $pType, $lParam)

	$global_types_count += 1
	$name_count = 0

	If $iPopulateArray Then
		Local $a_iCall = DllCall("kernel32.dll", "int", "lstrlenW", "ptr", $pType)
		If $a_iCall[0] Then
			Local $tType = DllStructCreate("wchar[" & $a_iCall[0] + 1 & "]", $pType)
			$ARRAY_MODULE_STRUCTURE[$global_types_count - 1][0][0] = DllStructGetData($tType, 1)
		Else
			$ARRAY_MODULE_STRUCTURE[$global_types_count - 1][0][0] = BitOR($pType, 0)
		EndIf
	EndIf

	Local $h_CB = DllCallbackRegister("_CallbackEnumResLangProc", "int", "hwnd;ptr;ptr;ushort;int")

	Local $a_iCall = DllCall("kernel32.dll", "int", "EnumResourceNamesW", _
			"hwnd", $hModule, _
			"ptr", $pType, _
			"ptr", $lParam, _
			"ptr", DllCallbackGetPtr($h_CB))

	DllCallbackFree($h_CB)

	Return 1

EndFunc   ;==>_CallbackEnumResTypeProc


Func _CallbackEnumResNameProc($hModule, $pType, $pName, $lParam)

	$lang_count = 0
	$name_count += 1

	If $iPopulateArray Then
		Local $a_iCall = DllCall("kernel32.dll", "int", "lstrlenW", "ptr", $pName)
		If $a_iCall[0] Then
			Local $tName = DllStructCreate("wchar[" & $a_iCall[0] + 1 & "]", $pName)
			$ARRAY_MODULE_STRUCTURE[$global_types_count - 1][$name_count][0] = DllStructGetData($tName, 1)
		Else
			$ARRAY_MODULE_STRUCTURE[$global_types_count - 1][$name_count][0] = BitOR($pName, 0)
		EndIf
	Else
		If $name_count > $global_names_count - 1 Then
			$global_names_count += 1
		EndIf
	EndIf

	Local $a_iCall = DllCall("kernel32.dll", "int", "EnumResourceLanguagesW", _
			"hwnd", $hModule, _
			"ptr", $pType, _
			"ptr", $pName, _
			"ptr", $lParam, _
			"int", $name_count)

	Return 1

EndFunc   ;==>_CallbackEnumResNameProc


Func _CallbackEnumResLangProc($hModule, $pType, $pName, $iLang, $lParam)

	$lang_count += 1
	If $lang_count > $global_langs_count - 1 Then
		$global_langs_count += 1
	EndIf

	If $iPopulateArray Then
		$ARRAY_MODULE_STRUCTURE[$global_types_count - 1][$lParam][$lang_count] = $iLang
	EndIf

	Return 1

EndFunc   ;==>_CallbackEnumResLangProc


Func _ResourceGetAsRaw($iResType, $iResName, $iResLang, $sModule, $iMode = 0, $iSize = 0)

	Local $iLoaded
	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "GetModuleHandleW", "wstr", $sModule)

	If @error Then
		Return SetError(1, 0, "")
	EndIf

	If Not $a_hCall[0] Then
		$a_hCall = DllCall("kernel32.dll", "hwnd", "LoadLibraryExW", "wstr", $sModule, "hwnd", 0, "int", 34)
		If @error Or Not $a_hCall[0] Then
			Return SetError(2, 0, "")
		EndIf
		$iLoaded = 1
	EndIf

	Local $hModule = $a_hCall[0]

	Switch IsNumber($iResType) + 2 * IsNumber($iResName)
		Case 0
			$a_hCall = DllCall("kernel32.dll", "hwnd", "FindResourceExW", _
					"hwnd", $hModule, _
					"wstr", $iResType, _
					"wstr", $iResName, _
					"int", $iResLang)
		Case 1
			$a_hCall = DllCall("kernel32.dll", "hwnd", "FindResourceExW", _
					"hwnd", $hModule, _
					"int", $iResType, _
					"wstr", $iResName, _
					"int", $iResLang)
		Case 2
			$a_hCall = DllCall("kernel32.dll", "hwnd", "FindResourceExW", _
					"hwnd", $hModule, _
					"wstr", $iResType, _
					"int", $iResName, _
					"int", $iResLang)
		Case 3
			$a_hCall = DllCall("kernel32.dll", "hwnd", "FindResourceExW", _
					"hwnd", $hModule, _
					"int", $iResType, _
					"int", $iResName, _
					"int", $iResLang)
	EndSwitch

	If @error Or Not $a_hCall[0] Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(7, 0, "")
			EndIf
		EndIf
		Return SetError(3, 0, "")
	EndIf

	Local $hResource = $a_hCall[0]

	Local $a_iCall = DllCall("kernel32.dll", "int", "SizeofResource", "hwnd", $hModule, "hwnd", $hResource)

	If @error Or Not $a_iCall[0] Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(7, 0, "")
			EndIf
		EndIf
		Return SetError(4, 0, "")
	EndIf

	Local $iSizeOfResource = $a_iCall[0]

	$a_hCall = DllCall("kernel32.dll", "hwnd", "LoadResource", "hwnd", $hModule, "hwnd", $hResource)

	If @error Or Not $a_hCall[0] Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(7, 0, "")
			EndIf
		EndIf
		Return SetError(5, 0, "")
	EndIf

	Local $a_pCall = DllCall("kernel32.dll", "ptr", "LockResource", "hwnd", $a_hCall[0])

	If @error Or Not $a_pCall[0] Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(7, 0, "")
			EndIf
		EndIf
		Return SetError(6, 0, "")
	EndIf

	Local $tOut
	Switch $iMode
		Case 0
			$tOut = DllStructCreate("char[" & $iSizeOfResource + 1 & "]", $a_pCall[0])
		Case 1
			$tOut = DllStructCreate("byte[" & $iSizeOfResource & "]", $a_pCall[0])
	EndSwitch

	Local $sReturnData = DllStructGetData($tOut, 1)

	If $iLoaded Then
		Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
		If @error Or Not $a_iCall[0] Then
			Return SetError(7, 0, "")
		EndIf
	EndIf

	Switch $iSize
		Case 0
			Return SetError(0, 0, $sReturnData)
		Case Else
			Switch $iMode
				Case 0
					Return SetError(0, 0, StringLeft($sReturnData, $iSize))
				Case 1
					Return SetError(0, 0, BinaryMid($sReturnData, 1, $iSize))
			EndSwitch
	EndSwitch

EndFunc   ;==>_ResourceGetAsRaw


Func _ResourceGetAsHex($iResType, $iResName, $iResLang, $sModule)

	Local $bRaw = _ResourceGetAsRaw($iResType, $iResName, $iResLang, $sModule, 1)

	If @error Then
		Return SetError(@error, 0, "")
	EndIf

	Local $sReturn = _HexEncode($bRaw)

	If @error Then
		Return SetError(@error + 7, 0, "")
	EndIf

	Return SetError(0, 0, $sReturn)

EndFunc   ;==>_ResourceGetAsHex


Func _HexEncode($bInput)

	Local $tInput = DllStructCreate("byte[" & BinaryLen($bInput) & "]")

	DllStructSetData($tInput, 1, $bInput)

	Local $a_iCall = DllCall("crypt32.dll", "int", "CryptBinaryToString", _
			"ptr", DllStructGetPtr($tInput), _
			"dword", DllStructGetSize($tInput), _
			"dword", 11, _
			"ptr", 0, _
			"dword*", 0)

	If @error Or Not $a_iCall[0] Then
		Return SetError(1, 0, "")
	EndIf

	Local $iSize = $a_iCall[5]
	Local $tOut = DllStructCreate("char[" & $iSize & "]")

	$a_iCall = DllCall("crypt32.dll", "int", "CryptBinaryToString", _
			"ptr", DllStructGetPtr($tInput), _
			"dword", DllStructGetSize($tInput), _
			"dword", 11, _
			"ptr", DllStructGetPtr($tOut), _
			"dword*", $iSize)

	If @error Or Not $a_iCall[0] Then
		Return SetError(2, 0, "")
	EndIf

	Return SetError(0, 0, DllStructGetData($tOut, 1))

EndFunc   ;==>_HexEncode


Func _GetIconHandle($iResType, $iResName, $iResLang, $sModule)

	Local $iLoaded
	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "GetModuleHandleW", "wstr", $sModule)

	If @error Then
		Return SetError(1, 0, "")
	EndIf

	If Not $a_hCall[0] Then
		$a_hCall = DllCall("kernel32.dll", "hwnd", "LoadLibraryExW", "wstr", $sModule, "hwnd", 0, "int", 34)
		If @error Or Not $a_hCall[0] Then
			Return SetError(2, 0, "")
		EndIf
		$iLoaded = 1
	EndIf

	Local $hModule = $a_hCall[0]

	Local $sType = "int"

	If IsString($iResName) Then
		$sType = "wstr"
	EndIf

	$a_hCall = DllCall("user32.dll", "hwnd", "LoadImageW", _
			"hwnd", $hModule, _
			$sType, $iResName, _
			"dword", 1, _
			"int", 0, _
			"int", 0, _
			"dword", 0)

	If @error Or Not $a_hCall[0] Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(11, 0, "")
			EndIf
		EndIf
		Return SetError(3, 0, "")
	EndIf

	If $iLoaded Then
		Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
		If @error Or Not $a_iCall[0] Then
			Return SetError(11, 0, "")
		EndIf
	EndIf

	Return SetError(0, 0, $a_hCall[0])

EndFunc   ;==>_GetIconHandle


Func _GetCursorHandle($iResType, $iResName, $iResLang, $sModule)

	Local $iLoaded
	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "GetModuleHandleW", "wstr", $sModule)

	If @error Then
		Return SetError(1, 0, "")
	EndIf

	If Not $a_hCall[0] Then
		$a_hCall = DllCall("kernel32.dll", "hwnd", "LoadLibraryExW", "wstr", $sModule, "hwnd", 0, "int", 34)
		If @error Or Not $a_hCall[0] Then
			Return SetError(2, 0, "")
		EndIf
		$iLoaded = 1
	EndIf

	Local $hModule = $a_hCall[0]

	Local $sType = "int"

	If IsString($iResName) Then
		$sType = "wstr"
	EndIf

	$a_hCall = DllCall("user32.dll", "hwnd", "LoadImageW", _
			"hwnd", $hModule, _
			$sType, $iResName, _
			"dword", 2, _
			"int", 0, _
			"int", 0, _
			"dword", 0)

	If @error Or Not $a_hCall[0] Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(11, 0, "")
			EndIf
		EndIf
		Return SetError(3, 0, "")
	EndIf

	If $iLoaded Then
		Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
		If @error Or Not $a_iCall[0] Then
			Return SetError(11, 0, "")
		EndIf
	EndIf

	Return SetError(0, 0, $a_hCall[0])

EndFunc   ;==>_GetCursorHandle


Func _GetMenuHandle($iResType, $iResName, $iResLang, $sModule)

	Local $iLoaded
	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "GetModuleHandleW", "wstr", $sModule)

	If @error Then
		Return SetError(1, 0, "")
	EndIf

	If Not $a_hCall[0] Then
		$a_hCall = DllCall("kernel32.dll", "hwnd", "LoadLibraryExW", "wstr", $sModule, "hwnd", 0, "int", 34)
		If @error Or Not $a_hCall[0] Then
			Return SetError(2, 0, "")
		EndIf
		$iLoaded = 1
	EndIf

	Local $hModule = $a_hCall[0]

	If $hMenuLoaded Then
		Local $a_Call = DllCall("user32.dll", "int", "DestroyMenu", "hwnd", $hMenuLoaded)
		If @error Or Not $a_Call[0] Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(11, 0, "")
			EndIf
			Return SetError(1, 0, "")
		EndIf
		$hMenuLoaded = ""
	EndIf

	Local $sType = "int"

	If IsString($iResName) Then
		$sType = "wstr"
	EndIf

	$a_hCall = DllCall("user32.dll", "hwnd", "LoadMenuW", _
			"hwnd", $hModule, _
			$sType, $iResName)

	If @error Or Not $a_hCall[0] Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(11, 0, "")
			EndIf
		EndIf
		Return SetError(3, 0, "")
	EndIf

	Local $hMemu = $a_hCall[0]

	If $iLoaded Then
		Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
		If @error Or Not $a_iCall[0] Then
			Return SetError(11, 0, "")
		EndIf
	EndIf

	Return SetError(0, 0, $hMemu)

EndFunc   ;==>_GetMenuHandle


Func _GetDialogWindowHandle($iResType, $iResName, $iResLang, $sModule)

	If $hDialogWindow Then
		Local $a_Call = DllCall("user32.dll", "int", "DestroyWindow", "hwnd", $hDialogWindow)
		If @error Or Not $a_Call[0] Then
			Return SetError(1, 0, "")
		EndIf
		$hDialogWindow = ""
	EndIf

	Local $iLoaded
	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "GetModuleHandleW", "wstr", $sModule)

	If @error Then
		Return SetError(2, 0, "")
	EndIf

	If Not $a_hCall[0] Then
		$a_hCall = DllCall("kernel32.dll", "hwnd", "LoadLibraryExW", "wstr", $sModule, "hwnd", 0, "int", 34)
		If @error Or Not $a_hCall[0] Then
			Return SetError(3, 0, "")
		EndIf
		$iLoaded = 1
	EndIf

	Local $hModule = $a_hCall[0]

	Local $bData = _ResourceGetAsRaw($iResType, $iResName, $iResLang, $sModule, 1)
	If @error Then
		Return SetError(4, 0, "")
	EndIf

	Local $tData = DllStructCreate("byte[" & BinaryLen($bData) & "]")
	DllStructSetData($tData, 1, $bData)

	Local $tDLGTEMPLATEModified = DllStructCreate("dword Style;" & _
			"dword ExtendedStyle;" & _
			"ushort NumberOfItems;" & _
			"byte RestOfTheDLGTEMPLATE[" & DllStructGetSize($tData) - 10 & "]", _
			DllStructGetPtr($tData))

	Local $iChild
	If BitAND(DllStructGetData($tDLGTEMPLATEModified, "Style"), 1073741824) Then ; if WS_CHILD
		$iChild = 1
	EndIf

	If BitAND(DllStructGetData($tDLGTEMPLATEModified, "Style"), 268435456) And Not $iChild Then ; if WS_VISIBLE - remove it
		DllStructSetData($tDLGTEMPLATEModified, "Style", DllStructGetData($tDLGTEMPLATEModified, "Style") - 268435456)
	EndIf

	If DllStructGetData($tDLGTEMPLATEModified, "NumberOfItems") > 255 Then ;  this indicates exe compressor is used. It's not quite ok
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(6, 0, $bData)
			EndIf
		EndIf
		Return SetError(5, 0, $bData)
	EndIf

	$a_hCall = DllCall("user32.dll", "hwnd", "CreateDialogIndirectParam", _
			"hwnd", $hModule, _
			"ptr", DllStructGetPtr($tDLGTEMPLATEModified), _
			"hwnd", $hGui, _
			"ptr", 0, _
			"lparam", 0)

	If @error Or Not $a_hCall[0] Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(8, 0, $bData)
			EndIf
		EndIf
		Return SetError(7, 0, $bData)
	EndIf

	$hDialogWindow = $a_hCall[0]

	If $iLoaded Then
		Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
		If @error Or Not $a_iCall[0] Then
			Return SetError(9, 0, $hDialogWindow)
		EndIf
	EndIf

	$iDialogIsChild = 0 ; predefining in case of error

	If $iChild Then
		Local $a_iCall = DllCall("user32.dll", "hwnd", "GetDesktopWindow")

		If @error Or Not $a_iCall[0] Then
			$iDialogIsChild = 1
			Return SetError(0, 0, $hDialogWindow)
		EndIf

		Local $hDesktop = $a_iCall[0]

		$a_iCall = DllCall("user32.dll", "int", "SetParent", _
				"hwnd", $hDialogWindow, _
				"hwnd", $hDesktop)

		If @error Or Not $a_iCall[0] Then
			$iDialogIsChild = 1
		EndIf
	EndIf

	Return SetError(0, 0, $hDialogWindow)

EndFunc   ;==>_GetDialogWindowHandle


Func _GetBitmapHandle($iResType, $iResName, $iResLang, $sModule, ByRef $iWidth, ByRef $iHeight, ByRef $sTip)

	Local $iLoaded
	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "GetModuleHandleW", "wstr", $sModule)

	If @error Then
		Return SetError(1, 0, "")
	EndIf

	If Not $a_hCall[0] Then
		$a_hCall = DllCall("kernel32.dll", "hwnd", "LoadLibraryExW", "wstr", $sModule, "hwnd", 0, "int", 34)
		If @error Or Not $a_hCall[0] Then
			Return SetError(2, 0, "")
		EndIf
		$iLoaded = 1
	EndIf

	Local $hModule = $a_hCall[0]

	Local $bBinary = _ResourceGetAsRaw($iResType, $iResName, $iResLang, $sModule, 1, 40) ; 40 bytes is enough

	If @error Then
		Return SetError(@error + 3, 0, "")
	EndIf

	Local $tBinary = DllStructCreate("byte[40]")
	DllStructSetData($tBinary, 1, $bBinary)
	Local $tBitmap = DllStructCreate("dword HeaderSize", DllStructGetPtr($tBinary))

	Local $iHeaderSize = DllStructGetData($tBitmap, "HeaderSize")

	Switch $iHeaderSize
		Case 40
			$tBitmap = DllStructCreate("dword HeaderSize;" & _
					"dword Width;" & _
					"dword Height;" & _
					"ushort Planes;" & _
					"ushort BitPerPixel;" & _
					"dword CompressionMethod;" & _
					"dword Size;" & _
					"dword Hresolution;" & _
					"dword Vresolution;" & _
					"dword Size;" & _
					"dword ImportantColors;", _
					DllStructGetPtr($tBinary))
		Case 12
			$tBitmap = DllStructCreate("dword HeaderSize;" & _
					"ushort Width;" & _
					"ushort Height;" & _
					"ushort Planes;" & _
					"ushort BitPerPixel;", _
					DllStructGetPtr($tBinary))
		Case Else
			If $iLoaded Then
				Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
				If @error Or Not $a_iCall[0] Then
					Return SetError(11, 0, "")
				EndIf
			EndIf
			Return SetError(3, 0, $bBinary)
	EndSwitch

	$iWidth = DllStructGetData($tBitmap, "Width")
	$iHeight = DllStructGetData($tBitmap, "Height")

	Local $iCompressionMethod = DllStructGetData($tBitmap, "CompressionMethod")

	Local $sCompressionMethod
	Switch $iCompressionMethod
		Case 0
			$sCompressionMethod = "None"
		Case 1
			$sCompressionMethod = "RLE 8-bit/pixel"
		Case 2
			$sCompressionMethod = "RLE 4-bit/pixel"
		Case 3
			$sCompressionMethod = "Bit field"
		Case 4
			$sCompressionMethod = "JPEG"
		Case 5
			$sCompressionMethod = "PNG"
	EndSwitch

	$sTip = " Width: " & $iWidth & @LF & _
			" Height: " & $iHeight & @LF & _
			" Planes: " & DllStructGetData($tBitmap, "Planes") & @LF & _
			" BitPerPixel: " & DllStructGetData($tBitmap, "BitPerPixel") & @LF & _
			" Compression Method: " & $sCompressionMethod

	Local $iRawBitmapSize = DllStructGetData($tBitmap, "Size")

	If $iRawBitmapSize Then
		$sTip &= @LF & " Raw bitmap data size: " & $iRawBitmapSize & " bytes"
	EndIf

	Local $sType = "int"

	If IsString($iResName) Then
		$sType = "wstr"
	EndIf

	$a_hCall = DllCall("user32.dll", "hwnd", "LoadImageW", _
			"hwnd", $hModule, _
			$sType, $iResName, _
			"dword", 0, _
			"int", 0, _
			"int", 0, _
			"dword", 0)

	If @error Or Not $a_hCall[0] Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(11, 0, "")
			EndIf
		EndIf
		Return SetError(4, 0, "")
	EndIf

	If $iLoaded Then
		Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
		If @error Or Not $a_iCall[0] Then
			Return SetError(11, 0, "")
		EndIf
	EndIf

	Return SetError(0, 0, $a_hCall[0])

EndFunc   ;==>_GetBitmapHandle


Func _CrackIcon($iIconName, $iResLang, $sModule)

	Local $bBinary = _ResourceGetAsRaw($RT_GROUP_ICON, $iIconName, $iResLang, $sModule, 1)

	If @error Then
		Return SetError(@error + 3, 0, "")
	EndIf

	Local $tBinary = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
	DllStructSetData($tBinary, 1, $bBinary)

	Local $tResource = DllStructCreate("ushort;" & _
			"ushort Type;" & _
			"ushort ImageCount;" & _
			"byte Body[" & DllStructGetSize($tBinary) - 6 & "]", _
			DllStructGetPtr($tBinary))

	Local $iIconCount = DllStructGetData($tResource, "ImageCount")

	If Not $iIconCount Or $iIconCount > 50 Then ; this likely indicates usage of exe compressor
		Return SetError(0, 1, "")
	EndIf

	Local $iWidth, $iHeight
	Local $aIconsData[$iIconCount][7]
	Local $tGroupIconData

	For $i = 0 To $iIconCount - 1
		$tGroupIconData = DllStructCreate("ubyte Width;" & _
				"ubyte Height;" & _
				"ubyte Colors;" & _
				"ubyte;" & _
				"ushort Planes;" & _
				"ushort BitPerPixel;" & _
				"dword BitmapSize;" & _
				"ushort OrdinalName;", _
				DllStructGetPtr($tResource, "Body") + $i * 14)

		$iWidth = DllStructGetData($tGroupIconData, "Width")
		If Not $iWidth Then
			$iWidth = 256
		EndIf

		$iHeight = DllStructGetData($tGroupIconData, "Height")
		If Not $iHeight Then
			$iHeight = 256
		EndIf

		$aIconsData[$i][0] = $iWidth
		$aIconsData[$i][1] = $iHeight
		$aIconsData[$i][2] = DllStructGetData($tGroupIconData, "Colors")
		$aIconsData[$i][3] = DllStructGetData($tGroupIconData, "Planes")
		$aIconsData[$i][4] = DllStructGetData($tGroupIconData, "BitPerPixel")
		$aIconsData[$i][5] = DllStructGetData($tGroupIconData, "BitmapSize")
		$aIconsData[$i][6] = DllStructGetData($tGroupIconData, "OrdinalName")
	Next

	Return SetError(0, 0, $aIconsData)

EndFunc   ;==>_CrackIcon


Func _GenerateGUID()

	Local $GUIDSTRUCT = DllStructCreate("int;short;short;byte[8]")

	Local $a_iCall = DllCall("rpcrt4.dll", "int", "UuidCreate", "ptr", DllStructGetPtr($GUIDSTRUCT))

	If @error Or $a_iCall[0] Then
		Return SetError(1, 0, "")
	EndIf

	$a_iCall = DllCall("ole32.dll", "int", "StringFromGUID2", _
			"ptr", DllStructGetPtr($GUIDSTRUCT), _
			"wstr", "", _
			"int", 40)

	If @error Or Not $a_iCall[0] Then
		Return SetError(2, 0, "")
	EndIf

	Return SetError(0, 0, $a_iCall[2])

EndFunc   ;==>_GenerateGUID


Func _LittleEndianBinaryToInt($bBinary)

	Local $hex
	$bBinary = Binary($bBinary)
	Local $iBinaryLen = BinaryLen($bBinary)

	For $i = 1 To $iBinaryLen
		$hex &= Hex(BinaryMid($bBinary, $iBinaryLen + 1 - $i, 1))
	Next

	Return SetError(0, 0, Dec($hex))

EndFunc   ;==>_LittleEndianBinaryToInt


Func _PlayResource($aResourceToPlay)

	If $hMCI Then
		Local $a_Call = DllCall("user32.dll", "int", "DestroyWindow", "hwnd", $hMCI)
		If @error Or Not $a_Call[0] Then
			Return SetError(1, 1, "")
		EndIf
		FileDelete($sMediaTempFile)
		$sMediaTempFile = ""
		$hMCI = ""
	EndIf

	Local $bBinary = _ResourceGetAsRaw($aResourceToPlay[0], $aResourceToPlay[1], $aResourceToPlay[2], $aResourceToPlay[3], 1)

	If @error Then
		Return SetError(1, 0, "")
	EndIf

	$sMediaTempFile = @TempDir & "\" & _GenerateGUID() & $aResourceToPlay[4]
	If @error Then
		Return SetError(2, 0, "")
	EndIf

	Local $hTempFile = FileOpen($sMediaTempFile, 26)
	FileWrite($hTempFile, $bBinary)
	FileClose($hTempFile)

	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "GetModuleHandleW", "wstr", "msvfw32.dll")

	If @error Then
		Return SetError(3, 0, "")
	EndIf

	If Not $a_hCall[0] Then
		Local $hDll = DllOpen("msvfw32.dll")
		If @error Or $hDll = -1 Then
			FileDelete($sMediaTempFile)
			Return SetError(4, 0, "")
		EndIf
	EndIf

	$a_hCall = DllCall("msvfw32.dll", "hwnd:cdecl", "MCIWndCreateW", "hwnd", $hGui, "hwnd", 0, "int", $aResourceToPlay[5], "wstr", $sMediaTempFile)

	If @error Or Not $a_hCall[0] Then
		FileDelete($sMediaTempFile)
		Return SetError(5, 0, "")
	EndIf

	$hMCI = $a_hCall[0]

	Local $a_Call = DllCall("user32.dll", "dword", "SendMessage", "hwnd", $hMCI, "dword", 1128, "dword", 0, "dword", 0) ; get length
	$iLength = $a_Call[0]

	Switch $aResourceToPlay[4]
		Case ".wav"
			DllCall("user32.dll", "dword", "SendMessage", "hwnd", $hMCI, "dword", 2054, "dword", 0, "dword", 0) ; play
			GUICtrlSetData($hInfoSoundEdit, $aMediaResource[8] & @CRLF & "Length: " & StringFormat('%d min %.2f sec', Floor($iLength / 60000), Mod($iLength / 1000, 60)))
			GUICtrlSetState($hButtonPlayMedia, 128)
			GUICtrlSetState($hButtonPauseSound, 64)
			GUICtrlSetState($hButtonStopSound, 64)
		Case ".avi"
			Local $aClientSize = WinGetClientSize($hGui)
			Local $iPosX = ($aClientSize[0] + 318 - $aMediaResource[6]) / 2
			Local $iPosY = (.4 * $aClientSize[1] - $aMediaResource[7]) / 2
			If $iPosX < 318 Then $iPosX = 318
			If $iPosY < 0 Then $iPosY = 0
			WinMove($hMCI, 0, $iPosX, $iPosY, $aResourceToPlay[6], $aResourceToPlay[7] + 25)
			GUICtrlSetPos($hLabelAviInfo, $iPosX, $iPosY + $aMediaResource[7] + 35, 150, 150)
	EndSwitch

	$iPlayed = 0

	Return SetError(0, 0, 1)

EndFunc   ;==>_PlayResource


Func _SetMinMax($hWnd, $iMsg, $wParam, $lParam)

	If $hWnd = $hGui Then
		Local $tMINMAXINFO = DllStructCreate("int[2];" & _
				"int MaxSize[2];" & _
				"int MaxPosition[2];" & _
				"int MinTrackSize[2];" & _
				"int MaxTrackSize[2]", _
				$lParam)

		DllStructSetData($tMINMAXINFO, "MinTrackSize", 325, 1)
		DllStructSetData($tMINMAXINFO, "MinTrackSize", 350, 2)
	EndIf

EndFunc   ;==>_SetMinMax


Func _AdjustMediaViewPos($hWnd, $iMsg, $wParam, $lParam)

	Local $aClientSize[2] = [BitAND($lParam, 65535), BitShift($lParam, 16)]

	Switch $aMediaResource[4]

		Case ".avi"

			If $hMCI Then
				Local $iPosX = ($aClientSize[0] + 318 - $aMediaResource[6]) / 2
				Local $iPosY = (.4 * $aClientSize[1] - $aMediaResource[7]) / 2
				If $iPosX < 318 Then $iPosX = 318
				If $iPosY < 0 Then $iPosY = 0
				WinMove($hMCI, 0, $iPosX, $iPosY, $aMediaResource[6], $aMediaResource[7] + 25)
				GUICtrlSetPos($hLabelAviInfo, $iPosX, $iPosY + $aMediaResource[7] + 35, 150, 150)
			EndIf

		Case ".bmp", ".png", ".jpg", ".gif"

			If $aMediaResource[4] = ".gif" And $iMultipleFramesGIF Then
				Local $iPosX = ($aClientSize[0] + 318 - $aMediaResource[6]) / 2
				Local $iPosY = ($aClientSize[1] * .5 - 32 - $aMediaResource[7]) / 2
				If $iPosX < 318 Then $iPosX = 318
				If $iPosY < 0 Then $iPosY = 0
				GUICtrlSetPos($hPic, $iPosX, $iPosY, $aMediaResource[6], $aMediaResource[7])
			Else
				Local $iPosX = ($aClientSize[0] + 318 - $aMediaResource[6]) / 2
				Local $iPosY = ($aClientSize[1] - 32 - $aMediaResource[7]) / 2
				If $iPosX < 318 Then $iPosX = 318
				If $iPosY < 0 Then $iPosY = 0
				GUICtrlSetPos($hPic, $iPosX, $iPosY, $aMediaResource[6], $aMediaResource[7])
			EndIf

		Case ".ico", ".ani"

			Local $iPosX = ($aClientSize[0] + 318 - $aMediaResource[6]) / 2
			Local $iPosY = (.6 * $aClientSize[1] - $aMediaResource[7]) / 2
			If $iPosX < 318 Then $iPosX = 318
			If $iPosY < 0 Then $iPosY = 0
			GUICtrlSetPos($hIco, $iPosX, $iPosY, $aMediaResource[6], $aMediaResource[7])

		Case ".cur"

			Local $iPosX = ($aClientSize[0] + 318 - $aMediaResource[6]) / 2
			Local $iPosY = (.8 * $aClientSize[1] - $aMediaResource[7]) / 2
			If $iPosX < 318 Then $iPosX = 318
			If $iPosY < 0 Then $iPosY = 0
			GUICtrlSetPos($hIco, $iPosX, $iPosY, $aMediaResource[6], $aMediaResource[7])

	EndSwitch

	If $sFileLoaded And $hWnd = $hGui And Not $iCompilerEnabled Then

		Local $sTitle = FileGetLongName($sFileLoaded) & " - Resources [" & $iInstanceCurrent & " of " & $iInstancesOverall & "]"

		Local $a_iCall = DllCall("shlwapi.dll", "int", "PathCompactPathW", _
				"hwnd", 0, _
				"wstr", $sTitle, _
				"dword", $aClientSize[0] - 100)

		If @error Then
			WinSetTitle($hGui, 0, $sTitle)
		Else
			WinSetTitle($hGui, 0, $a_iCall[2])
		EndIf

	EndIf

	Local $iPosX = $aClientSize[0] - 170
	If $iPosX < 320 Then $iPosX = 320
	Local $iPosY = $aClientSize[1] - 38
	GUICtrlSetPos($hNameLabel, $iPosX, $iPosY)

EndFunc   ;==>_AdjustMediaViewPos


Func _ResizePic($hWnd, $iMsg, $wParam, $lParam)

	Local $aCurInfo = GUIGetCursorInfo($hGui) ; WindowFromPoint($lparam - hi lo)
	If @error Then
		Return
	EndIf

	If $aCurInfo[4] = $hPic And Not $iMultipleFramesGIF Then

		Local $aClientSize = WinGetClientSize($hGui)

		If BitShift($wParam, 16) > 0 Then
			$aMediaResource[6] *= 1.1
			$aMediaResource[7] *= 1.1
		Else
			$aMediaResource[6] /= 1.1
			$aMediaResource[7] /= 1.1
		EndIf

		Local $iPosX = ($aClientSize[0] + 318 - $aMediaResource[6]) / 2
		Local $iPosY = ($aClientSize[1] - 32 - $aMediaResource[7]) / 2
		If $iPosX < 318 Then $iPosX = 318
		If $iPosY < 0 Then $iPosY = 0

		GUICtrlSetPos($hPic, $iPosX, $iPosY, $aMediaResource[6], $aMediaResource[7])

	ElseIf $aCurInfo[4] = $hIco Then

		Local $aClientSize = WinGetClientSize($hGui)

		If BitShift($wParam, 16) > 0 Then
			$aMediaResource[6] *= 1.1
			$aMediaResource[7] *= 1.1
		Else
			$aMediaResource[6] /= 1.1
			$aMediaResource[7] /= 1.1
		EndIf

		Local $iPosX, $iPosY

		Switch $aMediaResource[4]
			Case ".ico", ".ani"
				$iPosX = ($aClientSize[0] + 318 - $aMediaResource[6]) / 2
				$iPosY = (.6 * $aClientSize[1] - $aMediaResource[7]) / 2

			Case ".cur"
				$iPosX = ($aClientSize[0] + 318 - $aMediaResource[6]) / 2
				$iPosY = (.8 * $aClientSize[1] - $aMediaResource[7]) / 2

		EndSwitch

		If $iPosX < 318 Then $iPosX = 318
		If $iPosY < 0 Then $iPosY = 0

		GUICtrlSetPos($hIco, $iPosX, $iPosY, $aMediaResource[6], $aMediaResource[7])

	EndIf

EndFunc   ;==>_ResizePic


Func _AcceleratorTableFlag($iFlag)

	If $iFlag < 2 Or $iFlag > 32 Then
		Return SetError(0, 0, "")
	EndIf

	Local $aArrayFlag[4][2] = [[2, "(NOINVERT)"],[4, "SHIFT"],[8, "CTRL"],[16, "ALT"]]

	Local $sOut
	Local $a

	While 1
		$a = Floor(Log($iFlag) / Log(2))
		If $a = 0 Then
			ExitLoop
		ElseIf $a < 2 Then
			$sOut = $aArrayFlag[$a - 1][1] & " " & $sOut
			ExitLoop
		Else
			$sOut = $aArrayFlag[$a - 1][1] & " + " & $sOut
		EndIf
		$iFlag -= $aArrayFlag[$a - 1][0]
	WEnd

	Return SetError(0, 0, $sOut)

EndFunc   ;==>_AcceleratorTableFlag


Func _VirtualKey($iValue, $iMode)

	If $iMode Then
		Return SetError(0, 0, '"^' & Chr($iValue + 64) & '"')
	EndIf

	If $iValue < 1 Or $iValue > 254 Then
		Return SetError(0, 1, "")
	EndIf

	Local $aArrayVirtualKey[254][2] = [[1, "Left mouse"], _
			[2, "Right mouse"], _
			[3, "CTRL + BREAK"], _
			[4, "Middle mouse"], _
			[5, "X1 mouse"], _
			[6, "X2 mouse"], _
			[7, ""], _
			[8, "BACKSPACE"], _
			[9, "TAB"], _
			[10, ""],[11, ""], _
			[12, "CLEAR"], _
			[13, "ENTER"], _
			[14, ""],[15, ""], _
			[16, "SHIFT"], _
			[17, "CTRL"], _
			[18, "ALT"], _
			[19, "PAUSE"], _
			[20, "CAPS LOCK"], _
			[21, "IME Hangul mode"], _
			[22, "IME Junja mode"], _
			[23, "IME final mode"], _
			[24, "IME Hanja mode"], _
			[25, "IME Kanji mode"], _
			[26, ""], _
			[27, "ESC"], _
			[28, "IME convert"], _
			[29, "IME nonconvert"], _
			[30, "IME accept"], _
			[31, "IME mode change request"], _
			[32, "SPACEBAR"], _
			[33, "PAGE UP"], _
			[34, "PAGE DOWN"], _
			[35, "END"], _
			[36, "HOME"], _
			[37, "LEFT ARROW"], _
			[38, "UP ARROW"], _
			[39, "RIGHT ARROW"], _
			[40, "DOWN ARROW"], _
			[41, "SELECT"], _
			[42, "PRINT"], _
			[43, "EXECUTE"], _
			[44, "PRINT SCREEN"], _
			[45, "INS"], _
			[46, "DEL"], _
			[47, "HELP"], _
			[48, "0"], _
			[49, "1"], _
			[50, "2"], _
			[51, "3"], _
			[52, "4"], _
			[53, "5"], _
			[54, "6"], _
			[55, "7"], _
			[56, "8"], _
			[57, "9"], _
			[58, ""],[59, ""],[60, ""],[61, ""],[62, ""],[63, ""],[64, ""], _
			[65, "A"], _
			[66, "B"], _
			[67, "C"], _
			[68, "D"], _
			[69, "E"], _
			[70, "F"], _
			[71, "G"], _
			[72, "H"], _
			[73, "I"], _
			[74, "J"], _
			[75, "K"], _
			[76, "L"], _
			[77, "M"], _
			[78, "N"], _
			[79, "O"], _
			[80, "P"], _
			[81, "Q"], _
			[82, "R"], _
			[83, "S"], _
			[84, "T"], _
			[85, "U"], _
			[86, "V"], _
			[87, "W"], _
			[88, "X"], _
			[89, "Y"], _
			[90, "Z"], _
			[91, "Left Windows key"], _
			[92, "Right Windows key"], _
			[93, "Applications key"], _
			[94, ""], _
			[95, "Computer Sleep key"], _
			[96, "Numpad 0"], _
			[97, "Numpad 1"], _
			[98, "Numpad 2"], _
			[99, "Numpad 3"], _
			[100, "Numpad 4"], _
			[101, "Numpad 5"], _
			[102, "Numpad 6"], _
			[103, "Numpad 7"], _
			[104, "Numpad 8"], _
			[105, "Numpad 9"], _
			[106, "Multiply"], _
			[107, "Add"], _
			[108, "Separator"], _
			[109, "Subtract"], _
			[110, "Decimal Point"], _
			[111, "Divide"], _
			[112, "F1"], _
			[113, "F2"], _
			[114, "F3"], _
			[115, "F4"], _
			[116, "F5"], _
			[117, "F6"], _
			[118, "F7"], _
			[119, "F8"], _
			[120, "F9"], _
			[121, "F10"], _
			[122, "F11"], _
			[123, "F12"], _
			[124, "F13"], _
			[125, "F14"], _
			[126, "F15"], _
			[127, "F16"], _
			[128, "F17"], _
			[129, "F18"], _
			[130, "F19"], _
			[131, "F20"], _
			[132, "F21"], _
			[133, "F22"], _
			[134, "F23"], _
			[135, "F24"], _
			[136, ""],[137, ""],[138, ""],[139, ""],[140, ""],[141, ""],[142, ""],[143, ""], _
			[144, "NUM LOCK"], _
			[145, "SCROLL LOCK"], _
			[146, ""],[147, ""],[148, ""],[149, ""],[150, ""],[151, ""],[152, ""],[153, ""],[154, ""],[155, ""],[156, ""],[157, ""],[158, ""],[159, ""], _
			[160, "Left SHIFT"], _
			[161, "Right SHIFT"], _
			[162, "Left CONTROL"], _
			[163, "Right CONTROL"], _
			[164, "Left MENU"], _
			[165, "Right MENU"], _
			[166, "Browser Back key"], _
			[167, "Browser Forward key"], _
			[168, "Browser Refresh key"], _
			[169, "Browser Stop key"], _
			[170, "Browser Search key"], _
			[171, "Browser Favorites key"], _
			[172, "Browser Start and Home key"], _
			[173, "Volume Mute key"], _
			[174, "Volume Down key"], _
			[175, "Volume Up key"], _
			[176, "Next Track key"], _
			[177, "Previous Track key"], _
			[178, "Stop Media key"], _
			[179, "Play/Pause Media key"], _
			[180, "Start Mail key"], _
			[181, "Select Media key"], _
			[182, "Start Application 1 key"], _
			[183, "Start Application 2 key"], _
			[184, ""],[185, ""], _
			[186, ";:(US standard keyboard)"], _
			[187, "="], _
			[188, ","], _
			[189, "-"], _
			[190, "."], _
			[191, "/?(US standard keyboard)"], _
			[192, "`~(US standard keyboard)"], _
			[193, ""],[194, ""],[195, ""],[196, ""],[197, ""],[198, ""],[199, ""],[200, ""],[201, ""],[202, ""],[203, ""],[204, ""], _
			[205, ""],[206, ""],[207, ""],[208, ""],[209, ""],[210, ""],[211, ""],[212, ""],[213, ""],[214, ""],[215, ""], _
			[216, ""],[217, ""],[218, ""], _
			[219, "[{(US standard keyboard)"], _
			[220, "\|(US standard keyboard)"], _
			[221, "]}(US standard keyboard)"], _
			[222, "'single-quote/double-quote' key(US standard keyboard)"], _
			[223, ""],[224, ""],[225, ""], _
			[226, "backslash(RT 102-key keyboard)"], _
			[227, ""],[228, ""], _
			[229, "IME PROCESS key"], _
			[230, ""], _
			[231, "VK_PACKET"], _
			[232, ""], _
			[233, ""],[234, ""],[235, ""],[236, ""],[237, ""],[238, ""],[239, ""],[240, ""],[241, ""],[242, ""],[243, ""],[244, ""],[245, ""], _
			[246, "Attn key"], _
			[247, "CrSel key"], _
			[248, "ExSel key"], _
			[249, "Erase EOF key"], _
			[250, "Play"], _
			[251, "Zoom"], _
			[252, ""], _
			[253, "PA1 key"], _
			[254, "Clear key"]]

	Return SetError(0, 0, $aArrayVirtualKey[$iValue - 1][1])

EndFunc   ;==>_VirtualKey


Func _SaveSelected($iSelected, $aArray)

	Local $aArrayIndexes
	For $i = 0 To UBound($aArray) - 1
		If $aArray[$i][0] = $iSelected Then
			$aArrayIndexes = StringSplit($aArray[$i][1], ":")
			ExitLoop
		EndIf
	Next

	If Not UBound($aArrayIndexes) = 4 Then
		Return SetError(1, 0, "")
	EndIf

	Local $sExtension
	Local $bBinaryToWrite
	Local $sFileType
	Local $sSuggestedName

	Switch $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0]


		Case $RT_CURSOR

			For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1

				If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_GROUP_CURSOR Then

					Local $bRTGroupCursor

					For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
						$bRTGroupCursor = _ResourceGetAsRaw($RT_GROUP_CURSOR, $ARRAY_MODULE_STRUCTURE[$m][$n][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
						If @error Then
							ContinueLoop
						EndIf

						If $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] = _LittleEndianBinaryToInt(BinaryMid($bRTGroupCursor, 19, 2)) Then

							Local $tBinaryRTCursorGroup = DllStructCreate("byte[" & BinaryLen($bRTGroupCursor) & "]")
							DllStructSetData($tBinaryRTCursorGroup, 1, $bRTGroupCursor)
							Local $tRTCursorGroup = DllStructCreate("ushort;" & _
									"ushort Type;" & _
									"ushort ImageCount;" & _
									"ushort Width;" & _
									"ushort Height;" & _
									"ushort Planes;" & _
									"ushort BitPerPixel;" & _
									"ushort;" & _
									"ushort;" & _
									"ushort OrdinalName", _
									DllStructGetPtr($tBinaryRTCursorGroup))

							Local $bBinary = _ResourceGetAsRaw($RT_CURSOR, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
							If @error Then
								Return SetError(2, 0, "")
							EndIf
							Local $tBinaryRTCursor = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
							DllStructSetData($tBinaryRTCursor, 1, $bBinary)

							Local $tRTCursor = DllStructCreate("ushort Xhotspot;" & _
									"ushort Yhotspot;" & _
									"byte Body[" & DllStructGetSize($tBinaryRTCursor) - 4 & "]", _
									DllStructGetPtr($tBinaryRTCursor))

							Local $tCursor = DllStructCreate("align 2;ushort;" & _
									"ushort Type;" & _
									"ushort ImageCount;" & _
									"ubyte Width;" & _
									"ubyte Height;" & _
									"ubyte Colors;" & _
									"ubyte;" & _
									"ushort Xhotspot;" & _
									"ushort Yhotspot;" & _
									"dword BitmapSize;" & _
									"dword BitmapOffset;" & _
									"byte Body[" & DllStructGetSize($tBinaryRTCursor) - 4 & "]")

							Local $iWidth = DllStructGetData($tRTCursorGroup, "Width")
							If $iWidth > 32 Then
								$iWidth = 32
							EndIf
							Local $iHeight = $iWidth
							Local $iXhotspot = DllStructGetData($tRTCursor, "Xhotspot")
							Local $iYhotspot = DllStructGetData($tRTCursor, "Yhotspot")
							Local $iBitmapSize = DllStructGetSize($tRTCursor) - 4

							DllStructSetData($tCursor, "Type", 2)
							DllStructSetData($tCursor, "ImageCount", 1)
							DllStructSetData($tCursor, "Width", $iWidth)
							DllStructSetData($tCursor, "Height", $iHeight)
							DllStructSetData($tCursor, "Xhotspot", $iXhotspot)
							DllStructSetData($tCursor, "Yhotspot", $iYhotspot)
							DllStructSetData($tCursor, "BitmapSize", $iBitmapSize)
							DllStructSetData($tCursor, "BitmapOffset", 22)
							DllStructSetData($tCursor, "Body", DllStructGetData($tRTCursor, "Body"))

							Local $tBinaryCursor = DllStructCreate("byte[" & DllStructGetSize($tCursor) & "]", DllStructGetPtr($tCursor))

							$bBinaryToWrite = DllStructGetData($tBinaryCursor, 1)
							$sSuggestedName = "CursorResource" & $RT_CURSOR & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]] & ".cur"
							$sFileType = "Cursor"
							$sExtension = ".cur"

							ExitLoop 2

						EndIf

					Next

					ExitLoop

				EndIf

			Next


		Case $RT_BITMAP

			Local $bBinary = _ResourceGetAsRaw($RT_BITMAP, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
			If @error Then
				Return SetError(2, 0, "")
			EndIf

			Local $tBinary = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
			DllStructSetData($tBinary, 1, $bBinary)

			Local $tBitmap = DllStructCreate("dword HeaderSize", DllStructGetPtr($tBinary))

			Local $iHeaderSize = DllStructGetData($tBitmap, "HeaderSize")

			Local $iMultiplier

			Switch $iHeaderSize
				Case 40
					$tBitmap = DllStructCreate("dword HeaderSize;" & _
							"dword Width;" & _
							"dword Height;" & _
							"ushort Planes;" & _
							"ushort BitPerPixel;" & _
							"dword CompressionMethod;" & _
							"dword Size;" & _
							"dword Hresolution;" & _
							"dword Vresolution;" & _
							"dword Colors;" & _
							"dword ImportantColors", _
							DllStructGetPtr($tBinary))
					$iMultiplier = 4
				Case 12
					$tBitmap = DllStructCreate("dword HeaderSize;" & _
							"ushort Width;" & _
							"ushort Height;" & _
							"ushort Planes;" & _
							"ushort BitPerPixel", _
							DllStructGetPtr($tBinary))
					$iMultiplier = 3
				Case Else
					Return SetError(22, 0, "")
			EndSwitch

			Local $iExponent = DllStructGetData($tBitmap, "BitPerPixel")

			Local $tDIB = DllStructCreate("align 2;byte Identifier[2];" & _
					"dword BitmapSize;" & _
					"short;" & _
					"short;" & _
					"dword BitmapOffset;" & _
					"byte Body[" & BinaryLen($bBinary) & "]")

			DllStructSetData($tDIB, "Identifier", Binary("BM"))
			DllStructSetData($tDIB, "BitmapSize", BinaryLen($bBinary) + 14)

			Local $iRawBitmapSize = DllStructGetData($tBitmap, "Size")

			If $iRawBitmapSize Then
				DllStructSetData($tDIB, "BitmapOffset", BinaryLen($bBinary) - $iRawBitmapSize + 14)
			Else
				If $iExponent = 24 Then
					DllStructSetData($tDIB, "BitmapOffset", $iHeaderSize + 14)
				Else
					Local $iWidth = DllStructGetData($tBitmap, "Width")
					Local $iHeight = DllStructGetData($tBitmap, "Height")
					$iRawBitmapSize = 4 * Floor(($iWidth * $iExponent + 31) / 32) * $iHeight + 2

					Local $iOffset_1 = BinaryLen($bBinary) - $iRawBitmapSize + 14
					Local $iOffset_2 = 2 ^ $iExponent * $iMultiplier + $iHeaderSize + 14

					If $iOffset_2 - $iOffset_1 - 2 <= 0 Then
						DllStructSetData($tDIB, "BitmapOffset", $iOffset_2)
					Else
						DllStructSetData($tDIB, "BitmapOffset", $iOffset_1)
					EndIf

				EndIf
			EndIf

			DllStructSetData($tDIB, "Body", $bBinary)

			Local $tBinaryBMP = DllStructCreate("byte[" & DllStructGetSize($tDIB) & "]", DllStructGetPtr($tDIB))

			$bBinaryToWrite = DllStructGetData($tBinaryBMP, 1)
			$sSuggestedName = "BitmapResource" & $RT_BITMAP & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]] & ".bmp"
			$sFileType = "Bitmap"
			$sExtension = ".bmp"


		Case $RT_ICON

			Local $bBinary = _ResourceGetAsRaw($RT_ICON, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
			If @error Then
				Return SetError(2, 0, "")
			EndIf

			Local $tBinary = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
			DllStructSetData($tBinary, 1, $bBinary)

			Local $tBitmap = DllStructCreate("dword HeaderSize", DllStructGetPtr($tBinary))

			Local $iHeaderSize = DllStructGetData($tBitmap, "HeaderSize")
			Local $iWidth, $iHeight
			Local $iColors, $iPlanes, $iBitPerPixel

			Switch $iHeaderSize
				Case 40
					$tBitmap = DllStructCreate("dword HeaderSize;" & _
							"dword Width;" & _
							"dword Height;" & _
							"ushort Planes;" & _
							"ushort BitPerPixel;" & _
							"dword CompressionMethod;" & _
							"dword Size;" & _
							"dword Hresolution;" & _
							"dword Vresolution;" & _
							"dword Colors;" & _
							"dword ImportantColors;", _
							DllStructGetPtr($tBinary))
					$iWidth = DllStructGetData($tBitmap, "Width")
					$iHeight = DllStructGetData($tBitmap, "Height")
					$iColors = DllStructGetData($tBitmap, "Colors")
					$iPlanes = DllStructGetData($tBitmap, "Planes")
					$iBitPerPixel = DllStructGetData($tBitmap, "BitPerPixel")
				Case 12
					$tBitmap = DllStructCreate("dword HeaderSize;" & _
							"ushort Width;" & _
							"ushort Height;" & _
							"ushort Planes;" & _
							"ushort BitPerPixel;", _
							DllStructGetPtr($tBinary))
					$iWidth = DllStructGetData($tBitmap, "Width")
					$iHeight = DllStructGetData($tBitmap, "Height")
					$iPlanes = DllStructGetData($tBitmap, "Planes")
					$iBitPerPixel = DllStructGetData($tBitmap, "BitPerPixel")
				Case Else
					Local $tPNG = DllStructCreate("ubyte; char PNG[3]", DllStructGetPtr($tBinary))
					If Not (DllStructGetData($tPNG, 1) = 137 And DllStructGetData($tPNG, "PNG") == "PNG") Then
						Return SetError(0, 1, "")
					EndIf

					Local $iIHDROffset = StringInStr(BinaryToString($bBinary), "IHDR", 1)
					If $iIHDROffset Then
						Local $tBinaryIHDR = DllStructCreate("byte[13]")
						DllStructSetData($tBinaryIHDR, 1, BinaryMid($bBinary, $iIHDROffset + 4, 13))
						Local $tIHDR = DllStructCreate("byte Width[4];" & _
								"byte Height[4];" & _
								"ubyte BitDepth;" & _
								"ubyte ColorType;" & _
								"ubyte CompressionMethod;" & _
								"ubyte FilterMethod;" & _
								"ubyte InterlaceMethod", _
								DllStructGetPtr($tBinaryIHDR))
						$iWidth = Dec(Hex(DllStructGetData($tIHDR, "Width")))
						$iHeight = Dec(Hex(DllStructGetData($tIHDR, "Height")))
						$iBitPerPixel = DllStructGetData($tIHDR, "BitDepth")
						$iPlanes = 1
					EndIf
			EndSwitch

			Local $tIcon = DllStructCreate("align 2;ushort;" & _
					"ushort Type;" & _
					"ushort ImageCount;" & _
					"ubyte Width;" & _
					"ubyte Height;" & _
					"ubyte Colors;" & _
					"byte;" & _
					"ushort Planes;" & _
					"ushort BitPerPixel;" & _
					"dword BitmapSize;" & _
					"dword BitmapOffset;" & _
					"byte Body[" & DllStructGetSize($tBinary) & "]")

			Local $iWidth = DllStructGetData($tBitmap, "Width")

			DllStructSetData($tIcon, "Type", 1)
			DllStructSetData($tIcon, "ImageCount", 1)
			DllStructSetData($tIcon, "Width", $iWidth)
			DllStructSetData($tIcon, "Height", $iHeight)
			DllStructSetData($tIcon, "Colors", $iColors)
			DllStructSetData($tIcon, "Planes", $iPlanes)
			DllStructSetData($tIcon, "BitPerPixel", $iBitPerPixel)
			DllStructSetData($tIcon, "BitmapSize", DllStructGetSize($tBinary))
			DllStructSetData($tIcon, "BitmapOffset", 22)
			DllStructSetData($tIcon, "Body", DllStructGetData($tBinary, 1))

			Local $tBinaryIcon = DllStructCreate("byte[" & DllStructGetSize($tIcon) & "]", DllStructGetPtr($tIcon))

			$bBinaryToWrite = DllStructGetData($tBinaryIcon, 1)
			$sSuggestedName = "IconResource" & $RT_ICON & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]] & ".ico"
			$sFileType = "Icon"
			$sExtension = ".ico"


		Case $RT_RCDATA
			Local $bBinary = _ResourceGetAsRaw($RT_RCDATA, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
			If @error Then
				Return SetError(2, 0, "")
			EndIf

			Switch $aMediaResource[4]
				Case ".wav", ".avi", ".png", ".jpg", ".gif"
					$bBinaryToWrite = $bBinary
					$sSuggestedName = "Resource" & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]] & $aMediaResource[4]
					$sFileType = StringUpper(StringTrimLeft($aMediaResource[4], 1))
					$sExtension = $aMediaResource[4]
				Case Else
					$bBinaryToWrite = $bBinary
					$sSuggestedName = "Resource" & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]]
					$sFileType = "Not specified"
					$sExtension = ""
			EndSwitch


		Case $RT_GROUP_CURSOR

			Local $bBinary = _ResourceGetAsRaw($RT_GROUP_CURSOR, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
			If @error Then
				Return SetError(2, 0, "")
			EndIf
			Local $tBinary = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
			DllStructSetData($tBinary, 1, $bBinary)

			Local $tCursorGroup = DllStructCreate("ushort;" & _
					"ushort Type;" & _
					"ushort ImageCount;" & _
					"ushort Width;" & _
					"ushort Height;" & _
					"ushort Planes;" & _
					"ushort BitPerPixel;" & _
					"ushort;" & _
					"ushort;" & _
					"ushort OrdinalName", _
					DllStructGetPtr($tBinary))

			Local $iOrdinalName = DllStructGetData($tCursorGroup, "OrdinalName")

			$bBinary = _ResourceGetAsRaw($RT_CURSOR, $iOrdinalName, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
			If @error Then
				Return SetError(3, 0, "")
			EndIf

			Local $tBinaryRTCursor = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
			DllStructSetData($tBinaryRTCursor, 1, $bBinary)

			Local $tRTCursor = DllStructCreate("ushort Xhotspot;" & _
					"ushort Yhotspot;" & _
					"byte Body[" & DllStructGetSize($tBinaryRTCursor) - 4 & "]", _
					DllStructGetPtr($tBinaryRTCursor))

			Local $tCursor = DllStructCreate("align 2;ushort;" & _
					"ushort Type;" & _
					"ushort ImageCount;" & _
					"ubyte Width;" & _
					"ubyte Height;" & _
					"ubyte Colors;" & _
					"ubyte;" & _
					"ushort Xhotspot;" & _
					"ushort Yhotspot;" & _
					"dword BitmapSize;" & _
					"dword BitmapOffset;" & _
					"byte Body[" & DllStructGetSize($tBinaryRTCursor) - 4 & "]")

			Local $iWidth = DllStructGetData($tCursorGroup, "Width")
			If $iWidth > 32 Then
				$iWidth = 32
			EndIf
			Local $iHeight = $iWidth

			DllStructSetData($tCursor, "Type", 2)
			DllStructSetData($tCursor, "ImageCount", 1)
			DllStructSetData($tCursor, "Width", $iWidth)
			DllStructSetData($tCursor, "Height", $iHeight)
			DllStructSetData($tCursor, "Xhotspot", DllStructGetData($tRTCursor, "Xhotspot"))
			DllStructSetData($tCursor, "Yhotspot", DllStructGetData($tRTCursor, "Yhotspot"))
			DllStructSetData($tCursor, "BitmapSize", DllStructGetSize($tRTCursor) - 4)
			DllStructSetData($tCursor, "BitmapOffset", 22)
			DllStructSetData($tCursor, "Body", DllStructGetData($tRTCursor, "Body"))

			Local $tBinaryCursor = DllStructCreate("byte[" & DllStructGetSize($tCursor) & "]", DllStructGetPtr($tCursor))

			$bBinaryToWrite = DllStructGetData($tBinaryCursor, 1)
			$sSuggestedName = "CursorResource" & $RT_GROUP_CURSOR & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]] & ".cur"
			$sFileType = "Cursor"
			$sExtension = ".cur"


		Case $RT_GROUP_ICON

			Local $aIconData = _CrackIcon($ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded)
			If @error Then
				Return SetError(2, 0, "")
			EndIf

			Local $iIconCount = UBound($aIconData)

			Local $tIconHeader = DllStructCreate("ushort;" & _
					"ushort Type;" & _
					"ushort ImageCount")

			DllStructSetData($tIconHeader, "Type", 1)
			DllStructSetData($tIconHeader, "ImageCount", $iIconCount)

			Local $tBinaryIconHeader = DllStructCreate("byte[6]", DllStructGetPtr($tIconHeader))
			Local $bBinaryIconHeader = DllStructGetData($tBinaryIconHeader, 1)

			Local $aIconSizes[$iIconCount]
			Local $bBinaryBody
			Local $bBinaryChunk

			For $i = 0 To $iIconCount - 1
				$bBinaryChunk = _ResourceGetAsRaw($RT_ICON, $aIconData[$i][6], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
				$aIconSizes[$i] = BinaryLen($bBinaryChunk)
				$bBinaryBody = _BinaryConcat($bBinaryBody, $bBinaryChunk)
			Next

			Local $tDirectory = DllStructCreate("byte[" & 16 * $iIconCount & "]")

			Local $tDirectoryChunk
			Local $tBinaryDirectoryChunk
			Local $bBinaryDirectoryChunk
			Local $bBinaryDirectory
			Local $iOffset = 6 + 16 * $iIconCount

			For $i = 0 To $iIconCount - 1

				$tDirectoryChunk = DllStructCreate("ubyte Width;" & _
						"ubyte Height;" & _
						"ubyte Colors;" & _
						"ubyte;" & _
						"ushort Planes;" & _
						"ushort BitPerPixel;" & _
						"dword BitmapSize;" & _
						"dword Offset")

				DllStructSetData($tDirectoryChunk, "Width", $aIconData[$i][0])
				DllStructSetData($tDirectoryChunk, "Height", $aIconData[$i][1])
				DllStructSetData($tDirectoryChunk, "Colors", $aIconData[$i][2])
				DllStructSetData($tDirectoryChunk, "Planes", $aIconData[$i][3])
				DllStructSetData($tDirectoryChunk, "BitPerPixel", $aIconData[$i][4])
				DllStructSetData($tDirectoryChunk, "BitmapSize", $aIconData[$i][5])
				DllStructSetData($tDirectoryChunk, "Offset", $iOffset)
				$iOffset += $aIconSizes[$i]

				$tBinaryDirectoryChunk = DllStructCreate("byte[16]", DllStructGetPtr($tDirectoryChunk))
				$bBinaryDirectoryChunk = DllStructGetData($tBinaryDirectoryChunk, 1)

				$bBinaryDirectory = _BinaryConcat($bBinaryDirectory, $bBinaryDirectoryChunk)

			Next

			$bBinaryToWrite = _BinaryConcat($bBinaryIconHeader, $bBinaryDirectory)
			$bBinaryToWrite = _BinaryConcat($bBinaryToWrite, $bBinaryBody)

			$sSuggestedName = "IconResource" & $RT_GROUP_ICON & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]] & ".ico"
			$sFileType = "Icon"
			$sExtension = ".ico"


		Case $RT_ANICURSOR

			Local $bBinary = _ResourceGetAsRaw($RT_ANICURSOR, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
			If @error Then
				Return SetError(2, 0, "")
			EndIf

			$bBinaryToWrite = $bBinary
			$sSuggestedName = "Resource" & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]] & ".ani"
			$sFileType = "Animated Cursor"
			$sExtension = ".ani"


		Case $RT_ANIICON

			Local $bBinary = _ResourceGetAsRaw($RT_ANIICON, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
			If @error Then
				Return SetError(2, 0, "")
			EndIf

			$bBinaryToWrite = $bBinary
			$sSuggestedName = "Resource" & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]] & ".ico"
			$sFileType = "Animated Icon"
			$sExtension = ".ico"


		Case $RT_HTML, $RT_MANIFEST

			Local $sData = _ResourceGetAsRaw($ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
			If @error Then
				Return SetError(2, 0, "")
			EndIf

			$bBinaryToWrite = $sData
			$sSuggestedName = "Resource" & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]] & ".txt"
			$sFileType = "Text"
			$sExtension = ".txt"


		Case Else

			If FileExists($sMediaTempFile) Then
				If $aMediaResource[4] = ".wav" Or $aMediaResource[4] = ".avi" Then
					Local $hTmpFile = FileOpen($sMediaTempFile, 16)
					If @error Or $hTmpFile = -1 Then
						Return SetError(24, 0, "")
					EndIf
					$bBinaryToWrite = FileRead($hTmpFile)
					FileClose($hTmpFile)
					$sSuggestedName = "Resource" & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]] & $aMediaResource[4]
					$sFileType = StringUpper(StringTrimLeft($aMediaResource[4], 1))
					$sExtension = $aMediaResource[4]
				EndIf
			Else
				If $aMediaResource[4] = ".wav" Or $aMediaResource[4] = ".avi" Or $aMediaResource[4] = ".png" Or $aMediaResource[4] = ".jpg" Or $aMediaResource[4] = ".gif" Then
					$bBinaryToWrite = _ResourceGetAsRaw($ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]], $sFileLoaded, 1)
					If @error Then
						Return SetError(25, 0, "")
					EndIf
					$sSuggestedName = "Resource" & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0] & $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]] & $aMediaResource[4]
					$sFileType = StringUpper(StringTrimLeft($aMediaResource[4], 1))
					$sExtension = $aMediaResource[4]
				EndIf
			EndIf

	EndSwitch

	Local $sSaveFile
	$sSuggestedName = StringRegExpReplace($sSuggestedName, '[\\/:*?"<>|]', "")

	While 1

		$sSaveFile = FileSaveDialog("Save Resource", @DesktopDir, $sFileType & " (*" & $sExtension & ")", 2, $sSuggestedName, $hGui)

		If Not $sSaveFile Then
			Return SetError(0, 0, 1)
		EndIf

		If Not (StringRight($sSaveFile, StringLen($sExtension)) = $sExtension) Then
			$sSaveFile &= $sExtension
		EndIf

		If FileExists($sSaveFile) Then
			If MsgBox(52, "Save Resource", FileGetLongName($sSaveFile) & " already exists." & @CRLF & "Do you want to replace it?", 0, $hGui) = 6 Then
				ExitLoop
			EndIf
		Else
			ExitLoop
		EndIf

	WEnd

	Local $hSaveFile = FileOpen($sSaveFile, 26)
	If @error Or $hSaveFile = -1 Then
		Return SetError(31, 0, "")
	EndIf
	FileWrite($hSaveFile, $bBinaryToWrite)
	FileClose($hSaveFile)

	Return SetError(0, 0, 1)

EndFunc   ;==>_SaveSelected


Func _BinaryConcat($bBinary1, $bBinary2)

	If Not IsBinary($bBinary1) Then
		Return $bBinary2
	EndIf

	Local $tInitial = DllStructCreate("byte[" & BinaryLen($bBinary1) & "];byte[" & BinaryLen($bBinary2) & "]")
	DllStructSetData($tInitial, 1, $bBinary1)
	DllStructSetData($tInitial, 2, $bBinary2)

	Local $tOutput = DllStructCreate("byte[" & DllStructGetSize($tInitial) & "]", DllStructGetPtr($tInitial))

	Return SetError(0, 0, DllStructGetData($tOutput, 1))

EndFunc   ;==>_BinaryConcat


Func _GetVersionInformation($bBinary)

	Local $sData = @CRLF

	Local $tBinary = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
	DllStructSetData($tBinary, 1, $bBinary)

	Local $tVS_VERSION_INFO = DllStructCreate("ushort Length;" & _
			"ushort ValueLength;" & _
			"ushort Type;" & _
			"wchar szKey[15];" & _
			"ushort[2];" & _
			"dword Signature;" & _
			"dword StrucVersion;" & _
			"dword FileVersionMS;" & _
			"dword FileVersionLS;" & _
			"dword ProductVersionMS;" & _
			"dword ProductVersionLS;" & _
			"dword FileFlagMask;" & _
			"dword FileFlags;" & _
			"dword FileOS;" & _
			"dword FileType;" & _
			"dword FileSubtype;" & _
			"dword FileDateMS;" & _
			"dword FileDateLS;" & _
			"byte Children[" & DllStructGetSize($tBinary) - 92 & "]", _
			DllStructGetPtr($tBinary))

	$sData &= "<" & DllStructGetData($tVS_VERSION_INFO, "szKey") & ">" & @CRLF & @CRLF

	Local $tFileVersion = DllStructCreate("dword[2]", DllStructGetPtr($tVS_VERSION_INFO) + 48)
	Local $tFVersion = DllStructCreate("ushort[4]", DllStructGetPtr($tFileVersion))
	$sData &= "      File Version: " & DllStructGetData($tFVersion, 1, 2) & "." & DllStructGetData($tFVersion, 1, 1) & "." & DllStructGetData($tFVersion, 1, 4) & "." & DllStructGetData($tFVersion, 1, 3) & @CRLF

	Local $tProductVersion = DllStructCreate("dword[2]", DllStructGetPtr($tVS_VERSION_INFO) + 56)
	Local $tPVersion = DllStructCreate("ushort[4]", DllStructGetPtr($tProductVersion))
	$sData &= "      Product Version: " & DllStructGetData($tPVersion, 1, 2) & "." & DllStructGetData($tPVersion, 1, 1) & "." & DllStructGetData($tPVersion, 1, 4) & "." & DllStructGetData($tPVersion, 1, 3) & @CRLF

	$sData &= "      Characteristics: " & _FileType(DllStructGetData($tVS_VERSION_INFO, "FileType")) & " " & _FileOS(DllStructGetData($tVS_VERSION_INFO, "FileOS")) & @CRLF

	Local $iStringTable_Length = DllStructGetData($tVS_VERSION_INFO, "Length")
	Local $ChildrenLen
	Local $tStringTable
	Local $iSaver

	While $ChildrenLen < $iStringTable_Length - 92

		$iSaver += 1
		If $iSaver = 10 Then ; some crazy scenario. Will return to prevent cpu overload. Should never happen!
			$sData &= @CRLF & "</" & DllStructGetData($tVS_VERSION_INFO, "szKey") & ">"
			Return SetError(0, 1, $sData)
		EndIf

		$tStringTable = DllStructCreate("ushort Length;" & _
				"ushort ValueLength;" & _
				"ushort Type;" & _
				"wchar szKey[14]", _
				DllStructGetPtr($tVS_VERSION_INFO, "Children") + $ChildrenLen)

		$ChildrenLen += DllStructGetData($tStringTable, "Length")
		Local $iPadd = Mod($ChildrenLen, 4)
		If $iPadd Then
			$ChildrenLen += 4 - $iPadd
		EndIf


		Switch DllStructGetData($tStringTable, "szKey")

			Case "StringFileInfo"
				$sData &= @CRLF & "      <StringFileInfo>"
				Local $tChildren = DllStructCreate("byte[" & DllStructGetData($tStringTable, "Length") - 36 & "]", DllStructGetPtr($tStringTable) + 36)

				Local $tSubString = DllStructCreate("ushort Length;" & _
						"ushort ValueLength;" & _
						"ushort Type;" & _
						"wchar szKey[8];" & _
						"ushort", _
						DllStructGetPtr($tChildren))

				Local $iTotalLength = DllStructGetData($tSubString, "Length")

				$sData &= @CRLF & "          <" & DllStructGetData($tSubString, "szKey") & ">" & @CRLF

				Local $iLang = Dec(Hex("0x" & StringLeft(DllStructGetData($tSubString, "szKey"), 4)))
				Local $iCodePage = Dec(Hex("0x" & StringRight(DllStructGetData($tSubString, "szKey"), 4)))

				$sData &= "              Language identifier: " & $iLang & "  (" & _LanguageCode($iLang) & ")" & @CRLF
				$sData &= "              Code page: " & $iCodePage & "  " & _CodePage($iCodePage) & @CRLF & @CRLF

				Local $tValue = DllStructCreate("byte[" & DllStructGetData($tSubString, "Length") - 24 & "]", DllStructGetPtr($tSubString) + 24)
				Local $tValue_Sub
				Local $tValue_String
				Local $iLength, $iPadding, $szKey, $iValueLength, $sValue
				Local $sKeyPadding, $struct_KeyPadding
				Local $iOffset

				While $iOffset < $iTotalLength - 24

					$tValue_Sub = DllStructCreate("ushort Length", DllStructGetPtr($tValue) + $iOffset)
					$iLength = DllStructGetData($tValue_Sub, 1)

					$iPadding = Mod($iLength, 4)
					If $iPadding Then
						$iLength += 4 - $iPadding
					EndIf

					$tValue_String = DllStructCreate("ushort Length;" & _
							"ushort ValueLength;" & _
							"ushort Type;" & _
							"wchar szKey[" & $iLength - 6 & "]", _
							DllStructGetPtr($tValue) + $iOffset)

					$szKey = DllStructGetData($tValue_String, "szKey")
					If StringLen($szKey) < 21 Then
						$struct_KeyPadding = DllStructCreate("byte[" & 20 - StringLen($szKey) & "]") ; this is only cosmetics
						$sKeyPadding = StringReplace(BinaryToString(DllStructGetData($struct_KeyPadding, 1)), Chr(0), Chr(32))
					Else
						$sKeyPadding = ""
					EndIf

					$sData &= "                  " & $szKey & ": " & $sKeyPadding

					$iValueLength = DllStructGetData($tValue_String, "ValueLength")
					$iPadding = 4 - Mod(2 * StringLen($szKey) + 6, 4)

					$tValue_String = DllStructCreate("ushort Length;" & _
							"ushort ValueLength;" & _
							"ushort Type;" & _
							"wchar szKey[" & StringLen($szKey) & "];" & _
							"byte[" & $iPadding & "];" & _
							"wchar Value[" & $iValueLength & "]", _
							DllStructGetPtr($tValue) + $iOffset)

					$sValue = DllStructGetData($tValue_String, "Value")
					If Not $sValue Then
						$sValue = ""
					EndIf
					$sData &= $sValue & @CRLF

					$iOffset += $iLength

				WEnd

				$sData &= @CRLF & "          </" & DllStructGetData($tSubString, "szKey") & ">"
				$sData &= @CRLF & "      </StringFileInfo>" & @CRLF

			Case "VarFileInfo"
				$sData &= @CRLF & "      <VarFileInfo>"
				Local $tChildren = DllStructCreate("byte[" & DllStructGetData($tStringTable, "Length") - 32 & "]", DllStructGetPtr($tStringTable) + 32)

				Local $tVar = DllStructCreate("ushort Length;" & _
						"ushort ValueLength;" & _
						"ushort Type;" & _
						"wchar szKey[13]", _
						DllStructGetPtr($tChildren))

				$sData &= @CRLF & "          <" & DllStructGetData($tVar, "szKey") & ">" & @CRLF

				Local $tValue = DllStructCreate("short[" & DllStructGetData($tVar, "ValueLength") / 2 & "]", DllStructGetPtr($tVar) + 32)
				Local $iCodePage, $iLang

				For $i = 1 To DllStructGetData($tVar, "ValueLength") / 2
					If Mod($i, 2) Then
						$iLang = DllStructGetData($tValue, 1, $i)
						$sData &= "              Language identifier: " & $iLang & "  (" & _LanguageCode($iLang) & ")" & @CRLF
					Else
						$iCodePage = DllStructGetData($tValue, 1, $i)
						$sData &= "              Code page: " & $iCodePage & "  " & _CodePage($iCodePage) & @CRLF
					EndIf
				Next
				$sData &= "          </" & DllStructGetData($tVar, "szKey") & ">"
				$sData &= @CRLF & "      </VarFileInfo>" & @CRLF
		EndSwitch

	WEnd

	$sData &= @CRLF & "</" & DllStructGetData($tVS_VERSION_INFO, "szKey") & ">"

	Return SetError(0, 0, $sData)

EndFunc   ;==>_GetVersionInformation


Func _CodePage($iCode)

	Local $aArray[15][2] = [[0, "7-bit ASCII"], _
			[932, "Shift - JIS X-0208"], _
			[949, "Shift - KSC 5601"], _
			[950, "Big5"], _
			[1200, "Unicode"], _
			[1250, "East European Latin"], _
			[1251, "Cyrillic"], _
			[1252, "West European Latin"], _
			[1253, "Greek"], _
			[1254, "Turkish"], _
			[1255, "Hebrew"], _
			[1256, "Arabic"], _
			[1257, "Baltic"], _
			[1258, "Vietnamese"], _
			[847, "Thai"]]

	For $i = 0 To 9
		If $iCode = $aArray[$i][0] Then
			Return SetError(0, 0, "(" & $aArray[$i][1] & ")")
		EndIf
	Next

	Return SetError(0, 0, "")

EndFunc   ;==>_CodePage


Func _FileOS($iFileOS)

	; Should always be Windows32 this and that, but for the sake of completeness almost all listed here

	Local $aArray[16][2] = [[0, ""], _
			[1, "designed for 16-bit Windows"], _
			[2, "designed for 16-bit Presentation Manager"], _
			[3, "designed for 32-bit Presentation Manager"], _
			[4, "designed for 32-bit Windows"], _
			[65536, "designed for Microsoft MS-DOS"], _
			[65537, "designed for 16-bit Windows running on MS-DOS"], _
			[65540, "designed for 32-bit Windows running on MS-DOS"], _
			[131072, "designed for 16-bit OS/2"], _
			[131074, "designed for 16-bit Presentation Manager running on 16-bit OS/2"], _
			[196608, "designed for 32-bit OS/2"], _
			[196611, "designed for 32-bit Presentation Manager running on 32-bit OS/2"], _
			[262144, "designed for Windows NT"], _
			[262148, "designed for 32-bit Windows NT"], _
			[327680, "designed for Windows CE"], _
			[327684, "designed for 32-bit Windows CE"]]

	For $i = 0 To 15
		If $iFileOS = $aArray[$i][0] Then
			Return SetError(0, 0, $aArray[$i][1])
		EndIf
	Next

	Local $tOut = DllStructCreate("ptr")
	DllStructSetData($tOut, 1, $iFileOS)

	Return SetError(0, 0, "-FileOS flag: " & DllStructGetData($tOut, 1))

EndFunc   ;==>_FileOS


Func _FileType($iType)

	If $iType < 0 Or $iType > 7 Then
		Return SetError(0, 1, "")
	EndIf

	Local $aArray[8][2] = [[0, "Unknown file type"], _
			[1, "Application"], _
			[2, "DLL file"], _
			[3, "Device driver"], _
			[4, "Font file"], _
			[5, "Virtual device"], _
			[6, ""], _
			[7, "Static-link library"]]

	Return SetError(0, 0, $aArray[$iType][1])

EndFunc   ;==>_FileType


Func _NumInst($sName)

	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "CreateSemaphore", _
			"ptr", 0, _
			"int", 1, _
			"int", 999, _
			"str", $sName)

	If @error Or Not $a_hCall[0] Then
		Return SetError(1, 0, "")
	EndIf

	Local $hSemaphore = $a_hCall[0]

	Local $a_iCall = DllCall("kernel32.dll", "int", "ReleaseSemaphore", "hwnd", $hSemaphore, "int", 1, "int*", 0)

	If @error Or Not $a_iCall[0] Then
		Return SetError(2, 0, "")
	EndIf

	$iInstanceCurrent = $a_iCall[3] ; global variable
	$iInstancesOverall = $a_iCall[3] ; this too, initially they are the same

	Return SetError(0, 0, 1)

EndFunc   ;==>_NumInst


Func _RegisterWindowMessage($sMessage)

	Local $a_iCall = DllCall("user32.dll", "dword", "RegisterWindowMessage", "str", $sMessage)

	If @error Or Not $a_iCall[0] Then
		Return SetError(1, 0, "")
	EndIf

	Local $iMessage = $a_iCall[0]

	$a_iCall = DllCall("user32.dll", "int", "SendNotifyMessage", _
			"hwnd", 0xFFFF, _
			"dword", $iMessage, _
			"int", $iInstanceCurrent, _
			"int", 0)

	If @error Or Not $a_iCall[0] Then
		Return SetError(2, 0, "")
	EndIf

	GUIRegisterMsg($iMessage, "_IntermediaryFunction")

	Return SetError(0, 0, $iMessage)

EndFunc   ;==>_RegisterWindowMessage


Func _IntermediaryFunction($hHwnd, $iMsg, $wParam, $lParam)

	If ($iChild Or $iMenuIs) And Not $iSkipOne Then
		$iSkipOne = 1
		Return
	EndIf

	$wParam = BitOR($wParam, 0)
	$lParam = BitOR($lParam, 0)

	If $wParam > $iInstanceCurrent Then
		$iInstancesOverall += 1
	EndIf

	If $lParam Then
		$iInstancesOverall -= 1
		If $lParam <= $iInstanceCurrent Then
			$iInstanceCurrent -= 1
		EndIf
	EndIf

	If $iCompilerEnabled Then
		WinSetTitle($hGui, 0, "Resources [" & $iInstanceCurrent & " of " & $iInstancesOverall & "] - Compiler Enabled")
	Else
		If $sFileLoaded Then
			Local $sTitle = FileGetLongName($sFileLoaded) & " - Resources [" & $iInstanceCurrent & " of " & $iInstancesOverall & "]"
			Local $aClientSize = WinGetClientSize($hGui)

			Local $a_iCall = DllCall("shlwapi.dll", "int", "PathCompactPathW", _
					"hwnd", 0, _
					"wstr", $sTitle, _
					"dword", $aClientSize[0] - 100)

			If @error Then
				WinSetTitle($hGui, 0, $sTitle)
			Else
				WinSetTitle($hGui, 0, $a_iCall[2])
			EndIf

		Else
			WinSetTitle($hGui, 0, "Resources [" & $iInstanceCurrent & " of " & $iInstancesOverall & "]")
		EndIf
	EndIf

	$iSkipOne = 0

EndFunc   ;==>_IntermediaryFunction


Func _GenerateInitialDLL($sName = "")

	; Initial values are predefined, there is no point in creating and filling structures. Once in my house is enough.
	; Only thing that changes is TimeDateStamp in IMAGE_FILE_HEADER structure.

	Local $bBin = "0x4D5A000000000000000000000000000000000000000000000000000000000000" & _
			"0000000000000000437265617465642077697468204175746F497400A8000000" & _
			"00000000000000000000000D0A2154686973206973207265736F757263652064" & _
			"6C6C2E204E6F20636F646520696E736964652121210D0D0A0000000000000000" & _
			"0000000000000000000000000000000000000000000000000000000000000000" & _
			"0000000000000000504500004C010100" & _HexEpochNowUTC() & "0000000000000000E0000220" & _
			"0B01010000000000000200000000000000000000001000000010000000000010" & _
			"0002000000020000060000000100000006000000000000000004000000020000" & _
			"0000000002000000000000000000000000000000000000000000000010000000" & _
			"0000000000000000000000000000000000020000100000000000000000000000" & _
			"0000000000000000000000000000000000000000000000000000000000000000" & _
			"0000000000000000000000000000000000000000000000000000000000000000" & _
			"0000000000000000000000000000000000000000000000000000000000000000" & _
			"2E72737263000000100000000002000000020000000200000000000000000000" & _
			"0000000040000040"

	Local $tRawData = DllStructCreate("byte[1024]")
	DllStructSetData($tRawData, 1, $bBin)

	Local $sTmpFolder = @TempDir

	Local $sTmpFileName

	If $sName Then
		$sTmpFileName = $sName
		If Not (StringRight($sTmpFileName, 4) = ".dll") Then
			$sTmpFileName &= ".dll"
		EndIf
	Else
		$sTmpFileName = _GenerateGUID() & ".dll"
		If @error Then
			Return SetError(1, 0, "")
		EndIf
	EndIf

	Local $sTmpFile = $sTmpFolder & "/" & $sTmpFileName

	Local $hTmpFile = FileOpen($sTmpFile, 26)
	FileWrite($hTmpFile, DllStructGetData($tRawData, 1))
	FileClose($hTmpFile)

	Return SetError(0, 0, $sTmpFile)

EndFunc   ;==>_GenerateInitialDLL


Func _HexEpochNowUTC()

	Local $tTIME_ZONE_INFORMATION = DllStructCreate("int Bias;" & _
			"wchar StandardName[32];" & _
			"ushort StandardDate[8];" & _
			"int StandardBias;" & _
			"wchar DaylightName[32];" & _
			"ushort DaylightDate[8];" & _
			"int DaylightBias")

	Local $a_iCall = DllCall("kernel32.dll", "dword", "GetTimeZoneInformation", "ptr", DllStructGetPtr($tTIME_ZONE_INFORMATION))

	If @error Or $a_iCall[0] = -1 Then
		Local $iHour = @HOUR
		Local $iMinute = @MIN
	Else
		Local $iBias = DllStructGetData($tTIME_ZONE_INFORMATION, "Bias")
		Local $iHour = @HOUR + Int($iBias / 60)
		Local $iMinute = @MIN + Mod($iBias, 60)
	EndIf

	Local $aDatePart[2] = [@YEAR, @MON]

	If $aDatePart[1] < 3 Then
		$aDatePart[1] += 12
		$aDatePart[0] -= 1
	EndIf

	Local $i_aFactor = Int($aDatePart[0] / 100)
	Local $i_bFactor = Int($i_aFactor / 4)
	Local $i_eFactor = Int(1461 * ($aDatePart[0] + 4716) / 4)
	Local $i_fFactor = Int(153 * ($aDatePart[1] + 1) / 5)

	Local $aDaysDiff = ($i_bFactor - $i_aFactor + @MDAY + $i_eFactor + $i_fFactor - 2442110) * 86400
	Local $iTimeDiff = $iHour * 3600 + $iMinute * 60 + @SEC

	Local $tDwordEPOCHTime = DllStructCreate("dword")
	DllStructSetData($tDwordEPOCHTime, 1, $aDaysDiff + $iTimeDiff)

	Local $tByteEPOCHTime = DllStructCreate("byte[4]", DllStructGetPtr($tDwordEPOCHTime))

	Return SetError(0, 0, Hex(DllStructGetData($tByteEPOCHTime, 1)))

EndFunc   ;==>_HexEpochNowUTC


Func _EpochDecrypt($iEpochTime)

	Local $iDayToAdd = Int($iEpochTime / 86400)
	Local $iTimeVal = Mod($iEpochTime, 86400)

	If $iTimeVal < 0 Then
		$iDayToAdd -= 1
		$iTimeVal += 86400
	EndIf

	Local $i_wFactor = Int((573371.75 + $iDayToAdd) / 36524.25)
	Local $i_xFactor = Int($i_wFactor / 4)
	Local $i_bFactor = 2442113 + $iDayToAdd + $i_wFactor - $i_xFactor

	Local $i_cFactor = Int(($i_bFactor - 122.1) / 365.25)
	Local $i_dFactor = Int(365.25 * $i_cFactor)
	Local $i_eFactor = Int(($i_bFactor - $i_dFactor) / 30.6001)

	Local $aDatePart[3]
	$aDatePart[2] = $i_bFactor - $i_dFactor - Int(30.6001 * $i_eFactor)
	$aDatePart[1] = $i_eFactor - 1 - 12 * ($i_eFactor - 2 > 11)
	$aDatePart[0] = $i_cFactor - 4716 + ($aDatePart[1] < 3)

	Local $aTimePart[3]
	$aTimePart[0] = Int($iTimeVal / 3600)
	$iTimeVal = Mod($iTimeVal, 3600)
	$aTimePart[1] = Int($iTimeVal / 60)
	$aTimePart[2] = Mod($iTimeVal, 60)

	Return SetError(0, 0, StringFormat("%.2d/%.2d/%.2d %.2d:%.2d:%.2d", $aDatePart[0], $aDatePart[1], $aDatePart[2], $aTimePart[0], $aTimePart[1], $aTimePart[2]))

EndFunc   ;==>_EpochDecrypt


Func _GetHashes($sFile) ; Siao's originally

	Local $aHashArray[2] = [" ~unable to resolve~", " ~unable to resolve~"] ; predefining output

	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "CreateFileW", _
			"wstr", $sFile, _
			"dword", 0x80000000, _ ; GENERIC_READ
			"dword", 1, _ ; FILE_SHARE_READ
			"ptr", 0, _
			"dword", 3, _ ; OPEN_EXISTING
			"dword", 0, _ ; SECURITY_ANONYMOUS
			"ptr", 0)

	If @error Or $a_hCall[0] = -1 Then
		Return SetError(1, 0, $aHashArray)
	EndIf

	Local $hFile = $a_hCall[0]

	$a_hCall = DllCall("kernel32.dll", "ptr", "CreateFileMapping", _
			"hwnd", $hFile, _
			"dword", 0, _ ; default security descriptor
			"dword", 2, _ ; PAGE_READONLY
			"dword", 0, _
			"dword", 0, _
			"ptr", 0)

	If @error Or Not $a_hCall[0] Then
		DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile)
		Return SetError(2, 0, $aHashArray)
	EndIf

	DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFile)

	Local $hFileMappingObject = $a_hCall[0]

	$a_hCall = DllCall("kernel32.dll", "ptr", "MapViewOfFile", _
			"hwnd", $hFileMappingObject, _
			"dword", 4, _ ; FILE_MAP_READ
			"dword", 0, _
			"dword", 0, _
			"dword", 0)

	If @error Or Not $a_hCall[0] Then
		DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
		Return SetError(3, 0, $aHashArray)
	EndIf

	Local $pFile = $a_hCall[0]
	Local $iBufferSize = FileGetSize($sFile)

	Local $a_iCall = DllCall("advapi32.dll", "int", "CryptAcquireContext", _
			"ptr*", 0, _
			"ptr", 0, _
			"ptr", 0, _
			"dword", 1, _ ; PROV_RSA_FULL
			"dword", 0xF0000000) ; CRYPT_VERIFYCONTEXT

	If @error Or Not $a_iCall[0] Then
		DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
		DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
		Return SetError(5, 0, $aHashArray)
	EndIf

	Local $hContext = $a_iCall[1]

	$a_iCall = DllCall("advapi32.dll", "int", "CryptCreateHash", _
			"ptr", $hContext, _
			"dword", 0x00008003, _ ; CALG_MD5
			"ptr", 0, _ ; nonkeyed
			"dword", 0, _
			"ptr*", 0)

	If @error Or Not $a_iCall[0] Then
		DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
		DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
		DllCall("advapi32.dll", "int", "CryptReleaseContext", "ptr", $hContext, "dword", 0)
		Return SetError(6, 0, $aHashArray)
	EndIf

	Local $hHashMD5 = $a_iCall[5]

	$a_iCall = DllCall("advapi32.dll", "int", "CryptHashData", _
			"ptr", $hHashMD5, _
			"ptr", $pFile, _
			"dword", $iBufferSize, _
			"dword", 0)

	If @error Or Not $a_iCall[0] Then
		DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
		DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
		DllCall("advapi32.dll", "int", "CryptDestroyHash", "ptr", $hHashMD5)
		DllCall("advapi32.dll", "int", "CryptReleaseContext", "ptr", $hContext, "dword", 0)
		Return SetError(7, 0, $aHashArray)
	EndIf

	Local $tOutMD5 = DllStructCreate("byte[16]")

	$a_iCall = DllCall("advapi32.dll", "int", "CryptGetHashParam", _
			"ptr", $hHashMD5, _
			"dword", 2, _ ; HP_HASHVAL
			"ptr", DllStructGetPtr($tOutMD5), _
			"dword*", 16, _
			"dword", 0)

	If @error Or Not $a_iCall[0] Then
		DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
		DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
		DllCall("advapi32.dll", "int", "CryptDestroyHash", "ptr", $hHashMD5)
		DllCall("advapi32.dll", "int", "CryptReleaseContext", "ptr", $hContext, "dword", 0)
		Return SetError(8, 0, $aHashArray)
	EndIf

	DllCall("advapi32.dll", "int", "CryptDestroyHash", "ptr", $hHashMD5)

	$aHashArray[0] = Hex(DllStructGetData($tOutMD5, 1))

	$a_iCall = DllCall("advapi32.dll", "int", "CryptCreateHash", _
			"ptr", $hContext, _
			"dword", 0x00008004, _ ; CALG_SHA1
			"ptr", 0, _ ; nonkeyed
			"dword", 0, _
			"ptr*", 0)

	If @error Or Not $a_iCall[0] Then
		DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
		DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
		DllCall("advapi32.dll", "int", "CryptReleaseContext", "ptr", $hContext, "dword", 0)
		Return SetError(9, 0, $aHashArray)
	EndIf

	Local $hHashSHA1 = $a_iCall[5]

	$a_iCall = DllCall("advapi32.dll", "int", "CryptHashData", _
			"ptr", $hHashSHA1, _
			"ptr", $pFile, _
			"dword", $iBufferSize, _
			"dword", 0)

	If @error Or Not $a_iCall[0] Then
		DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
		DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
		DllCall("advapi32.dll", "int", "CryptDestroyHash", "ptr", $hHashSHA1)
		DllCall("advapi32.dll", "int", "CryptReleaseContext", "ptr", $hContext, "dword", 0)
		Return SetError(10, 0, $aHashArray)
	EndIf

	Local $tOutSHA1 = DllStructCreate("byte[20]")

	$a_iCall = DllCall("advapi32.dll", "int", "CryptGetHashParam", _
			"ptr", $hHashSHA1, _
			"dword", 2, _ ; HP_HASHVAL
			"ptr", DllStructGetPtr($tOutSHA1), _
			"dword*", 20, _
			"dword", 0)

	If @error Or Not $a_iCall[0] Then
		DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
		DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)
		DllCall("advapi32.dll", "int", "CryptDestroyHash", "ptr", $hHashSHA1)
		DllCall("advapi32.dll", "int", "CryptReleaseContext", "ptr", $hContext, "dword", 0)
		Return SetError(11, 0, $aHashArray)
	EndIf

	DllCall("kernel32.dll", "int", "UnmapViewOfFile", "ptr", $pFile)
	DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hFileMappingObject)

	DllCall("advapi32.dll", "int", "CryptDestroyHash", "ptr", $hHashSHA1)

	$aHashArray[1] = Hex(DllStructGetData($tOutSHA1, 1))

	DllCall("advapi32.dll", "int", "CryptReleaseContext", "ptr", $hContext, "dword", 0)

	Return SetError(0, 0, $aHashArray)

EndFunc   ;==>_GetHashes


Func _ProcessFile($sFile)

	Local $hChild = GUICreate("Add resource ", 230, 300, -1, -1, -1, -1, $hGui)

	GUICtrlCreateLabel("Resource type:", 10, 12, 130, 20)
	GUICtrlSetFont(-1, 9, 800, 2)
	GUICtrlSetColor(-1, 0x0000CC)

	Local $hTypeInput = GUICtrlCreateInput("", 10, 35, 210, 21, 8)
	GUICtrlSetState($hTypeInput, 32)
	Local $hTypeInputCombo = GUICtrlCreateCombo("", 10, 35, 210, 21, 2097219)

	Local $sDefaultData = "10 - RT_RCDATA"

	Switch StringRight($sFile, 4)
		Case ".bmp"
			If FileRead($sFile, 2) == "BM" Then
				$sDefaultData = "2 - RT_BITMAP"
			EndIf
		Case ".cur"
			$sDefaultData = "12 - RT_GROUP_CURSOR"
		Case ".ico"
			If FileRead($sFile, 4) == "RIFF" Then
				$sDefaultData = "22 - RT_ANIICON"
			Else
				$sDefaultData = "14 - RT_GROUP_ICON"
			EndIf
		Case ".ani"
			If FileRead($sFile, 4) == "RIFF" Then
				$sDefaultData = "21 - RT_ANICURSOR"
			EndIf
		Case ".htm", "html"
			$sDefaultData = "23 - RT_HTML"
		Case ".avi"
			If FileRead($sFile, 4) == "RIFF" Then
				$sDefaultData = "AVI"
			EndIf
		Case ".wav"
			If FileRead($sFile, 4) == "RIFF" Then
				$sDefaultData = "WAV"
			EndIf
		Case ".png"
			If FileRead($sFile, 4) == "‰PNG" Then
				$sDefaultData = "PNG"
			EndIf
		Case ".jpg"
			If StringRight(FileRead($sFile, 10), 4) == "JFIF" Then
				$sDefaultData = "JPEG"
			EndIf
		Case ".gif"
			If FileRead($sFile, 4) == "GIF8" Then
				$sDefaultData = "GIF"
			EndIf
	EndSwitch

	GUICtrlSetData($hTypeInputCombo, "2 - RT_BITMAP|10 - RT_RCDATA|12 - RT_GROUP_CURSOR|14 - RT_GROUP_ICON|21 - RT_ANICURSOR|22 - RT_ANIICON|23 - RT_HTML|24 - RT_MANIFEST|AVI|WAV|PNG|JPEG|GIF", $sDefaultData)

	Local $hCheckBox = GUICtrlCreateCheckbox("Use predefined values", 10, 57, 135, 20)
	GUICtrlSetState($hCheckBox, 1)

	GUICtrlCreateLabel("Resource name:", 10, 88, 130, 20)
	GUICtrlSetFont(-1, 9, 800, 2)
	GUICtrlSetColor(-1, 0x0000CC)

	Local $hTypeInputName = GUICtrlCreateInput("", 10, 110, 210, 21, 8)
	GUICtrlSetState($hTypeInputName, 256)

	GUICtrlCreateLabel("Resource language:", 10, 143, 130, 20)
	GUICtrlSetFont(-1, 9, 800, 2)
	GUICtrlSetColor(-1, 0x0000CC)

	Local $hTypeInputLanguage = GUICtrlCreateCombo("", 10, 165, 210, 21, 2097219)

	Local $sComboData
	For $i = 1 To 121
		$sComboData &= _LanguageCode($i, 1, 0) & "|"
	Next
	$sComboData &= "0 - Neutral"
	GUICtrlSetData($hTypeInputLanguage, $sComboData, "0 - Neutral")

	Local $hButtonAdd = GUICtrlCreateButton("Add Resource", 20, 220, 110, 27)
	GUICtrlSetFont($hButtonAdd, 9, 800, 2)

	Local $hButtonCancel = GUICtrlCreateButton("Cancel", 140, 220, 70, 27)
	GUICtrlSetFont($hButtonCancel, 9, 800)

	GUICtrlCreateLabel("Adding: ", 10, 265, 40, 20)

	GUICtrlCreateLabel(StringRegExpReplace($sFile, ".*\\", ""), 55, 264, 170, 20)
	GUICtrlSetTip(-1, FileGetLongName($sFile), "File to add:", 1)
	GUICtrlSetFont(-1, 9, 800)
	GUICtrlSetColor(-1, 0x0000CC)

	$iChild = 1
	GUISetState(@SW_DISABLE, $hGui)
	GUISetState(@SW_SHOW, $hChild)

	Local $aMsg, $iState, $sType, $sName, $sLanguage, $iToLoad, $iCanGo

	While 1
		$aMsg = GUIGetMsg(1)
		If $aMsg[1] = $hChild Then
			Switch $aMsg[0]
				Case - 3, $hButtonCancel
					ExitLoop
				Case $hButtonAdd
					$sName = GUICtrlRead($hTypeInputName)
					Local $iResName = Number($sName)
					If $iResName < 1 Or $iResName > 65535 Then
						$iResName = $sName
					EndIf

					$sLanguage = GUICtrlRead($hTypeInputLanguage)
					Local $iResLang
					If $sLanguage = "0 - Neutral" Then
						$iResLang = 0
					Else
						$iResLang = Number(StringLeft($sLanguage, 5))
					EndIf

					If $iState Then
						Local $sResType = GUICtrlRead($hTypeInput)
						If $sResType Then
							Local $sType = Number($sResType)
							If $sType < 1 Then
								$sType = $sResType
							EndIf
							Switch $sType
								Case 1 To 24
									MsgBox(48, "Resource type error", "Numbers from 1 to 24 are predefined values and not allowed to be used.", 0, $hChild)
									GUICtrlSetState($hTypeInput, 256)
								Case Else
									If $iResName Then
										If StringLeft($iResName, 1) = "#" Then
											MsgBox(48, "Resource name error", "Name cannot start with '#'", 0, $hChild)
											GUICtrlSetState($hTypeInputName, 256)
										Else
											$iToLoad = 1
											ExitLoop
										EndIf
									Else
										MsgBox(48, "Resource name error", "Name field is empty. This value is required.", 0, $hChild)
										GUICtrlSetState($hTypeInputName, 256)
									EndIf
							EndSwitch
						Else
							MsgBox(48, "Resource type error", "Type field is empty. This value is required.", 0, $hChild)
							GUICtrlSetState($hTypeInput, 256)
						EndIf
					Else
						$sType = Number(StringLeft(GUICtrlRead($hTypeInputCombo), 2))
						$iCanGo = 1
						Switch $sType
							Case $RT_RCDATA
								For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
									If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_RCDATA Then
										For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
											If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
												MsgBox(48, "Resource name error", "Resource with that name already exists. Choose another name.", 0, $hChild)
												GUICtrlSetState($hTypeInputName, 256)
												$iCanGo = 0
												ExitLoop 2
											EndIf
										Next
									EndIf
								Next
							Case $RT_GROUP_CURSOR
								For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
									If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_ANICURSOR Then
										For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
											If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
												MsgBox(48, "Resource name error", "Cursor (animated) with that name already exists. Choose another name.", 0, $hChild)
												GUICtrlSetState($hTypeInputName, 256)
												$iCanGo = 0
												ExitLoop 2
											EndIf
										Next
									EndIf
									If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_GROUP_CURSOR Then
										For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
											If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
												MsgBox(48, "Resource name error", "Cursor with that name already exists. Choose another name.", 0, $hChild)
												GUICtrlSetState($hTypeInputName, 256)
												$iCanGo = 0
												ExitLoop 2
											EndIf
										Next
									EndIf
								Next
							Case $RT_GROUP_ICON
								For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
									If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_ANIICON Then
										For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
											If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
												MsgBox(48, "Resource name error", "Icon (animated) with that name already exists. Choose another name.", 0, $hChild)
												GUICtrlSetState($hTypeInputName, 256)
												$iCanGo = 0
												ExitLoop 2
											EndIf
										Next
									EndIf
									If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_GROUP_ICON Then
										For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
											If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
												MsgBox(48, "Resource name error", "Icon with that name already exists. Choose another name.", 0, $hChild)
												GUICtrlSetState($hTypeInputName, 256)
												$iCanGo = 0
												ExitLoop 2
											EndIf
										Next
									EndIf
								Next
							Case $RT_ANICURSOR
								For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
									If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_ANICURSOR Then
										For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
											If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
												MsgBox(48, "Resource name error", "Animated cursor with that name already exists. Choose another name.", 0, $hChild)
												GUICtrlSetState($hTypeInputName, 256)
												$iCanGo = 0
												ExitLoop 2
											EndIf
										Next
									EndIf
									If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_GROUP_CURSOR Then
										For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
											If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
												MsgBox(48, "Resource name error", "Animated cursor is cursor." & @CRLF & "Cursor with that name already exists. Choose another name.", 0, $hChild)
												GUICtrlSetState($hTypeInputName, 256)
												$iCanGo = 0
												ExitLoop 2
											EndIf
										Next
									EndIf
								Next
							Case $RT_ANIICON
								For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
									If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_ANIICON Then
										For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
											If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
												MsgBox(48, "Resource name error", "Animated icon with that name already exists. Choose another name.", 0, $hChild)
												GUICtrlSetState($hTypeInputName, 256)
												$iCanGo = 0
												ExitLoop 2
											EndIf
										Next
									EndIf
									If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_GROUP_ICON Then
										For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
											If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
												MsgBox(48, "Resource name error", "Animated icon is icon." & @CRLF & "Icon with that name already exists. Choose another name.", 0, $hChild)
												GUICtrlSetState($hTypeInputName, 256)
												$iCanGo = 0
												ExitLoop 2
											EndIf
										Next
									EndIf
								Next
							Case $RT_BITMAP
								For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
									If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_BITMAP Then
										For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
											If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
												MsgBox(48, "Resource name error", "Bitmap with that name already exists. Choose another name.", 0, $hChild)
												GUICtrlSetState($hTypeInputName, 256)
												$iCanGo = 0
												ExitLoop 2
											EndIf
										Next
									EndIf
								Next
							Case $RT_HTML
								For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
									If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_HTML Then
										For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
											If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
												MsgBox(48, "Resource name error", "HTML resource with that name already exists. Choose another name.", 0, $hChild)
												GUICtrlSetState($hTypeInputName, 256)
												$iCanGo = 0
												ExitLoop 2
											EndIf
										Next
									EndIf
								Next
							Case $RT_MANIFEST
								For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
									If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_RCDATA Then
										For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
											If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
												MsgBox(48, "Resource name error", "Manifest with that name already exists. Choose another name.", 0, $hChild)
												GUICtrlSetState($hTypeInputName, 256)
												$iCanGo = 0
												ExitLoop 2
											EndIf
										Next
									EndIf
								Next
							Case False
								$sType = GUICtrlRead($hTypeInputCombo)
								If $sType == "AVI" Then
									For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
										If $ARRAY_MODULE_STRUCTURE[$m][0][0] == "AVI" Then
											For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
												If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
													MsgBox(48, "Resource name error", "AVI resource with that name already exists. Choose another name.", 0, $hChild)
													GUICtrlSetState($hTypeInputName, 256)
													$iCanGo = 0
													ExitLoop 2
												EndIf
											Next
										EndIf
									Next
								ElseIf $sType == "WAV" Then
									For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
										If $ARRAY_MODULE_STRUCTURE[$m][0][0] == "WAV" Then
											For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
												If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
													MsgBox(48, "Resource name error", "WAV resource with that name already exists. Choose another name.", 0, $hChild)
													GUICtrlSetState($hTypeInputName, 256)
													$iCanGo = 0
													ExitLoop 2
												EndIf
											Next
										EndIf
									Next
								ElseIf $sType == "PNG" Then
									For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
										If $ARRAY_MODULE_STRUCTURE[$m][0][0] == "PNG" Then
											For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
												If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
													MsgBox(48, "Resource name error", "PNG resource with that name already exists. Choose another name.", 0, $hChild)
													GUICtrlSetState($hTypeInputName, 256)
													$iCanGo = 0
													ExitLoop 2
												EndIf
											Next
										EndIf
									Next
								ElseIf $sType == "JPEG" Then
									For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
										If $ARRAY_MODULE_STRUCTURE[$m][0][0] == "JPEG" Then
											For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
												If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
													MsgBox(48, "Resource name error", "JPEG resource with that name already exists. Choose another name.", 0, $hChild)
													GUICtrlSetState($hTypeInputName, 256)
													$iCanGo = 0
													ExitLoop 2
												EndIf
											Next
										EndIf
									Next
								ElseIf $sType == "GIF" Then
									For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
										If $ARRAY_MODULE_STRUCTURE[$m][0][0] == "GIF" Then
											For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
												If $iResName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
													MsgBox(48, "Resource name error", "GIF resource with that name already exists. Choose another name.", 0, $hChild)
													GUICtrlSetState($hTypeInputName, 256)
													$iCanGo = 0
													ExitLoop 2
												EndIf
											Next
										EndIf
									Next
								EndIf
						EndSwitch

						If $iCanGo Then
							If $iResName Then
								If StringLeft($iResName, 1) = "#" Then
									MsgBox(48, "Resource name error", "Name cannot start with '#'", 0, $hChild)
									GUICtrlSetState($hTypeInputName, 256)
								Else
									$iToLoad = 1
									ExitLoop
								EndIf
							Else
								MsgBox(48, "Resource name error", "Name field is empty. This value is required.", 0, $hChild)
								GUICtrlSetState($hTypeInputName, 256)
							EndIf
						EndIf
					EndIf
			EndSwitch
		EndIf

		If GUICtrlRead($hCheckBox) = 1 Then
			If $iState Then
				$iState = 0
				GUICtrlSetState($hTypeInput, 32)
				GUICtrlSetState($hTypeInputCombo, 16)
			EndIf
		Else
			If Not $iState Then
				$iState = 1
				GUICtrlSetState($hTypeInputCombo, 32)
				GUICtrlSetState($hTypeInput, 16)
			EndIf
		EndIf
	WEnd

	GUISetState(@SW_ENABLE, $hGui)
	GUIDelete($hChild)
	$iChild = 0

	If $iToLoad Then
		If _ResUpdate($sRawDLL, $sType, $iResName, $iResLang, $sFile) Then
			Return SetError(0, 0, 1)
		EndIf
	EndIf

	Return SetError(@error, 0, "")

EndFunc   ;==>_ProcessFile


Func _ResUpdate($sModule, $iResType, $iResName, $iResLang, $sResFile, $lParam = 0)

	If Not FileExists($sModule) Then
		Return SetError(100, 0, "") ; what happened???
	EndIf

	Local $hFile = FileOpen($sModule, 1)
	If $hFile = -1 Then
		Return SetError(101, 0, "") ; cannot obtain writing rights
	EndIf

	FileClose($hFile)

	Switch $iResType

		Case $RT_GROUP_CURSOR

			Local $tBinary = DllStructCreate("byte[" & FileGetSize($sResFile) & "]")
			Local $hResFile = FileOpen($sResFile, 16)
			DllStructSetData($tBinary, 1, FileRead($hResFile))
			FileClose($hResFile)

			If @error Then
				Return SetError(5, 0, "")
			EndIf

			Local $tResource = DllStructCreate("align 2;ushort;" & _
					"ushort Type;" & _
					"ushort ImageCount;" & _
					"ubyte Width;" & _
					"ubyte Height;" & _
					"ubyte ColorCount;" & _
					"byte;" & _
					"ushort Xhotspot;" & _
					"ushort Yhotspot;" & _
					"dword BitmapSize;" & _
					"dword BitmapOffset;" & _
					"byte Body[" & DllStructGetSize($tBinary) - 22 & "]", _
					DllStructGetPtr($tBinary))

			Local $tBitmap = DllStructCreate("dword HeaderSize", DllStructGetPtr($tResource, "Body"))

			Local $iHeaderSize = DllStructGetData($tBitmap, "HeaderSize")

			Switch $iHeaderSize
				Case 40
					$tBitmap = DllStructCreate("dword HeaderSize;" & _
							"dword Width;" & _
							"dword Height;" & _
							"ushort Planes;" & _
							"ushort BitPerPixel;" & _
							"dword CompressionMethod;" & _
							"dword Size;" & _
							"dword Hresolution;" & _
							"dword Vresolution;" & _
							"dword Colors;" & _
							"dword ImportantColors;", _
							DllStructGetPtr($tResource, "Body"))
				Case 12
					$tBitmap = DllStructCreate("dword HeaderSize;" & _
							"ushort Width;" & _
							"ushort Height;" & _
							"ushort Planes;" & _
							"ushort BitPerPixel;", _
							DllStructGetPtr($tResource, "Body"))
				Case Else
					Return SetError(6, 0, "")
			EndSwitch

			Local $tCursorWrite = DllStructCreate("ushort Xhotspot;" & _
					"ushort Yhotspot;" & _
					"byte Body[" & DllStructGetSize($tResource) - 22 & "]", _
					DllStructGetPtr($tResource) + DllStructGetData($tResource, "BitmapOffset") - 4)

			DllStructSetData($tCursorWrite, "Xhotspot", DllStructGetData($tResource, "Xhotspot"))
			DllStructSetData($tCursorWrite, "Yhotspot", DllStructGetData($tResource, "Xhotspot"))

			Local $a_hCall = DllCall("kernel32.dll", "hwnd", "BeginUpdateResourceW", "wstr", $sModule, "int", 0)

			If @error Or Not $a_hCall[0] Then
				Return SetError(7, 0, "")
			EndIf

			Local $iCurName = 1
			For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
				If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_CURSOR Then
					For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
						If $iCurName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
							$iCurName += 1
						EndIf
					Next
					ExitLoop
				EndIf
			Next

			Local $a_iCall = DllCall("kernel32.dll", "int", "UpdateResource", _
					"hwnd", $a_hCall[0], _
					"int", $RT_CURSOR, _
					"int", $iCurName, _
					"int", $iResLang, _
					"ptr", DllStructGetPtr($tCursorWrite), _
					"dword", DllStructGetSize($tCursorWrite))

			If @error Or Not $a_iCall[0] Then
				DllCall("kernel32.dll", "int", "EndUpdateResource", "hwnd", $a_hCall[0], "int", 0)
				Return SetError(8, 0, "")
			EndIf

			Local $tCursorGroupWrite = DllStructCreate("ushort;" & _
					"ushort Type;" & _
					"ushort ImageCount;" & _
					"ushort Width;" & _
					"ushort Height;" & _
					"ushort Planes;" & _
					"ushort BitPerPixel;" & _
					"ushort;" & _
					"ushort;" & _
					"ushort OrdinalName")

			DllStructSetData($tCursorGroupWrite, 1, DllStructGetData($tResource, 1))
			DllStructSetData($tCursorGroupWrite, "Type", DllStructGetData($tResource, "Type"))
			DllStructSetData($tCursorGroupWrite, "ImageCount", DllStructGetData($tResource, "ImageCount"))

			DllStructSetData($tCursorGroupWrite, "Width", DllStructGetData($tBitmap, "Width"))
			DllStructSetData($tCursorGroupWrite, "Height", DllStructGetData($tBitmap, "Height"))

			DllStructSetData($tCursorGroupWrite, "Planes", DllStructGetData($tBitmap, "Planes"))
			DllStructSetData($tCursorGroupWrite, "BitPerPixel", DllStructGetData($tBitmap, "BitPerPixel"))

			DllStructSetData($tCursorGroupWrite, 8, 308)

			DllStructSetData($tCursorGroupWrite, "OrdinalName", $iCurName)

			Switch IsNumber($iResName)
				Case True
					$a_iCall = DllCall("kernel32.dll", "int", "UpdateResource", _
							"hwnd", $a_hCall[0], _
							"int", $RT_GROUP_CURSOR, _
							"int", $iResName, _
							"int", $iResLang, _
							"ptr", DllStructGetPtr($tCursorGroupWrite), _
							"dword", DllStructGetSize($tCursorGroupWrite))
				Case Else
					$a_iCall = DllCall("kernel32.dll", "int", "UpdateResourceW", _
							"hwnd", $a_hCall[0], _
							"int", $RT_GROUP_CURSOR, _
							"wstr", StringUpper($iResName), _
							"int", $iResLang, _
							"ptr", DllStructGetPtr($tCursorGroupWrite), _
							"dword", DllStructGetSize($tCursorGroupWrite))
			EndSwitch

			If @error Or Not $a_iCall[0] Then
				DllCall("kernel32.dll", "int", "EndUpdateResource", "hwnd", $a_hCall[0], "int", 0)
				Return SetError(9, 0, "")
			EndIf

			$a_iCall = DllCall("kernel32.dll", "int", "EndUpdateResource", "hwnd", $a_hCall[0], "int", 0)

			If @error Or Not $a_iCall[0] Then
				Return SetError(10, 0, "")
			EndIf


		Case $RT_GROUP_ICON

			Local $tBinary = DllStructCreate("byte[" & FileGetSize($sResFile) & "]")
			Local $hResFile = FileOpen($sResFile, 16)
			DllStructSetData($tBinary, 1, FileRead($hResFile))
			FileClose($hResFile)

			Local $tResource = DllStructCreate("ushort;" & _
					"ushort Type;" & _
					"ushort ImageCount;" & _
					"byte Body[" & DllStructGetSize($tBinary) - 6 & "]", _
					DllStructGetPtr($tBinary))

			Local $iIconCount = DllStructGetData($tResource, "ImageCount")

			If Not $iIconCount Then
				Return SetError(5, 0, "")
			EndIf

			Local $tIconGroupHeader = DllStructCreate("ushort;" & _
					"ushort Type;" & _
					"ushort ImageCount;" & _
					"byte Body[" & $iIconCount * 14 & "]")

			DllStructSetData($tIconGroupHeader, 1, DllStructGetData($tResource, 1))
			DllStructSetData($tIconGroupHeader, "Type", DllStructGetData($tResource, "Type"))
			DllStructSetData($tIconGroupHeader, "ImageCount", DllStructGetData($tResource, "ImageCount"))

			Local $tInputIconHeader
			Local $tGroupIconData

			Local $a_hCall = DllCall("kernel32.dll", "hwnd", "BeginUpdateResourceW", "wstr", $sModule, "int", 0)

			If @error Or Not $a_hCall[0] Then
				Return SetError(6, 0, "")
			EndIf

			Local $iEnumIconName

			For $i = 1 To $iIconCount

				$tInputIconHeader = DllStructCreate("ubyte Width;" & _
						"ubyte Height;" & _
						"ubyte Colors;" & _
						"ubyte;" & _
						"ushort Planes;" & _
						"ushort BitPerPixel;" & _
						"dword BitmapSize;" & _
						"dword BitmapOffset", _
						DllStructGetPtr($tResource, "Body") + ($i - 1) * 16)

				$tGroupIconData = DllStructCreate("ubyte Width;" & _
						"ubyte Height;" & _
						"ubyte Colors;" & _
						"ubyte;" & _
						"ushort Planes;" & _
						"ushort BitPerPixel;" & _
						"dword BitmapSize;" & _
						"ushort OrdinalName;", _
						DllStructGetPtr($tIconGroupHeader, "Body") + ($i - 1) * 14)

				DllStructSetData($tGroupIconData, "Width", DllStructGetData($tInputIconHeader, "Width"))
				DllStructSetData($tGroupIconData, "Height", DllStructGetData($tInputIconHeader, "Height"))
				DllStructSetData($tGroupIconData, "Colors", DllStructGetData($tInputIconHeader, "Colors"))
				DllStructSetData($tGroupIconData, 4, DllStructGetData($tInputIconHeader, 4))
				DllStructSetData($tGroupIconData, "Planes", DllStructGetData($tInputIconHeader, "Planes"))
				DllStructSetData($tGroupIconData, "BitPerPixel", DllStructGetData($tInputIconHeader, "BitPerPixel"))
				DllStructSetData($tGroupIconData, "BitmapSize", DllStructGetData($tInputIconHeader, "BitmapSize"))

				$iEnumIconName += 1
				For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
					If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_ICON Then
						For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
							If $iEnumIconName = $ARRAY_MODULE_STRUCTURE[$m][$n][0] Then
								$iEnumIconName += 1
							EndIf
						Next
						ExitLoop
					EndIf
				Next

				DllStructSetData($tGroupIconData, "OrdinalName", $iEnumIconName)

				Local $a_iCall = DllCall("kernel32.dll", "int", "UpdateResource", _
						"hwnd", $a_hCall[0], _
						"int", $RT_ICON, _
						"int", $iEnumIconName, _
						"int", $iResLang, _
						"ptr", DllStructGetPtr($tResource) + DllStructGetData($tInputIconHeader, "BitmapOffset"), _
						"dword", DllStructGetData($tInputIconHeader, "BitmapSize"))

				If @error Or Not $a_iCall[0] Then
					DllCall("kernel32.dll", "int", "EndUpdateResource", "hwnd", $a_hCall[0], "int", 0)
					Return SetError(7, $iEnumIconName, "")
				EndIf

			Next

			Switch IsNumber($iResName)
				Case True
					$a_iCall = DllCall("kernel32.dll", "int", "UpdateResource", _
							"hwnd", $a_hCall[0], _
							"int", $RT_GROUP_ICON, _
							"int", $iResName, _
							"int", $iResLang, _
							"ptr", DllStructGetPtr($tIconGroupHeader), _
							"dword", DllStructGetSize($tIconGroupHeader))
				Case Else
					$a_iCall = DllCall("kernel32.dll", "int", "UpdateResourceW", _
							"hwnd", $a_hCall[0], _
							"int", $RT_GROUP_ICON, _
							"wstr", StringUpper($iResName), _
							"int", $iResLang, _
							"ptr", DllStructGetPtr($tIconGroupHeader), _
							"dword", DllStructGetSize($tIconGroupHeader))
			EndSwitch

			If @error Or Not $a_iCall[0] Then
				DllCall("kernel32.dll", "int", "EndUpdateResource", "hwnd", $a_hCall[0], "int", 0)
				Return SetError(8, 0, "")
			EndIf

			$a_iCall = DllCall("kernel32.dll", "int", "EndUpdateResource", "hwnd", $a_hCall[0], "int", 0)

			If @error Or Not $a_iCall[0] Then
				Return SetError(9, 0, "")
			EndIf


		Case $RT_RCDATA, $RT_MANIFEST, $RT_ANICURSOR, $RT_ANIICON, $RT_HTML

			Local $tResource = DllStructCreate("byte[" & FileGetSize($sResFile) & "]")
			Local $hResFile = FileOpen($sResFile, 16)
			DllStructSetData($tResource, 1, FileRead($hResFile))
			FileClose($hResFile)

			If @error Then
				Return SetError(5, 0, "")
			EndIf

			Local $a_hCall = DllCall("kernel32.dll", "hwnd", "BeginUpdateResourceW", "wstr", $sModule, "int", 0)

			If @error Or Not $a_hCall[0] Then
				Return SetError(6, 0, "")
			EndIf

			Switch IsNumber($iResName)
				Case True
					Local $a_iCall = DllCall("kernel32.dll", "int", "UpdateResource", _
							"hwnd", $a_hCall[0], _
							"int", $iResType, _
							"int", $iResName, _
							"int", $iResLang, _
							"ptr", DllStructGetPtr($tResource), _
							"dword", FileGetSize($sResFile))
				Case Else
					Local $a_iCall = DllCall("kernel32.dll", "int", "UpdateResourceW", _
							"hwnd", $a_hCall[0], _
							"int", $iResType, _
							"wstr", StringUpper($iResName), _
							"int", $iResLang, _
							"ptr", DllStructGetPtr($tResource), _
							"dword", FileGetSize($sResFile))
			EndSwitch

			If @error Or Not $a_iCall[0] Then
				DllCall("kernel32.dll", "int", "EndUpdateResource", "hwnd", $a_hCall[0], "int", 0)
				Return SetError(7, 0, "")
			EndIf

			$a_iCall = DllCall("kernel32.dll", "int", "EndUpdateResource", "hwnd", $a_hCall[0], "int", 0)

			If @error Or Not $a_iCall[0] Then
				Return SetError(8, 0, "")
			EndIf

		Case $RT_BITMAP

			Local $tBinary = DllStructCreate("byte[" & FileGetSize($sResFile) & "]")
			Local $hResFile = FileOpen($sResFile, 16)
			DllStructSetData($tBinary, 1, FileRead($hResFile))
			FileClose($hResFile)

			Local $tResource = DllStructCreate("align 2;char Identifier[2];" & _
					"dword BitmapSize;" & _
					"short;" & _
					"short;" & _
					"dword BitmapOffset;" & _
					"byte Body[" & DllStructGetSize($tBinary) - 14 & "]", _
					DllStructGetPtr($tBinary))

			If Not (DllStructGetData($tResource, 1) == "BM") Then
				Return SetError(5, 0, "")
			EndIf

			Local $a_hCall = DllCall("kernel32.dll", "hwnd", "BeginUpdateResourceW", "wstr", $sModule, "int", 0)

			If @error Or Not $a_hCall[0] Then
				Return SetError(6, 0, "")
			EndIf

			Switch IsNumber($iResName)
				Case True
					Local $a_iCall = DllCall("kernel32.dll", "int", "UpdateResource", _
							"hwnd", $a_hCall[0], _
							"int", $iResType, _
							"int", $iResName, _
							"int", $iResLang, _
							"ptr", DllStructGetPtr($tResource, "Body"), _
							"dword", FileGetSize($sResFile) - 14)
				Case Else
					Local $a_iCall = DllCall("kernel32.dll", "int", "UpdateResourceW", _
							"hwnd", $a_hCall[0], _
							"int", $iResType, _
							"wstr", StringUpper($iResName), _
							"int", $iResLang, _
							"ptr", DllStructGetPtr($tResource, "Body"), _
							"dword", FileGetSize($sResFile) - 14)
			EndSwitch

			If @error Or Not $a_iCall[0] Then
				DllCall("kernel32.dll", "int", "EndUpdateResource", "hwnd", $a_hCall[0], "int", 0)
				Return SetError(7, 0, "")
			EndIf

			$a_iCall = DllCall("kernel32.dll", "int", "EndUpdateResource", "hwnd", $a_hCall[0], "int", 0)

			If @error Or Not $a_iCall[0] Then
				Return SetError(8, 0, "")
			EndIf


		Case Else

			Local $tResource = DllStructCreate("byte[" & FileGetSize($sResFile) & "]")
			Local $hResFile = FileOpen($sResFile, 16)
			DllStructSetData($tResource, 1, FileRead($hResFile))
			FileClose($hResFile)

			If @error Then
				Return SetError(5, 0, "")
			EndIf

			Local $a_hCall = DllCall("kernel32.dll", "hwnd", "BeginUpdateResourceW", "wstr", $sModule, "int", 0)

			If @error Or Not $a_hCall[0] Then
				Return SetError(6, 0, "")
			EndIf

			Switch IsNumber($iResType) + 2 * IsNumber($iResName)
				Case 0
					Local $a_iCall = DllCall("kernel32.dll", "int", "UpdateResourceW", _
							"hwnd", $a_hCall[0], _
							"wstr", StringUpper($iResType), _
							"wstr", StringUpper($iResName), _
							"int", $iResLang, _
							"ptr", DllStructGetPtr($tResource), _
							"dword", FileGetSize($sResFile))
				Case 1
					Local $a_iCall = DllCall("kernel32.dll", "int", "UpdateResourceW", _
							"hwnd", $a_hCall[0], _
							"int", $iResType, _
							"wstr", StringUpper($iResName), _
							"int", $iResLang, _
							"ptr", DllStructGetPtr($tResource), _
							"dword", FileGetSize($sResFile))
				Case 2
					Local $a_iCall = DllCall("kernel32.dll", "int", "UpdateResourceW", _
							"hwnd", $a_hCall[0], _
							"wstr", StringUpper($iResType), _
							"int", $iResName, _
							"int", $iResLang, _
							"ptr", DllStructGetPtr($tResource), _
							"dword", FileGetSize($sResFile))
				Case 3
					Local $a_iCall = DllCall("kernel32.dll", "int", "UpdateResource", _
							"hwnd", $a_hCall[0], _
							"int", $iResType, _
							"int", $iResName, _
							"int", $iResLang, _
							"ptr", DllStructGetPtr($tResource), _
							"dword", FileGetSize($sResFile))
			EndSwitch

			If @error Or Not $a_iCall[0] Then
				DllCall("kernel32.dll", "int", "EndUpdateResource", "hwnd", $a_hCall[0], "int", 0)
				Return SetError(7, 0, "")
			EndIf

			$a_iCall = DllCall("kernel32.dll", "int", "EndUpdateResource", "hwnd", $a_hCall[0], "int", 0)

			If @error Or Not $a_iCall[0] Then
				Return SetError(8, 0, "")
			EndIf

	EndSwitch

	Return SetError(0, 0, 1) ; all done

EndFunc   ;==>_ResUpdate


Func _DeleteSelected($iSelected, $aArray)

	Local $aArrayIndexes
	For $i = 0 To UBound($aArray) - 1
		If $aArray[$i][0] = $iSelected Then
			$aArrayIndexes = StringSplit($aArray[$i][1], ":")
			ExitLoop
		EndIf
	Next

	If Not UBound($aArrayIndexes) = 4 Then
		Return SetError(1, 0, "")
	EndIf

	Local $sTitle = "Delete Resource"
	Local $sText = "Selected resource will be permanently deleted." & @CRLF & "Are you sure you want to proceed?"
	Local $sIdentifier = "{3E5305D5-3368-4DB3-A741-6CEFFD6691F5}"
	Local $iDefault = 1

	Switch _MessageBoxCheck(33, $sTitle, $sText, $sIdentifier, $iDefault, $hGui)
		Case 0, 1
			_ResDelete($sFileLoaded, $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][0][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][0], $ARRAY_MODULE_STRUCTURE[$aArrayIndexes[1]][$aArrayIndexes[2]][$aArrayIndexes[3]])
			If @error Then
				Return SetError(@error, 0, 0)
			Else
				Return SetError(0, 0, 1)
			EndIf
	EndSwitch

	Return SetError(3, 0, 1)

EndFunc   ;==>_DeleteSelected


Func _ResDelete($sModule, $iResType, $iResName, $iResLang, $lParam = 0)

	If Not FileExists($sModule) Then
		Return SetError(100, 0, "") ; what happened???
	EndIf

	Local $hFile = FileOpen($sModule, 1)
	If $hFile = -1 Then
		Return SetError(101, 0, "") ; cannot obtain writing rights
	EndIf

	FileClose($hFile)

	Switch $iResType

		Case $RT_GROUP_ICON
			Local $bBinGroupIcon = _ResourceGetAsRaw($iResType, $iResName, $iResLang, $sModule, 1)
			Local $tGroupIcon = DllStructCreate("byte[" & BinaryLen($bBinGroupIcon) & "]")
			DllStructSetData($tGroupIcon, 1, $bBinGroupIcon)

			Local $tEnumGroupIcon = DllStructCreate("ushort;" & _
					"ushort Type;" & _
					"ushort ResCount;" & _
					"byte Body[" & BinaryLen($bBinGroupIcon) - 6 & "]", _
					DllStructGetPtr($tGroupIcon))

		Case $RT_GROUP_CURSOR
			Local $bBinGroupCursor = _ResourceGetAsRaw($iResType, $iResName, $iResLang, $sModule, 1)

		Case $RT_ICON
			If Not $lParam Then ; currently not available, will return
				Return SetError(0, 0, 1) ;  <------'
				For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
					If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_GROUP_ICON Then
						Local $bBinGroupIcon, $iResCount
						Local $tGroupIcon
						Local $tHeaderGroupIcon
						For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
							$bBinGroupIcon = _ResourceGetAsRaw($RT_GROUP_ICON, $ARRAY_MODULE_STRUCTURE[$m][$n][0], $iResLang, $sModule, 1)
							$tGroupIcon = DllStructCreate("byte[" & BinaryLen($bBinGroupIcon) & "]")
							DllStructSetData($tGroupIcon, 1, $bBinGroupIcon)
							$tHeaderGroupIcon = DllStructCreate("ushort;" & _
									"ushort Type;" & _
									"ushort ResCount;" & _
									"byte Body[" & BinaryLen($bBinGroupIcon) - 6 & "]", _
									DllStructGetPtr($tGroupIcon))

							$iResCount = DllStructGetData($tHeaderGroupIcon, "ResCount")

							If $iResCount < 2 Then
								_ResDelete($sModule, $RT_GROUP_ICON, $ARRAY_MODULE_STRUCTURE[$m][$n][0], $iResLang)
								If @error Then
									Return SetError(@error, 0, "")
								EndIf
								Return SetError(0, 0, 1)
							EndIf
						Next
					EndIf
				Next
			EndIf

		Case $RT_CURSOR
			If Not $lParam Then
				For $m = 0 To UBound($ARRAY_MODULE_STRUCTURE, 1) - 1
					If $ARRAY_MODULE_STRUCTURE[$m][0][0] = $RT_GROUP_CURSOR Then
						Local $bGroupCursor

						For $n = 1 To UBound($ARRAY_MODULE_STRUCTURE, 2) - 1
							$bGroupCursor = _ResourceGetAsRaw($RT_GROUP_CURSOR, $ARRAY_MODULE_STRUCTURE[$m][$n][0], $iResLang, $sModule, 1)

							If $iResName = _LittleEndianBinaryToInt(BinaryMid($bGroupCursor, 19, 2)) Then
								_ResDelete($sModule, $RT_GROUP_CURSOR, $ARRAY_MODULE_STRUCTURE[$m][$n][0], $iResLang)
								If @error Then
									Return SetError(@error, 0, "")
								EndIf
							EndIf

						Next

					EndIf
				Next
				Return SetError(0, 0, 1)
			EndIf

	EndSwitch

	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "BeginUpdateResourceW", "wstr", $sModule, "int", 0)

	If @error Or Not $a_hCall[0] Then
		Return SetError(1, 0, "")
	EndIf

	Local $a_iCall
	Switch IsNumber($iResType) + 2 * IsNumber($iResName)
		Case 0
			Local $a_iCall = DllCall("kernel32.dll", "int", "UpdateResourceW", _
					"hwnd", $a_hCall[0], _
					"wstr", $iResType, _
					"wstr", $iResName, _
					"int", $iResLang, _
					"ptr", 0, _
					"dword", 0)
		Case 1
			Local $a_iCall = DllCall("kernel32.dll", "int", "UpdateResourceW", _
					"hwnd", $a_hCall[0], _
					"int", $iResType, _
					"wstr", $iResName, _
					"int", $iResLang, _
					"ptr", 0, _
					"dword", 0)
		Case 2
			Local $a_iCall = DllCall("kernel32.dll", "int", "UpdateResourceW", _
					"hwnd", $a_hCall[0], _
					"wstr", $iResType, _
					"int", $iResName, _
					"int", $iResLang, _
					"ptr", 0, _
					"dword", 0)
		Case 3
			Local $a_iCall = DllCall("kernel32.dll", "int", "UpdateResource", _
					"hwnd", $a_hCall[0], _
					"int", $iResType, _
					"int", $iResName, _
					"int", $iResLang, _
					"ptr", 0, _
					"dword", 0)
	EndSwitch

	If @error Or Not $a_iCall[0] Then
		DllCall("kernel32.dll", "int", "EndUpdateResource", "hwnd", $a_hCall[0], "int", 0)
		Return SetError(2, 0, "")
	EndIf

	$a_iCall = DllCall("kernel32.dll", "int", "EndUpdateResource", "hwnd", $a_hCall[0], "int", 0)

	If @error Or Not $a_iCall[0] Then
		Return SetError(3, 0, "")
	EndIf

	Switch $iResType
		Case $RT_GROUP_ICON
			Local $iIconName
			For $i = 1 To DllStructGetData($tEnumGroupIcon, "ResCount")
				$iIconName = _LittleEndianBinaryToInt(BinaryMid(DllStructGetData($tEnumGroupIcon, "Body"), (14 * $i) - 1, 2))
				If $iIconName Then
					_ResDelete($sModule, $RT_ICON, $iIconName, $iResLang, 1)
				EndIf
			Next
		Case $RT_GROUP_CURSOR
			_ResDelete($sModule, $RT_CURSOR, _LittleEndianBinaryToInt(BinaryMid($bBinGroupCursor, 19, 2)), $iResLang, 1)
			If @error Then
				Return SetError(@error, 0, "")
			EndIf
	EndSwitch

	Return SetError(0, 0, 1)

EndFunc   ;==>_ResDelete


Func _CreateHBitmapFromBinaryImage($bBinary, ByRef $iWidth, ByRef $iHeight) ; ProgAndy's originally

	Local $tBinary = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
	DllStructSetData($tBinary, 1, $bBinary)

	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "GlobalAlloc", _  ;  local version will work too (no difference in local and global heap)
			"dword", 2, _  ; LMEM_MOVEABLE
			"dword", DllStructGetSize($tBinary))

	If @error Or Not $a_hCall[0] Then
		Return SetError(1, 0, "")
	EndIf

	Local $hMemory = $a_hCall[0]

	Local $a_pCall = DllCall("kernel32.dll", "ptr", "GlobalLock", "hwnd", $hMemory)

	If @error Or Not $a_pCall[0] Then
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(2, 0, "")
	EndIf

	Local $pMemory = $a_pCall[0]

	DllCall("kernel32.dll", "none", "RtlMoveMemory", _
			"ptr", $pMemory, _
			"ptr", DllStructGetPtr($tBinary), _
			"dword", DllStructGetSize($tBinary))

	DllCall("kernel32.dll", "int", "GlobalUnlock", "hwnd", $hMemory)

	$a_pCall = DllCall("ole32.dll", "int", "CreateStreamOnHGlobal", _
			"ptr", $pMemory, _
			"int", 1, _
			"ptr*", 0)

	If @error Or $a_pCall[0] Then
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(3, 0, "")
	EndIf

	Local $pStream = $a_pCall[3]

	Local $tGdiplusStartupInput = DllStructCreate("dword GdiplusVersion;" & _
			"ptr DebugEventCallback;" & _
			"int SuppressBackgroundThread;" & _
			"int SuppressExternalCodecs")

	DllStructSetData($tGdiplusStartupInput, "GdiplusVersion", 1)

	Local $a_iCall = DllCall("gdiplus.dll", "dword", "GdiplusStartup", _
			"dword*", 0, _
			"ptr", DllStructGetPtr($tGdiplusStartupInput), _
			"ptr", 0)

	If @error Or $a_iCall[0] Then
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(4, 0, "")
	EndIf

	Local $hGDIplus = $a_iCall[1]

	$a_iCall = DllCall("gdiplus.dll", "dword", "GdipCreateBitmapFromStream", _ ; GdipLoadImageFromStream
			"ptr", $pStream, _
			"ptr*", 0)

	If @error Or $a_pCall[0] Then
		DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(5, 0, "")
	EndIf

	Local $pBitmap = $a_iCall[2]

	$a_iCall = DllCall("gdiplus.dll", "dword", "GdipGetImageDimension", _
			"ptr", $pBitmap, _
			"float*", 0, _
			"float*", 0)

	If @error Or $a_pCall[0] Then
		DllCall("gdiplus.dll", "dword", "GdipDisposeImage", "ptr", $pBitmap)
		DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(5, 0, "")
	EndIf

	$iWidth = $a_iCall[2]
	$iHeight = $a_iCall[3]

	$a_iCall = DllCall("gdiplus.dll", "dword", "GdipCreateHBITMAPFromBitmap", _
			"ptr", $pBitmap, _
			"hwnd*", 0, _
			"dword", 0xFF000000)

	If @error Or $a_iCall[0] Then
		DllCall("gdiplus.dll", "dword", "GdipDisposeImage", "ptr", $pBitmap)
		DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(8, 0, "")
	EndIf

	Local $hBitmap = $a_iCall[2]

	DllCall("gdiplus.dll", "dword", "GdipDisposeImage", "ptr", $pBitmap)
	DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
	DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)

	Return SetError(0, 0, $hBitmap)

EndFunc   ;==>_CreateHBitmapFromBinaryImage


Func _CreateArrayHBitmapsFromGIFBinaryImage($bBinary, ByRef $iWidth, ByRef $iHeight, ByRef $iTransparency) ; ProgAndy's originally

	Local $tBinary = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
	DllStructSetData($tBinary, 1, $bBinary)

	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "GlobalAlloc", _  ;  local version will work too (no difference in local and global heap)
			"dword", 2, _  ; LMEM_MOVEABLE
			"dword", DllStructGetSize($tBinary))

	If @error Or Not $a_hCall[0] Then
		Return SetError(1, 0, "")
	EndIf

	Local $hMemory = $a_hCall[0]

	Local $a_pCall = DllCall("kernel32.dll", "ptr", "GlobalLock", "hwnd", $hMemory)

	If @error Or Not $a_pCall[0] Then
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(2, 0, "")
	EndIf

	Local $pMemory = $a_pCall[0]

	DllCall("kernel32.dll", "none", "RtlMoveMemory", _
			"ptr", $pMemory, _
			"ptr", DllStructGetPtr($tBinary), _
			"dword", DllStructGetSize($tBinary))

	DllCall("kernel32.dll", "int", "GlobalUnlock", "hwnd", $hMemory)

	$a_pCall = DllCall("ole32.dll", "int", "CreateStreamOnHGlobal", _
			"ptr", $pMemory, _
			"int", 1, _
			"ptr*", 0)

	If @error Or $a_pCall[0] Then
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(3, 0, "")
	EndIf

	Local $pStream = $a_pCall[3]

	Local $tGdiplusStartupInput = DllStructCreate("dword GdiplusVersion;" & _
			"ptr DebugEventCallback;" & _
			"int SuppressBackgroundThread;" & _
			"int SuppressExternalCodecs")

	DllStructSetData($tGdiplusStartupInput, "GdiplusVersion", 1)

	Local $a_iCall = DllCall("gdiplus.dll", "dword", "GdiplusStartup", _
			"dword*", 0, _
			"ptr", DllStructGetPtr($tGdiplusStartupInput), _
			"ptr", 0)

	If @error Or $a_iCall[0] Then
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(4, 0, "")
	EndIf

	Local $hGDIplus = $a_iCall[1]

	$a_iCall = DllCall("gdiplus.dll", "dword", "GdipCreateBitmapFromStream", _ ; GdipLoadImageFromStream
			"ptr", $pStream, _
			"ptr*", 0)

	If @error Or $a_pCall[0] Then
		DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(5, 0, "")
	EndIf

	Local $pBitmap = $a_iCall[2]

	$a_iCall = DllCall("gdiplus.dll", "dword", "GdipGetImageDimension", _
			"ptr", $pBitmap, _
			"float*", 0, _
			"float*", 0)

	If @error Or $a_pCall[0] Then
		DllCall("gdiplus.dll", "dword", "GdipDisposeImage", "ptr", $pBitmap)
		DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(5, 0, "")
	EndIf

	$iWidth = $a_iCall[2]
	$iHeight = $a_iCall[3]

	Local $a_iCall = DllCall("gdiplus.dll", "dword", "GdipImageGetFrameDimensionsCount", _
			"ptr", $pBitmap, _
			"dword*", 0)

	If @error Or $a_iCall[0] Then
		DllCall("gdiplus.dll", "dword", "GdipDisposeImage", "ptr", $pBitmap)
		DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(8, 0, "")
	EndIf

	Local $iFrameDimensionsCount = $a_iCall[2]

	Local $tGUID = DllStructCreate("int;short;short;byte[8]")

	$a_iCall = DllCall("gdiplus.dll", "dword", "GdipImageGetFrameDimensionsList", _
			"ptr", $pBitmap, _
			"ptr", DllStructGetPtr($tGUID), _
			"dword", $iFrameDimensionsCount)

	If @error Or $a_iCall[0] Then
		DllCall("gdiplus.dll", "dword", "GdipDisposeImage", "ptr", $pBitmap)
		DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(9, 0, "")
	EndIf

	$a_iCall = DllCall("gdiplus.dll", "dword", "GdipImageGetFrameCount", _
			"ptr", $pBitmap, _
			"ptr", DllStructGetPtr($tGUID), _
			"dword*", 0)

	If @error Or $a_iCall[0] Then
		DllCall("gdiplus.dll", "dword", "GdipDisposeImage", "ptr", $pBitmap)
		DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(10, 0, "")
	EndIf

	Local $iFrameCount = $a_iCall[3]

	Local $aHBitmaps[$iFrameCount][3]

	For $j = 0 To $iFrameCount - 1

		$a_iCall = DllCall("gdiplus.dll", "dword", "GdipImageSelectActiveFrame", _
				"ptr", $pBitmap, _
				"ptr", DllStructGetPtr($tGUID), _
				"dword", $j)

		If @error Or $a_iCall[0] Then
			ContinueLoop
		EndIf

		$a_iCall = DllCall("gdiplus.dll", "dword", "GdipCreateHBITMAPFromBitmap", _
				"ptr", $pBitmap, _
				"hwnd*", 0, _
				"dword", 0xFF000000)

		If @error Or $a_iCall[0] Then
			ContinueLoop
		EndIf

		$aHBitmaps[$j][0] = $a_iCall[2]

	Next

	$a_iCall = DllCall("gdiplus.dll", "dword", "GdipGetPropertyItemSize", _
			"ptr", $pBitmap, _
			"dword", 20736, _ ; PropertyTagFrameDelay
			"dword*", 0)

	If @error Or $a_iCall[0] Then
		DllCall("gdiplus.dll", "dword", "GdipDisposeImage", "ptr", $pBitmap)
		DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(11, 0, "")
	EndIf

	Local $iPropertyItemSize = $a_iCall[3]

	Local $tRawPropItem = DllStructCreate("byte[" & $iPropertyItemSize & "]")

	$a_iCall = DllCall("gdiplus.dll", "dword", "GdipGetPropertyItem", _
			"ptr", $pBitmap, _
			"dword", 20736, _ ; PropertyTagFrameDelay
			"dword", DllStructGetSize($tRawPropItem), _
			"ptr", DllStructGetPtr($tRawPropItem))

	If @error Or $a_iCall[0] Then
		DllCall("gdiplus.dll", "dword", "GdipDisposeImage", "ptr", $pBitmap)
		DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(12, 0, "")
	EndIf

	Local $tPropItem = DllStructCreate("int Id;" & _
			"dword Length;" & _
			"ushort Type;" & _
			"ptr Value", _
			DllStructGetPtr($tRawPropItem))

	Local $iSize = DllStructGetData($tPropItem, "Length") / 4 ; 'Delay Time' is dword type

	Local $tPropertyData = DllStructCreate("dword[" & $iSize & "]", DllStructGetData($tPropItem, "Value"))

	For $j = 0 To $iFrameCount - 1
		$aHBitmaps[$j][1] = DllStructGetData($tPropertyData, 1, $j + 1) * 10 ; 1 = 10 msec
		$aHBitmaps[$j][2] = $aHBitmaps[$j][1] ; read values
		If Not $aHBitmaps[$j][1] Then
			$aHBitmaps[$j][1] = 130 ; 0 is interpreted as 130 ms
		EndIf
		If $aHBitmaps[$j][1] < 50 Then ; will slow it down to prevent more extensive cpu usage
			$aHBitmaps[$j][1] = 50
		EndIf
	Next

	$iTransparency = 1 ; predefining

	$a_iCall = DllCall("gdiplus.dll", "dword", "GdipBitmapGetPixel", _
			"ptr", $pBitmap, _
			"int", 0, _  ; left
			"int", 0, _  ; upper
			"dword*", 0)

	If @error Or $a_iCall[0] Then
		DllCall("gdiplus.dll", "dword", "GdipDisposeImage", "ptr", $pBitmap)
		DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
		DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
		Return SetError(13, 0, "")
	EndIf

	If $a_iCall[4] > 16777215 Then ; BitShift($a_iCall[4], 24)
		$iTransparency = 0
	EndIf

	DllCall("gdiplus.dll", "dword", "GdipDisposeImage", "ptr", $pBitmap)
	DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
	DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)

	Return SetError(0, 0, $aHBitmaps)

EndFunc   ;==>_CreateArrayHBitmapsFromGIFBinaryImage


Func _MessageBoxCheck($iFlag, $sTitle, $sText, $sIdentifier, $iDefault, $hWnd, $iTimeout = 0)

	Local $a_iCall = DllCall("shlwapi.dll", "int", "SHMessageBoxCheckW", _
			"hwnd", $hWnd, _
			"wstr", $sText, _
			"wstr", $sTitle, _
			"dword", $iFlag, _
			"int", $iDefault, _
			"wstr", $sIdentifier)

	If @error Or $a_iCall[0] = -1 Then
		Return SetError(1, 0, MsgBox($iFlag, $sTitle, $sText, $iTimeout, $hWnd))
	EndIf

	Return SetError(0, 0, $a_iCall[0])

EndFunc   ;==>_MessageBoxCheck


Func _RestoreDefaultSettings()

	RegDelete("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\DontShowMeThisDialogAgain", "{3E5305D5-3368-4DB3-A741-6CEFFD6691F5}")
	RegDelete("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\DontShowMeThisDialogAgain", "{05374BF7-1479-42BC-86DB-63829CA9D7B9}")

EndFunc   ;==>_RestoreDefaultSettings


Func _BinaryImageData()

	Local $bBinaryImage = "0x47494638396110001000B20300B6B6B6929292DADADAFFFFFFC2C2C2FF7348FF" _
			 & "FF0000000021F904050A0007002C000000001000100000033F78BADC0D3002A7" _
			 & "82B858041ABA1F014139D6589CC5618154611829018A8E0B578289AA023B2EB2" _
			 & "104502B16C4819CCD141F0787E8D1C54A1E948A19AAB2201003B"

	Return SetError(0, 0, $bBinaryImage)

EndFunc   ;==>_BinaryImageData


Func _CheckSave()

	If FileExists($sRawDLL) Then

		Switch _MessageBoxCheck(291, "Unsaved File", "Would you like to save compiled DLL before exit?", "{05374BF7-1479-42BC-86DB-63829CA9D7B9}", 7, $hGui)
			Case 6
				Local $sSaveFile

				While 1
					$sSaveFile = FileSaveDialog("Save Resource DLL", @DesktopDir, "Resource DLL (*.dll)", 2, "", $hGui)
					If Not $sSaveFile Then
						ExitLoop
					EndIf
					If Not (StringRight($sSaveFile, 4) = ".dll") Then
						$sSaveFile &= ".dll"
					EndIf
					If FileExists($sSaveFile) Then
						If MsgBox(52, "Save Resource", FileGetLongName($sSaveFile) & " already exists." & @CRLF & "Do you want to replace it?", 0, $hGui) = 6 Then
							ExitLoop
						EndIf
					Else
						ExitLoop
					EndIf
				WEnd
				If $sSaveFile Then
					Local $iOffsetPadding = StringInStr(FileRead($sRawDLL), "PADDING", 1, -1) ; will truncate first if necessary
					If $iOffsetPadding Then
						$iOffsetPadding += 6
						$iOffsetPadding = 512 * Floor(($iOffsetPadding + 511) / 512) ; alignment

						Local $hFile = FileOpen($sRawDLL, 16)
						Local $bFile = FileRead($hFile, $iOffsetPadding)
						FileClose($hFile)
						If $bFile Then
							$hFile = FileOpen($sRawDLL, 18)
							If Not ($hFile = -1) Then
								FileWrite($hFile, $bFile)
								FileClose($hFile)
							EndIf
						EndIf
					EndIf

					If FileCopy($sRawDLL, $sSaveFile, 9) Then
						FileDelete($sRawDLL)
						$sRawDLL = ""
						$iPlayed = 3
						$iDestroyDialogWindow = 1
						GUICtrlSetState($hGenerateItem, 128)
						GUICtrlSetState($hSaveItem, 128)
						GUICtrlSetState($hActionItem, 64)
						GUICtrlSetState($hFileOpenItem, 512)
						WinSetTitle($hGui, 0, "Resources [" & $iInstanceCurrent & " of " & $iInstancesOverall & "]")
						$iCompilerEnabled = 0
						_Main($sSaveFile)
					Else
						MsgBox(48, "Error", "Saving Failed!", 0, $hGui)
					EndIf
				EndIf
				Exit
			Case 7
				FileDelete($sRawDLL)
				Exit
		EndSwitch

	Else
		Exit
	EndIf

EndFunc   ;==>_CheckSave


Func _PopulateMiscTreeView($hTreeViewControl, $sModule)

	DllCall("kernel32.dll", "dword", "SetErrorMode", "dword", 1) ; SEM_FAILCRITICALERRORS ; will handle errors

	Local $iLoaded
	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "GetModuleHandleW", "wstr", $sModule)

	If @error Then
		Return SetError(1, 0, "")
	EndIf

	Local $pPointer = $a_hCall[0]

	If Not $a_hCall[0] Then
		$a_hCall = DllCall("kernel32.dll", "hwnd", "LoadLibraryExW", "wstr", $sModule, "hwnd", 0, "int", 1) ; DONT_RESOLVE_DLL_REFERENCES
		If @error Or Not $a_hCall[0] Then
			$a_hCall = DllCall("kernel32.dll", "hwnd", "LoadLibraryExW", "wstr", $sModule, "hwnd", 0, "int", 34) ; LOAD_LIBRARY_AS_IMAGE_RESOURCE|LOAD_LIBRARY_AS_DATAFILE

			If @error Or Not $a_hCall[0] Then
				Return SetError(2, 0, "")
			EndIf
			$iLoaded = 1
			$pPointer = $a_hCall[0] - 1
		Else
			$iLoaded = 1
			$pPointer = $a_hCall[0]
		EndIf

	EndIf

	Local $hModule = $a_hCall[0]

	Local $tIMAGE_DOS_HEADER = DllStructCreate("char Magic[2];" & _
			"ushort BytesOnLastPage;" & _
			"ushort Pages;" & _
			"ushort Relocations;" & _
			"ushort SizeofHeader;" & _
			"ushort MinimumExtra;" & _
			"ushort MaximumExtra;" & _
			"ushort SS;" & _
			"ushort SP;" & _
			"ushort Checksum;" & _
			"ushort IP;" & _
			"ushort CS;" & _
			"ushort Relocation;" & _
			"ushort Overlay;" & _
			"char Reserved[8];" & _
			"ushort OEMIdentifier;" & _
			"ushort OEMInformation;" & _
			"char Reserved2[20];" & _
			"dword AddressOfNewExeHeader", _
			$pPointer)

	Local $sMagic = DllStructGetData($tIMAGE_DOS_HEADER, "Magic")

	If Not ($sMagic == "MZ") Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(5, 0, "")
			EndIf
		EndIf
		Return SetError(3, 0, "")
	EndIf

	Local $iAddressOfNewExeHeader = DllStructGetData($tIMAGE_DOS_HEADER, "AddressOfNewExeHeader")

	$pPointer += $iAddressOfNewExeHeader ; start of PE file header

	Local $tIMAGE_NT_SIGNATURE = DllStructCreate("dword Signature", $pPointer) ; IMAGE_NT_SIGNATURE = 17744

	If Not (DllStructGetData($tIMAGE_NT_SIGNATURE, "Signature") = 17744) Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(5, 0, "")
			EndIf
		EndIf
		Return SetError(4, 0, "")
	EndIf

	$pPointer += 4 ; size of $tIMAGE_NT_SIGNATURE structure

	Local $tIMAGE_FILE_HEADER = DllStructCreate("ushort Machine;" & _
			"ushort NumberOfSections;" & _
			"dword TimeDateStamp;" & _
			"dword PointerToSymbolTable;" & _
			"dword NumberOfSymbols;" & _
			"ushort SizeOfOptionalHeader;" & _
			"ushort Characteristics", _
			$pPointer)

	$pPointer += 20 ; size of $tIMAGE_FILE_HEADER structure

	Local $tIMAGE_OPTIONAL_HEADER = DllStructCreate("ushort Magic;" & _
			"ubyte MajorLinkerVersion;" & _
			"ubyte MinorLinkerVersion;" & _
			"dword SizeOfCode;" & _
			"dword SizeOfInitializedData;" & _
			"dword SizeOfUninitializedData;" & _
			"dword AddressOfEntryPoint;" & _
			"dword BaseOfCode;" & _
			"dword BaseOfData;" & _
			"dword ImageBase;" & _
			"dword SectionAlignment;" & _
			"dword FileAlignment;" & _
			"ushort MajorOperatingSystemVersion;" & _
			"ushort MinorOperatingSystemVersion;" & _
			"ushort MajorImageVersion;" & _
			"ushort MinorImageVersion;" & _
			"ushort MajorSubsystemVersion;" & _
			"ushort MinorSubsystemVersion;" & _
			"dword Win32VersionValue;" & _
			"dword SizeOfImage;" & _
			"dword SizeOfHeaders;" & _
			"dword CheckSum;" & _
			"ushort Subsystem;" & _
			"ushort DllCharacteristics;" & _
			"dword SizeOfStackReserve;" & _
			"dword SizeOfStackCommit;" & _
			"dword SizeOfHeapReserve;" & _
			"dword SizeOfHeapCommit;" & _
			"dword LoaderFlags;" & _
			"dword NumberOfRvaAndSizes", _
			$pPointer)

	$hGeneralInfoTree = GUICtrlCreateTreeViewItem("General information", $hTreeViewControl)
	GUICtrlSetColor($hGeneralInfoTree, 0x0000C0)
	GUICtrlSetState($hGeneralInfoTree, 512)

	Local $iMachine = DllStructGetData($tIMAGE_FILE_HEADER, "Machine")
	Local $sMachine
	Switch $iMachine
		Case 332
			$sMachine = "x86"
		Case 512
			$sMachine = "Intel IPF"
		Case 34404
			$sMachine = "x64"
	EndSwitch

	Local $iMagic = DllStructGetData($tIMAGE_OPTIONAL_HEADER, "Magic")
	Local $sMagic
	Switch $iMagic
		Case 267
			$sMagic = "32-bit application"
		Case 523
			$sMagic = "64-bit application"
		Case 263
			$sMagic = "ROM image"
	EndSwitch

	GUICtrlCreateTreeViewItem("File size: " & FileGetSize($sModule) & " bytes", $hGeneralInfoTree)
	Local $aHashes = _GetHashes($sModule)
	GUICtrlCreateTreeViewItem("MD5: " & $aHashes[0], $hGeneralInfoTree)
	GUICtrlCreateTreeViewItem("SHA1: " & $aHashes[1], $hGeneralInfoTree)
	GUICtrlCreateTreeViewItem("TimeDateStamp: " & _EpochDecrypt(DllStructGetData($tIMAGE_FILE_HEADER, "TimeDateStamp")) & " UTC", $hGeneralInfoTree)
	GUICtrlCreateTreeViewItem("Made for: " & $sMachine & " machine", $hGeneralInfoTree)
	GUICtrlCreateTreeViewItem("Type: " & $sMagic, $hGeneralInfoTree)
	GUICtrlCreateTreeViewItem("AddressOfEntryPoint: " & Ptr(DllStructGetData($tIMAGE_OPTIONAL_HEADER, "AddressOfEntryPoint")), $hGeneralInfoTree)
	GUICtrlCreateTreeViewItem("ImageBase: " & Ptr(DllStructGetData($tIMAGE_OPTIONAL_HEADER, "ImageBase")), $hGeneralInfoTree)
	GUICtrlCreateTreeViewItem("CheckSum: " & DllStructGetData($tIMAGE_OPTIONAL_HEADER, "CheckSum"), $hGeneralInfoTree)

	If Not ($iMagic = 267) Then
		If $iLoaded Then
			Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
			If @error Or Not $a_iCall[0] Then
				Return SetError(5, 0, "")
			EndIf
		EndIf
		Return SetError(0, 1, 1) ; not 32-bit application. Structures are for 32-bit
	EndIf

	$pPointer += 96 ; size of $tIMAGE_OPTIONAL_HEADER structure

	$hExportedFuncTree = GUICtrlCreateTreeViewItem("Exported functions - none", $hTreeViewControl)
	GUICtrlSetColor($hExportedFuncTree, 0x0000C0)
	GUICtrlSetState($hExportedFuncTree, 512)

	$hImportsTree = GUICtrlCreateTreeViewItem("Imported functions - none", $hTreeViewControl)
	GUICtrlSetColor($hImportsTree, 0x0000C0)
	GUICtrlSetState($hImportsTree, 512)

	$hSectionsTree = GUICtrlCreateTreeViewItem("Sections", $hTreeViewControl)
	GUICtrlSetColor($hSectionsTree, 0x0000C0)
	GUICtrlSetState($hSectionsTree, 512)

	Local $hTreeViewExp[1]
	Local $hTreeViewImpModules[1]
	Local $hTreeViewImp[1]
	Local $hTreeViewSections[1]

	Local $iNumberOfSections = DllStructGetData($tIMAGE_FILE_HEADER, "NumberOfSections")
	ReDim $hTreeViewSections[$iNumberOfSections + 1]
	GUICtrlSetData($hSectionsTree, "Sections (" & $iNumberOfSections & ")")

	; Export Directory
	Local $tIMAGE_DIRECTORY_ENTRY_EXPORT = DllStructCreate("dword VirtualAddress;" & _
			"dword Size", _
			$pPointer)

	If DllStructGetData($tIMAGE_DIRECTORY_ENTRY_EXPORT, "Size") Then

		Local $tIMAGE_EXPORT_DIRECTORY = DllStructCreate("dword Characteristics;" & _
				"dword TimeDateStamp;" & _
				"ushort MajorVersion;" & _
				"ushort MinorVersion;" & _
				"dword Name;" & _
				"dword Base;" & _
				"dword NumberOfFunctions;" & _
				"dword NumberOfNames;" & _
				"dword AddressOfFunctions;" & _
				"dword AddressOfNames;" & _
				"dword AddressOfNameOrdinals", _
				DllStructGetPtr($tIMAGE_DOS_HEADER) + DllStructGetData($tIMAGE_DIRECTORY_ENTRY_EXPORT, "VirtualAddress"))

		Local $iBase = DllStructGetData($tIMAGE_EXPORT_DIRECTORY, "Base")
		Local $iNumberOfExporedFunctions = DllStructGetData($tIMAGE_EXPORT_DIRECTORY, "NumberOfFunctions")

		If $iNumberOfExporedFunctions Then
			ReDim $hTreeViewExp[$iNumberOfExporedFunctions]
			GUICtrlSetData($hExportedFuncTree, "Exported Functions (" & $iNumberOfExporedFunctions & ")")
		EndIf

		;Local $tBufferAddress = DllStructCreate("dword[" & DllStructGetData($tIMAGE_EXPORT_DIRECTORY, "NumberOfFunctions") & "]", DllStructGetPtr($tIMAGE_DOS_HEADER) + DllStructGetData($tIMAGE_EXPORT_DIRECTORY, "AddressOfFunctions"))
		Local $tBufferNames = DllStructCreate("dword[" & DllStructGetData($tIMAGE_EXPORT_DIRECTORY, "NumberOfNames") & "]", DllStructGetPtr($tIMAGE_DOS_HEADER) + DllStructGetData($tIMAGE_EXPORT_DIRECTORY, "AddressOfNames"))
		Local $tBufferNamesOrdinals = DllStructCreate("ushort[" & DllStructGetData($tIMAGE_EXPORT_DIRECTORY, "NumberOfFunctions") & "]", DllStructGetPtr($tIMAGE_DOS_HEADER) + DllStructGetData($tIMAGE_EXPORT_DIRECTORY, "AddressOfNameOrdinals"))

		Local $iNumNames = DllStructGetData($tIMAGE_EXPORT_DIRECTORY, "NumberOfNames") ; number of functions exported by name
		Local $iFuncOrdinal
		Local $tFuncName, $sFuncName
		Local $iFuncAddress

		For $i = 1 To $iNumberOfExporedFunctions
			$hTreeViewExp[$i - 1] = GUICtrlCreateTreeViewItem("Ordinal " & $iBase + $i - 1, $hExportedFuncTree)
		Next

		For $i = 1 To $iNumNames
			$tFuncName = DllStructCreate("char[64]", DllStructGetPtr($tIMAGE_DOS_HEADER) + DllStructGetData($tBufferNames, 1, $i))
			$sFuncName = DllStructGetData($tFuncName, 1) ; name of the function
			$iFuncOrdinal = $iBase + DllStructGetData($tBufferNamesOrdinals, 1, $i)
			;$iFuncAddress = DllStructGetData($tBufferAddress, 1, $i)

			GUICtrlSetData($hTreeViewExp[$iFuncOrdinal - $iBase], $iFuncOrdinal & "  " & $sFuncName); & "  " & Ptr($iFuncAddress))
		Next

	EndIf

	$pPointer += 8

	; Import Directory
	Local $tIMAGE_DIRECTORY_ENTRY_IMPORT = DllStructCreate("dword VirtualAddress;" & _
			"dword Size", _
			$pPointer)

	If DllStructGetData($tIMAGE_DIRECTORY_ENTRY_IMPORT, "Size") Then

		Local $tIMAGE_IMPORT_MODULE_DIRECTORY

		Local $iOffset, $iOffset2, $tModuleName, $iBufferOffset, $sModuleName, $iInitialOffset, $tBufferOffset, $tBuffer, $sFunctionName
		Local $i, $j, $k

		While 1

			$i += 1

			$tIMAGE_IMPORT_MODULE_DIRECTORY = DllStructCreate("dword RVAOriginalFirstThunk;" & _ ; actually union
					"dword TimeDateStamp;" & _
					"dword ForwarderChain;" & _
					"dword RVAModuleName;" & _
					"dword RVAFirstThunk", _
					DllStructGetPtr($tIMAGE_DOS_HEADER) + DllStructGetData($tIMAGE_DIRECTORY_ENTRY_IMPORT, "VirtualAddress") + $iOffset)

			If Not DllStructGetData($tIMAGE_IMPORT_MODULE_DIRECTORY, "RVAFirstThunk") Then ; the end
				ExitLoop
			EndIf

			If DllStructGetData($tIMAGE_IMPORT_MODULE_DIRECTORY, "RVAOriginalFirstThunk") Then
				$iInitialOffset = DllStructGetPtr($tIMAGE_DOS_HEADER) + DllStructGetData($tIMAGE_IMPORT_MODULE_DIRECTORY, "RVAOriginalFirstThunk")
			Else
				$iInitialOffset = DllStructGetPtr($tIMAGE_DOS_HEADER) + DllStructGetData($tIMAGE_IMPORT_MODULE_DIRECTORY, "RVAFirstThunk")
			EndIf

			$tModuleName = DllStructCreate("char[64]", DllStructGetPtr($tIMAGE_DOS_HEADER) + DllStructGetData($tIMAGE_IMPORT_MODULE_DIRECTORY, "RVAModuleName"))
			$sModuleName = DllStructGetData($tModuleName, 1)
			ReDim $hTreeViewImpModules[$i + 1]
			$hTreeViewImpModules[$i] = GUICtrlCreateTreeViewItem($sModuleName, $hImportsTree)

			$iOffset2 = 0
			$j = 0

			While 1

				$j += 1
				$tBufferOffset = DllStructCreate("dword", $iInitialOffset + $iOffset2)

				$iBufferOffset = DllStructGetData($tBufferOffset, 1)
				If Not $iBufferOffset Then ; zero value is the end
					ExitLoop
				EndIf

				If BitShift($iBufferOffset, 24) Then ; MSB is set for imports by ordinal, otherwise not

					GUICtrlCreateTreeViewItem("Ordinal " & BitAND($iBufferOffset, 0xFFFFFF), $hTreeViewImpModules[$i])
					$iOffset2 += 4 ; size of $tBufferOffset
					ContinueLoop

				EndIf

				$tBuffer = DllStructCreate("ushort Ordinal; char Name[64]", DllStructGetPtr($tIMAGE_DOS_HEADER) + $iBufferOffset)

				$sFunctionName = DllStructGetData($tBuffer, "Name")

				GUICtrlCreateTreeViewItem($sFunctionName, $hTreeViewImpModules[$i])

				$iOffset2 += 4 ; size of $tBufferOffset

			WEnd

			GUICtrlSetData($hTreeViewImpModules[$i], $sModuleName & " (" & $j - 1 & ")")
			$k += $j - 1

			$iOffset += 20 ; size of $tIMAGE_IMPORT_MODULE_DIRECTORY

		WEnd

		GUICtrlSetData($hImportsTree, "Imported functions (" & $k & ")")

	EndIf

	$pPointer += 8

	#cs
		; Resource Directory
		Local $tIMAGE_DIRECTORY_ENTRY_RESOURCE = DllStructCreate("dword VirtualAddress;" & _
		"dword Size", _
		$pPointer)
		
		$pPointer += 8
		
		; Exception Directory
		Local $tIMAGE_DIRECTORY_ENTRY_EXCEPTION = DllStructCreate("dword VirtualAddress;" & _
		"dword Size", _
		$pPointer)
		
		$pPointer += 8
		
		; Security Directory
		Local $tIMAGE_DIRECTORY_ENTRY_SECURITY = DllStructCreate("dword VirtualAddress;" & _
		"dword Size", _
		$pPointer)
		
		$pPointer += 8
		
		; Base Relocation Directory
		Local $tIMAGE_DIRECTORY_ENTRY_BASERELOC = DllStructCreate("dword VirtualAddress;" & _
		"dword Size", _
		$pPointer)
		
		$pPointer += 8
		
		; Debug Directory
		Local $tIMAGE_DIRECTORY_ENTRY_DEBUG = DllStructCreate("dword VirtualAddress;" & _
		"dword Size", _
		$pPointer)
		
		$pPointer += 8
		
		; Description String
		Local $tIMAGE_DIRECTORY_ENTRY_COPYRIGHT = DllStructCreate("dword VirtualAddress;" & _
		"dword Size", _
		$pPointer)
		
		$pPointer += 8
		
		; Machine Value (MIPS GP)
		Local $tIMAGE_DIRECTORY_ENTRY_GLOBALPTR = DllStructCreate("dword VirtualAddress;" & _
		"dword Size", _
		$pPointer)
		
		$pPointer += 8
		
		; TLS Directory
		Local $tIMAGE_DIRECTORY_ENTRY_TLS = DllStructCreate("dword VirtualAddress;" & _
		"dword Size", _
		$pPointer)
		
		$pPointer += 8
		
		; Load Configuration Directory
		Local $tIMAGE_DIRECTORY_ENTRY_LOAD_CONFIG = DllStructCreate("dword VirtualAddress;" & _
		"dword Size", _
		$pPointer)
		
		$pPointer += 8
	#ce

	$pPointer += 72 ; instead of olive-green part

	$pPointer += 40 ; five more unused data directories

	Local $tIMAGE_SECTION_HEADER
	Local $iSizeOfRawData, $pPointerToRawData, $tRawData, $bRawData

	For $i = 0 To $iNumberOfSections - 1

		$tIMAGE_SECTION_HEADER = DllStructCreate("char Name[8];" & _
				"dword UnionOfData;" & _
				"dword VirtualAddress;" & _
				"dword SizeOfRawData;" & _
				"dword PointerToRawData;" & _
				"dword PointerToRelocations;" & _
				"dword PointerToLinenumbers;" & _
				"ushort NumberOfRelocations;" & _
				"ushort NumberOfLinenumbers;" & _
				"dword Characteristics", _
				$pPointer)

		$hTreeViewSections[$i] = GUICtrlCreateTreeViewItem(DllStructGetData($tIMAGE_SECTION_HEADER, "Name"), $hSectionsTree)
		GUICtrlCreateTreeViewItem("SizeOfRawData: " & DllStructGetData($tIMAGE_SECTION_HEADER, "SizeOfRawData") & " bytes", $hTreeViewSections[$i])
		GUICtrlCreateTreeViewItem("PointerToRawData: " & Ptr(DllStructGetData($tIMAGE_SECTION_HEADER, "PointerToRawData")), $hTreeViewSections[$i])
		GUICtrlCreateTreeViewItem("VirtualAddress: " & Ptr(DllStructGetData($tIMAGE_SECTION_HEADER, "VirtualAddress")), $hTreeViewSections[$i])
		GUICtrlCreateTreeViewItem("NumberOfRelocations: " & DllStructGetData($tIMAGE_SECTION_HEADER, "NumberOfRelocations"), $hTreeViewSections[$i])

		$pPointer += 40 ; size of $tIMAGE_SECTION_HEADER structure

	Next

	If $iLoaded Then
		Local $a_iCall = DllCall("kernel32.dll", "int", "FreeLibrary", "hwnd", $hModule)
		If @error Or Not $a_iCall[0] Then
			Return SetError(6, 0, "")
		EndIf
	EndIf

	Return SetError(0, 0, 1)

EndFunc   ;==>_PopulateMiscTreeView


Func _GetParent()

	Local $sParent

	Local $aCall = DllCall("kernel32.dll", "int", "GetCurrentProcess")

	If @error Or Not $aCall[0] Then
		Return SetError(1, 0, "")
	EndIf

	Local $hProcess = $aCall[0]

	Local $tPROCESS_BASIC_INFORMATION = DllStructCreate("dword ExitStatus;" & _
			"ptr PebBaseAddress;" & _
			"dword AffinityMask;" & _
			"dword BasePriority;" & _
			"dword UniqueProcessId;" & _
			"dword InheritedFromUniqueProcessId")

	Local $aCall = DllCall("ntdll", "int", "NtQueryInformationProcess", _
			"hwnd", $hProcess, _
			"dword", 0, _
			"ptr", DllStructGetPtr($tPROCESS_BASIC_INFORMATION), _
			"dword", DllStructGetSize($tPROCESS_BASIC_INFORMATION), _
			"dword*", 0)

	If @error Then
		Return SetError(2, 0, "")
	EndIf

	Local $iParentPID = DllStructGetData($tPROCESS_BASIC_INFORMATION, "InheritedFromUniqueProcessId")

	$aCall = DllCall("kernel32.dll", "hwnd", "OpenProcess", _
			"dword", 1040, _ ; PROCESS_QUERY_INFORMATION|PROCESS_VM_READ
			"int", 0, _
			"dword", $iParentPID)

	If @error Or Not $aCall[0] Then
		Return SetError(3, 0, "")
	EndIf

	Local $hParentHandle = $aCall[0]

	$aCall = DllCall("psapi.dll", "dword", "GetModuleBaseNameW", _
			"hwnd", $hParentHandle, _
			"ptr", 0, _
			"wstr", "", _
			"dword", 65536)

	If @error Or Not $aCall[0] Then
		DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hParentHandle)
		Return SetError(4, 0, "")
	EndIf

	$sParent = $aCall[3]

	DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hParentHandle)

	Return SetError(0, 0, $sParent)

EndFunc   ;==>_GetParent


Func _ProcessGetParent($iPID) ; SmOke_N's originally

	Local $aCall = DllCall("kernel32.dll", "hwnd", "CreateToolhelp32Snapshot", _
			"dword", 2, _ ; CS_SNAPPROCESS
			"dword", 0)

	If @error Or $aCall[0] = -1 Then
		Return SetError(1, 0, "")
	EndIf

	Local $hSnapshot = $aCall[0]

	Local $tPROCESSENTRY32 = DllStructCreate("dword Size;" & _
			"dword Usage;" & _
			"dword ProcessID;" & _
			"int DefaultHeapID;" & _
			"dword ModuleID;" & _
			"dword Threads;" & _
			"dword ParentProcessID;" & _
			"int PriClassBase;" & _
			"dword Flags;" & _
			"wchar ExeFile[260]")

	DllStructSetData($tPROCESSENTRY32, "Size", DllStructGetSize($tPROCESSENTRY32))

	$aCall = DllCall("kernel32.dll", "int", "Process32FirstW", _
			"hwnd", $hSnapshot, _
			"ptr", DllStructGetPtr($tPROCESSENTRY32))

	If @error Or Not $aCall[0] Then
		Return SetError(2, 0, "")
	EndIf

	If DllStructGetData($tPROCESSENTRY32, "ProcessID") = $iPID Then

		DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hSnapshot)
		Local $aProcesses = ProcessList()
		If @error Then
			Return SetError(11, 0, "")
		EndIf
		For $i = 1 To $aProcesses[0][0]
			If $aProcesses[$i][1] = DllStructGetData($tPROCESSENTRY32, "ParentProcessID") Then
				Return SetError(0, 0, $aProcesses[$i][0])
			EndIf
		Next
		Return SetError(3, 0, "")

	EndIf

	While 1

		$aCall = DllCall("kernel32.dll", "int", "Process32NextW", "hwnd", $hSnapshot, "ptr", DllStructGetPtr($tPROCESSENTRY32))

		If @error Or Not $aCall[0] Then
			DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hSnapshot)
			Return SetError(4, 0, "")
		EndIf

		If DllStructGetData($tPROCESSENTRY32, "ProcessID") = $iPID Then
			DllCall("kernel32.dll", "int", "CloseHandle", "hwnd", $hSnapshot)
			Local $aProcesses = ProcessList()
			If @error Then
				Return SetError(11, 0, "")
			EndIf
			For $i = 1 To $aProcesses[0][0]
				If $aProcesses[$i][1] = DllStructGetData($tPROCESSENTRY32, "ParentProcessID") Then
					Return SetError(0, 0, $aProcesses[$i][0])
				EndIf
			Next
			Return SetError(3, 0, "")
		EndIf

	WEnd

EndFunc   ;==>_ProcessGetParent


Func _ExecuteCommandLine()

	ConsoleWriteError("Section under construction!" & @CRLF) ; write to the STDERR stream
	ConsoleWrite($CmdLineRaw & @CRLF) ; write to the STDOUT stream

	Return

	;Suggestion for parents:
	#	Local $hResourcesExe = Run("Resources.exe -add -compile MyRes.dll -res SomeAnimated.gif -type GIF -name 1 -lang 0", "", @SW_HIDE, 6); $STDERR_CHILD + $STDOUT_CHILD
	#	Local $sLine, $sLineError
	#
	#	While 1
	#		$sLineError = StderrRead($hResourcesExe)
	#		If @error Then ExitLoop
	#		If $sLineError Then
	#			ConsoleWrite($sLineError)
	#		EndIf
	#		Sleep(100)
	#	WEnd
	#
	#	While 1
	#		$sLine = StdoutRead($hResourcesExe)
	#		If @error Then ExitLoop
	#		If $sLine Then
	#			ConsoleWrite($sLine)
	#		EndIf
	#		Sleep(100)
	#	WEnd
	; End suggestion

EndFunc   ;==>_ExecuteCommandLine


Func _ToggleEasterEgg()

	If $iSoundPlaying Then
		SoundPlay("")
		$iSoundPlaying = 0
	Else
		Local $sMusicFile = @SystemDir & "\oobe\images\title.wma"
		If FileExists($sMusicFile) Then ; XP
			SoundPlay($sMusicFile)
		Else
			$sMusicFile = @HomeDrive & "\Users\Public\Music\Sample Music\One Step Beyond.wma"
			If FileExists($sMusicFile) Then ; Vista
				SoundPlay($sMusicFile)
			Else
				; nothing
			EndIf
		EndIf
		$iSoundPlaying = 1
	EndIf

	If $iEasterEgg Then
		$iEasterEgg = 0
	Else
		$iEasterEgg = 1
	EndIf

EndFunc   ;==>_ToggleEasterEgg


Func OnAutoItExit()

	If FileExists($sMediaTempFile) Then
		FileDelete($sMediaTempFile)
	EndIf

	If FileExists($sRawDLL) Then
		FileDelete($sRawDLL)
	EndIf

	If $iMessage Then

		Local $a_hCall = DllCall("kernel32.dll", "hwnd", "OpenSemaphore", _
				"dword", 0x100000, _ ; SYNCHRONIZE
				"int", 0, _
				"str", "{FA151046-C493-4B54-8BFA-E0B1CC98DF52}")

		If Not @error Then
			Local $hSemaphore = $a_hCall[0]

			Local $a_iCall = DllCall("kernel32.dll", "dword", "WaitForSingleObject", _
					"hwnd", $hSemaphore, _
					"dword", 0)

			If Not @error Then
				$a_iCall = DllCall("user32.dll", "int", "SendNotifyMessage", _
						"hwnd", 0xFFFF, _
						"dword", $iMessage, _
						"int", 0, _
						"int", $iInstanceCurrent)
			EndIf
		EndIf
	EndIf

EndFunc   ;==>OnAutoItExit