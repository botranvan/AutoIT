#include <GuiConstants.au3>
#Include <Misc.au3>
#include <GuiConstantsEx.au3>
#include <WindowsConstants.au3>
#include <ButtonConstants.au3>
#include <StaticConstants.au3>
#include <GDIpProgress.au3>
#include <GDIPlus.au3>

#NotrayIcon

$GUI=GuiCreate("Pikachu v1.0 - SangProNhat",800,600,-1,-1,$WS_POPUP)
GUISetBkColor(0x000000)
$PICMAIN=GuiCtrlCreatePic(@ScriptDir&"\data\bk.jpg",0,0,800,600)
GuiCtrlSetState(-1,$GUI_DISABLE)
$TITLE1=GuiCtrlCreatePic(@ScriptDir&"\data\title.jpg",0,0,800,28)
GuiCtrlSetState(-1,$GUI_DISABLE)
$TITLE2=GuiCtrlCreatePic(@ScriptDir&"\data\left.jpg",0,28,20,572)
GuiCtrlSetState(-1,$GUI_DISABLE)
$BT1=GuiCtrlCreateButton("X",750,4,20,20)
GuiCtrlSetFont(-1,11,"Arial Black")
GUICtrlSetBkColor(-1,0xdfe1de)
$BT2=GuiCtrlCreateButton("-",728,4,20,20)
GuiCtrlSetFont(-1,11,"Arial Black")
GUICtrlSetBkColor(-1,0xdfe1de)
$BD=GuiCtrlCreateButton("",100,80,180,46,$BS_BITMAP)
GUICtrlSetImage(-1,@ScriptDir&"\data\bt1.bmp")
$KETHUC=GuiCtrlCreateButton("",100,80+50,180,46,$BS_BITMAP)
GUICtrlSetImage(-1,@ScriptDir&"\data\bt2.bmp")
SoundPlay(@ScriptDir&"\music\tianxianzi.mp3")

