Option _Explicit
Randomize Timer
'VariantPerfTest.bas
'Test bulk variant creates, changes, lookups, and deletes
'$Include: 'variant.bi'
Const BLOCKSIZE = 100000&
Dim timings(10) As Single
Dim vars(BLOCKSIZE) As Long
Dim As Long i, j, k, testIx
Dim randomMap(BLOCKSIZE) As Long
testIx = 1

For i = 1 To BLOCKSIZE
    randomMap(i) = i
Next i
For i = 1 To 10 * BLOCKSIZE
    j = 1 + Int(BLOCKSIZE * Rnd)
    k = 1 + Int(BLOCKSIZE * Rnd)
    If j <> k Then Swap randomMap(j), randomMap(k)
Next i

'populate array of strings, random length 1 to 80
VTInit




timings(testIx) = Timer
Dim s As String
For i = 1 To BLOCKSIZE
    'vars(i) = rndWords
    s = rndWords
Next i
timings(testIx + 1) = Timer
Print "Data Generation - "; BLOCKSIZE; " String variants: "; timings(testIx + 1) - timings(testIx); " seconds."
testIx = testIx + 2




timings(testIx) = Timer
For i = 1 To BLOCKSIZE
    vars(i) = VTNewStr(rndWords)
Next i
timings(testIx + 1) = Timer
Print "Create "; BLOCKSIZE; " String variants: "; timings(testIx + 1) - timings(testIx); " seconds."
testIx = testIx + 2

'time fetch ops
timings(testIx) = Timer
For i = 1 To BLOCKSIZE
    's = VTStr(vars(i))
    s = VTStr(vars(randomMap(i)))
Next i
timings(testIx + 1) = Timer
Print "Fetch "; BLOCKSIZE; " String variants: "; timings(testIx + 1) - timings(testIx); " seconds."
testIx = testIx + 2

timings(testIx) = Timer
VTReleaseAll
VTDump
VTTerminate
timings(testIx + 1) = Timer
Print "ReleaseAll & Terminate "; BLOCKSIZE; " String variants: "; timings(testIx + 1) - timings(testIx); " seconds."
testIx = testIx + 2
End

Function rndWords$
    Dim As Integer i, goalLen
    Dim As String rslt
    goalLen = Int(80 * Rnd) + 1
    rslt = ""
    For i = 1 To goalLen
        rslt = rslt + Chr$(Int(65 + 26 * Rnd))
    Next i
    rndWords = rslt
End Function

'$Include: 'variant.bm'
