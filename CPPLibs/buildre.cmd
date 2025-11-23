REM Build batch file for retrials.cpp- to make a .EXE for work
REM implementing a QB64PE external .DLL to search a string for
REM a regular expression pattern.  The only code I found does
REM a whole string match.  It might also be nice to find multiple
REM matches and or sub-matches.
g:
cd \qb64pe\internal\c\c_compiler\bin
del retrials.exe
gcc retrials.cpp -o retrials.exe -lstdc++
REM or maybe gcc retrials.cpp -o retrials.exe -lc++
.\retrials.exe
