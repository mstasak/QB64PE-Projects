'$Debug
Option _Explicit
'dictionary.bi
'create and use key-value dictionaries
'keys may be long or string
'values may be long or string (any long can contain a variant handle, to store other types)

'Documentation TBD.  Look at dictionarytest.bas for typical usage scenarios.

Const DICT_NONE = 0
Const DICT_KSTR_VSTR = 1
Const DICT_KSTR_VLNG = 2
Const DICT_KSTR_VDBL = 3
Const DICT_KLNG_VSTR = 4
Const DICT_KLNG_VLNG = 5
Const DICT_KLNG_VDBL = 6

Type DictHolderStruct
    dictHandle As Long
    dictName As String
    dictType As _Byte
    dictKeyElemSize As _Byte
    dictValElemSize As _Byte
    dictMemKeys As _MEM
    dictMemVals As _MEM
    dictAlloc As Long
    dictLength As Long 'elements used, from 0..dictAlloc
    'dictMaxLength As Long
    dictGrowth As Single '1.0 = 100% - amount to expand when realloc()ing
End Type

''' (re)initialize the dictionary library
ReDim Shared DictStore(1 To 10) As DictHolderStruct
Dim Shared As Long DictMaxUsed, DictReleased, DictLastHandle

'in dictionary.bm

'procedure names end in two letters indicating the dictionary key and value types
' L=Long, S=String, A=Any(don't care)

'function DictNewLL&
'function DictNewLS&
'function DictNewSL&
'function DictNewSS&
'sub DictFreeLL(d&)
'sub DictFreeLS(d&)
'sub DictFreeSL(d&)
'sub DictFreeSS(d&)
'sub DictDumpLL(d&)
'sub DictDumpLS(d&)
'sub DictDumpSL(d&)
'sub DictDumpSS(d&)
'function DictHasKeyAL%%(d&, k&)
'function DictHasKeyAS%%(d&, k$)
'function DictGetLL&(d&, k&)
'function DictGetLS$(d&, k$)
'function DictGetSL&(d&, k&)
'function DictGetSS$(d&, k$)
'sub DictAddLL(d&, v&)
'sub DictAddLS(d&, v$)
'sub DictAddSL(d&, v&)
'sub DictAddSS(d&, v$)
'sub DictPutLL(d&, v&)
'sub DictPutLS(d&, v$)
'sub DictPutSL(d&, v&)
'sub DictPutSS(d&, v$)
'sub DictRemoveLL(d&, k&)
'sub DictRemoveLS(d&, k$)
'sub DictChangeKeyLA(d&, kOld&, kNew&)
'sub DictChangeKeySA(d&, kOld$, kNew$)
'function DictCountAA&(d&)
'sub DictGetKeysLA(d&, dynarr&())
'sub DictGetKeysSA(d&, dynarr$())
'sub DictGetKeysLA(d&, dynarr&())
'sub DictGetKeysSA(d&, dynarr$())
'sub DictGetValuesAL(d&, dynarr&())
'sub DictGetValuesAS(d&, dynarr$())

'<>s TO BE EXPANDED
'function DictCountOfValueA&<v>(d, v)
'function DictCountOfValueA&<v>(d, v)
'sub DictKeysForValue<k><v>(d, v, dynarr())
'sub DictKeysForValue<k><v>(d, v, dynarr())
'sub DictKeysForValue<k><v>(d, v, dynarr())
'sub DictKeysForValue<k><v>(d, v, dynarr())
'sub DictToArray<k><v>
'sub DictToArray<k><v>
'sub DictToArray<k><v>
'sub DictToArray<k><v>
