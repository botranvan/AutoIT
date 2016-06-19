;WMI Custom Class v1.0
;Author: WeaponX (ghostofagoodthing@gmail.com)

#cs ===============================================================================
Class_AddProperty
Class_Commit
Class_Create
Class_Debug
Class_Delete
Class_Exists
Class_Properties
Class_Release
Class_Spawn
Collection_Count
Collection_Create
Collection_Debug
#ce ===============================================================================

;Define the valid CIM types of a property value.
Const $wbemCimtypeSint16 = 2 ;0x2 - Signed 16-bit integer
Const $wbemCimtypeSint32 = 3 ;0x3 - Signed 32-bit integer
Const $wbemCimtypeReal32 = 4 ;0x4 - 32-bit real number
Const $wbemCimtypeReal64 = 5 ;0x5 - 64-bit real number
Const $wbemCimtypeString = 8 ;0x8 - String datatype
Const $wbemCimtypeBoolean = 11 ;0xB - Boolean value
Const $wbemCimtypeObject = 13 ;0xD - CIM object
Const $wbemCimtypeSint8 = 16 ;0x10 - Signed 8-bit integer
Const $wbemCimtypeUint8 = 17 ;0x11 - Unsigned 8-bit integer
Const $wbemCimtypeUint16 = 18 ;0x12 - Unsigned 16-bit integer
Const $wbemCimtypeUint32 = 19 ;0x13 - Unsigned 32-bit integer
Const $wbemCimtypeSint64 = 20 ;0x14 - Signed 64-bit integer
Const $wbemCimtypeUint64 = 21 ;0x15 - Unsigned 64-bit integer
Const $wbemCimtypeDatetime = 101 ;0x65 - Date/time value
Const $wbemCimtypeReference = 102 ;0x66 - Reference to a CIM object
Const $wbemCimtypeChar16 = 103 ;0x67 - 16-bit character


;~ == Các Class cho GUI ========================================================
$objClass = Class_Create("GUIInfo")
Class_AddProperty($objClass, "title", $wbemCimtypeString)
Class_AddProperty($objClass, "width", $wbemCimtypeSint16)
Class_AddProperty($objClass, "height", $wbemCimtypeSint16)
Class_AddProperty($objClass, "x", $wbemCimtypeSint16)
Class_AddProperty($objClass, "y", $wbemCimtypeSint16)
Class_AddProperty($objClass, "style", $wbemCimtypeSint32)
Class_AddProperty($objClass, "estyle", $wbemCimtypeSint32)
Class_AddProperty($objClass, "path", $wbemCimtypeString)

$FunctionClass = Class_Create("FunctionInfo")
Class_AddProperty($FunctionClass, "name", $wbemCimtypeString)
Class_AddProperty($FunctionClass, "file", $wbemCimtypeString)
Class_AddProperty($FunctionClass, "line", $wbemCimtypeString)
;~ =============================================================================


#cs ===============================================================================
FUNCTIONS
#ce ===============================================================================

#cs ===============================================================================
Function: Class_AddProperty
Parameters:
    $oClass* - ISWbemObjectEx - Class object
    $sPropertyName - String - Name of property to add
    $iCimType - Integer - Property type (see defined constants)
    $bKey - Boolean - Determines if the parameter is a key
    $bIsArray - Boolean - Determines if parameter is an array
Return:
Errors:
    None
Notes:
    None
#ce ===============================================================================
Func Class_AddProperty(ByRef $oClass, $sPropertyName, $iCimType, $bKey = true, $bIsArray = false)
    ;Add property
    $oClass.Properties_.add($sPropertyName, $iCimType)
    
    If $bKey Then
        ;Make the property a key property 
        $oClass.Properties_($sPropertyName).Qualifiers_.Add("key", TRUE)
    EndIf
    
    Class_Commit($oClass)
EndFunc

#cs ===============================================================================
Function: Class_Commit
Parameters:
    $oClass* - ISWbemObjectEx - Class object
Return: 
    None  
Errors:
    None
Notes:
    None
#ce ===============================================================================
Func Class_Commit(ByRef $oClass)
    Local $oInstancePath = $oClass.Put_
    ;ConsoleWrite($oInstancePath.Path & @CRLF)
EndFunc

#cs ===============================================================================
Function: Class_Create
Parameters:
    $sClassName - String - Identifier name for your class
Return: 
    ISWbemObjectEx Object    
