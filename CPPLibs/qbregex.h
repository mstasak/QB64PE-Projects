//====================================================================
//=== Regular Expressions support ====================================
//====================================================================

#include <regex>

// Check whether the given string does match the given regular expression.
// The regex must match entirely to be true (ie. without any additional
// characters before or after the match), hence the use of ^ or $ for
// line start or line end respectively is not required/supported.
//  In: string, regex (both STRINGs, add CHR$(0) to end of strings)
// Out: match         (INTEGER, 0 = no match, 1 = positive match)
// Err: out < 0       (call RegexError() to get the error message)
//--------------------------------------------------------------------
int16_t RegexMatch(const char *qbStr, const char *qbRegex) {
    int16_t result;
    try {result = regex_match(qbStr, std::regex(qbRegex));}
    catch (const std::regex_error& e) {result = ~e.code();}
    return result;
}

/* QB64 usage:
'$INCLUDE: 'qbregex.bi'

PRINT "Type a short phrase with your or others username in it: "
LINE INPUT "Phrase: "; phrase$
PRINT

'remove one open or close parantheses to check error part
you$ = "(.*)grymmjack(.*)"

res% = RegexMatch%(UCASE$(phrase$) + CHR$(0), UCASE$(you$) + CHR$(0)) 'match ignoring case
IF res% > 0 THEN
    PRINT "Hey, must be you, grymmjack."
ELSEIF res% = 0 THEN
    PRINT "Hello unknown user."
ELSE
    PRINT "Error: "; RegexError$(res%)
END IF

END
*/

// Find a range of qbStr matching the regular expression pattern in
// qbRegex.
//
// Input:  'qbStr': string to search in, terminated by Chr$(0).
//         'qbRegex': string containing RE pattern to search for, 
//           terminated by Chr$(0).
//         'flags': contains a bitwise-ored set of options controlling
//           pattern matching.  Notably iCase enables case-insensitive
//           searching, and ecmascript enables some advanced
//           functionality.  See REGEX_* Const values in qbregex.bi .
//         'nMatchLongs': number of longs in array provided for matches
//           and submatches detected by the search.  Each match occupies
//           two Longs: a 1-based start of match, and a length of match.
//           submatches identify match substrings corresponding to parts
//           of the search pattern surrounded by parentheses. 
//         'matchPtrOffset': The ByVal passed _Offset(matcharray())
//           of the long array receiving match and submatches.
//--------------------------------------------------------------------
int16_t RegexSearch(const char* qbStr, const char* qbRegex,
    int32_t flags, int32_t nMatchLongs, uintptr_t matchPtrOffset) {
    int32_t *results = (int32_t *)matchPtrOffset;
    if (nMatchLongs < 2) return -3;
    int16_t rslt = 0; //1 if success, 0 if nomatch, <0 = errorcode
    int16_t outCounter = 0;
    try {
        auto decoded_flags = (std::regex_constants::syntax_option_type)flags;
        results[31] = decoded_flags;
        std::string text(qbStr);
        std::regex re(qbRegex,decoded_flags);
        //std::regex re(qbRegex, flags);
        //std::regex::flag_type refs;
        //std::regex re(qbRegex, std::regex::icase);
        std::smatch match; // smatch is an alias for match_results<string::const_iterator>

        // Perform the regex search
        if (std::regex_search(text, match, re)) {
            int i = 0;
            for (auto it = match.cbegin(); it != match.cend(); ++it) {
                if (outCounter+2 > nMatchLongs) break;
                results[outCounter++] = match.position(i)+1;
                results[outCounter++] = match.length(i);
                i++;
            }
            if (outCounter < nMatchLongs) {
                results[outCounter] = -1; //save end of submatches marker, if there is room
            }
            rslt = 1;
        } else {
            rslt = 0;
        }
    }
    catch (const std::regex_error& e) {
        rslt = ~e.code();
    }
    return rslt;
}

/* QB64 usage:
Option _Explicit
'$Include: 'qbregex.bi'

Dim s As String
Dim re As String
Dim res As Integer
ReDim buffr(0 To 1) As Long
Dim flags As Long

s = "Now is the time for all good men" + Chr$(0)
re = "IS" + Chr$(0)
flags = REGEX_icase Or REGEX_ECMAScript
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

s = "negative pi = -3.141592654" + Chr$(0)
re = "(([\+-]?)([0-9]*)?(\.[0-9]+)([eE][+-]?[0-9]+)?)|" + _
     "(([\+-]?)([0-9]+)?(\.[0-9]*)([eE][+-]?[0-9]+)?)" + Chr$(0)
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

End
*/

// Function RegexReplace& (source$, target$, replacement$, replaceAll%)
// (future project)


// Return a detailed error description message for any negative error code,
// which might be returned by the RegexMatch() function.
//  In: error code (INTEGER, usually the code returned by RegexMatch())
// Out: error text (STRING, description for the given error code)
//--------------------------------------------------------------------
const char *RegexError(int16_t errCode) {
    switch (~errCode) {
        // just in case somebody pass in the regular matching result as error
        case -3: {return "Result buffer too small."; break;}
        case -2: {return "No error, it was a positive RegEx match."; break;}
        case -1: {return "No error, the RegEx just didn't match."; break;}
        // and now the real errors known to the regex library
        case std::regex_constants::error_collate: {return "RegEx has an invalid collating element name."; break;}
        case std::regex_constants::error_ctype: {return "RegEx has an invalid character class name."; break;}
        case std::regex_constants::error_escape: {return "RegEx has an invalid escaped character, or a trailing escape."; break;}
        case std::regex_constants::error_backref: {return "RegEx has an invalid back reference."; break;}
        case std::regex_constants::error_brack: {return "RegEx has mismatched brackets [ and ]."; break;}
        case std::regex_constants::error_paren: {return "RegEx has mismatched parentheses ( and )."; break;}
        case std::regex_constants::error_brace: {return "RegEx has mismatched braces { and }."; break;}
        case std::regex_constants::error_badbrace: {return "RegEx has an invalid range between braces { and }."; break;}
        case std::regex_constants::error_range: {return "RegEx has an invalid character range."; break;}
        case std::regex_constants::error_space: {return "Out of memory while converting RegEx into a finite state machine."; break;}
        case std::regex_constants::error_badrepeat: {return "RegEx has a repeat specifier, one of *?+{, that was not preceded by a valid token."; break;}
        case std::regex_constants::error_complexity: {return "Complexity of an attempted match exceeded a pre-set level."; break;}
        case std::regex_constants::error_stack: {return "Out of memory while trying to match the specified string."; break;}
        //case -4: {return ""; break;}
        // everything else is unknown
        default: {return "Unknown RegEx error."; break;}
    }
}

