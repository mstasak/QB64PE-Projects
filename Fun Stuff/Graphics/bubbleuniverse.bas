'$Debug
'Bubble Universe show
'QB64-PE, version 4.0 or higher
'recommend full high def (1080x1920 display or higher
'Adapted from https://my.numworks.com/python/schraf/univers2
'see this sample: https://msabal.net/bubbleUniverse.html

Option _Explicit
Randomize Timer
Dim fullwid, fullhgt
Screen _ScreenImage, 32
fullwid = _Width
fullhgt = _Height
If fullhgt > 1000 Then
    Screen _NewImage(fullwid \ 2, fullhgt \ 2, 32)
Else
    Screen _NewImage(fullwid, fullhgt, 32)
End If
'Screen _ScreenImage, 32
_FullScreen

Dim As Integer n, i, j, updskip
Dim ch As String
Dim r, t, x, u, v, wid, hgt, siz, sinMultiplier
Dim addFrames
wid = _Width
hgt = _Height
siz = _Min(wid, hgt)
n = 250
r = 2 * _Pi / (0.9 * siz) '235
updskip = 0
'_Limit 30
Do
    Dim tmin, tmax, tstep
    tmin = 4 * Rnd
    tmax = (4 - tmin) * Rnd
    tstep = (tmax - tmin) / 1000
    sinMultiplier = 10 * Rnd
    addFrames = Rnd
    If addFrames < 0.75 Then
        Line (1, 1)-(wid, hgt), _RGB(0, 0, 0), BF
        Locate 1, 1
        Color _RGB(255, 255, 255), _RGBA(0, 0, 0, 0)
        Print "N for next pattern parameters, Esc to quit";
        _Display
    End If
    For t = tmin To tmax Step tstep
        updskip = (updskip + 1) Mod 10
        If addFrames >= 0.75 And updskip = 0 Then
            Line (1, 1)-(wid, hgt), _RGB(0, 0, 0), BF
            Locate 1, 1
            Color _RGB(255, 255, 255), _RGBA(0, 0, 0, 0)
            Print "N for next pattern parameters, Esc to quit";
            _Display
        End If


        For i = 0 To n
            For j = 0 To n
                u = Sin(i + v) + Sin(Sin(sinMultiplier * r) * i + x)
                v = Cos(i + v) + Cos(r * i + x)
                x = u + t
                Dim As Integer px, py
                px = Int((wid \ 2) + (wid \ 4) * u)
                py = Int((hgt \ 2) + (hgt \ 4) * v)
                If 0 <= px and px < wid And 0 <= py and py < hgt Then '320,222
                    Dim As Integer r_col, g_col, b_col
                    r_col = (i * 3) Mod 256
                    g_col = (j * 3) Mod 256
                    b_col = (255 - (i + j) \ 2) Mod 256
                    PSet (px, py), _RGB(r_col, g_col, b_col)
                End If
            Next j
            If addFrames >= 0.75 Or updskip = 0 Then
                _Display
            End If
        Next i
        ch = InKey$
        If ch = _CHR_ESC Then Exit For
        If UCase$(ch) = "N" Then ch = "": Exit For
    Next t
    If ch = _CHR_ESC Then Exit Do
    'Sleep 1
    ch = InKey$

Loop While InKey$ <> _CHR_ESC
System
