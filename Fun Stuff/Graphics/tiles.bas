Option _Explicit
Randomize Timer
Dim screenImage&, wid!, hgt!
screenImage& = _NewImage(1600, 800, 32)
Screen screenImage&
wid = _Width(screenImage&)
hgt = _Height(screenImage&)

Dim xCells%, yCells%
Do
    Cls
    xCells% = 3 + Int(Rnd * 14)
    yCells% = 3 + Int(Rnd * 6)

    Dim i%, j%
    For i% = 0 To xCells% - 1
        For j% = 0 To yCells% - 1

            'draw cell(i,j)
            Dim x0!, y0!, x1!, y1!
            x0! = i% * (wid! - 1) / xCells%
            y0! = j% * (hgt! - 1) / yCells%
            x1! = x0! + (wid! - 1) / xCells%
            y1! = y0! + (hgt! - 1) / yCells%
            Line (x0, y0)-(x1, y1), _RGB(255, 255, 255), B
            PSet (x0 + 3, y0 + 3), _RGB(255, 255, 0)
            Draw "S16R2D4R4u2l2u2r4D4R4u2l2u2r4D4R4u2l2u2r4D4R4u2l2u2r4D4R4u2l2u2r4d20l32u20"
        Next j%
    Next i%
    Dim ch$
    Do
        Sleep
        ch$ = InKey$
    Loop While ch$ <> " " And ch$ <> Chr$(27)
Loop While ch$ <> Chr$(27)
System

