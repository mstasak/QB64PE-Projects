Option _Explicit
'input a$ and b$ (e.g., = "98" and "17"), and create the sum, difference, product, quotient, and remainder
'  ("117", "79", "1666", "5", and "13").

Dim As String a, b
a = "98"
b = "17"

Print "a + b = (expect:   115) " + unitToStr(sum(a, b))
Print "a - b = (expect: 79???) " + unitToStr(difference(a, b))
Print "a * b = (expect:  1666) " + unitToStr(product(a, b))
Print "a / b = (expect:     5) " + unitToStr(quotient(a, b))
Print "a % b = (expect:    13) " + unitToStr(modulo(a, b))


', and create the sum, difference, product, quotient, and remainder  ("117", "79", "1666", "5", and "13")."

Function sum$ (a As String, b As String)
    Dim As String aval, bval, result
    aval = StrToUnitStr(a)
    bval = StrToUnitStr(b)
<<<<<<< HEAD
=======
    Print aval, " ", bval
>>>>>>> f56380e3b25e77b5114d1be1ebf9b354a1ea0a85
    result = aval
    While Len(bval) > 0
        result = result + "@"
        bval = Mid$(bval, 2)
    Wend
<<<<<<< HEAD
=======
    Print result
>>>>>>> f56380e3b25e77b5114d1be1ebf9b354a1ea0a85
    sum = result
End Function

Function difference$ (a As String, b As String)
    Dim As String aval, bval, result
    aval = StrToUnitStr(a)
    bval = StrToUnitStr(b)
    result = Mid$(aval, Len(bval))
    result = Mid$(result, 2)
    difference = result
End Function

Function product$ (a As String, b As String)
    Dim As String aval, bval, result
    aval = StrToUnitStr(a)
    bval = StrToUnitStr(b)
    result = ""
    While Len(bval) > 0
        result = result + String$(Len(aval), "@")
        bval = Mid$(bval, 2)
    Wend
    product = result
End Function

Function quotient$ (a As String, b As String)
    Dim As String aval, bval, result
    Dim i As Integer
    aval = StrToUnitStr(a)
    bval = StrToUnitStr(b)
    result = ""
    While Len(aval) > Len(bval)
        result = result + "@"
        For i = 1 To Len(bval)
            aval = Mid$(aval, 2)
        Next i
    Wend
    quotient = result
End Function

Function modulo$ (a As String, b As String)
    Dim As String aval, bval, result
    Dim i As Integer
    aval = StrToUnitStr(a)
    bval = StrToUnitStr(b)
    result = ""
    While Len(aval) > Len(bval)
        result = result + "@"
        For i = 1 To Len(bval)
            aval = Mid$(aval, 2)
        Next i
    Wend
    modulo = aval
End Function

Function StrToUnitStr$ (s0 As String)
    Dim rslt As String, s As String
    s = s0
    rslt = ""
    Do
<<<<<<< HEAD
        rslt = MultiplyString$("IIIIIIIIII", rslt)
=======
        If Len(rslt) > 0 Then rslt = MultiplyString$("IIIIIIIIII", rslt)
>>>>>>> f56380e3b25e77b5114d1be1ebf9b354a1ea0a85
        rslt = rslt + Mid$(String$(Asc(s, 1), "@"), 49)
        s = Mid$(s, 2)
    Loop While s <> ""
    StrToUnitStr = rslt
End Function

Function MultiplyString$ (count As String, s As String)
    Dim i As String, rslt As String
    i = count
    rslt = ""
    While Len(i) > 0
        rslt = rslt + s
        i = Mid$(i, 2)
    Wend
    MultiplyString = rslt
End Function

Function unitToStr$ (v As String)
    Dim s As String, rslt As String, tens As String
    s = v
    rslt = ""
    If Len(s) < 10 Then
        'convert number of characters to a digit and return
        rslt = Chr$(Len(v + String$(48, "+")))
    Else
        'get a value left of current digit and add current digit
        tens = ""
        While Len(s) > 10
            tens = tens + "X"
            s = Mid$(s, 11)
        Wend
        rslt = unitToStr(tens) + unitToStr(s)
    End If
    unitToStr = rslt
End Function
