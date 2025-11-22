'$Debug
'variant.bi
'These are actually private to variant.bm; user should not directly use these const values, types and variables

$IncludeOnce
Option _Explicit

Const VT_NONE = 0
Const VT_STR = 1
Const VT_BYT = 2 'needs testing
Const VT_INT = 3
Const VT_LNG = 4
CONST VT_INT64 = 5 'needs testing
Const VT_SNG = 6
Const VT_DBL = 7
Const VT_FLT = 8 'needs testing
Const VT_STRINGARRAY = 9 'extra difficult - cannot make _MEM block containing array of variable length string - could use string variants? hmm... or 1 mem block per string - high overhead
Const VT_BYTEARRAY = 10 'needs testing
Const VT_INTARRAY = 11 'needs testing
Const VT_LONGARRAY = 12
Const VT_INT64ARRAY = 13 'needs testing
Const VT_SINGLEARRAY = 14 'needs testing
Const VT_DOUBLEARRAY = 15 'needs testing
Const VT_FLOATARRAY = 16 'needs testing

Type VTHolderStruct
    vHandle As Long
    vType As _Byte
    lbound As Long
    uBound As Long
    arrayMemCopy as _MEM
    strValue As String
    intValue As _Integer64 'for byte, short, integer, long, integer64, or variant array handle (longarray)
    sngValue As Single
    dblValue As Double
    fltValue As _Float
End Type

ReDim Shared VTStore(1 To 10) As VTHolderStruct
Dim Shared As Long VTMaxUsed, VTReleased, VTLastHandle
