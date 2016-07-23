#include <_SQLConnect.au3>
#include <GUIConstantsEx.au3>
#include <ComboConstants.au3>
Global $Conn;
$GUI = GUICreate("Test SQL Connect", 500, 305, -1, -1)
GUICtrlCreateLabel("Server Name:", 5, 10) 
$txtServer = GUICtrlCreateCombo("", 75, 8, 120, 18)
GUICtrlSetData($txtServer, ".\SQLEXPRESS")
$btnConnect = GUICtrlCreateButton("Connect", 200, 6, 100, 24)
$btnDisConnect = GUICtrlCreateButton("Dis Connect", 305, 6, 100, 24)
GUICtrlSetState($btnDisConnect, $GUI_DISABLE)
GUICtrlCreateLabel("Data Name:", 5, 40)
$txtDataBase = GUICtrlCreateCombo("", 75, 38, 120, 18, 0x0003)
GUICtrlCreateLabel("Table Name:", 5, 70)
$txtTable = GUICtrlCreateCombo("", 75, 68, 120, 18, 0x0003)
$listView = GUICtrlCreateListView("", 5, 100, 490, 200)
GUICtrlCreateLabel("Query", 438, 10)
$txtQuery = GUICtrlCreateEdit("Select * from [Table]", 200, 40, 205, 50, 0x0004)
$btnExec = GUICtrlCreateButton("Execute", 420, 40, 65, 50)
GUISetState()
While 1
	 $nMsg = GUIGetMsg()
    Switch $nMsg
		Case $GUI_EVENT_CLOSE
			Exit
		Case $btnConnect
			
			If GUICtrlRead($txtServer) <> "" Then
				$Conn = _SQlConnection(GUICtrlRead($txtServer))
				If _SQLState($Conn) =1 Then
					_SQLClose($Conn)
				EndIf
					If _SQLOpen($Conn) = 1 Then
						GUICtrlSetState($btnConnect, $GUI_DISABLE)
						GUICtrlSetState($btnDisConnect, $GUI_ENABLE)
						Local $Array = _SQL_GetDataBases($Conn)
						Local $DBName = $Array[1]
						GUICtrlSetData($txtDataBase, "")
						For $i = 0 To UBound($DBName) -1
							GUICtrlSetData($txtDataBase, $DBName[$i][0])
						Next	
						
					Else
						MsgBox(0, "Error !", "Cannot Connect SQL Server !")
					EndIf	
			Else
				MsgBox(0, "Error !", "Choice SQL Server Name Or Input Server Name from  Server Name ComboBox !")
			EndIf
		Case $btnDisConnect
			_SQLClose($Conn)
			GUICtrlSetData($txtDataBase, "")
			GUICtrlSetState($btnConnect, $GUI_ENABLE)
			GUICtrlSetState($btnDisConnect, $GUI_DISABLE)
		Case $txtDataBase
			Local $Array =  _SQL_GetNameTables($Conn, GUICtrlRead($txtDataBase))
					GUICtrlSetData($txtTable, "")
					Local $TableName = $Array[1]
					For $i = 0 To UBound($TableName) -1
						GUICtrlSetData($txtTable, $TableName[$i][0])
					Next	
		Case $txtTable
			Local $Array =  _SQL_GetColumnInfor($Conn, GUICtrlRead($txtDataBase), GUICtrlRead($txtTable))
			_AppendToListView($listView, $Array)
			$StrQuery = GUICtrlRead($txtQuery)
			GUICtrlSetData($txtQuery, "")
			GUICtrlSetData($txtQuery, StringLeft($StrQuery, StringInStr($StrQuery, "[")) & GUICtrlRead($txtTable) & StringRight($StrQuery, StringLen($StrQuery) -  StringInStr($StrQuery, "]") +1))
		Case $btnExec
			If _SQLState($Conn) =1 Then
				Local $Query = "Use " & GUICtrlRead($txtDataBase) & " " & GUICtrlRead($txtQuery)
				Local $Array = _SQLQuery($Conn, $Query, 1)
				_AppendToListView($listView, $Array)
			EndIf
    EndSwitch
WEnd
