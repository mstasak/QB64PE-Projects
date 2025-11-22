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
kbPollInterval = 0
Randomize Timer
isMono = _FALSE
istep = 0.001
monoColor = _RGB(0, 255, 0)
Do
    Cls
    r = Rnd * 490 + 10
    cycles = Rnd * 19 + 2
    widbase = wid - 2 * r
    hgtbase = hgt - 2 * r
    twists = CLng(Sqr(Rnd * 9 + 1))

    x0 = r: x1 = wid - r: y0 = r: y1 = hgt - r

    redphase = Rnd / 2: greenphase = Rnd / 2: bluephase = Rnd / 2
    ch = ""

    For i = x0 To x1 - 1 Step istep
        x = i + r * Cos(10 * i)
        y = hgt / 2 + hgtbase / 2 * Sin(i / widbase * 2 * _Pi * cycles) + r * Sin(10 * twists * i)
        If isMono Then
            pColor = monoColor
        Else
            pColor = _RGB(20 + Sin(i * redphase) * 235, 20 + Sin(i * greenphase) * 235, Sin(20 + i * bluephase) * 235)
        End If
        PSet (x, y), pColor
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
        Sleep 2: ch = InKey$
    End If
    If ch <> "" And InStr("pP", ch) > 0 Then
        Do
            ch = InKey$
        Loop Until ch <> "" 'pause until another keypress
    End If
    If ch <> "" And InStr("Mm", ch) > 0 Then
        isMono = Not isMono
        If isMono Then
            monoColor = _RGB(Rnd * 200 + 56, Rnd * 200 + 56, Rnd * 200 + 56)
            istep = 0.005
        Else
            istep = 0.001
        End If
    End If
    If ch <> "" And InStr("Hh?", ch) > 0 Then
        Cls
        Print "Get Help! (please, Loki is dying!)"
        Print "Q/X/Esc: Quit"
        Print "M: Toggle Monochrome (a random color)"
        Print "P: Pause, space to resume"
        Print
        Print "Press a key to resume."
        While InKey$ = "": Wend
    End If
Loop While ch = "" Or InStr("qQxX" + Chr$(_ASC_ESC), ch) < 1
Screen 0: System
