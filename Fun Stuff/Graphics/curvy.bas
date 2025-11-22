'$Debug
Option _Explicit
Randomize Timer
Dim As Integer i, k
Dim Shared As Integer turtlex(1000), turtley(1000), turtledirturn(1000)
Dim Shared As _Bit turtlelive(1000)
Const wid = 1000
Const hgt = 1000
Dim Shared As _Bit pointIsH(wid, hgt)
Dim Shared As _Bit pointIsV(wid, hgt)
Const maxTurtles = 40
Dim Shared As Integer liveTurtles

Dim scrn As Long
Dim ch As String
Dim paused As _Bit
Dim As Integer dir, turns, x, y, stepx, stepy
Dim success As Integer
scrn = _NewImage(wid, hgt, 32)
Screen scrn
$Color:32
_DontBlend
Do
    For i = 1 To 1000
        For k = 1 To 1000
            pointIsH(i, k) = 0
            pointIsV(i, k) = 0
        Next k
        turtlelive(i) = 0
    Next i
    turtlex(1) = wid \ 2: turtley(1) = hgt \ 2: turtledirturn(1) = 1 Or &H18%: turtlelive(1) = 1
    pointIsH(turtlex(1), turtley(1)) = 0

    'turtlex(2) = wid \ 2: turtley(2) = hgt \ 2: turtledirturn(2) = 2 Or &H18%: turtlelive(2) = 1
    'pointIsV(turtlex(2), turtley(2)) = 0

    'turtlex(3) = wid \ 2: turtley(3) = hgt \ 2: turtledirturn(3) = 3 Or &H18%: turtlelive(3) = 1
    'pointIsH(turtlex(3), turtley(3)) = 0

    'turtlex(4) = wid \ 2: turtley(4) = hgt \ 2: turtledirturn(4) = 4 Or &H18%: turtlelive(4) = 1
    'pointIsV(turtlex(4), turtley(4)) = 0
    liveTurtles = 1
    Cls
    ch = " "
    Do
        i = 1 + Int(Rnd * liveTurtles) 'pick a random turtle
        If turtlelive(i) Then
            dir = turtledirturn(i) And 7
            turns = Int(3 * Rnd) '0 = left, 1 = right, 2 = both
            turns = turns And _ShR(turtledirturn(i) And &H18%, 3)
            'turn = 2
            x = turtlex(i): y = turtley(i)
            Dim leg As Integer
            leg = Int(Rnd * 23) + 18 '12
            Select Case dir
                Case 1
                    stepx = 3 * leg: stepy = leg
                Case 2
                    stepx = leg: stepy = 3 * leg
                Case 3
                    stepx = 3 * leg: stepy = leg
                Case 4
                    stepx = leg: stepy = 3 * leg
            End Select
            Select Case turns
                Case 0
                    success = trygo(x, y, dir, stepx, stepy, 0, i, _TRUE)
                Case 1
                    success = trygo(x, y, dir, stepx, stepy, 1, i, _TRUE)
                Case 2
                    If liveTurtles < maxTurtles Then
                        Dim nextfree As Integer
                        For k = 1 To maxTurtles + 1
                            If turtlelive(k) = 0 Then
                                nextfree = k
                                Exit For
                            End If
                        Next k
                        liveTurtles = liveTurtles + 1
                        turtlelive(nextfree) = 1
                        turtlex(nextfree) = x: turtley(nextfree) = y
                        turtledirturn(nextfree) = dir Or &H08%
                        turtledirturn(i) = dir Or &H10%
                        success = trygo((x), (y), dir, stepx, stepy, 0, i, _TRUE)
                        success = trygo((x), (y), dir, stepx, stepy, 1, nextfree, _TRUE)
                    End If
            End Select
            '_Delay .001
        End If
        Do
            If ch = " " Then
                ch = ""
                paused = _TRUE
            Else
                ch = InKey$
            End If
            If ch = "p" Or (paused And (ch = " " Or ch = _CHR_ESC)) Then paused = Not paused
        Loop While paused And ch <> " "
    Loop While ch <> _CHR_ESC And ch <> "n" And liveTurtles > 0

    Do
        If ch <> "n" Then ch = InKey$
    Loop While ch = ""
Loop While ch <> _CHR_ESC
Screen 0
_FreeImage scrn
System

Function dircolors& (dir As Integer)
    Select Case dir * 0
        Case 1
            dircolors = White
        Case 2
            dircolors = Red
        Case 3
            dircolors = Green
        Case 4
            dircolors = Cyan
        Case Else
            dircolors = DarkGreen
    End Select
End Function

