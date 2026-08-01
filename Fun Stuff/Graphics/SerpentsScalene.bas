'Serpentes Scalenas
'QB64 4.4.0 on Win11 X64
'Draw a bunch of snake-like trails on the screen, where the trail is drawn with triangles.
'Each "snake" advances by adding a new head by adding an adjoining triangle next to the
'prior head.  Triangles are drawn in rectangular boxes, sing two addjacent sides and a
' diagonal hypotenuse.
'The "body" is drawn with decreasing alpha levels, so the head is brightest.

Option _Explicit

Const nSnakes = 10 'number of snakes to show at once
Const nPiecesMax = 250 '#generations to show per snake (body length)
Const ageMax = 500 'turns until a snake is deleted and replaced
'Const footprints = _FALSE 'future - leave a dim gray trail where the snake was?
Const charCellWidth = 48
Const charCellHeight = 48
Const alphaDecay = 0.95 'rate at which old pieces fade toward tail end of snake

Dim Shared As Long wScreen, hScreen 'window width, height
Dim scrHandle As Long 'screen buffer
Dim spColor As _Unsigned Long 'snake piece color
Dim As Integer i, j, g 'for loop vars
Dim As Integer maxRows, maxCols 'screen dimension in "character" rows, columns
Dim sp As SnakePiece 'convenience UDT instance copy
Dim allDirs(0 To 7) As _Byte

wScreen = _DesktopWidth * 0.8
hScreen = _DesktopHeight * 0.8
wScreen = wScreen - wScreen Mod charCellWidth
hScreen = hScreen - hScreen Mod charCellHeight
maxRows = hScreen \ charCellHeight - 1
maxCols = wScreen \ charCellWidth - 1
allDirs(0) = 1 'fromleft or totop
allDirs(1) = 3 'fromleft or tobottom
allDirs(2) = 4 'fromtop or toleft
allDirs(3) = 6 'fromtop or toright
allDirs(4) = 9 'fromright or totop
allDirs(5) = 11 'fromright or tobottom
allDirs(6) = 12 'frombottom or toleft
allDirs(7) = 14 'frombottom or toright

scrHandle = _NewImage(wScreen, hScreen, 32)
Screen scrHandle
Randomize Timer

Type SnakePiece
    'As Long x1, y1, x2, y2, x3, y3
    xCol As Integer 'think 0..79
    yRow As Integer 'think 0..24
    age As Integer '0 = dead/regenerating
    spColor As _Unsigned Long 'color (same for all pieces, does not reduce alpha toward tail
    dir As _Byte 'from: 0=left,4=top,8=right,12=bottom; to: 0=left,1=top,2=right,3=bottom
    'lastdir is a bitwise or of from and to directions
    '
    ' example: from left to bottom
    '
    ' F  x
    ' R  x x
    ' O  x x x
    ' M  x x x x
    '
    '      TO
End Type

ReDim snakes(1 To nSnakes, 1 To nPiecesMax) As SnakePiece

