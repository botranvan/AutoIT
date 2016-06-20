Global Const $INVALID_HANDLE_VALUE = 0xFFFFFFFF
Global Const $GENERIC_READ = 0x80000000
Global Const $GENERIC_WRITE = 0x40000000
Global Const $FILE_SHARE_READ = 0x00000001
Global Const $FILE_SHARE_WRITE = 0x00000002
Global Const $OPEN_EXISTING = 3

Global Const $IOCTL_SCSI_PASS_THROUGH = 0x0004D004 ; (0x00000004 << 16) | ((0x0001 | 0x0002) << 14) | (0x0401 << 2) | 0 [from CTL_CODE macro]
Global Const $SCSI_IOCTL_DATA_IN = 0x01
Global Const $SCSI_IOCTL_DATA_OUT = 0x00
Global Const $SCSI_IOCTL_DATA_UNSPECIFIED = 0x02
Global Const $SPTCDBSIZE = 0x10 ; always sixteen, IOCTL_SCSI_PASS_THROUGH requires this - windows checks to make sure the size of $spt = 44.
Global Const $REALCDBSIZE = 0x0c ; twelve - more compatible than sixteen for ATAPI drives
Global Const $SENSEBUFFERSIZE = 0xF0 ;240 is max (was 32, then 255, which was stupid for byte alignment reasons)
Global Const $DATABUFFERSIZE = 0x0400 ;1024 should handle most calls, except IO, firmware and large changers.  Increase? (was 512)

Global $cdb
Global $spt
Global $sptwb
CreateDLLStructures()
PopulateCDB()
PopulateSPTWB()


Func CDTrayIsOpen($sDrive)
    Local $hVolume = OpenVolume($sDrive)
    
    If $hVolume = $INVALID_HANDLE_VALUE Then
        ;MsgBox(4096, $sDrive & " is not a valid Optical drive", _
            ;"There was no optical drive at that drive letter, or you do not have high enough access to talk to it directly.")
        
        Return SetError(1, 0, "There was no optical drive at that drive letter, " & _
            "or you do not have high enough access to talk to it directly.")
    EndIf
    
    Local $stReturn = DllStructCreate("ptr")
    
    ;!!! DeviceIOControl expects ptr;long;ptr;long;ptr;long;ptr;ptr !!!
    Local $aRet = DllCall( _
            "Kernel32.dll", "int", _
            "DeviceIoControl", _
            "hwnd", $hVolume, _
            "int", $IOCTL_SCSI_PASS_THROUGH, _
            "ptr", DllStructGetPtr($sptwb), _
            "int", DllStructGetSize($spt), _
            "ptr", DllStructGetPtr($sptwb), _
            "int", DllStructGetSize($sptwb), _
            "int*", $stReturn, _
            "ptr", 0 _
            )
    
    If @error Then Return SetError(2, 0, "DeviceIoControl DLLCall failed with error level: " & String(@error) & "!")
    If $aRet[0] = 0 Then Return SetError(3, 0, "Error in DeviceIoControl call to IOCTL_SCSI_PASS_THROUGH:")
    
    Local $iSecond_Byte = DllStructGetData($sptwb, 16, 2) ;should be the second byte
    
    ;now we need the bit here 00010000
    Local $iTrayStatus = BitAND($iSecond_Byte, 0x10)
    
    If $iTrayStatus = 0x10 Then Return True ;Tray Status - The Tray for drive $drive is open.
    Return False ;Tray Status - The Tray for drive $drive is closed.
EndFunc

;-----------------------------------------------------
; Top-level Function Definitions
;-----------------------------------------------------
Func CreateDLLStructures()
    $CDB_STRUCT = "ubyte[" & String($SPTCDBSIZE) & "]"
    
    $SCSI_PASS_THROUGH = "ushort;ubyte;ubyte;ubyte;ubyte;ubyte;ubyte;ubyte;ubyte[3];uint;uint;uint;uint;ubyte[" & _
        String($SPTCDBSIZE) & "]"
    
    $SCSI_PASS_THROUGH_WITH_BUFFERS = $SCSI_PASS_THROUGH & ";ubyte[" & _
        String($SENSEBUFFERSIZE) & "];ubyte[" & String($DATABUFFERSIZE) & "]"
    
    $cdb = DllStructCreate($CDB_STRUCT)
    $spt = DllStructCreate($SCSI_PASS_THROUGH) ;used only for length calculations
    $sptwb = DllStructCreate($SCSI_PASS_THROUGH_WITH_BUFFERS)
EndFunc   ;==>CreateDLLStructures

