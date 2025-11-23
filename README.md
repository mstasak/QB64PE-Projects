# QB64PE Projects

A collection of small QuickBasic64 Phoenix Edition programs and subs/functions,
some for entertainment, and some useful in other projects.

Potentially useful: 
- DataTypes/variant* - a data type which is a holder for other data types,
  useful for something like making an array of mixed types in order, say
  to pass a list of parameter values to a sql prepare-bind-execute procedure.
- DataTypes/list* - lists of Longs (or Strings or Doubles, but not intermixed
  in a single list), with insert, delete sort capabilities.
- DataTypes/dictionary* - dictionaries (maps), which are lists of key:value
  pairs enabling keyed lookup.  Keys may be Strings or Longs.  Values may
  be Strings, Longs, or Doubles.
- CPPLibs/qbregex* - a call interface (Declare Lib) allowing user to use C++
  std::regex_search option, with ignore case flag and basic, extended, and 
  EcmaScript regex flavors allowed.  Built on RhoSigma's 
  [regex_match interface](https://qb64phoenix.com/forum/showthread.php?tid=1889).  (match tests if an entire string matches a regular expression; search finds an instance of a substring matching the regular expression.) 
  
  **Bugs found** - flags are working unreliably, either parameter passing to C++ is flawed oe the casts to std::regex_constants::syntax_option_type isn't working - weirdness, working on it...