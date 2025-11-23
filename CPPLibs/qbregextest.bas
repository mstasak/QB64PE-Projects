Option _Explicit
'$Include: 'qbregex.bi'

Dim s As String: s = "Now iS the time for all good men" + Chr$(0)
Dim re As String: re = "Is" + Chr$(0)
Dim res As Integer
Dim buffr(0 To 5) As Long
Dim flags As Long: flags = REGEX_icase Or REGEX_ECMAScript

res = RegexSearch%(s, re, flags, 6, _Offset(buffr(0))) 'match ignoring case    * REGEX_icase
' Function RegexSearch% (qbStr$, qbRegex$, matches As _Offset, matchLimit&)

If res% > 0 Then
    Print "Matched at position: "; buffr(0); ", length: "; buffr(1)
ElseIf res% = 0 Then
    Print "No match."
Else
    Print "Error: "; RegexError$(res%)
End If
Print "REFlags = 0x"; Hex$(buffr(3))
End

