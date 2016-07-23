#cs
 Author : lenggiauit  | Lenggiauit@yahoo.com;
 Localtion : Viet Nam
 Function : AutoIT Connect SQL;
#ce
#include-once
#include <GuiListView.au3>
#cs
	Function Name	: _SQlConnection
	Description		: Connect SQL 
	Syntax			: _SQlConnection($SQl_Server, $SQL_Attach = "",$SQL_Database = "", $SQL_User = "", $SQL_Pass = "" , $SQL_Driver = "{SQL Server}", $SQL_TimeOut = 30)
	Parameter(s)	:  	+ $SQl_Server -> SQL Server 
							Example : .\SQLEXPRESS
						+ $SQL_Attach -> SQL attach to Server or file(*.mdf) 
							 "" or "Server" == Attach Server
							*.MDF ==  Attach File MDF
							Example : - c:\mydbfile.mdf 
									  - |DataDirectory|mydbfile.mdf 	
					   + $SQL_Database- Database Name 
					   + $SQL_User : User Login SQL
					   + $SQL_Pass : Pass Login SQL
					   + $SQL_Driver : Driver Connect, default {SQL Server}
					   + $SQL_TimeOut : Time out Connect default : 30 s;
	Author:        Lenggiauit | Lenggiauit@yahoo.com
#ce

Func _SQlConnection($SQl_Server, $SQL_Database = "", $SQL_Attach = "", $SQL_User = "", $SQL_Pass = "" , $SQL_Driver = "{SQL Server}", $SQL_TimeOut = 30)
	$SQLConnection = ObjCreate( "ADODB.Connection" )
	If Not IsObj($SQLConnection) Then 
		Return 0;
	ElseIf  $SQL_Attach = "" Or $SQL_Attach = "Server" Then
		$SQLConnection.ConnectionString = "DRIVER=" 			& $SQL_Driver & _
										  ";SERVER=" 			& $SQl_Server & _ 
										  ";DATABASE="			& $SQL_Database & _
										  ";UID=" 				& $SQL_User & _
										  ";PWD=" 				& $SQL_Pass & _ 
										  ";Connect Timeout=" 	& $SQL_TimeOut & _ 
										  ";Trusted_Connection=Yes" 
	ElseIf StringInStr($SQL_Attach, "mdf") <> 0 Then
		$SQLConnection.ConnectionString = "DRIVER=" 			& $SQL_Driver & _
										  ";SERVER=" 			& $SQl_Server & _
										  ";AttachDbFilename="	& $SQL_Attach & _	
										  ";DATABASE="			& $SQL_Database & _
										  ";UID=" 				& $SQL_User & _
										  ";PWD=" 				& $SQL_Pass & _ 
										  ";Connect Timeout=" 	& $SQL_TimeOut & _ 
										  ";Trusted_Connection=Yes"
	EndIf
	Return 	$SQLConnection;							  
EndFunc

#cs
	Function Name	: _SQlOpen
	Description		: Open Connect SQL
	Syntax			: _SQLOpen($SQLConnection)
	Parameter(s)	: Object Connection	
    Return 			: 1 Open OK
					: 0 Open False
	Author:        Lenggiauit | Lenggiauit@yahoo.com
#ce
Func _SQLOpen($SQLConnection)
	$SQLConnection.open
	Return $SQLConnection.State
EndFunc	
#cs
	Function Name	: _SQlClose
	Description		: Close Connect SQL
	Syntax			: _SQLClose($SQLConnection)
	Parameter(s)	: Object Connection
	Return 			: 0 Close OK
					: 1 Close False
	Author:        Lenggiauit | Lenggiauit@yahoo.com
#ce
Func _SQLClose($SQLConnection)
	$SQLConnection.close
	Return $SQLConnection.State
EndFunc	

Func _SQLState($SQLConnection)
	Return $SQLConnection.State
EndFunc

#cs
	Function Name	: _SQLQuery
	Description		: Query SQL
	Syntax			: _SQLQuery($SQLConnection, $Query, $Callback = 0)
	Parameter(s)	: 
						+ $SQLConnection = Object Connection
						+ $Query = SQL Query
						+ $Callback = return result query default = 0; option : 0 or 1
							 + 0 : Return: 	1 = Query Success !
											0 = Query Error ! 
							 + 1 : Return:	1 = Query success !
											Array = result of query
												Array[0] == Fields
												Array[1] == Rows
											0 = Query Error ! 
	Return 			: 1 OK
					: 0 False
	Author:        Lenggiauit | Lenggiauit@yahoo.com