Errors:
    1 - Class already exists
    2 - Error creating ISWbemServicesEx Object
Notes:
    None
#ce ===============================================================================
Func Class_Create($sClassName)
    
    ;If class already exists, just spawn a new instance of it, otherwise create the new class
    If Class_Exists($sClassName) Then
        $oClass = ObjGet("Winmgmts:root\default:" & $sClassName)
        ConsoleWrite("Class "&$sClassName&" doesn't yet exist" & @CRLF)
    Else
        Local $objSWbemService = ObjGet("Winmgmts:root\default") ;ISWbemServicesEx Object
        If @ERROR Then Return SetError(2,0,0)
        
        $oClass = $objSWbemService.Get() ;ISWbemObjectEx Object
        $oClass.Path_.Class = $sClassName        
        
        ConsoleWrite("Class "&$sClassName&" already exists" & @CRLF)
        ;Return SetError(1,0,0)        

    EndIf

    ; Release SwbemServices object
    $objSWbemService = ""
    
    Return $oClass
EndFunc

#cs ===============================================================================
Function: Class_Debug
Parameters:
    $oClass* - ISWbemObjectEx - Class object
Return: 
    ISWbemPropertySet Collection Object
Errors:
    1 - Not an object / not a ISWbemObjectEx object
Notes:
    None
#ce ===============================================================================
Func Class_Debug(ByRef $oClass)
    If IsObj($oClass) AND ObjName($oClass) = "ISWbemObjectEx" Then
        $oProperties = Class_Properties($oClass)
        ConsoleWrite("+<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Class Properties" & @CRLF)
        ConsoleWrite("Count: " & $oProperties.Count & @CRLF)
        For $oProperty in $oProperties
            ConsoleWrite("Name: " & $oProperty.Name & " Type: " & $oProperty.CIMType & @CRLF)
        Next
        ConsoleWrite(@CRLF)
    Else
        Return SetError(1,0,0)
    EndIf
EndFunc

#cs ----------------------------------------------------------------
Function: Class_Delete
Parameters:
    $sClassName - String - Identifier name for your class
Return: 
    None    
Errors:
    1 - Not an object / not a ISWbemObjectEx object
Notes:
    CAUTION - I don't know what this will do to non-user created classes,
    call this if your script crashed without calling Class_Release
#ce ----------------------------------------------------------------
Func Class_Delete($sClassName)
    ;$objSWbemService = ObjGet("Winmgmts:root\default") ;ISWbemServicesEx
    ;ConsoleWrite(ObjName($objSWbemService) & @CRLF)
    ;$objSWbemService.Delete($sClassName)
    
    If Class_Exists($sClassName) Then
        $objSWbemService = ObjGet("Winmgmts:root\default") ;ISWbemServicesEx
        ;ConsoleWrite(ObjName($objSWbemService) & @CRLF)
        $objSWbemService.Delete($sClassName)
    Else
        Return SetError(1,0,0)
    EndIf
EndFunc

#cs ===============================================================================
Function: Class_Exists
Parameters:
    $sClassName - String - Identifier name for your class
Return: 
    True/False
Errors:
    None
Notes:
    None
#ce ===============================================================================
Func Class_Exists($sClassName)
    ObjGet("Winmgmts:root\default:" & $sClassName)
    ;Local $objSWbemService = ObjGet("Winmgmts:root\default")
    ;$oClass = $objSWbemService.Get($sClassName) ;ISWbemObjectEx Object

    If NOT @ERROR Then
        Return True
    Else
        Return False
    EndIf
EndFunc

#cs ===============================================================================
Function: Class_Properties
Parameters:
    $oClass* - ISWbemObjectEx - Class object
Return: 
    ISWbemPropertySet Collection Object
Errors:
    1 - Not an object / not a ISWbemObjectEx object
Notes:
    None
#ce ===============================================================================
Func Class_Properties(ByRef $oClass)
    If IsObj($oClass) AND ObjName($oClass) = "ISWbemObjectEx" Then
        Local $oProperties = $oClass.Properties_
        ;ConsoleWrite(ObjName($oProperties) & @CRLF)
        Return $oProperties ;ISWbemPropertySet Object
    Else
        Return SetError(1,0,0)
    EndIf
EndFunc

#cs ----------------------------------------------------------------
Function: Class_Release
Parameters:
    $oClass - ISWbemObject Object
Return: 
    None    