Function trygo% (x As Integer, y As Integer, dir As Integer, stepx As Integer, stepy As Integer, turnright As Integer, saveturtleslot As Integer, killonfail As Integer)
    Dim success As Integer
    Dim i As Integer

    Dim endx As Integer, endy As Integer
    Dim intersects As Integer
    intersects = 0
    Select Case dir
        Case 1 'right
            endx = x + stepx
            endy = y + stepy * _IIf(turnright, 1, -1)
            For i = x To endx
                If Not (x <= 0 Or x >= wid Or y <= 0 Or y >= hgt Or endx <= 0 Or endx >= wid Or endy <= 0 Or endy >= hgt) Then
                    intersects = intersects + pointIsH(i, y)
                End If
            Next i
        Case 2 'up
            endx = x + stepx * _IIf(turnright, 1, -1)
            endy = y - stepy
            For i = endx To x
                If Not (x <= 0 Or x >= wid Or y <= 0 Or y >= hgt Or endx <= 0 Or endx >= wid Or endy <= 0 Or endy >= hgt) Then
                    intersects = intersects + pointIsV(x, i)
                End If
            Next i
        Case 3 'left
            endx = x - stepx
            endy = y + stepy * _IIf(turnright, -1, 1)
            For i = endx To x
                If Not (x <= 0 Or x >= wid Or y <= 0 Or y >= hgt Or endx <= 0 Or endx >= wid Or endy <= 0 Or endy >= hgt) Then
                    intersects = intersects + pointIsH(i, y)
                End If
            Next i
        Case 4 'down
            endx = x + stepx * _IIf(turnright, -1, 1)
            endy = y + stepy
            For i = x To endx
                If Not (x <= 0 Or x >= wid Or y <= 0 Or y >= hgt Or endx <= 0 Or endx >= wid Or endy <= 0 Or endy >= hgt) Then
                    intersects = intersects + pointIsV(x, i)
                End If
            Next i
    End Select

    If (x <= 0 Or x >= wid Or y <= 0 Or y >= hgt Or endx <= 0 Or endx >= wid Or endy <= 0 Or endy >= hgt) Then
        success = _FALSE 'endpoint off screen
    ElseIf (pointIsH(x, y) And ((dir = 2) Or (dir = 4))) Or (pointIsV(x, y) And ((dir = 1) Or (dir = 3))) Then
        success = _FALSE 'origin perpendicular to step
    ElseIf (pointIsH(endx, endy) And ((dir = 1) Or (dir = 3))) Or _
           (pointIsV(endx, endy) And ((dir = 2) Or (dir = 4))) Then
        success = _FALSE 'endpoint perpendicular to step
    ElseIf (intersects > 0) Then
        success = _FALSE 'perpendicular intersection
    Else
        Select Case dir
            Case 1 'right
                Line (x, y)-(x + stepx - stepy, y), dircolors(dir)
                If turnright Then
                    Circle (x + stepx - stepy, y + stepy), stepy, dircolors(dir), 0, _Pi / 2
                    y = y + stepy
                Else
                    Circle (x + stepx - stepy, y - stepy), stepy, dircolors(dir), 3 * _Pi / 2, 0
                    y = y - stepy
                End If
                For i = x To x + stepx - stepy
                    pointIsH(i, y) = 1
                Next i
                x = x + stepx
                pointIsV(x, y) = 1
                success = _TRUE
            Case 2 'up
                Line (x, y)-(x, y - stepy + stepx), dircolors(dir)
                If turnright Then
                    Circle (x + stepx, y - stepy + stepx), stepx, dircolors(dir), _Pi / 2, _Pi
                    x = x + stepx
                Else
                    Circle (x - stepx, y - stepy + stepx), stepx, dircolors(dir), 0, _Pi / 2
                    x = x - stepx
                End If
                For i = y - stepy + stepx To y
                    pointIsV(x, i) = 1
                Next i
                y = y - stepy
                pointIsH(x, y) = 1
                success = _TRUE
            Case 3 'left
                Line (x, y)-(x - stepx + stepy, y), dircolors(dir)
                If turnright Then
                    Circle (x - stepx + stepy, y - stepy), stepy, dircolors(dir), _Pi, 3 * _Pi / 2
                    y = y - stepy
                Else
                    Circle (x - stepx + stepy, y + stepy), stepy, dircolors(dir), _Pi / 2, _Pi
                    y = y + stepy
                End If
                For i = x - stepx + stepy To x
                    pointIsH(i, y) = 1
                Next i
                x = x - stepx
                pointIsV(x, y) = 1
                success = _TRUE
            Case 4 'down
                Line (x, y)-(x, y + stepy - stepx), dircolors(dir)
                If turnright Then
                    Circle (x - stepx, y + stepy - stepx), stepx, dircolors(dir), 3 * _Pi / 2, 0
                    x = x - stepx
                Else
                    Circle (x + stepx, y + stepy - stepx), stepx, dircolors(dir), _Pi, 3 * _Pi / 2
                    x = x + stepx
                End If
                For i = y To y + stepy - stepx
                    pointIsV(x, i) = 1
                Next i
                y = y + stepy
                pointIsH(x, y) = 1
                success = _TRUE
        End Select
    End If
    If success Then
        'save turtle properties
        Dim newdir As Integer
        newdir = ((dir + 1 + _IIf(turnright <> 0, 2, 0)) Mod 4)
        If newdir = 0 Then newdir = 4
        turtlex(saveturtleslot) = x
        turtley(saveturtleslot) = y
        turtledirturn(saveturtleslot) = newdir Or &H18%
        turtlelive(saveturtleslot) = 1
    Else
        If killonfail Then
            If (turtledirturn(saveturtleslot) And &H18%) = &H18% Then
                'both dirs, so turn off the one we tried
                turtlelive(saveturtleslot) = turtlelive(saveturtleslot) Xor _IIf(turnright, &H10%, &H08%)
            Else
                turtlelive(saveturtleslot) = 0
                liveTurtles = liveTurtles - 1
            End If
        End If
    End If
    trygo = success
End Function
