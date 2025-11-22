'$Debug
'$Debug
'Maze Maker
'QB64 PE 4.0+
'A sloppy little program to make a big maze and solve it


Option _Explicit
Randomize Timer

Dim As Long screenMaxX, screenMaxY
screenMaxX = _Width(_ScreenImage)
screenMaxY = _Height(_ScreenImage)

Screen _ScreenImage, 32
_FullScreen _SquarePixels
'Screen _NewImage(8 * 80, 8 * 25, 32),
'Screen 13

Dim Shared As Long wallColor, unknownColor, emptyColor, keyColor, solutionColor
wallColor = _RGBA(128, 128, 128, 255)
unknownColor = _RGBA(0, 0, 64, 255)
emptyColor = _RGBA(0, 0, 128, 255)
keyColor = _RGBA(255, 64, 64, 255)
solutionColor = _RGBA(32, 255, 32, 255)
Cls , emptyColor

Dim Shared As Long maxX, maxY
'_Font 16
_Font 8
maxX = screenMaxX \ _PrintWidth(" ") - 1 'was getting an occasional Locate error without the -1
maxY = screenMaxY \ _FontHeight - 1

Dim Shared As Long startX, startY, finishX, finishY
startX = 1
startY = Rnd * maxY + 1
finishX = maxX
finishY = Rnd * maxY + 1

'grid(x,y) values:
' 0 = undetermined
' 1 = wall
' 2 = empty
'xxx (bit3) +4 = on solution path (future)
'xxx (bit4-6) +8*number of undetermined neighbors
'xxx (bit7-9) +8*number of cleared neighbors
Dim Shared grid(maxX, maxY) As _Byte

'initialize grid
Dim As Integer i, j
For i = 1 To maxX
    For j = 1 To maxY
        grid(i, j) = _IIf(i = 1 Or i = maxX Or j = 1 Or j = maxY, 1, 0) 'border cells all = 1 (WALL)
    Next j
Next i

'initialize wall-drawing mazecursors
Type MazeCursor
    initialX As Integer
    initialY As Integer
    x As Integer
    y As Integer
    length As Integer
    active As _Byte
    'branchesUntried As Integer
    borderAttached As Integer
    wallColor As Long
End Type

Dim nCursors As Integer
nCursors = maxX / 10 'arbitrary, may change

ReDim Shared mazeCursors(nCursors) As MazeCursor
ReDim Shared mazeCursorTrails(nCursors, maxX * maxY) As Long

For i = 1 To nCursors
    initMazeCursor (i)
Next i

'draw initial screen before wall-drawing
For i = 1 To maxX
    drawCell i, 1, " ", wallColor
    drawCell i, maxY, " ", wallColor
Next i
For i = 1 To maxY
    drawCell 1, i, " ", wallColor
    drawCell maxX, i, " ", wallColor
Next i

drawCell startX, startY, "S>", keyColor
drawCell finishX - 1, finishY, ">F", keyColor

'draw the walls
Dim doneDrawing As _Byte
doneDrawing = _FALSE
Do
    doneDrawing = _TRUE
    For i = 1 To nCursors
        If mazeCursors(i).active Then
            If advanceCursor(i) Then
                doneDrawing = _FALSE
            End If
        End If
    Next
Loop Until doneDrawing

'solve the maze
'For i = 2 To maxX - 1
'    For j = 2 To maxY - 1
'        If grid(i, j) <> 1 Then
'            drawCell i, j, "*", _RGB(0, 64, 0)
'        End If
'    Next j
'Next i

'count distance from start for every clear cell
Dim cts(maxX, maxY) As Integer
cts(startX + 1, startY) = 1
Dim progressed As _Byte
Dim As Integer k, l, cnt
Do
    progressed = _FALSE
    For i = 2 To maxX - 1
        For j = 2 To maxY - 1
            'If grid(i, j) = 0 And cts(i, j) = 0 Then
            If grid(i, j) = 0 Then
                cnt = 0
                For k = i - 1 To i + 1
                    For l = j - 1 To j + 1
                        If ((k <> i) <> (l <> j)) And cts(k, l) > 0 Then
                            If (cnt = 0) Or (cts(k, l) < cnt) Then
                                cnt = cts(k, l)
                            End If
                        End If
                    Next l
                Next k
                If (cnt > 0) Then
                    k = cts(i, j)
                    If (cnt + 1 < cts(i, j)) Or (cts(i, j) = 0) Then
                        progressed = _TRUE
                        cts(i, j) = cnt + 1
                        'drawCell i, j, Chr$(48 + cnt Mod 10), emptyColor
                    End If
                End If
            End If
        Next j
    Next i