Func PopulateCDB()
    $CDBCOMMAND = 0xBD ;Mechanism Status in hex
    
    DllStructSetData($cdb, 1, $CDBCOMMAND, 1)
    DllStructSetData($cdb, 1, 0x00, 2)
    DllStructSetData($cdb, 1, 0x00, 3)
    DllStructSetData($cdb, 1, 0x00, 4)
    DllStructSetData($cdb, 1, 0x00, 5)
    DllStructSetData($cdb, 1, 0x00, 6)
    DllStructSetData($cdb, 1, 0x00, 7)
    DllStructSetData($cdb, 1, 0x00, 8)
    DllStructSetData($cdb, 1, 0x00, 9)
    DllStructSetData($cdb, 1, 0x08, 10) ;Request that the device returns only 08 bytes, which is the defined size of the header  We could do more if we had a changer, which would want to give more info, but by setting 8 here, we tell the device not to send more than the header anyway.
    DllStructSetData($cdb, 1, 0x00, 11)
    DllStructSetData($cdb, 1, 0x00, 12)
    ;The next four are not used for ATAPI compatibility, but should be set to zero anyway.
    DllStructSetData($cdb, 1, 0x00, 13)
    DllStructSetData($cdb, 1, 0x00, 14)
    DllStructSetData($cdb, 1, 0x00, 15)
    DllStructSetData($cdb, 1, 0x00, 16)
EndFunc   ;==>PopulateCDB

Func PopulateSPTWB()
    $Len_spt = DllStructGetSize($spt)
    ;Are these necessary if the optical drive is at a drive letter and we pass the handle, right?
    ;docs seem to suggest that the port driver fills these in if we are using an enumerated device
    $Bus = 0x00
    $ID = 0x00
    $Lun = 0x00
    
    DllStructSetData($sptwb, 1, $Len_spt);Length of pre-filler to be set before making call
    DllStructSetData($sptwb, 2, 0x00);Checked on return from call
    DllStructSetData($sptwb, 3, $Bus);SCSI bus # - I believe the port driver fills this in
    DllStructSetData($sptwb, 4, $ID);SCSI ID # - I believe the port driver fills this in
    DllStructSetData($sptwb, 5, $Lun);SCSI Lun # -I believe the port driver fills this in
    DllStructSetData($sptwb, 6, $REALCDBSIZE);Length of CDB to be set before making call (12 for ATAPI compatibility)?
    DllStructSetData($sptwb, 7, $SENSEBUFFERSIZE);Length of Sense buffer to be set before making call - or always 32?
    DllStructSetData($sptwb, 8, $SCSI_IOCTL_DATA_IN);Flag for Data Transfer direction to be set before making call
    ;item #9 is simple a placehold for byte alignment, so ignore it
    DllStructSetData($sptwb, 10, $DATABUFFERSIZE);Length of Data buffer to be set before making call - or always 512
    DllStructSetData($sptwb, 11, 0x05);Timeout for call - to be set before making call
    DllStructSetData($sptwb, 12, $Len_spt + $SENSEBUFFERSIZE);Offset from first byte to beginning of data buffer
    DllStructSetData($sptwb, 13, $Len_spt);Offset from first byte to beginning of sense buffer
    For $i = 1 To $SPTCDBSIZE
        DllStructSetData($sptwb, 14, DllStructGetData($cdb, 1, $i), $i);12 bytes of data representing the CDB
    Next
    DllStructSetData($sptwb, 15, 0x00, 1);Sense Buffer - leave alone before call
    DllStructSetData($sptwb, 16, 0x00, 1);Data Buffer - leave alone before call
EndFunc   ;==>PopulateSPTWB

Func OpenVolume($cDriveLetter)
    ;   From AUTOIT forums
    Local $hVolume, $uDriveType, $szVolumeName, $dwAccessFlags
    
    If StringLen($cDriveLetter) = 1 Then
        $cDriveLetter = $cDriveLetter & ":"
    ElseIf StringLen($cDriveLetter) = 2 Then
        ;do nothing
    ElseIf StringLen($cDriveLetter) = 3 Then
        $cDriveLetter = StringLeft($cDriveLetter, 2)
    Else
        Return $INVALID_HANDLE_VALUE
    EndIf
    
    Local $szRootName = $cDriveLetter & "\"
    
    $uDriveType = DriveGetType($szRootName)
    
    Select
        Case $uDriveType == "Removable"
            $dwAccessFlags = BitOR($GENERIC_READ, $GENERIC_WRITE)
        Case $uDriveType == "CDROM"
            ;We need write access in order to send scsi commands.
            $dwAccessFlags = BitOR($GENERIC_READ, $GENERIC_WRITE)
            ;$dwAccessFlags = $GENERIC_READ
        Case Else
            Return $INVALID_HANDLE_VALUE
    EndSelect
    
    $szVolumeName = "\\.\" & $cDriveLetter & ""
    ;$szVolumeName = "\\.\CdRom0"
    
    ;in addition to getting the handle, the following also verifies write access, which is required to use the scsi pass through
    $hVolume = DllCall( _
            "Kernel32.dll", "hWnd", _
            "CreateFile", _
            "str", $szVolumeName, _
            "long", $dwAccessFlags, _
            "long", BitOR($FILE_SHARE_READ, $FILE_SHARE_WRITE), _
            "ptr", 0, _
            "long", $OPEN_EXISTING, _
            "long", 0, _
            "long", 0 _
            )
    
    If @error Then Return SetError(1, 0, "CreateFile DLLCall failed!")
    
    Return $hVolume[0]
EndFunc   ;==>OpenVolume
