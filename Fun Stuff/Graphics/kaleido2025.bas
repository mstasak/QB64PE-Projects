'QB64PE 4.2.0 on Windows 11, display capable of minimum 1024Hx1024Wx32 colors
'Probably works on Mac or Linux, perhaps with minor edits
'Drawing circles centered on equidistant vectors from center of screen

Option _Explicit
Randomize Timer
Dim As Long s, wid, hgt, xc, yc, i, fg, nSlices, slice, rFactor, gFactor, bFactor, stepVal
Dim As String ky, ky2
Dim As Single spd
wid = 1024: hgt = 1024: s = _NewImage(wid, hgt, 32): Screen s
xc = wid \ 2
yc = hgt \ 2
spd = 0.1
Do
    Cls ' , _RGB(Int(255.0 * Rnd), Int(255.0 * Rnd), Int(255.0 * Rnd))
    Locate 1, 1
    Print "Esc: quit, space: next cycle, f:freeze, p: pause at end of cycle, 0..9: speed (fast..slow)"
    _Delay 0.1
    rFactor = 5 + Int(50 * Rnd)
    gFactor = 5 + Int(50 * Rnd)
    bFactor = 5 + Int(50 * Rnd)
    nSlices = 2 + Int(Rnd * 20)
    stepVal = 2 + Int(28 * Rnd)
    _Title "Delay: " + Str$(spd) + "ms, Slices: " + Str$(nSlices) + " Step: " + Str$(stepVal)
    For i = 0 To 2000 Step stepVal
        fg = _RGB(20 + 235 * Sin(i / rFactor), 20 + 235 * Sin(i / gFactor + 2.0 * _Pi / 3.0), 20 + 235 * Sin(i / bFactor + 4.0 * _Pi / 3.0))
        For slice = 1 To nSlices
            Circle (xc + Cos(2 * _Pi * slice / nSlices + i/200.0) * i, yc + Sin(2 * _Pi * slice / nSlices + i/407.0) * i), i * rFactor / 25, fg
        Next slice
        If i Mod (2 * stepVal) = 0 Then
            ky2 = InKey$
            If ky2 <> "" Then
                If ky <> "p" Or ky2 <> "" Then ky = ky2
                If ky = _CHR_ESC Or ky = " " Then Exit For
                If ky = "f" Then Sleep: ky = "~empty~"
                If Asc(ky) >= Asc("0") And Asc(ky) <= Asc("9") Then
                    spd = 0.01 * ((Asc(ky) - Asc("0")) ^ 2)
                    _Title "Delay: " + Str$(spd) + "ms, Slices: " + Str$(nSlices) + " Step: " + Str$(stepVal)
                    ky = ""
                End If
            End If
            _Delay spd
        End If
    Next i
    If ky = "p" Then Sleep: ky = ""
    If ky <> _CHR_ESC Then _Delay 0.5
Loop While ky <> _CHR_ESC
Screen 0: _FreeImage s: System

