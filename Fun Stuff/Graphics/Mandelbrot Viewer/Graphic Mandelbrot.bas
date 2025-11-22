Option _Explicit

Dim As Single X_MIN, X_MAX, Y_MIN, Y_MAX ', ZOOM, SKEW
X_MIN = -2.9!: X_MAX = 3.1!
Y_MIN = -2.5!: Y_MAX = 3!
Const MAX_ITER = 150

Dim scr As Long
Dim w As Long: w = _DesktopWidth - 100
Dim h As Long: h = _DesktopHeight - 100
w = w \ 2: h = h \ 2
scr = _NewImage(w, h, 32)
Screen scr
$Color:32
_ScreenMove (_DesktopWidth \ 2 - w \ 2) - 3, (_DesktopHeight \ 2 - h \ 2) - 39 '-3, -39 accomodate desktop factors like taskbar height
_Title "Mandelbrot Viewer"

Dim maxX As Long: maxX = w - 1
Dim maxY As Long: maxY = h - 1
Do
    Cls , Black
    'Beep
    Dim y As Long: For y = 0 To maxY
        Dim x As Long: For x = 0 To maxX
            Dim cx As Single: cx = X_MIN + (x / w) * (X_MAX - X_MIN)
            Dim cy As Single: cy = Y_MIN + (y / h) * (Y_MAX - Y_MIN)

            Dim zx As Single: zx = 0
            Dim zy As Single: zy = 0
            Dim i As Long: i = 0

            Do Until zx * zx + zy * zy >= 4 Or i >= MAX_ITER
                Dim temp As Single: temp = zx * zx - zy * zy + cx
                zy = 2 * zx * zy + cy
                zx = temp
                i = i + 1
            Loop
            PSet (x, y), i * (2.0 ^ 38 / MAX_ITER)
            'PSet (x, y), _RGB(i * (2.0 ^ 36 / MAX_ITER), i * (2.0 ^ 35 / MAX_ITER), i * (2.0 ^ 34 / MAX_ITER))
        Next x
    Next y
    Locate 1, 1
    Color Black, White
    Print "Rect = ("; X_MIN; ","; Y_MIN; ")-("; X_MAX; ","; Y_MAX!; ")  Controls: arrow keys pan, +/- zooms, Esc to quit, Home to reset, click+drag mouse to zoom to that area"
    'Print "Width = "; X_MAX - X_MIN; ", Height = "; Y_MAX - Y_MIN; ", Zoom = "; (X_MAX - X_MIN) / 6.0!
    _Display
    Dim ch As String
    Do 'waiting for input loop
        ch = InKey$
        If ch = "" Then 'nothing in KB buffer, check mouse
            Dim As Integer mx, my, mb, mx1, my1, mx2, my2
            If _MouseInput Then
                mb = _MouseButton(1)
                mx = _MouseX 'mx,my = latest value
                my = _MouseY
                mx1 = mx: mx2 = mx 'mx1,my1 = press location (anchor)
                my1 = my: my2 = my 'mx2,my2 = far corner of box
                If mb Then
                    Dim boximg As Long
                    Dim As Long xtl, ytl, boxw, boxh
                    boxw = Abs(mx2 - mx1) + 1
                    boxh = Abs(my2 - my1) + 1
                    If boxh / boxw > h / w Then
                        boxh = boxw * h / w
                    Else
                        boxw = boxh * w / h
                    End If

                    If mx1 < mx2 Then
                        xtl = mx1
                    Else
                        xtl = mx1 - (boxw - 1)
                    End If
                    If my1 < my2 Then
                        ytl = my1
                    Else
                        ytl = my1 - (boxh - 1)
                    End If
                    boximg = _NewImage(boxw, boxh, 32)
                    _PutImage , scr, boximg, (xtl, ytl)-(xtl + boxw - 1, ytl + boxh - 1)
                    Do While mb
                        If _MouseInput Then
                            mb = _MouseButton(1)
                            mx = _MouseX
                            my = _MouseY

                            Line (xtl, ytl)-(xtl + boxw - 1, ytl + boxh - 1), Red, B
                            _Display
                            _PutImage (xtl, ytl)-(xtl + boxw - 1, ytl + boxh - 1), boximg, scr
                            _FreeImage boximg

                            mx2 = mx: my2 = my

                            boxw = Abs(mx2 - mx1) + 1
                            boxh = Abs(my2 - my1) + 1
                            If boxh / boxw > h / w Then
                                boxh = boxw * h / w
                            Else
                                boxw = boxh * w / h
                            End If
                            If mx1 < mx2 Then
                                xtl = mx1
                            Else
                                xtl = mx1 - (boxw - 1)
                            End If
                            If my1 < my2 Then
                                ytl = my1
                            Else
                                ytl = my1 - (boxh - 1)
                            End If
                            boximg = _NewImage(boxw, boxh, 32)
                            _PutImage , scr, boximg, (xtl, ytl)-(xtl + boxw - 1, ytl + boxh - 1)
                            If Not mb Then
                                'do the zoom
                                Dim As Single newxmin, newxmax, newymin, newymax
                                newxmin = X_MIN + xtl / w * (X_MAX - X_MIN)
                                newxmax = X_MIN + (xtl + boxw - 1) / w * (X_MAX - X_MIN)
                                newymin = Y_MIN + ytl / h * (Y_MAX - Y_MIN)
                                newymax = Y_MIN + (ytl + boxh - 1) / h * (Y_MAX - Y_MIN)
                                X_MIN = newxmin: X_MAX = newxmax
                                Y_MIN = newymin: Y_MAX = newymax
                            End If
                        End If

                    Loop
                    _FreeImage boximg
                    _Display
                    Exit Do
                End If
            End If
        Else
            Dim rng As Single
            Select Case Asc(ch)
                Case _KEY_ESC
                    Exit Do
                Case 0
                    Select Case _ShL(Asc(ch, 2), 8)
                        Case _KEY_HOME
                            X_MIN = -2.9!: X_MAX = 3.1!
                            Y_MIN = -2.5!: Y_MAX = 3!
                        Case _KEY_LEFT 'pan left
                            rng = X_MAX - X_MIN
                            X_MIN = X_MIN - 0.2 * rng: X_MAX = X_MAX - 0.2 * rng
                        Case _KEY_RIGHT 'pan right
                            rng = X_MAX - X_MIN
                            X_MIN = X_MIN + 0.2 * rng: X_MAX = X_MAX + 0.2 * rng
                        Case _KEY_UP 'pan up
                            rng = Y_MAX - Y_MIN
                            Y_MIN = Y_MIN - 0.2 * rng: Y_MAX = Y_MAX - 0.2 * rng
                        Case _KEY_DOWN 'pan down
                            rng = Y_MAX - Y_MIN
                            Y_MIN = Y_MIN + 0.2 * rng: Y_MAX = Y_MAX + 0.2 * rng
                    End Select
                Case Asc("+") 'zoom in 20%
                    Dim As Single x_cen, y_cen, x_wid, y_hgt
                    x_wid = (X_MAX - X_MIN) * 0.8
                    y_hgt = (Y_MAX - Y_MIN) * 0.8
                    x_cen = (X_MAX + X_MIN) / 2
                    y_cen = (Y_MAX + Y_MIN) / 2
                    newxmin = x_cen - x_wid / 2: newxmax = newxmin + x_wid
                    newymin = y_cen - y_hgt / 2: newymax = newymin + y_hgt
                    X_MIN = newxmin: X_MAX = newxmax
                    Y_MIN = newymin: Y_MAX = newymax
                Case Asc("-") 'zoom out 20%
                    x_wid = (X_MAX - X_MIN) / 0.8
                    y_hgt = (Y_MAX - Y_MIN) / 0.8
                    x_cen = (X_MAX + X_MIN) / 2
                    y_cen = (Y_MAX + Y_MIN) / 2
                    newxmin = x_cen - x_wid / 2: newxmax = newxmin + x_wid
                    newymin = y_cen - y_hgt / 2: newymax = newymin + y_hgt
                    X_MIN = newxmin: X_MAX = newxmax
                    Y_MIN = newymin: Y_MAX = newymax
                Case Else
                    ch = ""
            End Select
        End If
    Loop While ch = ""
    If ch = _CHR_ESC Then Exit Do
Loop
'_SaveImage "Mandelbrot.jpg"
Screen 0
_FreeImage scr
System


