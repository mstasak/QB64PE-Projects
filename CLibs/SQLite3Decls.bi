'TODO: revise uing https://github.com/jakebullet70/QB64-SQLite; use bindings; try to pass a row type assembler function?
Option _Explicit
'$INCLUDEONCE

Common mmList, DB_Result_Count ', DB_Status, DB_ErrorCode, DB_ErrorStr, DB_RowsAffected, DB_ROWID

' $NOPREFIX
' $Console:Only
' $EXEICON:'databases.ico'
' ICON
 
Const SQLITE_ABORT = 4
Const SQLITE_AUTH = 23
Const SQLITE_BUSY = 5
Const SQLITE_CANTOPEN = 14
Const SQLITE_CONSTRAINT = 19
Const SQLITE_CORRUPT = 11
Const SQLITE_DONE = 101
Const SQLITE_EMPTY = 16
Const SQLITE_ERROR = 1
Const SQLITE_FORMAT = 24
Const SQLITE_FULL = 13
Const SQLITE_INTERNAL = 2
Const SQLITE_INTERRUPT = 9
Const SQLITE_IOERR = 10
Const SQLITE_LOCKED = 6
Const SQLITE_MISMATCH = 20
Const SQLITE_MISUSE = 21
Const SQLITE_NOLFS = 22
Const SQLITE_NOMEM = 7
Const SQLITE_NOTADB = 26
Const SQLITE_NOTFOUND = 12
Const SQLITE_NOTICE = 27
Const SQLITE_OK = 0
Const SQLITE_PERM = 3
Const SQLITE_PROTOCOL = 15
Const SQLITE_RANGE = 25
Const SQLITE_READONLY = 8
Const SQLITE_ROW = 100
Const SQLITE_SCHEMA = 17
Const SQLITE_TOOBIG = 18
Const SQLITE_WARNING = 28
 
Const SQLITE_INTEGER = 1
Const SQLITE_FLOAT = 2
Const SQLITE_BLOB = 4
Const SQLITE_NULL = 5
Const SQLITE_TEXT = 3
 
Type SQLITE_FIELD
    As Long TYPE
    As String columnName, value
End Type
 
Declare Dynamic Library "sqlite3"
    Function sqlite3_open& (filename As String, ByVal ppDb As _Offset)
    Sub sqlite3_open (filename As String, ByVal ppDb As _Offset)
    Function sqlite3_prepare& (ByVal db As _Offset, zSql As String, ByVal nByte As Long, ByVal ppStmt As _Offset, ByVal pzTail As _Offset)
    Function sqlite3_step& (ByVal sqlite3_stmt As _Offset)
    Function sqlite3_changes& (ByVal sqlite3_stmt As _Offset)
    Function sqlite3_column_count& (ByVal sqlite3_stmt As _Offset)
    Function sqlite3_column_type& (ByVal sqlite3_stmt As _Offset, ByVal iCol As Long)
    Function sqlite3_column_name$ (ByVal sqlite3_stmt As _Offset, ByVal N As Long)
    Function sqlite3_column_text$ (ByVal sqlite3_stmt As _Offset, ByVal iCol As Long)
    Function sqlite3_column_bytes& (ByVal sqlite3_stmt As _Offset, ByVal iCol As Long)
    Sub sqlite3_finalize (ByVal sqlite3_stmt As _Offset)
    Sub sqlite3_close (ByVal db As _Offset)
End Declare
 
Dim Shared As _Offset hSqlite, hStmt
'Dim As String sql
ReDim Shared As SQLITE_FIELD DB_Result(1 To 1, 1 To 1)
Dim Shared DB_Result_Count As Long
 