Loop While progressed

'retrace steps from finish to start
i = finishX - 1
j = finishY
cnt = cts(i, j)
Do
    drawCell i, j, " ", solutionColor
    Dim dirs(4) As _Byte
    dirs(1) = 1
    dirs(2) = 2
    dirs(3) = 3
    dirs(4) = 4
    'shuffle dirs
    For k = 1 To 10
        Swap dirs(Int(4 * Rnd) + 1), dirs(Int(4 * Rnd) + 1)
    Next k

    cnt = cnt - 1
    For k = 1 To 4
        If dirs(k) = 1 And cts(i - 1, j) = cnt Then
            i = i - 1
        ElseIf dirs(k) = 2 And cts(i + 1, j) = cnt Then
            i = i + 1
        ElseIf dirs(k) = 3 And cts(i, j - 1) = cnt Then
            j = j - 1
        ElseIf dirs(k) = 4 And cts(i, j + 1) = cnt Then
            j = j + 1
            'Else
            'cnt = 0
        End If
    Next k
Loop While cnt > 1



'Dim deadEndFound As _Byte
'Dim nWalls As _Byte
'Dim nClears As _Byte
'Do
'    deadEndFound = _FALSE
'    For i = 2 To maxX - 1
'        For j = 2 To maxY - 1
'            If grid(i, j) = 0 Then
'                'count walls around
'                nWalls = (grid(i, j + 1) And 1) + (grid(i - 1, j) And 1) + (grid(i + 1, j) And 1) + (grid(i, j - 1) And 1)
'                If nWalls >= 3 Then 'Or clearedByCorner(i, j) Then 'dead end
'                    grid(i, j) = 3
'                    drawCell i, j, " ", _RGB(64, 0, 0)
'                    deadEndFound = _TRUE
'                End If

'                nClears = (grid(i, j + 1) = 0) + (grid(i - 1, j) = 0) + (grid(i + 1, j) = 0) + (grid(i, j - 1) = 0)
'                If nClears = 1 Then 'dead end
'                    grid(i, j) = 3
'                    drawCell i, j, " ", _RGB(64, 32, 0)
'                    deadEndFound = _TRUE
'                End If

'            End If
'        Next j
'    Next i

'Loop While deadEndFound
While InKey$ <> Chr$(27): Wend
Sleep
System

LocError:
'Print "drawCell: Could not locate to x&, y&"
Resume Next

Sub drawCell (x&, y&, char$, cellColor&)

    If x& < 1 Or x& > maxX Or y& < 1 Or y& > maxY Then
        Rem Print x&, y&

    End If


    On Error GoTo LocError
    Locate y&, x&
    Color , cellColor&
    Print char$;
End Sub


Sub initMazeCursor (i%)
    'set up a maze cursor, observing these rules:
    'startX, startY specify a random point on the grid
    'the cursor may not be adjacent to another cursor, nor the start or finish points
    'the cursor may be adjacent to a wall (which will only be the outer edges at the start)
    Dim As Integer x, y, j
    Dim xyValid As _Byte
    Dim onBorder As _Byte
    Do
        onBorder = _FALSE
        xyValid = _TRUE
        x = 3 + Rnd * maxX - 4
        y = 3 + Rnd * maxY - 4
        'start some cursors next to border wall
        Select Case Int(6 * Rnd)
            Case 0: x = 2: onBorder = _TRUE
            Case 1: x = maxX - 1: onBorder = _TRUE
            Case 2: y = 2: onBorder = _TRUE
            Case 3: y = maxY - 1: onBorder = _TRUE
                'if >3, cursor may start away from border
        End Select
        If grid(x, y) <> 0 Then
            xyValid = _FALSE
        End If
        If isAdjacent(x, y, startX, startY) Then
            xyValid = _FALSE
        ElseIf isAdjacent(x, y, finishX, finishY) Then
            xyValid = _FALSE
        Else
            For j = 1 To i% - 1
                If isAdjacent(x, y, mazeCursors(j).x, mazeCursors(j).y) Then
                    xyValid = _FALSE
                    Exit For
                End If
            Next j
        End If
    Loop Until xyValid
    Dim cursor As MazeCursor
    cursor.initialX = x
    cursor.initialY = y
    cursor.x = cursor.initialX
    cursor.y = cursor.initialY
    cursor.length = 1
    'cursor.done = _False
    'cursor.branchesUntried = 0
    cursor.borderAttached = onBorder
    cursor.active = _TRUE
    cursor.wallColor = _RGB(32 + Int(Rnd * 96), 32 + Int(Rnd * 96), 32 + Int(Rnd * 96))
    mazeCursors(i%) = cursor
    drawCell x, y, " ", cursor.wallColor
    grid(x, y) = 1 'wall
    mazeCursorTrails(i%, 1) = _ShL(x, 16) + y
