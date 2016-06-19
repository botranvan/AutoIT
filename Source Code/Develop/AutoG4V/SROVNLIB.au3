;=========================================;
;==		Ten scritpt	:	SROVN Lib		==;
;==		Phien ban	:	1.0				==;
;==		Tac gia		:	Babal			==;
;=========================================;

;========================================;
;    PHAN CO DINH - KHONG CHINH SUA      ;
;========================================;

;============;
;	TOA DO   ;
;============;

Const $TD_Width			= 1
Const $TD_Height		= 2
Const $TD_Char_HP_X		= 3
Const $TD_Char_MP_X		= 3
Const $TD_Char_HP_Y		= 4
Const $TD_Char_MP_Y		= 5
Const $TD_Slot_X		= 6
Const $TD_Slot_Y		= 7
Const $TD_Mob_HP_X		= 8
Const $TD_Mob_HP_Y		= 9
Const $TD_Mob_Champ_X	= 10
Const $TD_Mob_Champ_Y	= 11
Const $TD_Mob_Giant_X	= 12
Const $TD_Mob_Giant_Y	= 13
Const $TD_Buff_Bar_X	= 14
Const $TD_Buff_Bar_Y	= 15
Const $TD_Buff_Icon_X	= 16
Const $TD_Buff_Icon_Y	= 17
Const $TD_Status_X		= 18
Const $TD_Status_Y		= 19

Const $TD_Screen800		= 1
Const $TD_Screen1024	= 2
Const $TD_Screen1280	= 3

Global $ToaDo[4][20] 

;Nhung toa do can thiet de viet script cho man hinh o do phan giai 800 x 600
$ToaDo[1][1]	= 800			; Do dai ngang man hinh
$ToaDo[1][2]	= 600			; Do dai doc man hinh
$ToaDo[1][3]	= 84			; Toa do X cua diem bat dau cua HP,MP nhan vat
$ToaDo[1][4]	= 32			; Toa do Y cua diem bat dau cua HP nhan vat
$ToaDo[1][5]	= 48			; Toa do Y cua diem bat dau cua MP nhan vat
$ToaDo[1][6]	= 304			; Toa do X cua diem ngay truoc 1/2 slot thu 1 (dung de kiem tra viec thuc thi cua slot)
$ToaDo[1][7]	= 560			; Toa do Y cua diem ngay truoc 1/2 slot thu 1 (dung de kiem tra viec thuc thi cua slot)
$ToaDo[1][8]	= 325			; Toa do X cua diem bat dau mau cua Mob
$ToaDo[1][9]	= 44			; Toa do Y cua diem bat dau mau cua Mob
$ToaDo[1][10]	= 375			; Toa do X cua bieu tuong con Mob thu linh
$ToaDo[1][11]	= 68			; Toa do Y cua bieu tuong hieu con Mob thu linh
$ToaDo[1][12]	= 380			; Toa do X cua bieu tuong hieu con Mob khong lo
$ToaDo[1][13]	= 68			; Toa do Y cua bieu tuong hieu con Mob khong lo
$ToaDo[1][14]	= 218			; Toa do X cua diem bat dau thanh thoi gian cua bieu tuong buff
$ToaDo[1][15]	= 31			; Toa do Y cua diem bat dau thanh thoi gian cua bieu tuong buff
$ToaDo[1][16]	= 219			; Toa do X goc tren ben trai bieu tuong cua chieu buff
$ToaDo[1][17]	= 11			; Toa do Y goc tren ben trai bieu tuong cua chieu buff
$ToaDo[1][18]	= 218			; Toa do X cua diem bat dau thoi gian cua bieu tuong di trang
$ToaDo[1][19]	= 60			 ;Toa do Y cua diem bat dau thoi gian cua bieu tuong di trang

