Option _Explicit
'spring.bas
'plot a sine wave (x = k1 * Theta, y = k2 * Sin(Theta)
'instead of plotting x,y, plot x+xdelta, y+ydelta, where xdelta and ydelta are points around a generally smaller circle

Dim fscreen As Long, wid As Long, hgt As Long

fscreen = _ScreenImage
wid = _Width(fscreen)
hgt = _Height(fscreen)
'wid = 1920 'screen size (FHD = 1080P)
'hgt = 1080
Screen fscreen
_FullScreen

Dim r As Long
Dim widbase As Long 'window in which sine wave is drawn (screen inset by r brom each border)
Dim hgtbase As Long
Dim cycles As Long 'number of times sine wave repeats horizontally across screen
Dim ch As String 'inket character
Dim redphase As Double, greenphase As Double, bluephase As Double 'random color generation variables
Dim x0 As Long, y0 As Long, x1 As Long, y1 As Long ' (x0, y0) - (x1, y1) are the coordinates of the inset sine wave window
Dim twists As Long ' "twist" the inner circle into a series of o's
Dim isMono As Integer
Dim kbPollInterval As Integer
Dim i As Double 'main loop var, essentially theta
Dim istep As Double 'increment for i loop
Dim x As Long, y As Long 'sine wave coordinates
Dim pColor As Long, monoColor As Long
Dim shape As Integer, shapeSetting As Integer
Dim theta As Double
Dim wiggle As Double
Dim wigglerate As Double
kbPollInterval = 0
Randomize Timer
isMono = _FALSE
istep = 0.001
shapeSetting = 7 'random
Do
    Cls
    r = Rnd * 490 + 10
    cycles = Rnd * 19 + 2
    widbase = wid - 2 * r
    hgtbase = hgt - 2 * r
    twists = Int(Rnd * 4) + 2
    x0 = r: x1 = wid - r: y0 = r: y1 = hgt - r

    redphase = Rnd / 2: greenphase = Rnd / 2: bluephase = Rnd / 2
    ch = ""
    If Not isMono Then
        monoColor = _RGB(Rnd * 200 + 56, Rnd * 200 + 56, Rnd * 200 + 56)
        pColor = monoColor
    End If
    shape = _IIf(shapeSetting < 7, shapeSetting, Int(Rnd * 7))
    Select Case shape
        Case 0: 'circle
            istep = _IIf(isMono, 0.005, 0.001)
        Case 1: 'lissajous curve
            istep = _IIf(isMono, 0.005, 0.001)
        Case 2: 'square
            istep = _IIf(isMono, 0.2, 0.1)
        Case 3: 'triangle
            istep = _IIf(isMono, 0.2, 0.1)
        Case 4: 'star
            istep = _IIf(isMono, 0.2, 0.1)
        Case 5: 'wiggly circle
            istep = _IIf(isMono, 0.005, 0.001)
            'istep = _IIf(isMono, 0.2, 0.1)
            wiggle = Rnd
            wigglerate = 100 + Rnd * 900
        Case 6: 'image
            istep = _IIf(isMono, 0.4, 0.2)
    End Select
    theta = -_Pi / 2
    Dim image&
    image& = _LoadImage("banana.jpg", 32)
    For i = x0 To x1 - 1 Step istep
        If Not isMono Then
            pColor = _RGB(20 + Sin(i * redphase) * 235, 20 + Sin(i * greenphase) * 235, Sin(20 + i * bluephase) * 235)
        End If
        Select Case shape
            Case 0: 'circle
                x = i + r * Cos(10 * i)
                y = hgt / 2 + hgtbase / 2 * Sin(i / widbase * 2 * _Pi * cycles) + r * Sin(10 * i)
                PSet (x, y), pColor
            Case 1: 'lissajous curve
                x = i + r * Cos(10 * i)
                y = hgt / 2 + hgtbase / 2 * Sin(i / widbase * 2 * _Pi * cycles) + r * Sin(10 * twists * i)
                PSet (x, y), pColor
            Case 2: 'square
                x = i ' + r * Cos(10 * i)
                y = hgt / 2 + hgtbase / 2 * Sin(i / widbase * 2 * _Pi * cycles) ' + r * Sin(10 * twists * i)
                PSet (x - r / 2, y - r / 2), pColor
                Line -Step(0, r), pColor
                Line -Step(r, 0), pColor
                Line -Step(0, -r), pColor
                Line -Step(-r, 0), pColor
            Case 3: 'triangle
                x = i ' + r * Cos(10 * i)
                y = hgt / 2 + hgtbase / 2 * Sin(i / widbase * 2 * _Pi * cycles) ' + r * Sin(10 * twists * i)
                'PSet (x, y), pColor
                'PSet (x + r, y + r * Sin(_Pi / 2)), pColor
                PSet (x + r * Cos(theta), y + r * Sin(theta)), pColor
                Line -(x + r * Cos(theta + 2 * _Pi / 3), y + r * Sin(theta + 2 * _Pi / 3)), pColor
                Line -(x + r * Cos(theta + 4 * _Pi / 3), y + r * Sin(theta + 4 * _Pi / 3)), pColor
                Line -(x + r * Cos(theta + 0 * _Pi / 3), y + r * Sin(theta + 0 * _Pi / 3)), pColor
                theta = theta + 0.01
            Case 4: 'star
                x = i ' + r * Cos(10 * i)
                y = hgt / 2 + hgtbase / 2 * Sin(i / widbase * 2 * _Pi * cycles) ' + r * Sin(10 * twists * i)
                PSet (x + r * Cos(theta), y + r * Sin(theta)), pColor
                Line -(x + r * Cos(theta + 4 * _Pi / 5), y + r * Sin(theta + 4 * _Pi / 5)), pColor
                Line -(x + r * Cos(theta + 8 * _Pi / 5), y + r * Sin(theta + 8 * _Pi / 5)), pColor
                Line -(x + r * Cos(theta + 12 * _Pi / 5), y + r * Sin(theta + 12 * _Pi / 5)), pColor
                Line -(x + r * Cos(theta + 16 * _Pi / 5), y + r * Sin(theta + 16 * _Pi / 5)), pColor
                Line -(x + r * Cos(theta + 0 * _Pi / 5), y + r * Sin(theta + 0 * _Pi / 5)), pColor
                theta = theta + 0.01
            Case 5: 'wiggly circle
                x = i + r * Cos(10 * i) * (wiggle + (1 - wiggle) * Sin(wigglerate * i))
                y = hgt / 2 + hgtbase / 2 * Sin(i / widbase * 2 * _Pi * cycles) + r * Sin(10 * i) * (wiggle + (1 - wiggle) * Sin(wigglerate * i))
                PSet (x, y), pColor
            Case 6: 'image bitblt
                x = i + r * Cos(10 * i)
                y = hgt / 2 + hgtbase / 2 * Sin(i / widbase * 2 * _Pi * cycles) + r * Sin(10 * i)
                _PutImage (x, y), image&

        End Select
        kbPollInterval = kbPollInterval + 1
        If kbPollInterval > 1000 Then
            '_Delay 0.05
            kbPollInterval = 0: ch = InKey$
            If ch <> "" And InStr("pP", ch) > 0 Then
                Do: ch = InKey$: Loop Until ch <> "" 'pause until another keypress
                If ch = " " Then ch = "" 'resume current pattern
            End If
            If ch <> "" Then Exit For
        End If
    Next i

    If ch = "" Then
        Sleep 5: ch = InKey$
    End If
    If ch <> "" And InStr("pP", ch) > 0 Then
        Do
            ch = InKey$
        Loop Until ch <> "" 'pause until another keypress
    End If
    If ch <> "" And InStr("Mm", ch) > 0 Then
        isMono = Not isMono
    End If
    If ch <> "" And InStr("Ss", ch) > 0 Then
        shapeSetting = (shapeSetting + 1) Mod 7
    End If
    If ch <> "" And InStr("Hh?", ch) > 0 Then
        Cls
        Print "Get Help! (please, Loki is dying!)"
        Print "Q/X/Esc: Quit"
        Print "M: Toggle Monochrome (a random color)"
        Print "P: Pause, space to resume"
        Print "S: Select shape (circle/triangle/square/lissajous pattern/star/wiggly circle/random).  Current: ";
        Select Case shapeSetting
            Case 0: Print "Circle"
            Case 1: Print "Lissajous Pattern"
            Case 2: Print "Triangle"
            Case 3: Print "Square"
            Case 4: Print "Star"
            Case 5: Print "Wiggly Circle"
            Case 6: Print "Image"
            Case 7: Print "Random"
        End Select
        Print "Press a key to resume."
        While InKey$ = "": Wend
    End If
Loop While ch = "" Or InStr("qQxX" + Chr$(_ASC_ESC), ch) < 1
Screen 0: System
