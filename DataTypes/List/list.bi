$IncludeOnce
$Debug
$Asserts
Option _Explicit

Const LST_NONE = 0
Const LST_STRING = 1
'const LST_BYTE = 2
'const LST_INTEGER = 3
Const LST_LONG = 4
'const LST_INT64 = 5
'const LST_SINGLE = 6
Const LST_DOUBLE = 7
'const LST_FLOAT = 8
'const LST_VARIANT = 9 'this would allow a release test, that every contained variant has been released???  Or a releaseallvariantelements sub?

Type LstHolderStruct
    listHandle As Long
    listName As String
    listType As _Byte
    listMeM As _MEM
    listAlloc As Long
    listLength As Long 'elements used, from 0..ListAlloc
    listMaxLength As Long
    listGrowth As Single '1.0 = 100% - amount to expand when realloc()ing
End Type

ReDim Shared LstStore(1 To 10) As LstHolderStruct
Dim Shared As Long LstMaxUsed, LstReleased, lstLastHandle
