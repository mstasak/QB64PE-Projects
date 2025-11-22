Option _Explicit

Dim MaxX%
Dim MaxY%

'FHD (1920 x 1080)
MaxX% = 1920
MaxY% = 960 '1080 - some room for taskbar

'HD2K scaled to 125%
'MaxX% = 3840 * 4 \ 5
'MaxY% = 2160 * 4 \ 5 - 200


Dim DelaySecs!, Speed%
Dim i%, j%, a#, b#, p&, c#, x#, y#, w#, h&, z#, u#
Dim BGColor&, FGColor&
Dim ky$

Dim SpeedTable!(0 To 9)
For i% = 0 To 9
    Read SpeedTable!(i%)
Next i%

Randomize
Speed% = 9
DelaySecs! = SpeedTable!(Speed%)
Screen _NewImage(MaxX%, MaxY%, 32)
For j% = 1 To 9999
    a# = 0.1 + Rnd * 0.76
    b# = 0.9998
    BGColor& = _RGB(Rnd * 255, Rnd * 255, Rnd * 255)
    Cls 0, BGColor&
    ShowCaption a#, j%, Speed%, DelaySecs!
    p& = 100000
    c# = 2 - 2 * a#
    x# = 0
    y# = 12.17
    w# = a# * x# + c# * x# * x# / (1 + x# * x#)
    Rem fgcolor& = _RGB(Rnd * 255, Rnd * 255, Rnd * 255)
    FGColor& = BGColor& Xor (_RGB(128, 128, 128) And &H00FFFFFF) 'seems to guarantee decent contrast to bgcolor
    For h& = 0 To p&
        'If h& > 100 Then
        Rem plot x*5+105,y+5+75
        PSet (x# * MaxX% / 40 + MaxX% \ 2, y# * MaxY% / 40 + MaxY% \ 2), FGColor&
        z# = x#
        x# = b# * y# + w#
        u# = x# * x#
        w# = a# * x# + c# * u# / (1 + u#)
        y# = w# - z#
        If h& Mod 10 = 0 Then
            ky$ = InKey$
            If ky$ <> "" Then
                If Asc(ky$) = 27 Then 'Esc
                    GoTo 999
                ElseIf (ky$ >= "0" And ky$ <= "9") Then
                    Speed% = Val(ky$)
                    DelaySecs! = SpeedTable!(Speed%)
                    ShowCaption a#, j%, Speed%, DelaySecs!
                ElseIf ky$ = "+" Then
                    Speed% = Min%(9, Speed% + 1)
                    DelaySecs! = SpeedTable!(Speed%)
                    ShowCaption a#, j%, Speed%, DelaySecs!
                ElseIf ky$ = "-" Then
                    Speed% = Max%(0, Speed% - 1)
                    DelaySecs! = SpeedTable!(Speed%)
                    ShowCaption a#, j%, Speed%, DelaySecs!
                ElseIf ky$ = " " Then
                    GoTo 900
                ElseIf Asc(ky$) = 8 And j% > 1 Then 'backspace
                    Rem Poor coding practice - One shouldn't modify a for loop variable directly within a loop
                    j% = Max%(0, j% - 2)
                    GoTo 900 'go back 2, then forward 1
                End If
                Locate 20, 1
            End If
            'If DelaySecs! > 0 Then
            _Delay DelaySecs!
            'End If
        End If
        'End If
    Next h&
900 Next j%
999 Screen 0: End

Rem Data to load into SpeedTable!(0..9)
Data 0.250,0.125,0.100,0.064,0.032,0.016,0.008,0.003,0.002,0.001,0.000,' screen tears a bit at Speed% = 9/DelaySecs!=0.0


Sub ShowCaption (a#, j%, Speed%, DelaySecs!)
    Locate 1, 1
    Print a#; " ("; j%; " of 9999, Speed ="; Speed%; " - "; DelaySecs!; "secs.).  Press Esc to quit,"
    Print "+/- or 0-9 to adjust speed, space to advance to next pattern, "
    Print "backspace for previous pattern)"
End Sub

Function Max% (a%, b%)
    If a% > b% Then Max% = a% Else Max% = b%
End Function

Function Min% (a%, b%)
    If a% < b% Then Min% = a% Else Min% = b%
End Function

