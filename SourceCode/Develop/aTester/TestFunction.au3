#include-once

;~ StartTest
Func StartTest()
	FTPCloseAll()
	FCommandAdd("FTPUpload")
EndFunc

;~ StopTest
Func StopTest()
	$StartTest = true
	BStartClick()
EndFunc

;~ FTPCloseAll
Func FTPCloseAll()
	Global $stdOutId
	While 1
		$close = WinClose($stdOutId)
		If Not $close Then ExitLoop
	WEnd
EndFunc

;~ FTPUpload
Func FTPUpload()
	Global $FilesUpload, $FilesUploadTemp

	if UBound($FilesUpload) <= 1 Then
		FilesLoad()
		FilesTemp()
	EndIf

	if UBound($FilesUploadTemp) > 1 Then
		FTPPutFiles()
	EndIf
EndFunc

;~ FTPPutFiles
Func FTPPutFiles()
	Global $FilesUploadTemp, $TempPath

	$count = UBound($FilesUploadTemp)-1

	For $i = 1 To $count
		$file = $TempPath & $FilesUploadTemp[$i]
		if FileExists($file) Then
			FTPShellExecute($file)
		EndIf
    Next

	StopTest()
EndFunc

;~ FTPShellExecute
Func FTPShellExecute($file)
	If Not $StartTest Then return
	LNoticeSet('Shell Executing...')

	Local $stdOut

	Local $host = IHostAddressGet()
	Local $user = IUsernameGet()
	Local $pass = IPasswordGet()
	Local $folder = IFolderGet()

	Local $command = "ftp "&$host

	$stdOut = Run($command)

	While Not ProcessExists($stdOut)
		Sleep(72)
	WEnd

	StdinLine($user)
	StdinLine($pass)
	StdinLine("cd "&$folder)
	StdinLine("put "&$file)

;~ 	ProcessClose($stdOut)
EndFunc

;~ StdinLine
Func StdinLine($command)
	Global $stdOutId, $TypeSpeed

	Sleep($TypeSpeed)

	If Not $StartTest Then return

;~ 	ConsoleWrite($stdOutId)
	ControlSend($stdOutId,'',0,$command)
	ControlSend($stdOutId,'',0,"{Enter}")
EndFunc


;~ FilesLoad
Func FilesLoad()
	LNoticeSet('Loading files...')

	Global $LocalPath, $FilesUpload

	If not FileExists($LocalPath) Then DirCreate($LocalPath)

	Local $hSearch = FileFindFirstFile($LocalPath&"*.*")

	While 1
        $sFileName = FileFindNextFile($hSearch)
        If @error Then ExitLoop

		if Not isDir($LocalPath & $sFileName) Then _ArrayAdd($FilesUpload,$sFileName)
    WEnd
EndFunc

;~ isDir
Func isDir($file)
	$att = FileGetAttrib($file)
	return StringInStr($att,'D',1)
EndFunc


;~ FileTemp
Func FileTemp($fileName)
	Global $LocalPath, $FilesUploadTemp, $TempPath
	Local $FileData, $filePath, $filePathTemp, $file

	$filePath = $LocalPath & $fileName
	$filePathTemp = $TempPath & $fileName

	If Not FileExists($filePath) Then Return
;~ 	If FileExists($filePathTemp) Then FileDelete($filePathTemp)

	$FileData = FileRead($filePath)

	$pattern = '{{[\S]+}}'

	Do
		LNoticeSet("File temping...")
		Sleep(72)

		$matches = StringRegExp ( $FileData, $pattern , $STR_REGEXPARRAYMATCH )
		If @error == 1 Then ExitLoop

		$temp = $matches[0]
		$tempData = TempData($temp)

		$FileData = StringReplace($FileData,$temp,$tempData)

	Until False

	LNoticeSet("Files temp done")

	$file = FileOpen($filePathTemp,$FO_OVERWRITE  + $FO_CREATEPATH + $FO_UTF16_LE_NOBOM )
	FileWrite($file, $FileData)
	FileClose($file)

	_ArrayAdd($FilesUploadTemp, $fileName)
EndFunc

;~ FilesTemp
Func FilesTemp()
	Global $FilesUpload

	$count = UBound($FilesUpload)-1

	For $i = 1 To $count
		FileTemp($FilesUpload[$i])
    Next
EndFunc

;~ TempData
Func TempData($temp)
	$temp = StringReplace($temp,'{{','')
	$temp = StringReplace($temp,'}}','')
	$dataArray = StringSplit($temp,'|')

	If $dataArray[0] < 1 Then Return ''
	If $dataArray[0] == 1 Then Return $dataArray[1]

	$data = $dataArray[1]
	For $i = 2 To $dataArray[0]
		$actionArray = StringSplit($dataArray[$i],',')
		TempAction($data,$actionArray)
	Next

	return $data
EndFunc

;~ TempAction
Func TempAction(ByRef $data, $actionArray)
	Global $RunTime

	Switch $actionArray[1]
		Case "StringFormat"
			$data = StringFormat($actionArray[2],$data)
		Case "timestamp"
			$data = _DateDiff('s', "1970/01/01 00:00:00", $RunTime)
		Case "stringmid"
			$data = StringMid($data,$actionArray[2],$actionArray[3])
		Case "StringRight"
			$data = StringRight ($data,$actionArray[2])
	EndSwitch
EndFunc