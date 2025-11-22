'$Debug
'Sorts.bas

Option _Explicit
'$Console:Only
Randomize Timer

Dim totalElements As Long
Dim msstart, msend As Single
Dim i As Long
Dim magnitude As Integer

For magnitude = 3 To 7
    totalElements = 10 ^ magnitude
    ReDim arr(0 To totalElements - 1) As Integer
    ReDim sorttemparr(LBound(arr) To UBound(arr)) As Integer
    For i = LBound(arr) To UBound(arr)
        arr(i) = Int(-32768& + 65535& * Rnd)
    Next i

    'If UBound(arr) <= 100 Then printArray "Unsorted: ", arr()

    For i = LBound(arr) To UBound(arr)
        sorttemparr(i) = arr(i)
    Next i
    Print "Quick sort "; UBound(arr) - LBound(arr) + 1; " elements...";
    msstart = Timer(0.001)
    quickSortArray sorttemparr()
    msend = Timer(0.001)
    'If UBound(arr) <= 100 Then printArray "Sorted: ", arr()
    Print TimespanStr$(msend - msstart)


    For i = LBound(arr) To UBound(arr)
        sorttemparr(i) = arr(i)
    Next i
    Print "Introsort "; UBound(arr) - LBound(arr) + 1; " elements...";
    msstart = Timer(0.001)
    IntrosortMain sorttemparr()
    msend = Timer(0.001)
    'If UBound(arr) <= 100 Then printArray "Sorted: ", sorttemparr()
    Print TimespanStr$(msend - msstart)


    For i = LBound(arr) To UBound(arr)
        sorttemparr(i) = arr(i)
    Next i
    Print "Bubble sort "; UBound(arr) - LBound(arr) + 1; " elements: ";
    If magnitude < 5 Then
        msstart = Timer(0.001)
        bubbleSortArray sorttemparr()
        msend = Timer(0.001)
        'If UBound(arr) <= 100 Then printArray "Sorted: ", arr()
        Print TimespanStr$(msend - msstart)
    ElseIf magnitude = 5 Then
        Print "approximately 2 minutes"
    ElseIf magnitude = 6 Then
        Print "Much too slow"
    Else
        Print "Could take days"
    End If


    Print
Next magnitude
End

Function TimespanStr$ (elapsedSecs!)
    If elapsedSecs < 0.001 Then
        TimespanStr$ = Str$(elapsedSecs * 1E6) + " microseconds"
    ElseIf elapsedSecs < 1.000 Then
        TimespanStr$ = Str$(elapsedSecs * 1E3) + " milliseconds"
    Else
        TimespanStr$ = Str$(elapsedSecs) + " seconds"
    End If
End Function

Sub printArray (name$, a%())
    Print name$; " [";
    Dim i As Integer
    Dim sep As String
    sep = ""
    For i = LBound(a%) To UBound(a%)
        Print sep; LTrim$(Str$(a%(i)));
        sep = ", "
    Next i
    Print "]"
End Sub

Sub bubbleSortArray (a%())
    Dim i, j As Long
    For i = LBound(a%) To UBound(a%) - 1
        For j = i + 1 To UBound(a%)
            If a%(i) > a%(j) Then
                Swap a%(i), a%(j)
            End If
        Next j
    Next i
End Sub

'Sort using QuickSort, Hoare Partition Scheme (https://en.wikipedia.org/wiki/Quicksort#Hoare_partition_scheme)
'Sorts (a portion of) an array, divides it into partitions, then sorts those
Sub quickSortArray (a%())
    quickSortRange a%(), LBound(a%), UBound(a%)
End Sub

Sub quickSortRange (a%(), lo&, hi&)
    Dim pivot As Long
    If lo& >= 0 And hi& >= 0 And lo& < hi& Then
        pivot = partition(a%(), lo&, hi&)
        quickSortRange a%(), lo&, pivot 'Note: the pivot is now included
        quickSortRange a%(), pivot + 1, hi&
    End If
End Sub

'Divides array into two partitions
Function partition& (a%(), lo&, hi&)
    'Pivot value
    Dim As Long i, j, pivot
    pivot = a%(lo&) ' Choose the first element as the pivot

    'Left index
    i = lo& - 1

    'Right index
    j = hi& + 1

    Do
        'Move the left index to the right at least once and while the element at
        'the left index is less than the pivot
        Do
            i = i + 1
        Loop While a%(i) < pivot

        'Move the right index to the left at least once and while the element at
        'the right index is greater than the pivot
        Do
            j = j - 1
        Loop While a%(j) > pivot

        'If the indices crossed, return
        If i >= j Then
            partition& = j
            Exit Function
        End If

        'Swap the elements at the left and right indices
        Swap a%(i), a%(j)
    Loop While _TRUE
