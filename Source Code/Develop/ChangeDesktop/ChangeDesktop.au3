
Global Const $SPI_SETDESKWALLPAPER = 20
Global Const $SPIF_SENDCHANGE      = 2
Global $Allfiles="",$SearchDir = @WindowsDir&"\Web\Wallpaper\"



$Folder = 'E:\Picture\'
$Path = $Folder&'image.bmp'
;~ $Path = $Folder&'kamael.jpg'
;~ _DesktopChange($Path)
_ApplyImage($Path)

Func _DesktopChange($sBMPFile, $bUpdate=True)
  Local $aResult
  Local $iWinIni = 0

  if $bUpdate then $iWinIni = $SPIF_SENDCHANGE
  $aResult = DllCall("user32.dll", "int", "SystemParametersInfo", "int", $SPI_SETDESKWALLPAPER, _
                     "int", 0, "str", $sBMPFile, "int", $iWinIni)
  Return $aResult[0] <> 0
EndFunc

;  style 1, tile 1 = tiled
;  style 2, tile 0 = stretched
;  style 1, tile 0 = centered
Func _ApplyImage($path, $style = 1, $tile = 1)
    $apply_type = StringRight($path, 4)
    If $apply_type = ".jpg" Or _
            $apply_type = ".gif" Or _
            $apply_type = ".png" Then
        FileDelete(@WindowsDir & "\xwall.bmp")
        RunWait(@ScriptDir & "\pvw32con.exe " & '"' & $path & '"' & " -w --oo " & '"' & @WindowsDir & "\xwall.bmp" & '"', _
                @ScriptDir, @SW_HIDE)
    Else
        FileCopy($path, @WindowsDir & "\xwall.bmp", 1)
    EndIf
    RegWrite("HKEY_CURRENT_USER\Control Panel\Desktop", "WallpaperStyle", "REG_SZ", $style)
    RegWrite("HKEY_CURRENT_USER\Control Panel\Desktop", "TileWallpaper", "REG_SZ", $tile)
    Sleep(250)
    DllCall("User32.dll", "int", "SystemParametersInfo", _
            "int", 20, _
            "int", 0, _
            "string", @WindowsDir & "\xwall.bmp", _
            "int", 0x01)
EndFunc