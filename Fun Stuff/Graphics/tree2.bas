Option _Explicit
Randomize Timer
Dim screenImage As Long
screenImage = _NewImage(1200, 1200, 32)
Screen screenImage
Window (0, -20)-(200, 190)


'PSet (0.25, 0.25), _RGB(255, 255, 255)

Dim x As Double, y As Double

'draw grass
'Dim grassColor As Long
'grassColor = _RGB(0, 255, 0)
Line (0, -20)-(200, 0), _RGB(65, 72, 82), BF
For x = 0 To 200 Step 1
    For y = -20 To 0 Step 0.3
        Line (x, y)-(x - 2 + Int(Rnd * 4), y + 2 + Int(3 * Rnd)), GrassColor&
    Next y
Next x

drawbranch 100, 0, _Pi / 2, 195, 0.1, 6, 0.8, _Pi / 2


Sleep
Screen 0
_FreeImage (screenImage)
System


Function GrassColor&
    GrassColor& = _RGB(20 + Int(70 * Rnd), 100 + Int(56 * Rnd), 20 + Int(70 * Rnd))
End Function

Sub drawbranch (x#, y#, dir#, h#, branchheightratio#, recurselevels%, xratio#, branchanglelimit#)
    Dim x2 As Double, y2 As Double
    Dim i As Integer
    Dim h3r As Double, x3 As Double, y3 As Double
    Dim theta As Double
    x2 = x# + h# * Cos(dir#)
    y2 = y# + h# * Sin(dir#)
    Line (x#, y#)-(x2, y2), _RGB(75, 55, 55)
    If recurselevels% > 1 Then
        For i = 1 To Rnd * recurselevels% * recurselevels% * 0.8
            'draw a branch at 15-85% of parent height
            h3r = 0.15 + 0.7 * Rnd
            x3 = x# + h3r * (x2 - x#)
            y3 = y# + h3r * (y2 - y#)
            theta = dir# - branchanglelimit# + 2 * Rnd * branchanglelimit#
            'drawbranch x3, y3, theta, 0.7, 5, .1, 0.8
            drawbranch x3, y3, theta, 0.8 * h# * (1 - h3r), branchheightratio#, recurselevels% - 1, xratio#, branchanglelimit# * 0.8 'branchheightratio#
        Next i
    End If
End Sub
