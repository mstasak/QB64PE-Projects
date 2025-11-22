'tic tac toe!
'TODO: snarky feedback
'TODO: GUI interface

Option _Explicit
Dim Shared PlayerName As String
Dim Shared HumanIsFirst As _Byte
Dim Shared PlayAgain As _Byte
Dim Shared Board(9) As _Byte
Dim Shared Moves(9) As _Byte
Dim Shared MoveCount As Integer
Dim Shared GameStatus As Integer '0=playing, 1=human won, 2=computer won, 3=tied, game over


Const True = 1
Const False = 0

Type Stats
    Played As Integer
    Won As Integer
    Lost As Integer
    Tied As Integer

End Type

Dim Shared PlayerStats As Stats

RunShell
End

Sub RunShell
    'RepeatRequested = 0
    PlayerName = "X"
    HumanIsFirst = True

    Do
        Cls
        Locate 2, 1
        Print center("Tic Tac Toe", 80)
        Print

        DetermineXO
        DetermineFirstSecond
        InitStats
        PlayGame
        PlayAgain = 0
        AskToPlayAgain
    Loop While PlayAgain = 1
    ReportResults
End Sub

Function center$ (stringy$, width%)
    center$ = Spc((width% - Len(stringy$)) / 2) + stringy$
End Function

Sub DetermineXO
    Do
        Print "Which player would you like to be (X/O, default=" + PlayerName + ")?"
        Dim Response As String
        Input Response
        If Response = "" And ((PlayerName = "X") Or (PlayerName = "O")) Then
            Exit Do
        End If
        If UCase$(Response) = "X" Then
            PlayerName = "X"
            Exit Do
        ElseIf UCase$(Response) = "O" Then
            PlayerName = "O"
            Exit Do
        End If
        Beep
    Loop While True
End Sub

Sub DetermineFirstSecond
    Do
        Print "Would you like to go first (Y/N, default=" + IIf(HumanIsFirst, "Y", "N") + ")?"
        Dim Response As String
        Input Response
        If Response = "" Then
            Exit Do
        End If
        If UCase$(Response) = "Y" Then
            HumanIsFirst = True
            Exit Do
        ElseIf UCase$(Response) = "N" Then
            HumanIsFirst = False
            Exit Do
        End If
        Beep
    Loop While True
End Sub

Function IIf$ (cond, TrueAnswer$, FalseAnswer$)
    If cond <> 0 Then
        IIf$ = TrueAnswer$
    Else
        IIf$ = FalseAnswer$
    End If
End Function

Sub InitStats
    PlayerStats.Played = 0
    PlayerStats.Won = 0
    PlayerStats.Lost = 0
    PlayerStats.Tied = 0
End Sub

Sub PlayGame
    InitGame
    ShowBoard


End Sub

Sub InitGame
    Dim i%
    For i% = 1 To 9
        Board(i%) = 0
        Moves(i%) = 0
    Next
    Board(1) = 1
    Board(5) = 2
    MoveCount = 1
    GameStatus = 0
End Sub

Sub ShowBoard
    Cls , 9
    Color 14, 9
    '    _PrintMode _KeepBackground
    Locate 2, 1
    Print center("Tic Tac Toe", 80)
    Color 7, 9
    DrawBar 9, 25, 9, 55
    DrawBar 15, 25, 15, 55
    DrawBar 4, 34, 20, 35
    DrawBar 4, 45, 20, 46
    Color 15, 9
    Dim i%
    For i% = 1 To 9
        FillCell (i%)
    Next i%
End Sub

Sub FillCell (cell%)
    Dim row%, col%, drawstr$
    row% = (cell% + 2) \ 3 '1..3
    col% = (cell% - 1) Mod 3 + 1 '1..3
    Dim r, c, i As Integer
    r = 6 + 6 * (row% - 1)
    c = 29 + 11 * (col% - 1)
    If Board(cell%) <> 0 Then
        drawstr$ = Mid$("XO", Board(cell%), 1)
    Else
        drawstr$ = LTrim$(Str$(cell%))
    End If
    If drawstr$ = "X" Then
        For i = r - 1 To r + 1
            Locate i, c - 2
            Select Case i
                Case r - 1:
                    Print Chr$(219) + Chr$(219) + " " + Chr$(219) + Chr$(219)
                Case r:
                    Print " " + Chr$(222) + Chr$(219) + Chr$(221) + "  "
                Case r + 1:
                    Print Chr$(219) + Chr$(219) + " " + Chr$(219) + Chr$(219)
            End Select

        Next
    ElseIf drawstr$ = "O" Then
        For i = r - 1 To r + 1
            Locate i, c - 2
            Select Case i
                Case r - 1:
                    Print " " + Chr$(222) + Chr$(219) + Chr$(221) + "  "
                Case r:
                    Print Chr$(219) + Chr$(221) + " " + Chr$(222) + Chr$(219)
                Case r + 1:
                    Print " " + Chr$(222) + Chr$(219) + Chr$(221) + "  "
            End Select

        Next
    Else
        Locate r, c
        Color 3, 9
        Print drawstr$
        Color 15, 9
    End If
End Sub

Sub DrawBar (r1%, c1%, r2%, c2%)
    Dim r%, c%
    For r% = r1% To r2%
        For c% = c1% To c2%
            Locate r%, c%
            Print Chr$(219);
        Next c%
    Next r%
End Sub

Sub AskToPlayAgain
    PlayAgain = 0
End Sub

Sub ReportResults
    Locate 23, 1
    Color 10, 14
    Print "GAME OVER."
End Sub


Function PickComputerMove%



    PickComputerMove% = 1
End Function

'StaticEval()
'Evaluate a board state, from the standpoint of the computer
'Return 1000 for win, -1000 for loss, otherwise a computed score based on:
'  100 points for 2 in a trio (a row, column or diagonal) (unblocked)
'  10 points for 1 in a trio (unblocked),
'  -10 points for 1 human marker in a trio (unblocked),
'  -100 points for 2 human markers in a trio (unblocked).
Function StaticEval% (Board())
    StaticEval% = 1000
End Function