Errors:
    1 - Not an object / not a ISWbemObjectEx object
Notes:
    None
#ce ----------------------------------------------------------------
Func Class_Release(ByRef $oClass)
    If IsObj($oClass) AND ObjName($oClass) = "ISWbemObjectEx" Then 
        $oClass.Delete_()
    Else
        Return SetError(1,0,0)
    EndIf
EndFunc

#cs ===============================================================================
Function: Class_Spawn
Parameters:
    $oClass* - ISWbemObjectEx - Class object
Return: 
    ISWbemObjectEx Object    
Errors:
    1 - Error creating ISWbemServicesEx Object
Notes:
    None
#ce ===============================================================================
Func Class_Spawn(ByRef $oClass)
    Local $oNewInst = ObjGet("Winmgmts:root\default:" & $oClass.Path_.Class)
    If @ERROR Then 
        Return SetError(1,0,0)
    Else
        $oNewInst = $oNewInst.SpawnInstance_
        Return $oNewInst
    EndIf
EndFunc

#cs ===============================================================================
Function: Collection_Count
Parameters:
    $oCollection* - ISWbemObjectSet - Collection object
Return: 
    Object count
Errors:
    1 - Not an object / not a ISWbemObjectSet object
Notes:
    None
#ce ===============================================================================
Func Collection_Count(ByRef $oCollection)
    If IsObj($oCollection) AND ObjName($oCollection) = "ISWbemObjectSet" Then 
        Return $oCollection.Count
    Else
        Return SetError(1,0,0)
    EndIf
EndFunc

#cs ===============================================================================
Function: Collection_Create
Parameters:
    $oClass* - ISWbemObjectEx - Class object
Return: 
    ISWbemObjectSet Collection Object
Errors:
    1 - Not an object / not a ISWbemObjectEx object
Notes:
    None
#ce ===============================================================================
Func Collection_Create(ByRef $oClass)
    If IsObj($oClass) AND ObjName($oClass) = "ISWbemObjectEx" Then
        ;Return $oClass.ExecQuery
        Return $objClass.Instances_ ;SWbemObjectSet Object
    Else
        Return SetError(1,0,0)
    EndIf
EndFunc

#cs ===============================================================================
Function: Collection_Debug
Parameters:
    $oCollection* - ISWbemObjectSet - Collection object
Return: 
    None
Errors:
    1 - Not an object / not a ISWbemObjectSet object
Notes:
    Dump collection and all properties of its sub objects to the console (PHP print_r style)
#ce ===============================================================================
Func Collection_Debug(ByRef $oCollection)
    If IsObj($oCollection) AND ObjName($oCollection) = "ISWbemObjectSet" Then 
        ConsoleWrite("+<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Collection Instances" & @CRLF)
        ConsoleWrite("Count: " & Collection_Count($oCollection) & @CRLF)
        
        For $oObject in $oCollection
            ;ConsoleWrite($oObject.ItemIndex & @CRLF)
            For $oProperty in Class_Properties($oObject)
                ConsoleWrite("[" & $oProperty.Name & "] => " & $oProperty.Value & @CRLF)
            Next
            ConsoleWrite("Absolute path: " & $oObject.Path_.Path & @CRLF) ;WMI Absolute Path
            ConsoleWrite("Relative path: " & $oObject.Path_.RelPath & @CRLF) ;WMI Relative Path
            ConsoleWrite(@CRLF)
        Next
    Else
        Return SetError(1,0,0)
    EndIf
EndFunc

#cs
Func ComErrHandler()
    $HexNumber = Hex($oMyError.number, 8)
    MsgBox(0, "COM Error", "COM Error Details:" & @CRLF & @CRLF & _
            "err.description is: " & @TAB & $oMyError.description & @CRLF & _
            "err.windescription:" & @TAB & $oMyError.windescription & @CRLF & _
            "err.number is: " & @TAB & $HexNumber & @CRLF & _
            "err.lastdllerror is: " & @TAB & $oMyError.lastdllerror & @CRLF & _
            "err.scriptline is: " & @TAB & $oMyError.scriptline & @CRLF & _
            "err.source is: " & @TAB & $oMyError.source & @CRLF & _
            "err.helpfile is: " & @TAB & $oMyError.helpfile & @CRLF & _
            "err.helpcontext is: " & @TAB & $oMyError.helpcontext _
            )
    SetError(1)
EndFunc  ;==>ComErrHandler
#ce