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

// Return a detailed error description message for any negative error code,
// which might be returned by the RegexMatch() function.
//  In: error code (INTEGER, usually the code returned by RegexMatch())
// Out: error text (STRING, description for the given error code)
//--------------------------------------------------------------------
const char *RegexError(int16_t errCode) {
    switch (~errCode) {
        // just in case somebody pass in the regular matching result as error
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
        // everything else is unknown
        default: {return "Unknown RegEx error."; break;}
    }
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