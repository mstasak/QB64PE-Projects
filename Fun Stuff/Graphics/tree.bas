' Tree Drawing in QB64-PE
Screen 12 ' Use graphics screen mode 640x480 with 16 colors

' Set colors
Const trunkColor = 6 ' Brownish
Const leafColor = 2 ' Green

' Draw trunk (a rectangle)
trunkX = 310
trunkY = 300
trunkWidth = 20
trunkHeight = 100
Line (trunkX, trunkY)-(trunkX + trunkWidth, trunkY + trunkHeight), trunkColor, BF

' Draw leaves (a series of circles)
leafCenterX = trunkX + trunkWidth \ 2
leafCenterY = trunkY - 30
leafRadius = 50

For i = 0 To 2
    For j = -1 To 1
        Circle (leafCenterX + j * 30, leafCenterY - i * 30), leafRadius, leafColor
        Paint (leafCenterX + j * 30, leafCenterY - i * 30), leafColor, leafColor
    Next j
Next i

' Wait for a key to exit
Print "Press any key to exit..."
Sleep






Screen 12
Randomize Timer

Const BRANCH_COUNT = 1000
Const TREE_HEIGHT = 400
Const TREE_WIDTH = 300
Const X_CENTER = 320
Const Y_BASE = 460

' Draw the trunk
Line (X_CENTER - 15, Y_BASE)-(X_CENTER + 15, Y_BASE - 40), BROWN, BF

' Draw the star
For r = 0 To 5
    angle1 = r * 60
    angle2 = angle1 + 30
    x1 = X_CENTER + 10 * Cos(angle1 * 3.14159 / 180)
    y1 = Y_BASE - TREE_HEIGHT - 10 + 10 * Sin(angle1 * 3.14159 / 180)
    x2 = X_CENTER + 20 * Cos(angle2 * 3.14159 / 180)
    y2 = Y_BASE - TREE_HEIGHT - 10 + 20 * Sin(angle2 * 3.14159 / 180)
    Line (X_CENTER, Y_BASE - TREE_HEIGHT - 10)-(x2, y2), YELLOW
Next

' Draw the tree branches
branchesDrawn = 0
While branchesDrawn < BRANCH_COUNT
    ' Pick a random y-position from top of tree to base
    y = Int(Rnd * TREE_HEIGHT)
    yPos = Y_BASE - y

    ' Compute tree width at that height (narrower at top)
    widthAtY = (1 - y / TREE_HEIGHT) * (TREE_WIDTH / 2)

    ' Pick a random x within the triangle width
    x = X_CENTER + Int(Rnd * 2 * widthAtY) - widthAtY

    ' Draw a small line or dot to represent a branch
    Color GREEN
    If Rnd < 0.5 Then
        Line (x, yPos)-(x + Int(Rnd * 3 - 1), yPos - Int(Rnd * 3)), GREEN
    Else
        PSet (x, yPos), GREEN
    End If

    branchesDrawn = branchesDrawn + 1
Wend

' Optional: Add some ornaments
For i = 1 To 50
    y = Int(Rnd * TREE_HEIGHT)
    yPos = Y_BASE - y
    widthAtY = (1 - y / TREE_HEIGHT) * (TREE_WIDTH / 2)
    x = X_CENTER + Int(Rnd * 2 * widthAtY) - widthAtY

    Select Case Int(Rnd * 4)
        Case 0: Color RED
        Case 1: Color YELLOW
        Case 2: Color MAGENTA
        Case Else: Color CYAN
    End Select

    Circle (x, yPos), 2, YELLOW
Next

Print "Merry Christmas! Press any key to exit."
Sleep