;Nhung toa do can thiet de viet script cho man hinh o do phan giai 1024 x 768
$ToaDo[2][1]	= 1024
$ToaDo[2][2]	= 768
$ToaDo[2][3]	= 84
$ToaDo[2][4]	= 32
$ToaDo[2][5]	= 48
$ToaDo[2][6]	= 416
$ToaDo[2][7]	= 728
$ToaDo[2][8]	= 437
$ToaDo[2][9]	= 44
$ToaDo[2][10]	= 487
$ToaDo[2][11]	= 68
$ToaDo[2][12]	= 492
$ToaDo[2][13]	= 68
$ToaDo[2][14]	= 218
$ToaDo[2][15]	= 31
$ToaDo[2][16]	= 219
$ToaDo[2][17]	= 11
$ToaDo[2][18]	= 218
$ToaDo[2][19]	= 60

;Nhung toa do can thiet de viet script cho man hinh o do phan giai 1280 x 1024
$ToaDo[3][1]	= 1280
$ToaDo[3][2]	= 1024
$ToaDo[3][3]	= 84
$ToaDo[3][4]	= 32
$ToaDo[3][5]	= 48
$ToaDo[3][6]	= 544
$ToaDo[3][7]	= 984
$ToaDo[3][8]	= 565
$ToaDo[3][9]	= 44
$ToaDo[3][10]	= 615
$ToaDo[3][11]	= 68
$ToaDo[3][12]	= 620
$ToaDo[3][13]	= 68
$ToaDo[3][14]	= 218
$ToaDo[3][15]	= 31
$ToaDo[3][16]	= 219
$ToaDo[3][17]	= 11
$ToaDo[3][18]	= 218
$ToaDo[3][19]	= 60

;===========;
;	Ma Mau	;
;===========;

Const $MM_Char_HP_Color		= 1
Const $MM_Char_MP_Color		= 2
Const $MM_Slot_Ready_Color	= 3
Const $MM_Mob_HP_Color		= 4
Const $MM_Mob_Champ_Color	= 5
Const $MM_Mob_Giant_Color	= 6
Const $MM_Buff_Bar_Color	= 7
Const $MM_Status_Bar_Color	= 7

Global $MaMau[8]

$MaMau[1]	= 0x68040F			; Mau HP cua Char
$MaMau[2]	= 0x0F1C4C			; Mau MP cua Char
$MaMau[3]	= 0xC6BD4A			; Mau vien cua slot luc chua kich hoat
$MaMau[4]	= 0xFF3131			; Mau HP cua Mob
$MaMau[5]	= 0xA86B47			; Mau bieu tuong cua Mob Thu Linh
$MaMau[6]	= 0x0063F7			; Mau bieu tuong cua Mob Khong Lo
$MaMau[7]	= 0x00CEFF			; Mau cua thanh thoi gian cua bieu tuong nho hien ra luc buff

;=======================================;
; Cac hang ve khoang cach va chieu rong ;
;=======================================;

Const $C_Char_HP_Width	= 120	; Do dai cua thanh HP nhan vat
Const $C_Char_MP_Width	= 120	; Do dai cua thanh MP nhan vat
Const $C_Mob_HP_Width	= 165	; Do dai cua thanh HP mob
Const $C_Buff_Width		= 18	; Do dai canh hinh vuong bieu tuong buff
Const $C_Buff_Distance	= 23	; Khoang cach giua 2 diem goc tren ben trai cua 2 bieu tuong buff
Const $C_Slot_Distance	= 36	; Khoang cach giua 2 diem goc tren ben trai cua 2 slot

;===============;
; Cac hang khac ;
;===============;

Const $F1 = "{F1}"
Const $F2 = "{F2}"
Const $F3 = "{F3}"
Const $F4 = "{F4}"

;===============;
; Bien toan cuc ;
;===============;

Global $MyScreen	= 2
Global $BarDefault	= $F1
Global $BuffTime	= True

;=================================================================;

;===================;
;	HAM - THU TUC	;
;===================;

; # Chu giai
; Dung de thiet lap do phan giai cua man hinh ma SRO se chay,
; Phai thiet lap giong voi trong game thi cac ham khac moi chay dung

; # Cach dung
; Gia tri cua $Screen chi gom 1,2,3 hoac $TD_Screen800, $TD_Screen1024, $TD_Screen1280
; 1 = $TD_Screen800		= 800 x 600
; 2 = $TD_Screen1024	= 1024 x 768
; 3 = $TD_Screen1280	= 1280 x 1024

