#cs ==========================================================
- Website: http://72ls.net
- Forum: http://autoit.72ls.net
- Thiết kế: Trần Minh Đức
- AutoIT: v3.3.4.0
- Chức năng: Minh họa cách hoạt động của ContinueCase
#ce ==========================================================

;~ Các Include
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

;~ Các phím nóng
HotKeySet("{ESC}", 'ExitAuto')

;~ Các biến toàn cục
Global $Title = "72ls.net"

;~ Những lệnh cần chạy trước
MainGUICreate()

;~ Vòng lặp chính
While 1
	$msg = GUIGetMsg()
	
	CheckLedGUI()
	
	If $msg = $GUI_EVENT_CLOSE Then ExitLoop
	Sleep(7)
WEnd

;~ == Các hàm chương trình ===============================================================================
;~ Lấy về những GUI mà chuột đang ở trên
Func CheckLedGUI()
	$Over = IsOver(0)
	Switch $Over
		Case 0
			SetBuzzGUI(0)
			
			If IsContinueCase() Then
				$Over = IsOver($Over+1)
				ContinueCase
			EndIf
		Case 1
			SetBuzzGUI(1)
			
			If IsContinueCase() Then
				$Over = IsOver($Over+1)
				ContinueCase
			EndIf
		Case 2
			SetBuzzGUI(2)
			
			If IsContinueCase() Then
				$Over = IsOver($Over+1)
				ContinueCase
			EndIf
		Case 3
			SetBuzzGUI(3)
			
			If IsContinueCase() Then
				$Over = IsOver($Over+1)
				ContinueCase
			EndIf
		Case 4
			SetBuzzGUI(4)
			
			If IsContinueCase() Then
				$Over = IsOver($Over+1)
				ContinueCase
			EndIf
		Case 5
			SetBuzzGUI(5)
			
			If IsContinueCase() Then
				$Over = IsOver($Over+1)
				ContinueCase
			EndIf
	EndSwitch

EndFunc

;~ Hàm kiểm tra xem có dùng ContinueCase không
Func IsContinueCase()
	If GUICtrlRead($CheckContinueCase) = 4 Then Return 0
	Return 1
EndFunc

;~ Kiểm tra xem chuột có ở trên GUI kg
Func IsOver($GUIID)
	
;~ 	Duyệt các GUI từ trên xuống
	For $i = $GUIID To $SubGUINumber-1 Step 1
		Local $GUISize = WinGetClientSize($SubGUI[$i])	;Kích thước của GUI hiện tại
		Local $GUISizeFix = 16				;Do hàm WinGetClientSize trả về kích thước GUI không chính xác nên tớ dùng biến này fix lại
		Local $MousePos = MouseGetPos()		;Vị trí chuột
		Local $GUIPosTL = $MainGUIPos		;Ranh giới phí trên GUI - Top Left
		Local $GUIPosBR[2] = [$GUIPosTL[0] + $GUISize[0] + $GUISizeFix, $GUIPosTL[1] + $GUISize[1] + $GUISizeFix]	;Ranh giới phía dưới GUI - Bottom Right
		
		If $MousePos[0] > $GUIPosTL[0] And $MousePos[1] > $GUIPosTL[1] And _				;Kiểm tra Top Left
		$MousePos[0] < $GUIPosBR[0] And $MousePos[1] <  $GUIPosBR[1] Then return $i 	;Kiểm tra Bottom Right
	Next	
	Return -1
EndFunc

;~ Chỉnh màu đèn Led
Func SetBuzzGUI($i)
	Local $Buzz = 10		;Độ rung động
	
;~ 	Kiểm tra số truyền vào để thao tác tên GUI
	GUISwitch($SubGUI[$i])	;GUI phụ
	WinMove($SubGUI[$i],'',$MainGUIPos[0]+Random($Buzz),$MainGUIPos[1]+Random($Buzz))
	
;~ 	Đổi màu GUI
	$LedColor = Hex(Dec($LedColor)*-1)
	GUICtrlSetBkColor($LedGUI[$i], $LedColor)
EndFunc

;~ Tạo GUI chính
Func MainGUICreate()
	Global $SizeAdd = 1.5				;Tỷ lệ tăng dần của các GUI Phụ
	Global $SubGUINumber = 6			;Số lượng GUI phụ
	Global $SubGUI[$SubGUINumber]		;Mảng chứa cái GUI phụ
	Global $LedColor = 0xFF0000			;Màu của đèn Led
	Global $LedGUI[$SubGUINumber+1]		;Danh sách đèn Led
	$LedSize = 10						;Kích thước đèn Led
	$LedPos = 20						;Vị trí đèn Led so với GUI

	Global $MainGUIPos[2] = [100,100]	;Vị trí của GUI
	Global $MainGUISize[2] = [150,70]	;Kích thước của GUI

;~ 	Tạo GUI chính
	$SubGUI[0] = GUICreate($Title, $MainGUISize[0], $MainGUISize[1], $MainGUIPos[0], $MainGUIPos[1])
	Global $CheckContinueCase = GUICtrlCreateCheckbox("ContinueCase",10,10)		;Nút tùy chọn dùng ContinueCase hay không 
	$LedGUI[0] = GUICtrlCreateGraphic($MainGUISize[0]-$LedPos, $MainGUISize[1]-$LedPos, $LedSize, $LedSize)	;Tạo đèn Led
	GUICtrlSetBkColor(-1, $LedColor)		;Chỉnh màu cho Đèn Led
	
;~ 	Tạo các GUI phía sau
	For $i = 0 To $SubGUINumber-2 Step 1
		Local $NewSize[2] = [$MainGUISize[0] * ($i + $SizeAdd), $MainGUISize[1] * ($i + $SizeAdd)]	;Kich thước cho các GUI phụ
		
		$SubGUI[$i+1] = GUICreate($Title, $NewSize[0], $NewSize[1], $MainGUIPos[0], $MainGUIPos[1])			;Tạo GUI phụ
		
		$LedGUI[$i+1] = GUICtrlCreateGraphic($NewSize[0]-$LedPos, $NewSize[1]-$LedPos, $LedSize, $LedSize)	;Tạo đèn Led
		GUICtrlSetBkColor(-1, $LedColor)		;Chỉnh màu cho Đèn Led
	Next
	
;~ 	Hiển thị các GUI đã tạo
	For $i = $SubGUINumber-1 To 0 Step -1
		GUISetState(@SW_SHOW,$SubGUI[$i])
	Next
	GUISetState(@SW_SHOW,$SubGUI[0])		;Hiện GUI chính
EndFunc

;~ Thoát Chương Trình
Func ExitAuto()
	Exit
EndFunc