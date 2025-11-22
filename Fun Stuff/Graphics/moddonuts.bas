'Hypotrochoids - see https://mathworld.wolfram.com/Hypotrochoid.html
Dim cx As Integer, cy As Integer, bottomrow As Integer
Dim pi As Double, x As Double, y As Double, a As Double, b As Double, theta As Double, h As Double
Dim cycles As Long, progress As Long, pixcolor As Long
pi = 4 * Atn(1) ' 3.141592654
cx = 450 'center point of screen
cy = 450
bottomrow = Int(2 * cy / 16) ' = 56 for 900x900
Screen _NewImage(2 * cx, 2 * cy, 32)
a = 400
b = 93
h = 128
cycles = 50000
Locate bottomrow, 1
Print "press Esc to cancel"
progress = 0
Line (1, 0)-(2 * cx, 4), _RGB(128, 128, 128), BF 'Draw gray progress bar background
For theta = 0 To cycles Step 0.1
    If progress = 0 Then
        Line (1, 0)-(Int(2 * cx * theta / cycles), 4), _RGB(0, 255, 0), BF 'Cover gray with green as looping occurs
        If InKey$ = Chr$(27) Then
            Exit For
        End If
    End If
    progress = progress + 1
    If progress > 100000 Then
        progress = 0
    End If
    x = (a - b) * Cos(theta) + h * Cos((a - b) / b * theta)
    y = (a - b) * Sin(theta) + h * Sin((a - b) / b * theta)
    pixcolor = _RGB(55 + 200 * Sin(2.1 * theta), 55 + 200 * Sin(3.3 * theta + pi / 3), 55 + 200 * Sin(7.7 * theta + 2 * pi / 3))
    'PSet (cx + x, cy + y), pixcolor
    Dim dx As Double, dy As Double
    dx = 20 * Cos(100 * theta) * Cos(89 * theta)
    dy = 20 * Sin(100 * theta) * Sin(89 * theta)
    'Line (cx + x, cy + y)-(cx + x + dx, cy + y + dy), pixcolor
    For i = 1 To 10000: Next i
    Circle (cx + x, cy + y), dx, pixcolor
Next
Locate bottomrow, 1
Print "                   " 'erase "press Esc to cancel"