; # Vi du
; Game chay o 1280 x 1024 thi ta dung nhu sau
;---------- SCRIPT VI DU ---------------
; SetScreen(3) 
;---------- SCRIPT VI DU ---------------

Func SetScreen($Screen)
	If $Screen>0 and $Screen<4 Then
		$MyScreen = $Screen
	EndIf
EndFunc

;--------------------------------------------------------------------------------------

; # Chu giai
; Dung de lay toa do X cua bieu tuong buff theo thu tu mong muon
; Biet duoc toa do nay ta co the viet ham de xem thoi gian kich hoat cua skill buff con hay het

; # Cach dung
; Gia tri cua $SoThuTu la vi tri bieu tuong buff theo thu tu tu trai sang
; Gia tri nho nhat ma ta dien vao phai la 1

; # Vi du
; Muon lay toa do X cua chieu Wind Walk (chieu buff ma minh buff thu 2) ta dung nhu sau
;---------- SCRIPT VI DU ---------------
; $ToaDoXChieuBuffThu2 = BuffGetX(2)
;---------- SCRIPT VI DU ---------------

Func BuffGetX($SoThuTu)
	If $SoThuTu>0 Then
		Return $ToaDo[$MyScreen][$TD_Buff_Bar_X] + ($C_Buff_Distance * ($SoThuTu-1))
	Else
		Return 0
	EndIf
EndFunc

;--------------------------------------------------------------------------------------

; # Chu giai
; Dung de lay toa do X cua slot theo thu tu mong muon
; Biet duoc toa do nay ta co the viet ham de xem thoi gian kich hoat cua skill o slot con hay het

; # Cach dung
; Gia tri cua $SoThuTu la vi tri bieu tuong buff theo thu tu tu trai sang
; Gia tri nho nhat ma ta dien vao phai la 0
; Gia tri 0 hay 10 chinh la slot cuoi cung (phim 0)

; # Vi du
; Muon lay toa do X cua chieu o slot thu 3 ta dung nhu sau
;---------- SCRIPT VI DU ---------------
; $ToaDoXSlotThu3 = SlotGetX(3)
;---------- SCRIPT VI DU ---------------

Func SlotGetX($SoThuTu)
	If $SoThuTu=0 Then $SoThuTu = 10
	If $SoThuTu>0 and $SoThuTu<=10 Then
		Return $ToaDo[$MyScreen][$TD_Slot_X] + ($C_Slot_Distance * ($SoThuTu -1))
	Else
		Return 0
	EndIf
EndFunc
;--------------------------------------------------------------------------------------

; # Chu giai
; Dung de lay checksum tai vi tri tung bieu tuong da duoc kick hoat (ke ben cai o co HP voi MP)
; Checksum ko biet dich tieng Viet ra sao nhung dai khai neu trong cai vung ma minh lay checksum
; neu co pixel nao thay doi thi checksum se khac nhau
; Thich hop de kiem tra xem skill buff da het tac dung hay chua

; # Cach dung
; Gia tri cua $SoThuTu la vi tri bieu tuong buff theo thu tu tu trai sang
; Gia tri nho nhat ma ta dien vao phai la 1

; # Vi du
; De so sanh 2 cai checksum tai vung cua bieu tuong buff dau tien o 2 thoi diem de xem co gi khac khong ta lam nhu sau
; Luu y ta co the dung BuffChecksum(1) hoac BuffChecksum() deu duoc vi mac dinh $SoThuTu = 1
;---------- SCRIPT VI DU ---------------
; $ChecksumTruoc	=  BuffChecksum()
; Sleep(1000)
; $ChecksumSau		= BuffChecksum()
; If $ChecksumTruoc <> $ChecksumSau Then // Dieu nay co nghia chieu buff o vi tri dau tien da het
;	//Viet script de Buff Lai o day
; EndIf
;---------- SCRIPT VI DU ---------------

Func BuffChecksum($SoThuTu=1)
	$left	= $ToaDo[$MyScreen][$TD_Buff_Icon_X] + ($C_Buff_Distance * ($SoThuTu-1))
	$top	= $ToaDo[$MyScreen][$TD_Buff_Icon_Y]
	$right	= $left + $C_Buff_Width
	$bottom	= $top + $C_Buff_Width
	$BuffCheckSum	= PixelChecksum($left,$top,$right,$bottom)
	Return $BuffCheckSum