#ce
Func _SQLQuery($SQLConnection, $Query, $Callback = 0)
	ObjEvent("AutoIt.Error", "_Error")
	If Not IsObj($SQLConnection) Then
		Return 0
	ElseIf $SQLConnection.State = 1 Then
		If $Callback = 0 Then
			$SQLConnection.Execute($Query)
			If Not @error Then Return 1
		ElseIf $Callback = 1 Then
			$SQLRecordSet = ObjCreate( "ADODB.RecordSet" ) 
			If IsObj($SQLRecordSet) Then
				$SQLRecordSet = $SQLConnection.Execute($Query)
				If $SQLRecordSet.State  = 1 Then
					Local $Fields[$SQLRecordSet.Fields.Count]
					For $i = 0 to $SQLRecordSet.Fields.Count -1
						$Fields[$i] = $SQLRecordSet.Fields($i).Name
					Next
						Local $Rows = $SQLRecordSet.GetRows( -1, 0)
						Local $Data[2] 
							  $Data[0] = $Fields
							  $Data[1] = $Rows
					Return $Data
				Else
					Return 0
				EndIf
				If Not @error Then Return 1
			Else
				Return 0
			EndIf	
		EndIf
	Else
		Return 0
	EndIf
EndFunc
#cs
	Function Name	: _SQL_GetDataBases
	Description		: Query SQL
	Syntax			:_SQL_GetDataBases($SQLConnection)
	Parameter(s)	: 
						+ $SQLConnection = Object Connection
						
	Return 			: Array
						Array[0] = Fields 
						Array[1] = Data 
					: 0 False
	Author:        Lenggiauit | Lenggiauit@yahoo.com
#ce

Func _SQL_GetDataBases($SQLConnection)
	Local $DataBases
	$DataBases = _SQLQuery($SQLConnection, "EXEC sp_helpdb", 1)
	Return $DataBases
EndFunc
#cs
	Function Name	: _SQL_GetNameTables
	Description		: Query SQL
	Syntax			:_SQL_GetNameTables($SQLConnection, $DatabaseName)
	Parameter(s)	: 
						+ $SQLConnection = Object Connection
						+ $DatabaseName = Database Name 
						
	Return 			: Array
						Array[0] = Fields 
						Array[1] = Data 
					: 0 False
	Author:        Lenggiauit | Lenggiauit@yahoo.com
#ce
Func _SQL_GetNameTables($SQLConnection, $DatabaseName)
	Local $TableNames
	If _SQLQuery($SQLConnection, "Use " & $DatabaseName) =1 Then
		$TableNames =  _SQLQuery($SQLConnection, "SELECT Name FROM sys.tables", 1)
	EndIf	
	Return $TableNames
EndFunc
#cs
	Function Name	: _SQL_GetColumnInfor
	Description		: Query SQL
	Syntax			:_SQL_GetColumnInfor($SQLConnection, $DatabaseName, $Table)
	Parameter(s)	: 
						+ $SQLConnection = Object Connection
						+ $DatabaseName = Database Name 
						+ $Table = Table Name in Database
						
	Return 			: Array
						Array[0] = Fields 
						Array[1] = Data 
					: 0 False
	Author:        Lenggiauit | Lenggiauit@yahoo.com
#ce
Func _SQL_GetColumnInfor($SQLConnection, $DatabaseName, $Table)
	Local $TableInfor
	If _SQLQuery($SQLConnection, "Use " & $DatabaseName) = 1 Then
		Local $StrQuery = "SELECT Column_Name as 'Column Name', " & _
												 "data_type as 'Data type', "& _ 
												 "character_maximum_length as 'Data Length'" & _ 
												 "FROM information_schema.columns " & _ 
												 "WHERE TABLE_NAME = '" & $Table & "'"
		$TableInfor =  _SQLQuery($SQLConnection, $StrQuery, 1)
	EndIf	
	Return $TableInfor
EndFunc	
; Function _Error _ AutoIt.Error ObjEvent
Func _Error()
	Return 0;
EndFunc
#cs
	Function Name	: _AppendToListView
	Description		: Append result Query To ListView
	Syntax			:_AppendToListView($hListView, $Array, $cWidth = 100)
	Parameter(s)	: 
						+ $hListView = ListView  Control
						+ $Array == result Of _SQLQuery($SQLConnection, $Query, $Callback = 0)
						+ $cWidth == Width Of Column
	Author:        Lenggiauit | Lenggiauit@yahoo.com
#ce
Func _AppendToListView($hListView, $Array, $cWidth = 100)
	$hColumn = _GUICtrlListView_GetColumnCount($hListView)
	For $i = 0 To _GUICtrlListView_GetColumnCount($hListView)
		 _GUICtrlListView_DeleteColumn($hListView, $i)
	Next
	_GUICtrlListView_DeleteAllItems($hListView)
	Local $ColumnHeader = $Array[0]
	Local $Item = $Array[1]
	For $i =0 To UBound($ColumnHeader) -1
		_GUICtrlListView_AddColumn($hListView, $ColumnHeader[$i], $cWidth)
	Next
	_GUICtrlListView_AddArray($hListView, $Item)
EndFunc	




