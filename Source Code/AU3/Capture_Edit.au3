#include <GDIPlus.au3>
#include <ScreenCapture.au3>

Opt("MustDeclareVars", 1)

; ====================================================================================================

; Description ...: Shows how to emboss text on an image
; Author ........: Paul Campbell (PaulIA) But now modifeid
; Notes .........: Copied from C:\Program Files\AutoIt3\Examples\GUI\Advanced\Emboss.au3
; ====================================================================================================


; ===================================================================================================
; Global variables
; ===================================================================================================
Global $hBitmap, $hImage, $hGraphic, $hFamily, $hFont, $tLayout, $hFormat, $aInfo, $hBrush1, $hBrush2
Global $iWidth, $iHeight, $hPen, $iX, $iY
Global $sString="  72ls.net  "

; ===================================================================================================
; Main
; ===================================================================================================

; Initialize GDI+ library
_GDIPlus_StartUp()

; Capture screen
$hBitmap  = _ScreenCapture_Capture(@MyDocumentsDir & '\AutoItImage.bmp', 0, 0, _
                                            @DesktopWidth / 2, @DesktopHeight /2)

; Load image and emboss text
$hImage   = _GDIPlus_ImageLoadFromFile(@MyDocumentsDir & '\AutoItImage.bmp')
$iX = _GDIPlus_ImageGetWidth ($hImage)
$iY = _GDIPlus_ImageGetHeight ($hImage)

$hGraphic = _GDIPlus_ImageGetGraphicsContext($hImage)

;Possible image enhancement methods
_GDIPlus_GraphicsDrawImageRectRectTrans($hGraphic, $hImage, 0, 0,"","",0,0,@DesktopWidth / 2, @DesktopHeight /2,"", 1)
_GDIPlus_SetSmoothingMode($hGraphic)

$hFamily  = _GDIPlus_FontFamilyCreate("Arial")
$hFont    = _GDIPlus_FontCreate($hFamily, 16, 1)
$tLayout  = _GDIPlus_RectFCreate(230, 0)
$hFormat  = _GDIPlus_StringFormatCreate(1) ; (2 - text are drawn vertically)
$hBrush1  = _GDIPlus_BrushCreateSolid(0xFFFFFFFF) ; (0x00FFFFFF - fully transparent. Alpha channel zero)
$hBrush2  = _GDIPlus_BrushCreateSolid(0xC4FF0000)
$hPen     = _GDIPlus_PenCreate(0xC4000000, 2)
$aInfo    = _GDIPlus_GraphicsMeasureString($hGraphic, $sString, $hFont, $tLayout, $hFormat)
$iWidth   = DllStructGetData($aInfo[0], "Width" )
$iHeight  = DllStructGetData($aInfo[0], "Height")
DllStructSetData($aInfo[0], "X",($iX-$iWidth)/2)
DllStructSetData($aInfo[0], "Y",($iY-$iHeight-5))

;ConsoleWrite(" $iWidth " & $iWidth  & @CRLF)
;ConsoleWrite(" $iHeight " & $iHeight  & @CRLF)

;_GDIPlus_GraphicsFillRect($hGraphic, 0, 0, $iWidth, $iHeight, $hBrush1) ; Fill BkGnd Rectangle
;_GDIPlus_GraphicsDrawRect($hGraphic, 1, 1, $iWidth, $iHeight, $hPen   ) ; Border Rectangle
_GDIPlus_GraphicsDrawStringEx($hGraphic, $sString, $hFont, $aInfo[0], $hFormat, $hBrush2)

; Save image
_GDIPlus_ImageSaveToFile($hImage, @MyDocumentsDir & '\AutoItImage2.bmp')

; Free resources
_GDIPlus_PenDispose         ($hPen    )
_GDIPlus_BrushDispose       ($hBrush1 )
_GDIPlus_BrushDispose       ($hBrush2 )
_GDIPlus_StringFormatDispose($hFormat )
_GDIPlus_FontDispose        ($hFont   )
_GDIPlus_FontFamilyDispose  ($hFamily )
_GDIPlus_GraphicsDispose    ($hGraphic)
_GDIPlus_ImageDispose       ($hImage  )
_GDIPlus_ShutDown()

; Show image
;Run("MSPaint.exe " & '"' & @MyDocumentsDir & '\AutoItImage2.bmp"')
ShellExecute ( @MyDocumentsDir & '\AutoItImage2.bmp')

