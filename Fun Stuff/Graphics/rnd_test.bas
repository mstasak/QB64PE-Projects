'$Debug
'test rng cycle
'currently invalid because it prints on test area during run
Option _Explicit
Dim wid&, hgt&
Dim i&
Dim nonzero&, all&
Dim iters#
Dim x#, y#
Dim oldPt&, newPt&

wid& = _Width(_ScreenImage)
hgt& = _Height(_ScreenImage)
Randomize Timer
Screen _ScreenImage
_FullScreen
Cls
Window (0, 0)-(1, 1)
i& = 1
nonzero& = 0
all& = wid& * hgt&
iters# = 0
Dim passes&
passes& = 0
Dim j&
Do
    i& = 1
    For j& = 0 To 16777215
        x# = Rnd
        y# = Rnd
        '# = .5
        oldPt& = Point(x#, y#)
        newPt& = oldPt& Xor i&
        PSet (x#, y#), newPt&
        If (oldPt& And &HFFFFFF) = 0 And (newPt& And &HFFFFFF) <> 0 Then
            nonzero& = nonzero& + 1
        ElseIf (oldPt& And &HFFFFFF) <> 0 And (newPt& And &HFFFFFF) = 0 Then
            nonzero& = nonzero& - 1
        End If
        i& = _ShL(i&, 1) And &HFFFFFF
        i& = _Max(1, i&)
        iters# = iters# + 1
        j& = j& + 1
    Next j&
    passes& = passes& + 1
    Locate 2, 1
    Print "Finished in "; iters#; " iterations."
    Print "Passes: "; passes&
    Print "Total pixels = "; all&
Loop While InKey$ = "" And nonzero& > 0
'While InKey$ = "": Wend
'System
