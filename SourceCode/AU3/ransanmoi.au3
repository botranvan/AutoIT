; Silver Shooter
; Khai báo thư viện thôi nhìn cái gì ?
#include <Misc.au3>
#Include <WinAPI.au3>
#Include <WindowsConstants.au3>

; Những Function Cần thiết
Func Dot($mxo,$myo,$color,$size) ; Funcion đồ họa duy nhất của game (đơn giản chỉ là chấm điểm ở vị trí tọa độ [$mxo,$myo]
$hPen = _WinAPI_CreatePen($PS_DASH, $size, $color)              ; 2 còn lại $size với $color tra từ điển nếu k biết
$obj_orig = _WinAPI_SelectObject($hDC, $hPen)
_WinAPI_DrawLine($hDC, $mxo-1, $myo-1, $mxo, $myo)
_WinAPI_SelectObject($hDC, $obj_orig)
_WinAPI_DeleteObject($hPen)
EndFunc



Func _Exit() ; Thoát ra game cũng phải tắt này nọ đàng hoàng rồi mới thoát
DllClose($user32_dll)
_WinAPI_ReleaseDC($hGUI, $hDC)
Exit
EndFunc

; Khai báo hot key
HotKeySet("!q", "_Exit") ; Game nhẹ nên thoát chỉ cần phím tắt là đủ

; Khai báo hằng số và những thủ tục tạo GUI màn hình trong suốt bla bla bla bla
$dll = DllOpen("user32.dll")
Global Const $pi = 3.14159265358979                                                     ; (không nên xem ... thằng viết cái này cũng chẳng xem khúc này)
Global Const $hFullScreen = WinGetHandle("Program Manager")
Global Const $aFullScreen = WinGetPos($hFullScreen)
Global Const $hGUI = GUICreate("", $aFullScreen[2], $aFullScreen[3], $aFullScreen[0], $aFullScreen[1], $WS_POPUP, BitOR($WS_EX_LAYERED,$WS_EX_TRANSPARENT))
GuiSetBkColor(0xABCDEF) ; Tạo màu nền GUI trong suốt
_WinAPI_SetLayeredWindowAttributes($hGUI, 0xABCDEF, 0xA0) ; Biết chết liền hình như là set màu trong suốt là màu 0xABCDEF
WinSetOnTop($hGUI, "", 1) ; Cái này để đè nền đó mà để nó luôn nằm trên chương trình khác
GuiSetState() ; Dòng này rất là quan trọng không có nó không vẽ đc và cũng k biết vì sao ...
Global Const $hDC = _WinAPI_GetWindowDC($hGUI) ; Thủ tục thôi
Global Const $user32_dll = DllOpen("user32.dll") ; Thủ tục thôi
Global $Snake [999999][3] ; Cứ cho con rắn mấy bạn chơi đc tới 999999 đốt đi
                                                        ; Cái chiều thứ 2 có 3 dòng tức là 2 tọa độ x và y của 999999 đốt
                                                         ; một dòng nữa là để xác định chiều bò
Global $Food [2] ; 2 giá trị xác định vị trí thức ăn
;<======================================================================================> Phần chính
$time = 0 ; Chọn mốc thời gian bằng 0
$Len = 8; Mới đầu cho con rắn dài 8 đốt
For $i = 1 To $Len Step 1 ; Đặt vị trí 8 đốt
        $Snake[$i][0] = 300 ; Mới đầu nó nằm dọc ở tọa độ x là 300
        $Snake[$i][1] = 300-$i*5 ; Trải dài theo chiều dọc với khoảng cách tiêu điểm của mỗi đốt là 5 Pixel
        $Snake[$i][2] = "down"          ; Bò xuống
Next

$check = 0 ; Kiểm tra coi có thức ăn không
While 1
        If $Check = 0 Then
                $Check = 1      ; Check đã có thức ăn
                $Food[0] = Random(20,$aFullScreen[2]-20) ; Cho thức ăn random
                $Food[1] = Random(20,$aFullScreen[3]-20)
        EndIf
        If sqrt(($Food[0] - $Snake[1][0])*($Food[0] - $Snake[1][0]) + ($Food[1] - $Snake[1][1])*($Food[1] - $Snake[1][1])) < 20 Then
                $check = 0 ; Nếu ăn được thức ăn thì mất thức ăn đó
                $Len = $Len + 8 ; Dài ra
        EndIf

        For $i = $Len to 2 Step -1                              ; Cho các đốt sau di chuyển lên vị trí đốt trước đó
                If ($Snake[$i][0] = $Snake[1][0]) and ($Snake[$i][1] = $Snake[1][1]) Then ; Nếu cắn phải đuôi
                        MsgBox(4096, "Snake", "Game over")
                        Exit
                EndIf
                $Snake[$i][0] = $Snake[$i - 1][0]
                $Snake[$i][1] = $Snake[$i - 1][1]
                $Snake[$i][2] = $Snake[$i - 1][2]
        Next
        If $Snake[$i][2] = "down" Then                  ; Điều khiển đốt đầu
                $Snake[$i][1] = $Snake[$i][1] + 5
        EndIf
        If $Snake[$i][2] = "up" Then
                $Snake[$i][1] = $Snake[$i][1] - 5
        EndIf
        If $Snake[$i][2] = "right" Then
                $Snake[$i][0] = $Snake[$i][0] + 5
        EndIf
        If $Snake[$i][2] = "left" Then
                $Snake[$i][0] = $Snake[$i][0] - 5
        EndIf
        Select
        Case _IsPressed("26", $dll) and ($Snake[1][2] <> "down")
                $Snake[1][2] = "up"
        Case _IsPressed("27", $dll) and ($Snake[1][2] <> "left")
                $Snake[1][2] = "right"
        Case _IsPressed("28", $dll) and ($Snake[1][2] <> "up")
                $Snake[1][2] = "down"
        Case _IsPressed("25", $dll) and ($Snake[1][2] <> "right")
                $Snake[1][2] = "left"
        EndSelect


        If $Snake[1][0] > $aFullScreen[2] then $Snake[1][0] = 0 ;Bò ra đầu này xuất hiện đầu kia
        If $Snake[1][0] < 0 then $Snake[1][0] = $aFullScreen[2]
        If $Snake[1][1] > $aFullScreen[3] then $Snake[1][1] = 0
        If $Snake[1][1] < 0 then $Snake[1][1] = $aFullScreen[3]

;~              $x = 500 + 5*Cos($pi*$time + 0*$pi/4)           Phần này là công thức dao động Lý lớp 12 (x = A0 + A*cos(wt + phi))
;~      Dot($x,500,0xFF0000,10)
;~              $x = 500 + 5*Cos($pi*$time + 1*$pi/4)           Với sự trễ pha pi/4 qua từng đốt ta được sự lượn lượn ảo ảo của sneak
;~      Dot($x,495,0xFF0000,10)
;~              $x = 500 + 5*Cos($pi*$time + 2*$pi/4)           Và với 1 chu kì tức là 2*pi thì quay lại ban đầu
;~      Dot($x,490,0xFF0000,10)
;~              $x = 500 + 5*Cos($pi*$time + 3*$pi/4)           Vậy ta chỉ cần lấy số đốt mod (chia lấy phần dư) cho 8 là sẽ biết đc cần
;~      Dot($x,485,0xFF0000,10)
;~              $x = 500 + 5*Cos($pi*$time + 4*$pi/4)           bao nhiêu pi/4
;~      Dot($x,480,0xFF0000,10)
;~              $x = 500 + 5*Cos($pi*$time + 5*$pi/4)
;~      Dot($x,475,0xFF0000,10)
;~              $x = 500 + 5*Cos($pi*$time + 6*$pi/4)
;~      Dot($x,470,0xFF0000,10)
;~              $x = 500 + 5*Cos($pi*$time + 7*$pi/4)
;~      Dot($x,465,0xFF0000,10)
;~              $x = 500 + 5*Cos($pi*$time + 0*$pi/4)
;~      Dot($x,460,0xFF0000,10)

        GuiSetBkColor(0xABCDEF) ; Clear màn hình rồi vẽ lại liền
        ; Cái thân
        For $i = 2 To $Len Step 1
                If ($Snake[$i][2] = "up") or ($Snake[$i][2] = "down") Then ; Nếu như lượng theo chiều ngang
                        Dot($Snake[$i][0] + 5*Cos($pi*$time + Mod($i,8)*$pi/4),$Snake[$i][1],0x00FF00,10) ; Xem công thức phần trên ...
                Else ; Nếu như lượng theo chiều dọc
                        Dot($Snake[$i][0],$Snake[$i][1] + 5*Cos($pi*$time + Mod($i,8)*$pi/4),0x00FF00,10) ; Đổi vai trò x và y trong hệ trục Đề-các
                EndIf                                                                   ; + 5*Cos($pi*$time + Mod($i,8)*$pi/4) phần code này chỉ đóng vai trò làm đốt dao động
        Next
        ; Cái đầu đặc biệt nên làm riêng
        If ($Snake[1][2] = "up") or ($Snake[1][2] = "down") Then  ; Nếu như lượng theo chiều ngang
                Dot($Snake[1][0] + 7.5*Cos($pi*$time + 1*$pi/4),$Snake[1][1],0x0000FF,15) ; Xem công thức phần trên ...
        Else ; Nếu như lượng theo chiều dọc
                Dot($Snake[1][0],$Snake[1][1] + 7.5*Cos($pi*$time + 1*$pi/4),0x0000FF,15) ; Đổi vai trò x và y trong hệ trục Đề-các
        EndIf                                                                   ; + 5*Cos($pi*$time + Mod($i,8)*$pi/4) phần code này chỉ đóng vai trò làm đốt dao động
        ; Thức ăn
        Dot(INT($Food[0]),INT($Food[1]),0xFF0000,10)
        Sleep(33) ; Tại sao lại là 33 hả? Bởi vì nếu muốn 30 FPS (30 khung hình trên giây là mượt rồi) thì cần
                                ; mỗi khung hình là 33.33(3) giây vậy ăn gian mất 0.33(3) giây của ng` ta ?
                                 ; bình tĩnh ... 0.33(3) giây đó cứ cho là thời gian chạy code đi =)
        $time = $time + 1000/33 ; Đúng thời gian ngủ + chạy code nhé
WEnd