Func _GDIPlus_GraphicsDrawImageRectRectTrans($hGraphics, $hImage, $iSrcX, $iSrcY, $iSrcWidth = "", $iSrcHeight = "", _
    $iDstX = "", $iDstY = "", $iDstWidth = "" , $iDstHeight = "", $iUnit = 2, $nTrans = 1)
    Local $tColorMatrix, $x, $hImgAttrib, $iW = _GDIPlus_ImageGetWidth($hImage), $iH = _GDIPlus_ImageGetHeight($hImage)
    If $iSrcWidth = 0 or $iSrcWidth = "" Then $iSrcWidth = $iW
    If $iSrcHeight = 0 or $iSrcHeight = "" Then $iSrcHeight = $iH
    If $iDstX = "" Then $iDstX = $iSrcX
    If $iDstY = "" Then $iDstY = $iSrcY
    If $iDstWidth = "" Then $iDstWidth = $iSrcWidth
    If $iDstHeight = "" Then $iDstHeight = $iSrcHeight 
    If $iUnit = "" Then $iUnit = 2 
    ;;create color matrix data
    $tColorMatrix = DllStructCreate("float[5];float[5];float[5];float[5];float[5]")
   
    ;============ Some example matrix values =================================================   
    ;Normal
    ;$x = DllStructSetData($tColorMatrix, 1, 1, 1) * DllStructSetData($tColorMatrix, 2, 1, 2) * DllStructSetData($tColorMatrix, 3, 1, 3) * _
    ;      DllStructSetData($tColorMatrix, 4, $nTrans, 4) * DllStructSetData($tColorMatrix, 5, 1, 5)
           
    ;Swap blue and red colours
    ;$x = DllStructSetData($tColorMatrix, 1, 1, 3) * DllStructSetData($tColorMatrix, 2, 1, 2) * DllStructSetData($tColorMatrix, 3, 1, 1) * _
    ;      DllStructSetData($tColorMatrix, 4, $nTrans, 4) * DllStructSetData($tColorMatrix, 5, 1, 5)
           
    ; Grey shading
    ;$x = DllStructSetData($tColorMatrix, 1, 1, 1) * DllStructSetData($tColorMatrix, 1, 1, 2) * DllStructSetData($tColorMatrix, 1, 1,3) * _
    ;      DllStructSetData($tColorMatrix,  4, $nTrans, 4) * DllStructSetData($tColorMatrix, 5, 0.1, 1) * _
    ;      DllStructSetData($tColorMatrix, 5, 0.1, 2) * DllStructSetData($tColorMatrix, 5, 0.1, 3) * DllStructSetData($tColorMatrix, 5, 1, 5)
   
    ;Brighten colours 5%
    $x = DllStructSetData($tColorMatrix, 1, 1, 1) * DllStructSetData($tColorMatrix, 2, 1, 2) * DllStructSetData($tColorMatrix, 3, 1, 3) * _
    DllStructSetData($tColorMatrix, 5, 0.05, 1) * DllStructSetData($tColorMatrix, 5, 0.05, 2) * DllStructSetData($tColorMatrix, 5, 0.05, 3) * _
            DllStructSetData($tColorMatrix, 4, $nTrans, 4) * DllStructSetData($tColorMatrix, 5, 1, 5)
    ;=================================================================================================   
   
    $hImgAttrib =  DllCall($ghGDIPDll, "int", "GdipCreateImageAttributes", "ptr*", 0)
    $hImgAttrib = $hImgAttrib[1]
     DllCall($ghGDIPDll, "int", "GdipSetImageAttributesColorMatrix", "ptr", $hImgAttrib, "int", 1, _
            "int", 1, "ptr", DllStructGetPtr($tColorMatrix), "ptr", 0, "int", 0)   
    ;;draw image into graphic object with alpha blend
    DllCall($ghGDIPDll, "int", "GdipDrawImageRectRectI", "hwnd", $hGraphics, "hwnd", $hImage, "int", $iDstX, "int", _
            $iDstY, "int", $iDstWidth, "int", $iDstHeight, "int", $iSrcX, "int", $iSrcY, "int", $iSrcWidth, "int", _
            $iSrcHeight, "int", $iUnit, "ptr", $hImgAttrib, "int", 0, "int", 0)    
    ;;clean up
    DllCall($ghGDIPDll, "int", "GdipDisposeImageAttributes", "ptr", $hImgAttrib)
    Return
EndFunc   ;==>_GDIPlus_GraphicsDrawImageRectRectTrans

; #FUNCTION# =====================================================================
; Name...........: GDIPlus_SetSmoothingMode
; Description ...: Sets the render quality of the Graphics object.
; Syntax.........: GDIPlus_SetSmoothingMode($hGraphics[, $iSmoothMode = 6])
; Parameters ....:$iSmoothMode:- Element of the SmoothingMode enumeration that specifies
;                         whether smoothing (antialiasing) is applied to lines and curves.
        ;                  SmoothingModeDefault = 0 = SmoothingModeNone
        ;                  SmoothingModeHighSpeed = 1 = SmoothingModeNone
        ;                  SmoothingModeHighQuality = 2 = SmoothingModeAntiAlias8x4
        ;                  SmoothingModeNone
        ;                  SmoothingModeAntiAlias8x4
        ;                  SmoothingModeAntiAlias = SmoothingModeAntiAlias8x4
        ;                  SmoothingModeAntiAlias8x8
; Return values .:
;                 
; Author ........:
; Modified.......:
; Remarks .......: Also been called _GDIPlus_AntiAlias($hGraphics) with $iSmoothMode = 2
;               To get the rendering quality for text, use the GetTextRenderingHint function.
;               The higher the level of quality of the smoothing mode, the slower the performance.
; Related .......:
; Link ..........; http://msdn2.microsoft.com/en-us/library/m...173(VS.85).aspx
; Example .......;
; ===============================================================================
;
Func _GDIPlus_SetSmoothingMode($hGraphics, $iSmoothMode = 6)
    Local $aResult = DllCall($ghGDIPDll, "int", "GdipSetSmoothingMode", "hwnd", $hGraphics, "int", $iSmoothMode)
    If @error Then Return SetError(@error, @extended, False)
    Return SetError($aResult[0], 0, $aResult[0] = 0)
EndFunc   ;==>GDIPlus_SetSmoothingMode