EndFunc

;--------------------------------------------------------------------------------------

Func MobIsSelected()
	$ToaDo_X	= $ToaDo[$MyScreen][$TD_Mob_HP_X]
	$ToaDo_Y	= $ToaDo[$MyScreen][$TD_Mob_HP_Y]
	If PixelGetColor($ToaDo_X, $ToaDo_Y) = $MaMau[$MM_Mob_HP_Color] Then
		Return True
	Else
		Return False
	EndIf
EndFunc

;--------------------------------------------------------------------------------------

Func MobIsChamp()
	$ToaDo_X	= $ToaDo[$MyScreen][$TD_Mob_Champ_X]
	$ToaDo_Y	= $ToaDo[$MyScreen][$TD_Mob_Champ_Y]
	If PixelGetColor($ToaDo_X, $ToaDo_Y) = $MaMau[$MM_Mob_Champ_Color] Then
		Return True
	Else
		Return False
	EndIf
EndFunc

;--------------------------------------------------------------------------------------

Func MobIsGiant()
	$ToaDo_X	= $ToaDo[$MyScreen][$TD_Mob_Giant_X]
	$ToaDo_Y	= $ToaDo[$MyScreen][$TD_Mob_Giant_Y]
	If PixelGetColor($ToaDo_X, $ToaDo_Y) = $MaMau[$MM_Mob_Giant_Color] Then
		Return True
	Else
		Return False
	EndIf
EndFunc

;--------------------------------------------------------------------------------------

Func MobGetHP()
	$ToaDo_X	= $ToaDo[$MyScreen][$TD_Mob_HP_X]
	$ToaDo_Y	= $ToaDo[$MyScreen][$TD_Mob_HP_Y]
	for $i=0 To 164 step 1
		$coord = PixelSearch($ToaDo_X + $i,$ToaDo_Y,$ToaDo_X + $i,$ToaDo_Y,$MaMau[$MM_Mob_HP_Color],10,1)
		if @error Then
			$KetQua = $i*100/165
			exitloop
		Else
			$KetQua=100
		EndIf
	Next
	Return $KetQua
EndFunc

;--------------------------------------------------------------------------------------

Func SkillWaitReady($SlotNumber)
	$ToaDo_X	= SlotGetX($SlotNumber)
	$ToaDo_Y	= $ToaDo[$MyScreen][$TD_Slot_Y]
	while Hex(PixelGetColor($ToaDo_X,$ToaDo_Y))<>Hex($MaMau[$MM_Slot_Ready_Color])
		Sleep(100)
	WEnd
EndFunc

;--------------------------------------------------------------------------------------

Func SkillWaitActive($SlotNumber)
	$ToaDo_X	= SlotGetX($SlotNumber)
	$ToaDo_Y	= $ToaDo[$MyScreen][$TD_Slot_Y]
	while Hex(PixelGetColor($ToaDo_X,$ToaDo_Y))=Hex($MaMau[$MM_Slot_Ready_Color])
		if not MobIsSelected() then ExitLoop
		Send($SlotNumber)
		Sleep(100)
	WEnd
EndFunc

;--------------------------------------------------------------------------------------

Func SkillWaitActive2($SlotNumber1,$SlotNumber2)
	$ToaDo_X1	= SlotGetX($SlotNumber1)
	$ToaDo_X2	= SlotGetX($SlotNumber2)
	$ToaDo_Y	= $ToaDo[$MyScreen][$TD_Slot_Y]
	while Hex(PixelGetColor($ToaDo_X1,$ToaDo_Y))=Hex($MaMau[$MM_Slot_Ready_Color]) and Hex(PixelGetColor($ToaDo_X2,$ToaDo_Y))=Hex($MaMau[$MM_Slot_Ready_Color])
		if not MobIsSelected() then ExitLoop
		Send($SlotNumber1)
		Sleep(500)
		Send($SlotNumber2)
		Sleep(500)
	WEnd
EndFunc

;--------------------------------------------------------------------------------------

