'QB64PE 4.0+
$Color:32
wid = _DesktopHeight * 0.75
hgt = _DesktopHeight * 0.75
scr = _NewImage(wid, hgt, 32)
Screen scr
_DontBlend
_PrintMode _KeepBackground
fontpath$ = Environ$("SYSTEMROOT") + "\fonts\forte.ttf" 'Find Windows Folder Path.
font& = _LoadFont(fontpath$, 200, "BOLD")
_Font font&

'Circle (500, 500), 300, Red
dx = Int(_PrintWidth("Love") \ -2)
dy = Int(_FontHeight \ -2)
For theta = 0.0 To 200.0 * _Pi Step 10 * _Pi
    x = wid \ 2 + 450 * Cos(theta / 100.0) + dx
    y = hgt \ 2 + 450 * Sin(theta / 100.0) + dy
    clr& = _HSB32(theta / 1.5, 100.0, 100.0)
    Color clr&
    _PrintString (x, y), "Love"
Next theta
Color Gray
_Font 14
_PrintString (5, hgt - 5 - _FontHeight), "Press a key to end"
Color White
Sleep
'_Delay 3

Screen 0
_FreeImage scr
_FreeFont font&
System

