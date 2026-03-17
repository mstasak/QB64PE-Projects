'QB64PE 4.4 (4.0+ should work)
Option _Explicit
Randomize Timer

'Launch a bunch of objects from the center of the screen, with a fixed velocity
'dx(i), dy(i).  The objects move endlessly with the same direction and speed.
'When they reach a screen border, they wrap to the other edge and continue.

'Every object returns to its origin after many steps.  Eventually, all objects
'return to the origin at once, at the least common multiple of their individual
'return-to-origin step counts.  This creates an interesting disperse-then-regroup
'effect, which is repeated on smaller scale when subsets of the objects meet at
'common points on their journeys.

Dim As Integer wid, hgt, nParticles, radius, shape
Dim As Long scr, pPalette(15)
Dim As Integer xSign, ySign '-1 = negative, 1=positive, 0=either, 2=ysign opposite of xsign

'note: different ratios of wid:hgt produce very different patterns!
'wid = _DesktopWidth: hgt = _DesktopHeight
'wid = 1000: hgt = 1000
wid = 1024: hgt = 768
'wid = 700: hgt = 600

$Color:32
pPalette(0) = Blue
pPalette(1) = Green
pPalette(2) = Red
pPalette(3) = Yellow
pPalette(4) = Purple
pPalette(5) = Orange
pPalette(6) = White
pPalette(7) = Cyan
pPalette(8) = Magenta
pPalette(9) = Brown
pPalette(10) = LightBlue
pPalette(11) = LightGreen
pPalette(12) = LightCyan
pPalette(13) = Pink
pPalette(14) = Beige
pPalette(15) = AntiqueWhite

scr = _NewImage(wid, hgt, 32): Screen scr: '_FullScreen
_Title "Cuckoo Patterns, aka LCM Reunions   Esc:quit   Space/other key: randomize parameters"

Do
    radius = 5 + 16 * Rnd
    nParticles = (4 + 27 * Rnd) * 50
    xSign = Int(Rnd * 3) - 1: ySign = Int(Rnd * 4) - 1
    shape = Int(3 * Rnd)

    ReDim As Long ParticlesX(nParticles), ParticlesY(nParticles)
    ReDim As Long ParticlesDX(nParticles), ParticlesDY(nParticles)
    ReDim As Long ParticleColors(nParticles)
    Dim As Single j
    Dim ch As String
    Dim As Integer i

    For i = 1 To nParticles
        ParticlesX(i) = wid \ 2
        ParticlesY(i) = hgt \ 2
        ParticleColors(i) = pPalette(Int(16 * Rnd))
        Select Case xSign
            Case -1: ParticlesDX(i) = -12.0 * Rnd
            Case 0: ParticlesDX(i) = 12.0 * (Rnd - Rnd)
            Case 1: ParticlesDX(i) = 12.0 * Rnd
        End Select
        Select Case ySign
            Case -1: ParticlesDY(i) = -12.0 * Rnd
            Case 0: ParticlesDY(i) = 12.0 * (Rnd - Rnd)
            Case 1: ParticlesDY(i) = 12.0 * Rnd
            Case 2: ParticlesDY(i) = -12.0 * Rnd * Sgn(ParticlesDX(i))
        End Select
    Next i

    Do
        For i = 1 To nParticles
            Const cScale = 0.9 ^ (10 / 0.3)
            Dim cFactor As Single, c As Long
            Dim As Integer x, y, r
            cFactor = cScale
            For j = 9 To 0 Step -0.30
                c = ParticleColors(i)
                c = _HSB32(_Hue32(c), _Saturation32(c), _Brightness32(c) * cFactor)
                x = ParticlesX(i) - j * ParticlesDX(i)
                y = ParticlesY(i) - j * ParticlesDY(i)
                r = radius * (10 - j) / 10
                Select Case shape
                    Case 0 'points
                        PSet (x, y), c
                    Case 1 'circles
                        Circle (x, y), r, c
                    Case 2 'diamonds
                        Line (x - r, y)-(x, y + r), c
                        Line -Step(r, -r), c
                        Line -Step(-r, -r), c
                        Line -Step(-r, r), c
                End Select
                cFactor = cFactor / 0.9
            Next j
        Next i
        _Display
        _Delay 0.04
        Cls
        For i = 1 To nParticles
            ParticlesX(i) = fixxy(ParticlesX(i) + ParticlesDX(i), wid)
            ParticlesY(i) = fixxy(ParticlesY(i) + ParticlesDY(i), hgt)
        Next i
        ch = InKey$
    Loop While ch = ""
Loop While ch <> Chr$(27)
Screen 0
_FreeImage scr
System
End

'limit function to keep x,y in (0,0) - (wid,hgt)
Function fixxy% (v As Integer, limit As Integer)
    If v < 0 Then
        fixxy = v + limit
    ElseIf v > limit Then
        fixxy = v - limit
    Else
        fixxy = v
    End If
End Function