Local $LBLV,$Pro,$BtMix,$BtPau, $BtSearch, $LBTEN,$NAME,$BATDAU=0
Local $ArrCARD[12][8][2]
Local $CardX=0,$CardY=0,$CARDSECLECT=0
Local $DUONGDIx[100],$DUONGDIy[100],$DANHDAU[100],$rCount=-1,$tCount=0,$SOCARD=0,$SEC1,$DUONGDIxr[100],$DUONGDIyr[100],$tCOUNtz=0
Local $LEVELX=StringSplit("10,11,12,13,14,15,16,17",",")
Local $LEVELY=StringSplit("6,6,8,8,10,10,10,10",",")
LOCAL $Core=StringSplit("10,11,12,13,14,15,16,17",",")
Local $YOURLV=1
Local $TIME=StringSplit("2,3,4,5,6,7,8,9",","),$TIMEINIT,$PASTIME,$SCORE,$SNUM=10
GuiSetState()
While 1
   $MSG=GuiGetMSG()
   If $msg=-3 or $MSG=$BT1 or $MSG=$KETHUC then  
	  Exit
   Endif
   If $MSG=$BT2 then GuiSetState(@SW_MINIMIZE)
   $N=MouseGetPos()
   $L=WinGetPos($GUI)
   $X=$N[0]-$L[0]
   $Y=$N[1]-$L[1]
   If _IsPressed(01) and (($X>0 and $X<800 and $Y>0 and $Y<28) or ($X>0 and $X<20 and $Y>0 and $Y<572)) Then
		   $N=MouseGetPos()
		   $L=WinGetPos($GUI)
		   Do
		    $M=MouseGetPos()
		   WinMove($GUI,"",$L[0]+$M[0]-$N[0],$L[1]+$M[1]-$N[1])
		   Until not _IsPressed(01)
   Endif
   ;---------------------------------------------KHOI TAO GUI 
   If $MSG=$BD then 
	  GuiCtrlSetImage($PICMAIN,@ScriptDir&"\data\nen"&random(1,5,1)&".jpg")
	  GuiCtrlDelete($BD)
	  GuiCtrlDelete($KETHUC)
	  $LBLV=GUICtrlCreateLabel("Level 1",22,30,100,30,$SS_CENTER)
	  GUICtrlSetFont(-1,18,"Arial Black")
	  GUICtrlSetColor(-1,0xffffff)
	  $Pro=_ProgressCreate(132,33)
	  _ProgressSetImages( $Pro,@ScriptDir&"\data\green.jpg" , @ScriptDir&"\data\bg.jpg")
	  _ProgressSet($Pro,100)
	  $LBSC=GUICtrlCreateLabel("0",340,30,100,30,$SS_CENTER)
	  GUICtrlSetFont(-1,18,"Arial Black")
	  GUICtrlSetColor(-1,0xffffff)    
	  $BtMix=GUICtrlCreateButton("",450,30,32,32,$BS_BITMAP)
	  GUICtrlSetImage(-1,@ScriptDir&"\data\mix.bmp")
	  $BtPau=GUICtrlCreateButton("",495,30,32,32,$BS_BITMAP)
	  GUICtrlSetImage(-1,@ScriptDir&"\data\pause.bmp")
	 ; $BtSearch=GUICtrlCreateButton("",495+42,30,32,32,$BS_BITMAP)
	 ; GUICtrlSetImage(-1,@ScriptDir&"\data\eye.bmp")
	  $NAME=InputBox("Yeu cau !!","Nhap ten cua ban vao day : ","NONAME")
	  $LBTEN=GUICtrlCreateLabel($NAME,495+42+50,30,150,30,$SS_CENTER)
	  GUICtrlSetFont(-1,18,"Arial Black")
	  GUICtrlSetColor(-1,0xffffff)
	  ;---------------xong nen game
	  CREATELEVEL(10,6,10) ;lv 1
   Endif 
   IF $BATDAU=1 Then
		 IF $MSG>=$ArrCARD[1][1][1] and $MSG<=$ArrCARD[Ubound($ArrCARD,1)-2][Ubound($ArrCARD,2)-2][1] then 
			IF $CARDSECLECT=0 Then
			   $CARDSECLECT=1
			   $A=POSCARD($msg)
			   $CARDX=$A[0]
			   $CARDY=$A[1]
			   GUICtrlSetImage($ArrCARD[$CARDX][$CARDY][1],@ScriptDir&"\data\c"&$ArrCARD[$CARDX][$CARDY][0]&".jpg")
			Else 
			   $A=POSCARD($msg)
			   $xX=$A[0]
			   $yY=$A[1]
			   If $xX<>$CARDX or $yY<>$CARDY Then
				  If $ArrCARD[$xX][$yY][0]=$ArrCARD[$CARDX][$CARDY][0] Then
					 dim $luu=$ArrCARD[$xX][$yY][0]
					 $ArrCARD[$xX][$yY][0]=0
					 $ArrCARD[$CARDX][$CARDY][0]=0
					 $rCount=1000
					 $tCount=0
					 TIMDUONG($xX,$yY,0)
					 $ArrCARD[$xX][$yY][0]=$luu
					 $ArrCARD[$CARDX][$CARDY][0]=$luu
					 IF $rCount<>1000 Then
						GUICtrlSetImage($ArrCARD[$xX][$yY][1],@ScriptDir&"\data\c"&$ArrCARD[$xX][$yY][0]&".jpg")
						Sleep(50)
						for $i=0 to $rCount-1 step 1
						   $h1=Ubound($ArrCARD,1)*40
						   $h2=UBound($ArrCARD,2)*40
						   $m=(800-$h1)/2
						   $n=(600-$h2)/2
						   GUICtrlSetPos( $ArrCARD[$xX][$yY][1],$m+$DUONGDIx[$i]*40+$DUONGDIx[$i]*2,$n+$DUONGDIy[$i]*40+$DUONGDIy[$i]*2)
						   Sleep(50)
						Next
						$ArrCARD[$xX][$yY][0]=0
						$ArrCARD[$CARDX][$CARDY][0]=0
						GuiCtrlSetState($ArrCARD[$xX][$yY][1],$GUI_HIDE)
						GuiCtrlSetState($ArrCARD[$CARDX][$CARDY][1],$GUI_HIDE)
						$CARDSECLECT=0
						$SOCARD=$SOCARD-2
						$SCORE=$SCORE+10
						GUICtrlSetData($LBSC,$SCORE)
						SoundPlay(@ScriptDir&"\music\an.wav")
					 Else
						$CARDSECLECT=0
						GUICtrlSetImage($ArrCARD[$CARDX][$CARDY][1],@ScriptDir&"\data\"&$ArrCARD[$CARDX][$CARDY][0]&".jpg")
						SoundPlay(@ScriptDir&"\music\aaaah.wav")
					 EndIf
				  Else
					 $CARDSECLECT=0
					 GUICtrlSetImage($ArrCARD[$CARDX][$CARDY][1],@ScriptDir&"\data\"&$ArrCARD[$CARDX][$CARDY][0]&".jpg")
					 SoundPlay(@ScriptDir&"\music\aaaah.wav")
				  Endif
			   Endif
		 Endif
		 Endif
		 IF $SOCARD=0 Then
			NEXTLEVEL()
			SoundPlay(@ScriptDir&"\music\lvup.wav")
		 EndIF
		 $PASTIME=@HOUR*60+@MiN*60+@SEC-$TIMEINIT
		 
		 IF $PASTIME>=$TIME[$YOURLV]*60 then GAMEOVER()
		$PER=100-($PASTIME/($TIME[$YOURLV]*60))*100
		_ProgressSet($Pro,ROUND($PER,0))
		 If $MSG=$BtMix then 
			for $i =1 to UBound($ArrCARD,1)-2 step 1
				  for $j=1 to UBound($ArrCARD,2)-2 step 1
					 GUICtrlDelete($ArrCARD[$i][$j][1])
					 $ArrCARD[$i][$j][0]=0
					 $ArrCARD[$i][$j][1]=0
				  Next
			Next
			GuiCtrlSetData($LBLV,"LEVEL "&$YOURLV)
			CREATELEVEL($LEVELX[$YOURLV],$LEVELY[$YOURLV],$Core[$YOURLV])
			_ProgressSet($Pro,100)
		 Endif
		 If $MSG=$BtPau Then
		 Do 
			sleep(10)
		 Until GuiGetMSG()=$BtPau
		 EndIf
		 EndIF
		 
WEND
Func CREATELEVEL($x,$y,$num)
$TIMEINIT=@HOUR*60+@MiN*60+@SEC
$SOCARD=$x*$y
$CARDNUM=$x*$y/$num
ReDim $ArrCARD[$x+2][$y+2][2]
For $i=0 to Ubound($ArrCARD,1)-1 step 1
   for $j=0 to UBound($ArrCARD,2)-1 step 1
	   $ArrCARD[$i][$j][0]=0 ;khoi tao mang
	Next
Next
Dim $ArrTX[$num+1][2]
$OK=TRUE
for $i=0 to $num step 1
   $OK=True
   Do
	  $a=random(1,30,1)
	  $OK=True
	  for $j=0 to $num step 1
		 if $ArrTX[$j][0]=$a Then
			$OK=False
			ExitLoop
		 EndIf
	  Next
   Until $OK
   $ArrTX[$i][0]=$a
   $ArrTX[$i][1]=$CARDNUM
Next

$Number=0
   While $Number<>$x*$y
	   Do
		  $x1=random(1,Ubound($ArrCARD,1)-2,1)
		  $y1=random(1,UBound($ArrCARD,2)-2,1)
		  $a=random(1,$num,1)
	   Until $ArrCARD[$x1][$y1][0]=0 and $ArrTX[$a][1]<>0
	  $ArrCARD[$x1][$y1][0]=$ArrTX[$a][0]
	  $ArrTX[$a][1]= $ArrTX[$a][1]-1
	  $Number=$Number+1
   WEnd
   DRAW()
   $BATDAU=1
   $SNUM=10
EndFunc   

Func DRAW()
For $i=1 to Ubound($ArrCARD,1)-2 step 1
   for $j=1 to UBound($ArrCARD,2)-2 step 1
	   $h1=Ubound($ArrCARD,1)*40
	   $h2=UBound($ArrCARD,2)*40
	   $m=(800-$h1)/2
	   $n=(600-$h2)/2
	   $ArrCARD[$i][$j][1]=GuiCtrlCreatePic(@ScriptDir&"\data\"& $ArrCARD[$i][$j][0]&".jpg",$m+$i*40+$i*2,$n+$j*40+$j*2,40,40)
	   GUICtrlSetState( -1,$GUI_SHOW)
	Next
 Next


EndFunc

Func POSCARD($m)
DIM $A[2]
For $i=1 to Ubound($ArrCARD,1)-2 step 1
   for $j=1 to UBound($ArrCARD,2)-2 step 1
	  If $ArrCARD[$i][$j][1]=$M then 
		 $A[0]=$i
		 $A[1]=$j
		 return $A
	  Endif
   Next
Next
EndFunc

Func TIMDUONG($a,$b,$way)
if $a<0 or $a>Ubound($ArrCARD,1)-1 then return 
if $b<0 or $b>Ubound($ArrCARD,2)-1 then return 
  ; msgbox(0,$b,$a)
if    $ArrCARD[$a][$b][0]<>0 then Return
   $DUONGDIxr[$tCOUNt]=$a
   $DUONGDIyr[$tCOUNt]=$b
   $DANHDAU[$tCount]=$way
if $tCount >= 2 then
if LANRE()>2 then Return
endif
   $tCOUNt=$tCOUNt+1
   $ArrCARD[$a][$b][0]=-1
   if $a=$CardX and $b=$CardY Then
	  if $tCount<$rCount Then
		 $rCount=$tCount
		 $DUONGDIx=$DUONGDIxr
		 $DUONGDIy=$DUONGDIyr
	  EndIf
   else 
	  TIMDUONG($a-1,$b,1)
	  TIMDUONG($a+1,$b,2)
	  TIMDUONG($a,$b-1,3)
	  TIMDUONG($a,$b+1,4)
   EndIf
    $tCOUNt=$tCOUNt-1
   $ArrCARD[$a][$b][0]=0
EndFunc

Func LANRE()
dim $count
for $i=2 to $tCOUNt step 1
   if $DANHDAU[$i-1]<>$DANHDAU[$i] then $count=$count+1
Next
return $count
EndFunc
   
Func NEXTLEVEL()
for $i =1 to UBound($ArrCARD,1)-2 step 1
   for $j=1 to UBound($ArrCARD,2)-2 step 1
	  GUICtrlDelete($ArrCARD[$i][$j][1])
	  $ArrCARD[$i][$j][0]=0
	  $ArrCARD[$i][$j][1]=0
   Next
Next
$YOURLV=$YOURLV+1
GuiCtrlSetData($LBLV,"LEVEL "&$YOURLV)
CREATELEVEL($LEVELX[$YOURLV],$LEVELY[$YOURLV],$Core[$YOURLV])
_ProgressSet($Pro,100)
EndFunc

Func GAMEOVER()
   SoundPlay(@ScriptDir&"\music\game.wav")
   $ct=MsgBox(4,"Thong bao !","Da het thoi gian ban da thua ! Ban co muon choi lai khong ?")
if $ct=6 Then
for $i =1 to UBound($ArrCARD,1)-2 step 1
   for $j=1 to UBound($ArrCARD,2)-2 step 1
	  GUICtrlDelete($ArrCARD[$i][$j][1])
	  $ArrCARD[$i][$j][0]=0
	  $ArrCARD[$i][$j][1]=0
   Next
Next
$YOURLV=1
CREATELEVEL($LEVELX[$YOURLV],$LEVELY[$YOURLV],$Core[$YOURLV])
else 
Exit
EndIF

EndFunc

