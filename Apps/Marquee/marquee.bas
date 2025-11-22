$Debug
' Marquee - show a list of reminders, one at a time, on host screen in a small window, with reasonably small resource footprint
Option _Explicit

'$Include: 'Sqlite3Decls.bi'
'$Include: 'MarqueeModelDecls.bi'

'Common Shared mmList, DB_Result_Count

'Type ReminderType
'    title As String
'    details As String
'    jsonDetails As String
'    startDate As Long
'    completed As _Byte
'    recurDays As Integer
'End Type

mmCreateDbIfNotExists
mmLoadList
Dim nReminders As Integer
nReminders = UBound(mmList)

ReDim Shared Reminders(1 To nReminders) As String
Dim i As Integer
For i = 1 To nReminders
    Reminders(i) = mmList(i).title + " (" + mmList(i).description + ")"
Next i

_Title "Don't forget!"

Dim sWidth As Long
sWidth = 1350
Dim sHeight As Long
sHeight = 76

Dim mScreen As Long

mScreen = _NewImage(sWidth, sHeight, 32)
Dim fontPath As String, font As Long
fontPath = Environ$("SYSTEMROOT") + "\fonts\Britanic.ttf" 'Find Windows Folder Path.
font = _LoadFont(fontPath, 72, "BOLD")
_Font font, mScreen
sWidth = 0
For i = 1 To nReminders
    Dim pWidth As Long
    pWidth = _PrintWidth(Reminders(i), mScreen)
    If sWidth < pWidth Then sWidth = pWidth
Next i
_FreeImage mScreen
mScreen = _NewImage(sWidth + 24, sHeight, 32) 'padded width because "Tidy Living Room" was displaying "m" line-wrapped before the final letter.
Screen mScreen
$Color:32

Color CrayolaGold
_Font font
Dim currentMsg As Integer
currentMsg = 1
Do
    Cls , Black
    Locate 1, 3
    Print Reminders(currentMsg);
    Sleep 2
    currentMsg = currentMsg Mod nReminders + 1
Loop While InKey$ <> _CHR_ESC
Screen 0
_FreeFont font
_FreeImage mScreen
System

'$Include: 'SQLite3.bm'
'$Include: 'MarqueeModel.bm'