End Sub

'return true if two x,y grid points are identical or adjacent
Function isAdjacent%% (x1 As Integer, y1 As Integer, x2 As Integer, y2 As Integer)
    isAdjacent = (Abs(x1 - x2) < 2) And (Abs(y1 - y2) < 2)
End Function

Function advanceCursor%% (i%)
    Static lastDir As Integer
    'try to build a wall using the i% cursor.  return true if successful, otherwise cursor will be deactivated
    'build list of directions it could go
    Dim rslt As _Byte
    rslt = _FALSE
    'Dim cursor As MazeCursor
    'cursor = c
    'If cursor.active Then 'this is tested by caller, so not needed here
    Dim moves As _Byte
    If mazeCursors(i%).length < maxX * 4 / 5 Then
        moves = findWallables(i%)
    Else
        moves = 0
    End If
    Dim moveDir As _Byte
    If moves <> 0 Then
        'pick one and go
        If (lastDir And moves) > 0 And Rnd < 0.9 Then
            moveDir = lastDir
        Else
            Do
                moveDir = moves And _ShL(1, Int(Rnd * 4))
                lastDir = moveDir
            Loop Until moveDir <> 0
        End If
        Select Case moveDir
            Case 1: 'up
                mazeCursors(i%).y = mazeCursors(i%).y + 1
            Case 2: 'left
                mazeCursors(i%).x = mazeCursors(i%).x - 1
            Case 4: 'right
                mazeCursors(i%).x = mazeCursors(i%).x + 1
            Case 8: 'down
                mazeCursors(i%).y = mazeCursors(i%).y - 1
        End Select
        mazeCursors(i%).length = mazeCursors(i%).length + 1
        mazeCursorTrails(i%, mazeCursors(i%).length) = _ShL(mazeCursors(i%).x, 16) Or mazeCursors(i%).y
        drawCell mazeCursors(i%).x, mazeCursors(i%).y, " ", mazeCursors(i%).wallColor
        grid(mazeCursors(i%).x, mazeCursors(i%).y) = 1 'save wall
        If mazeCursors(i%).x = 2 Or mazeCursors(i%).y = 2 Or mazeCursors(i%).x = maxX - 1 Or mazeCursors(i%).y = maxY - 1 Then
            mazeCursors(i%).borderAttached = _TRUE
        End If
        If moveDir = 1 Then _Delay 0.001
        rslt = _TRUE
    Else
        If mazeCursors(i%).length > 1 Then 'can back up
            '    back up
            mazeCursors(i%).length = mazeCursors(i%).length - 1
            mazeCursors(i%).x = _ShR(mazeCursorTrails(i%, mazeCursors(i%).length), 16)
            mazeCursors(i%).y = mazeCursorTrails(i%, mazeCursors(i%).length) And &HFFFF
            rslt = _TRUE
        Else
            '    deactivate cursor and return false
            mazeCursors(i%).active = _FALSE
        End If
    End If
    'End If
    advanceCursor = rslt
End Function

