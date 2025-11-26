'$Debug
Option _Explicit

$Console:Only
$Asserts
'$Include:'variant.bi'

'test/sample code

Dim As Long vName, vHeight, vGreeting, vSingle, vDouble, vLong

VTInit

'create a few variants
vName = VTNewStr("Mark")
vHeight = VTNewInt(69)
vGreeting = VTNewStr("Hello,")
vSingle = VTNewSng(100000.25)
vDouble = VTNewDbl(Sqr(2.0))
vLong = VTNewLng(1000000000)

'print them
Print VTToStr(vGreeting) + " " + VTToStr(vName)
Print "Long = ", VTToStr(vLong)
Print "Single = ", VTToStr(vSingle)
Print "Double = ", VTToStr(vDouble)
'Print "Long = ", Str$(VTLng(vLong))
'Print "Single = ", Str$(VTSng(vSingle))
'Print "Double = ", Str$(VTDbl(vDouble))
Print
'list the entire variant collection
VTDump

'add 10000 random long values, storedx in array elements
Dim i As Long, j As Long
ReDim bulk(1 To 10000) As Long
For i = 1 To 10000
    bulk(i) = VTNewLng(1 + Int(Rnd * 1000000000))
Next i

'remove 9990 elements, leaving ten
For i = 1 To 9990
    Do
        j = 1 + Int(Rnd * 10000)
    Loop While bulk(j) = 0
    VTRelease (bulk(j))
    bulk(j) = 0
Next i

'list the entire variant collection
'note what remains of the 10000 variants have relocated to the top 40 slots so the
'array can shrink
VTDump
'bulk should contain ten elements
'vtstore should be shrunk to 40 (could fit in 20, but resizing
'downward triggers at a lower count)

'save array to a single variant
Dim bulksave As Long
bulksave = VTNewLongArray(bulk())

'print it
Print "Bulk original ["
For i = 1 To 10000
    If bulk(i) <> 0 Then Print i, bulk(i), VTToStr(bulk(i))
Next i
Print "]"

'empty the array
For i = 1 To 10000
    bulk(i) = 0
Next i

'print it (all zeros, so nothing prints)
Print "Bulk emptied ["
For i = 1 To 10000
    If bulk(i) <> 0 Then Print i, bulk(i), VTToStr(bulk(i))
Next i
Print "]"

'erase the array
Erase bulk

'recreate the array
ReDim bulk(1 To 10000) As Long
'populate it from variant
VTGetLongArray bulksave, bulk()

'show restored contents
Print "Bulk restored ["
For i = 1 To 10000
    If bulk(i) <> 0 Then Print i, bulk(i), VTToStr(bulk(i))
Next i
Print "]"


'list the entire variant collection
VTDump

'shut down variant store, releasing all contents and invalidating handles stored in variant variables

VTTerminate

VTInit

Print "String Array test/demo:"
ReDim fruits(1 To 5) As String
fruits(1) = "Apple"
fruits(2) = "Orange"
fruits(3) = "Papaya"
fruits(4) = "Lemon"
fruits(5) = "Loquat"

Dim sep As String
Print "Fruits = ";
sep = "["
For i = LBound(fruits) To UBound(fruits)
    Print sep; fruits(i);
    sep = ","
Next i
Print "]"

Dim fruitvariant As Long
fruitvariant = VTNewStringArray(fruits())
Print "fruitvariant = ", fruitvariant
For i = 1 To 5
    fruits(i) = "(deleted)"
Next i

Print "(deleted)Fruits = ";
sep = "["
For i = LBound(fruits) To UBound(fruits)
    Print sep; fruits(i);
    sep = ","
Next i
Print "]"
VTDump

VTGetStringArray fruitvariant, fruits()

Print "(restored)Fruits = ";
sep = "["
For i = LBound(fruits) To UBound(fruits)
    Print sep; fruits(i);
    sep = ","
Next i
Print "]"
VTDump

VTReleaseAll
VTDump
VTTerminate

End

'$Include:'variant.bm'
