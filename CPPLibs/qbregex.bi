DECLARE LIBRARY "qbregex" 'Do not add .h here !!
    FUNCTION RegexMatch% (qbStr$, qbRegex$) 'add CHR$(0) to both
    FUNCTION RegexError$ (BYVAL errCode%)
END DECLARE
