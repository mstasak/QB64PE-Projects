'$Debug
'dictionarytest.bas
Option _Explicit

'create and use key-ordered dictionaries
'keys may be long or string
'values may be long, string, or double

'Sample/Test Code
$Console:Only
'$Include: 'variant.bi'
'$Include: 'dictionary.bi'

VTInit
DictInit

Dim d1 As Long, d2 As Long, d3 As Long

d1 = DictNewKStrVStr
DictSetName d1, "DoeRayMe"

DictAddKStrVStr d1, "DOE", "A deer.  A female deer."
DictAddKStrVStr d1, "RAY", "A drop of golden sun."
DictAddKStrVStr d1, "ME", "The name I call my"
DictAddKStrVStr d1, "ME", "The name I call myself"
DictAddKStrVStr d1, "ME", DictLookupStrForStr(d1, "ME") + "."
DictAddKStrVStr d1, "OOPS", "A mistake."
DictAddKStrVStr d1, "FAR", "A long long way to run."
DictDeleteForKeyS d1, "OOPS"


d2 = DictNewKLngVLng
DictSetName d2, "Squares"
DictAddKLngVLng d2, 10, 100
DictAddKLngVLng d2, 1, 1
DictAddKLngVLng d2, -3, 9
DictAddKLngVLng d2, 4, 16
DictAddKLngVLng d2, 25, 625
DictAddKLngVLng d2, 2, 4
DictAddKLngVLng d2, 5, 25


DictDump
VTDump

DictRelease d2

DictDump
VTDump

DictTerminate
VTDump
VTTerminate
End

'$Include: 'dictionary.bm'
'$Include: 'variant.bm'


