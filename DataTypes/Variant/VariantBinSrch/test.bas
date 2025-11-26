$Console:Only

'should be unnecessary!
$Checking:On

Dim t As Long, d As Double, i As Integer, t2 As Long
On Error GoTo errReport

Print "Division by zero"
t = 1
t2 = 0
t = t / t2
Print t, Hex$(t)
Print

Print "Square Root of 2   -- safe operation"
d = Sqr(2.0)
Print d
Print

Print "Square Root of -2   -- error raised"
d = Sqr(-2.0)
Print d
Print

Print "Max(Long) = 2^30 - 1 + 2^30   -- safe approach"
t = 2 ^ 30 - 1 + 2 ^ 30
Print t, Hex$(t)
Print

Print "Max(Long) = 2^31 - 1   -- 2^31 should overflow???"
t = 2 ^ 31 - 1
Print t, Hex$(t)
Print

Print "Max(Integer) = 2^15 - 1   -- 2^15 should overflow???"
i = 2 ^ 15 - 1
Print i, Hex$(i)
Print

Print "32767 * 32767   -- Max(Integer) * Max(Integer) should overflow???"
i = 32767 * 32767
Print i, Hex$(i)
Print

Print "Max(Long)+1   -- Max(Long) + 1 = Min(Long)?  should be overflow???"
t = t + 1
Print t, Hex$(t)
Print

Print "12 * 2^28   -- (Another overflow ignored: 12 * 1/4 billion = -4 * 1/4 billion)!"
t = 12 * 2 ^ 28
Print t, Hex$(t)

Print "-4 * 2^28   -- (Another overflow ignored: 12 * 1/4 billion = -4 * 1/4 billion)!"
t = 12 * 2 ^ 28
Print t, Hex$(t)

While InKey$ <> Chr$(27): Wend
End

errReport:
Print "An error occurred: "; Err
Resume Next








