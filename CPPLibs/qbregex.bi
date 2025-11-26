'Flag values from ...\QB64pe\internal\c\c_compiler\include\c++\v1\__cxx03\regex:2293
'std::regex_options::syntax_option_type implemented by a template?

Const REGEX_ECMAScript = &H0000 'good for basic use
Const REGEX_icase = &H0001 'case-insensitive search or compare
Const REGEX_nosubs = &H0002
Const REGEX_optimize = &H0004
Const REGEX_collate = &H0008
Const REGEX_basic = &H0010
Const REGEX_extended = &H0020
Const REGEX_awk = &H0040
Const REGEX_grep = &H0080
Const REGEX_egrep = &H0100
Const REGEX_ECMAScriptnonzero = &H0200
Const REGEX__Gmask = &H003F
Const REGEX_multiline = &H0400


Declare Library "qbregex" 'Do not add .h here !!
    Function RegexMatch% (qbStr$, qbRegex$) 'add CHR$(0) to both
    Function RegexSearch% (qbStr$, qbRegex$, ByVal flags&, ByVal matchLimit&, ByVal matches As _Offset)
    'Function RegexReplace$ (source$, target$, replacement$, replaceAll%, refNumReplaced&)
    Function RegexError$ (ByVal errCode%)
End Declare