Func AutoPickup()
	Send("g")
	Sleep(500)
EndFunc

;--------------------------------------------------------------------------------------

Func AutoHP($Percentage=50,$SlotNumber=0)
	$ToaDo_X	= $ToaDo[$MyScreen][$TD_Char_HP_X] + (($Percentage/100)*$C_Char_HP_Width)
	$ToaDo_Y	= $ToaDo[$MyScreen][$TD_Char_HP_Y]
	$coord = PixelSearch($ToaDo_X, $ToaDo_Y, $ToaDo_X, $ToaDo_Y, $MaMau[$MM_Char_HP_Color], 10, 1)
	If @error Then
		Send($SlotNumber)
		Sleep(300)
	EndIf
EndFunc	

;--------------------------------------------------------------------------------------

Func AutoMP($Percentage=50,$SlotNumber=9)
	$ToaDo_X	= $ToaDo[$MyScreen][$TD_Char_MP_X] + (($Percentage/100)*$C_Char_MP_Width)
	$ToaDo_Y	= $ToaDo[$MyScreen][$TD_Char_MP_Y]
	$coord = PixelSearch($ToaDo_X, $ToaDo_Y, $ToaDo_X, $ToaDo_Y, $MaMau[$MM_Char_MP_Color], 10, 1)
	If @error Then
		Send($SlotNumber)
		Sleep(300)
	EndIf
EndFunc

;--------------------------------------------------------------------------------------

Func AutoPill($SlotNumber=8)
	$ToaDo_X	= $ToaDo[$MyScreen][$TD_Status_X]
	$ToaDo_Y	= $ToaDo[$MyScreen][$TD_Status_Y]
	If PixelGetColor($ToaDo_X,$ToaDo_Y)=$MaMau[$MM_Status_Bar_Color] Then
		Send($SlotNumber)
		Sleep(500)
	EndIf	
EndFunc

;--------------------------------------------------------------------------------------

Func AutoHeal($FillPercentage=90,$SlotNumber=0,$Bar="{F4}")
	$ToaDo_X	= $ToaDo[$MyScreen][$TD_Char_HP_X] + (($FillPercentage/100)*$C_Char_HP_Width)
	$ToaDo_Y	= $ToaDo[$MyScreen][$TD_Char_HP_Y]
	$coord 		= PixelSearch($ToaDo_X, $ToaDo_Y, $ToaDo_X, $ToaDo_Y, $MaMau[$MM_Char_HP_Color], 10, 1)
	If @error Then
		Send($Bar)
		Sleep(300)
		SkillWaitReady($SlotNumber)
		Send($SlotNumber)
		Sleep(300)
		Send($BarDefault)
		Sleep(300)
	EndIf
EndFunc

;--------------------------------------------------------------------------------------

Func AutoCure($SlotNumber=9,$Bar="{F4}")
	$ToaDo_X	= $ToaDo[$MyScreen][$TD_Status_X]
	$ToaDo_Y	= $ToaDo[$MyScreen][$TD_Status_Y]
	If PixelGetColor($ToaDo_X,$ToaDo_Y)=$MaMau[$MM_Status_Bar_Color] Then
		Send($Bar)
		Sleep(300)
		SkillWaitReady($SlotNumber)
		Send($SlotNumber)
		Sleep(300)
		Send($BarDefault)
		Sleep(300)
	EndIf
EndFunc

;--------------------------------------------------------------------------------------

Func AutoBuff($BuffCount,$Bar="{F4}")
	If $BuffTime	= True Then
		For $i=1 to $BuffCount
			Send($Bar)
			Sleep(300)
			Send($i)
			Sleep(3000)
			Send($BarDefault)
			Sleep(300)
		Next
		$BuffTime	= False
	Else
		$ToaDo_X	= $ToaDo[$MyScreen][$TD_Buff_Bar_X]
		$ToaDo_Y	= $ToaDo[$MyScreen][$TD_Buff_Bar_Y]+1
		If hex(PixelGetColor($ToaDo_X,$ToaDo_Y))<>0x000000 Then
				$BuffTime = True
		EndIf
	EndIf
EndFunc

;--------------------------------------------------------------------------------------