Option _Explicit
'$Include: 'qbregex.bi'

'these work ok - case sensitive matching
Print RegExpSearch("This is a test", "is", 0)
Print RegExpSearch("This is a test", "Is", 0) 'REGEX_icase)
Print RegExpSearch("This is a test", "IS", 0) 'REGEX_icase)
Print RegExpSearch("This IS a test", "IS", 0) 'REGEX_icase)
Print RegExpSearch("This IS a test", "iS", 0) 'REGEX_icase)

'these behave as if no ignore case flag is present
Print RegExpSearch("This is a test", "is", REGEX_icase)
Print RegExpSearch("This is a test", "Is", REGEX_icase)
Print RegExpSearch("This is a test", "IS", REGEX_icase)
Print RegExpSearch("This IS a test", "IS", REGEX_icase)
Print RegExpSearch("This IS a test", "iS", REGEX_icase)
End

Function RegExpSearch$ (s As String, pattern As String, flags As Long)
    ReDim buffr(0 To 511) As Long
    Dim res As Integer
    Dim rslt As String
    res = RegexSearch(s + Chr$(0), pattern + Chr$(0), flags, UBound(buffr) - LBound(buffr) + 1, _Offset(buffr(0))) 'match ignoring case
    If res > 0 Then
        rslt = "Found '" + Mid$(s, buffr(0), buffr(1)) + "' at position: " + Str$(buffr(0)) + ", length: " + Str$(buffr(1))
    ElseIf res = 0 Then
        rslt = "*** NO MATCH ***"
    Else
        rslt = "Error: " + RegexError$(res%)
    End If
    rslt = rslt + Str$(buffr(31))
    RegExpSearch = rslt
End Function

Sub OldTests
    Dim s As String
    Dim re As String
    Dim res As Integer
    ReDim buffr(0 To 1) As Long
    Dim flags As Long

    s = "Now is the time for all good men" + Chr$(0)
    re = "IS" + Chr$(0)
    flags = REGEX_icase Or REGEX_ECMAScript 'icase only works with ecmascript - may be a default locale issue???
    res = RegexSearch%(s, re, flags, UBound(buffr) - LBound(buffr) + 1, _Offset(buffr(0))) 'match ignoring case
    Print "Search " + _CHR_QUOTE + s + _CHR_QUOTE + " for " + _CHR_QUOTE + re + _CHR_QUOTE + ", ignoring case."
    If res% > 0 Then
        Print "Matched at position: "; buffr(0) + 1; ", length: "; buffr(1)
    ElseIf res% = 0 Then
        Print "No match."
    Else
        Print "Error: "; RegexError$(res%)
    End If
    Print

    s = "Now is the time for all good men" + Chr$(0)
    re = "Good" + Chr$(0)
    flags = REGEX_basic
    res = RegexSearch%(s, re, flags, UBound(buffr) - LBound(buffr) + 1, _Offset(buffr(0))) 'case-sensitive match
    Print "Search " + _CHR_QUOTE + s + _CHR_QUOTE + " for " + _CHR_QUOTE + re + _CHR_QUOTE + ", case-sensitive."
    If res% > 0 Then
        Print "Matched at position: "; buffr(0) + 1; ", length: "; buffr(1)
    ElseIf res% = 0 Then
        Print "No match."
    Else
        Print "Error: "; RegexError$(res%)
    End If
    Print

    s = "negative (pi minus three) = -.141592654E+00" + Chr$(0)
re = "(([\+-]?)([0-9]+)(\.[0-9]*)([eE][\+-]?[0-9]+)?)|" + _
     "(([\+-]?)([0-9]*)(\.[0-9]+)([eE][\+-]?[0-9]+)?)" + Chr$(0)
    ReDim buffr(0 To 29) As Long
    flags = REGEX_ECMAScript
    res = RegexSearch%(s, re, flags, UBound(buffr) - LBound(buffr) + 1, _Offset(buffr(0))) 'case-sensitive match
    Print "Search " + _CHR_QUOTE + s + _CHR_QUOTE + " for " + _CHR_QUOTE + re + _CHR_QUOTE + "."
    If res% > 0 Then
        Dim As Integer i, mloc, mlength
        Dim As String match, mtype
        mtype = "Match"
        For i = 0 To 28 Step 2
            mloc = buffr(i) + 1
            If mloc < 1 Then Exit For
            mlength = buffr(i + 1)
            match = Mid$(s, mloc, mlength)
            Print mtype; i \ 2; ": ("; mloc; ", "; mlength; ") = "; _CHR_QUOTE; match; _CHR_QUOTE
            mtype = "Submatch"
        Next i
        Print "Matched at position: "; buffr(0) + 1; ", length: "; buffr(1)
    ElseIf res% = 0 Then
        Print "No match."
    Else
        Print "Error: "; RegexError$(res%)
    End If
End Sub