Function findWallables%% (iCursor%)
    Dim rslt As _Byte
    rslt = 0
    Dim mc As MazeCursor
    mc = mazeCursors(iCursor%)

    'test 4 cardinal directions for wall build elegibility
    'TODO: consider forward-then diagonal disqualifiers


    If mc.x > 1 And mc.x < maxX And mc.y > 1 And mc.y < maxY Then
        Dim As _Byte l, r, f, fl, fr, ff, ffl, ffr
        Dim As Integer x, y
        x = mc.x
        y = mc.y


        'testing up
        l = grid(x - 1, y)
        r = grid(x + 1, y)
        f = grid(x, y + 1)
        fl = grid(x - 1, y + 1)
        fr = grid(x + 1, y + 1)
        If y + 2 <= maxY Then
            ffl = grid(x - 1, y + 2)
            ff = grid(x, y + 2)
            ffr = grid(x + 1, y + 2)
        Else
            ff = 1 'outside border, so block movement
            ffl = 1
            ffr = 1
        End If

        If f = 0 Then '0=empty - cannot build wall where one exists; once a cell is marked clear it remains clear
            'make sure side and beyond squares are clear too - can only connect to outer wall once, no other walls
            If ((ff = 0) Or ((not mc.borderAttached) And (y + 2 = maxY))) And _
            (fl = 0) And (fr = 0) And _
            ((y + 2 = maxy) or (ffl = 0) And ((y + 2 = maxy) or (ffr = 0))) Then
                rslt = rslt + 1 'up allowed
            End If
        End If



        'test left
        l = grid(x, y - 1)
        r = grid(x, y + 1)
        f = grid(x - 1, y)
        fl = grid(x - 1, y - 1)
        fr = grid(x - 1, y + 1)
        If x - 2 >= 1 Then
            ffl = grid(x - 2, y - 1)
            ff = grid(x - 2, y)
            ffr = grid(x - 2, y + 1)
        Else
            ff = 1 'outside border, so block movement
            ffl = 1
            ffr = 1
        End If
        If f = 0 Then '0=empty - cannot build wall where one exists; once a cell is marked clear it remains clear
            'make sure side and beyond squares are clear too - can only connect to outer wall once, no other walls
            If ((ff = 0) Or (Not mc.borderAttached And (x - 2 = 1))) And _
            (fl = 0) And (fr = 0) And _
            ((x-2 = 1) or (ffl = 0) And ((x - 2 = 1) or (ffr = 0))) Then
                rslt = rslt + 2 'left allowed
            End If
        End If



        'test right
        l = grid(x, y + 1)
        r = grid(x, y - 1)
        f = grid(x + 1, y)
        fl = grid(x + 1, y + 1)
        fr = grid(x + 1, y - 1)
        If x + 2 <= maxX Then
            ffl = grid(x + 2, y + 1)
            ff = grid(x + 2, y)
            ffr = grid(x + 2, y - 1)
        Else
            ff = 1 'outside border, so block movement
            ffl = 1
            ffr = 1
        End If

        If f = 0 Then '0=empty - cannot build wall where one exists; once a cell is marked clear it remains clear
            'make sure side and beyond squares are clear too - can only connect to outer wall once, no other walls
            If ((ff = 0) Or (Not mc.borderAttached And (x + 2 = maxx))) And _
            (fl = 0) And (fr = 0) And _
            ((x + 2 = maxx) or (ffl = 0) And ((x + 2 = maxx) or (ffr = 0))) Then
                rslt = rslt + 4 'right allowed
            End If
        End If



        'test down
        l = grid(x + 1, y)
        r = grid(x - 1, y)
        f = grid(x, y - 1)
        fl = grid(x + 1, y - 1)
        fr = grid(x - 1, y - 1)
        If y - 2 >= 1 Then
            ffl = grid(x + 1, y - 2)
            ff = grid(x, y - 2)
            ffr = grid(x - 1, y - 2)
        Else
            ff = 1 'outside border, so block movement
            ffl = 1
            ffr = 1
        End If
        If f = 0 Then '0=empty - cannot build wall where one exists; once a cell is marked clear it remains clear
            'make sure side and beyond squares are clear too - can only connect to outer wall once, no other walls
            If ((ff = 0) Or ((not mc.borderAttached) And (y - 2 = 1))) And _
            (fl = 0) And (fr = 0) And _
            ((y - 2 = 1) or (ffl = 0) And ((y - 2 = 1) or (ffr = 0))) Then
                rslt = rslt + 8 'down allowed
            End If
        End If
    End If
    Dim As Integer x1, y1
    x1 = mc.x
    y1 = mc.y
    findWallables = rslt
End Function

'Function clearedByCorner%% (x%, y%)
'    clearedByCorner = ( _
'    (grid(x%-1, y%) = 0 and grid(x%-1,y%+1)=0 and grid(x%,y%+1)=0) or _
'    (grid(x%+1, y%) = 0 and grid(x%+1,y%+1)=0 and grid(x%,y%+1)=0) or _
'    (grid(x%-1, y%) = 0 and grid(x%-1,y%-1)=0 and grid(x%,y%-1)=0) or _
'    (grid(x%+1, y%) = 0 and grid(x%+1,y%-1)=0 and grid(x%,y%-1)=0))
'End Function

