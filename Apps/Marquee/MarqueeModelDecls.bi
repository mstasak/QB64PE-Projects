'MarqueeModel.bm

'Constants, Variables, Types, Subs and Functions for accessing data in a SQLite 3 database

Const mmDatabaseName = "Marquee.db"
Const mmItemType = "Marquee"

Type MMRow
    As Integer id
    As String title
    As String description
    As String itemType
End Type

ReDim Shared As MMRow mmList(1 To 0)