End Function




' Main Introsort function to call from your program
Sub IntrosortMain (arr() As Integer)
    Dim depthLimit As Integer
    Dim size As Long
    size = UBound(arr) - LBound(arr) + 1
    ' Set the depth limit to 2 * log2(size)
    ' Using an integer log, this is a reasonable approximation
    ' For example, if size is 1000, depthLimit would be 18-20
    If size > 0 Then
        depthLimit = 2 * Int(Log(size) / Log(2))
    Else
        depthLimit = 0
    End If

    ' Call the recursive sorting routine
    Call IntrosortRecursive(arr(), 0, size - 1, depthLimit)
End Sub

' The recursive introsort function
Sub IntrosortRecursive (arr() As Integer, left As Long, right As Long, depthLimit As Integer)
    Dim size As Integer
    size = right - left + 1

    ' Condition 1: Use Insertion Sort for small partitions
    If size < 16 Then ' 16 is a typical, tunable threshold
        Call InsertionSort(arr(), left, right)
        Exit Sub
    End If

    ' Condition 2: If recursion depth is exceeded, switch to Heapsort
    If depthLimit = 0 Then
        Call Heapsort(arr(), left, right)
        Exit Sub
    End If

    ' Condition 3: Otherwise, continue with Quicksort
    Dim pivotIndex As Integer
    Call Partition(arr(), left, right, pivotIndex)

    ' Sort the sub-arrays
    Call IntrosortRecursive(arr(), left, pivotIndex - 1, depthLimit - 1)
    Call IntrosortRecursive(arr(), pivotIndex + 1, right, depthLimit - 1)
End Sub

' Standard Partition function for Quicksort
Sub Partition (arr() As Integer, left As Long, right As Long, pivotIndex As Long)
    ' Simple pivot choice: last element.
    ' A better implementation would use "median-of-three" for better performance.
    Dim pivotValue As Integer
    Dim i As Long, j As Long

    pivotValue = arr(right)
    i = left - 1

    For j = left To right - 1
        If arr(j) <= pivotValue Then
            i = i + 1
            Swap arr(i), arr(j)
        End If
    Next j

    ' Place pivot in its correct position
    Swap arr(i + 1), arr(right)

    pivotIndex = i + 1
End Sub

' Standard Insertion Sort function
Sub InsertionSort (arr() As Integer, left As Long, right As Long)
    Dim As Long i, j
    Dim ky As Integer
    For i = left + 1 To right
        ky = arr(i)
        j = i - 1

        While j >= left _AndAlso arr(j) > ky
            arr(j + 1) = arr(j)
            j = j - 1
        Wend
        arr(j + 1) = ky
    Next i
End Sub

' Heapsort implementation (used for deep recursion)
Sub Heapsort (arr() As Integer, left As Long, right As Long)
    Dim n As Long
    n = right - left + 1

    ' Build max heap
    Dim i As Long
    For i = Int(n / 2) - 1 To 0 Step -1
        Call Heapify(arr(), n, i, left)
    Next i

    ' Extract elements one by one
    For i = n - 1 To 0 Step -1
        ' Move current root to end
        Dim temp As Integer
        temp = arr(left)
        arr(left) = arr(left + i)
        arr(left + i) = temp

        ' Call heapify on the reduced heap
        Call Heapify(arr(), i, 0, left)
    Next i
End Sub

' Standard Heapify function for Heapsort
Sub Heapify (arr() As Integer, heapSize As Long, rootIndex As Long, startIndex As Long)
    Dim largest As Long
    largest = rootIndex

    Dim leftChild As Long
    leftChild = 2 * rootIndex + 1

    Dim rightChild As Long
    rightChild = 2 * rootIndex + 2

    If leftChild < heapSize _AndAlso arr(startIndex + leftChild) > arr(startIndex + largest) Then
        largest = leftChild
    End If

    If rightChild < heapSize _AndAlso arr(startIndex + rightChild) > arr(startIndex + largest) Then
        largest = rightChild
    End If

    If largest <> rootIndex Then
        Swap arr(startIndex + rootIndex), arr(startIndex + largest)
        Call Heapify(arr(), heapSize, largest, startIndex)
    End If
End Sub

