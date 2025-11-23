Const REGEX_ECMAScript = &H01
Const REGEX_basic = &H02
Const REGEX_extended = &H04
Const REGEX_awk = &H08
Const REGEX_grep = &H10
Const REGEX_egrep = &H20
Const REGEX__Gmask = &H3F

Const REGEX_icase = &H0100
Const REGEX_nosubs = &H0200
Const REGEX_optimize = &H0400
Const REGEX_collate = &H0800

Declare Library "qbregex" 'Do not add .h here !!
    Function RegexMatch% (qbStr$, qbRegex$) 'add CHR$(0) to both
    Function RegexSearch% (qbStr$, qbRegex$, ByVal flags&, ByVal matchLimit&, ByVal matches As _Offset)
    'Function RegexReplace$ (source$, target$, replacement$, replaceAll%, refNumReplaced&)
    Function RegexError$ (ByVal errCode%)
End Declare