Do
    Cls
    For i = 1 To nSnakes
        If snakes(i, 1).age >= ageMax Then
            'kill this one so a new one can spawn later
            snakes(i, 1).age = 0
        ElseIf snakes(i, 1).age > 0 Then
            'add a flip to the triangle's generations
            For g = nPiecesMax To 2 Step -1
                snakes(i, g) = snakes(i, g - 1)
            Next g

            'flip tri on a random border
            sp = snakes(i, 1)
            Dim prevDir As _Byte
            prevDir = sp.dir
            sp.dir = _ShL((prevDir And 3) Xor 2, 2) '"from" = opposite of previous "to"
            'calc "to" direction compatible with from
            Select Case sp.dir
                Case 0 'from left, so TO can be top or bottom
                    sp.dir = sp.dir Or randpick(1, 3)
                    sp.xCol = sp.xCol + 1
                Case 4 'from top, so TO can be left or right
                    sp.dir = sp.dir Or randpick(0, 2)
                    sp.yRow = sp.yRow + 1
                Case 8 'from right, so TO can be top or bottom
                    sp.xCol = sp.xCol - 1
                    sp.dir = sp.dir Or randpick(1, 3)
                Case 12 'from bottom, so TO can be left or right
                    sp.dir = sp.dir Or randpick(0, 2)
                    sp.yRow = sp.yRow - 1
            End Select

            'wander no further than just offscreen
            sp.yRow = _Clamp(sp.yRow, -1, maxRows + 1)
            sp.xCol = _Clamp(sp.xCol, -1, maxCols + 1)

            sp.age = sp.age + 1
            snakes(i, 1) = sp
            'draw snake (all pieces)
            For g = 1 To nPiecesMax
                sp = snakes(i, g)
                If sp.age > 0 Then
                    spColor = snakes(i, g).spColor
                    spColor = _RGBA32(_RED32(spColor), _
                    _green32(spColor), _
                    _Blue32(spColor), _
                    255.0 * (alphaDecay ^ (g - 1)))
                    DrawPiece sp.xCol, sp.yRow, sp.dir, spColor
                End If
            Next g
        End If
        'spawn new triangles if needed
        For j = 1 To nSnakes
            If snakes(j, 1).age = 0 Then
                'build a triangle and exit for
                sp.xCol = Int(Rnd * maxCols)
                sp.yRow = Int(Rnd * maxRows)
                sp.age = 1
                sp.spColor = _RGBA(Int(256 * Rnd), Int(256 * Rnd), Int(256 * Rnd), 255)
                sp.dir = allDirs(Int(8 * Rnd))
                snakes(j, 1) = sp
                For g = 2 To nPiecesMax
                    snakes(j, g).age = 0
                Next g
                Exit For 'or could just spawn them all in one frame
            End If
        Next j
    Next i
    _Limit 15
    _Display
    Dim ch As String
    ch = InKey$
    Select Case ch
        Case _CHR_ESC, "q", "Q"
            'quit
            Exit Do
        Case " ", "p", "P"
            'pause
            While InKey$ = "": Wend
        Case "r", "R"
            'restart
            For i = 1 To nSnakes
                snakes(i, 1).age = 0
            Next i
    End Select
Loop
Screen 0
_FreeImage scrHandle
System

Function randpick% (a%, b%)
    randpick% = _IIf(Rnd < 0.5, a%, b%)
End Function

Sub DrawPiece (xcol As Integer, yrow As Integer, dir As _Byte, spColor As _Unsigned Long)
    'due to border and overlap interference from other triangles when alpha<>255,
    'draw into a new image with transparent background, then copy onto
    'main screen

    Dim As Long s2
    s2 = _NewImage(charCellWidth, charCellHeight, 32)
    _Dest s2
    _DontBlend 'needed when color has alpha below 255, without this Paint
    'bleeds through line joins

    Dim As _Byte x1, x2, x3, y1, y2, y3
    Select Case dir
        Case 1, 4: 'from left to top, from top to left
            x1 = 0: y1 = 0
            x2 = 0: y2 = charCellHeight
            x3 = charCellWidth: y3 = 0
        Case 3, 12 'from left to bottom, from bottom to left
            x1 = 0: y1 = 0
            x2 = 0: y2 = charCellHeight
            x3 = charCellWidth: y3 = charCellHeight
        Case 6, 9 'from top to right, from right to top
            x1 = 0: y1 = 0
            x2 = charCellWidth: y2 = 0
            x3 = charCellWidth: y3 = charCellHeight
        Case 11, 14 'from right to bottom, from bottom to right
            x1 = charCellWidth: y1 = 0
            x2 = charCellWidth: y2 = charCellHeight
            x3 = 0: y3 = charCellHeight
    End Select

    Line (x1, y1)-(x2, y2), spColor
    Line -(x3, y3), spColor
    Line -(x1, y1), spColor
    Paint ((x1 + x2 + x3) \ 3, (y1 + y2 + y3) \ 3), spColor
    _Blend
    _Dest 0
    _PutImage (xcol * charCellWidth, yrow * charCellHeight), s2, 0
    _FreeImage s2
End Sub
