# Variant support library API

## Purpose

variant.bi and variant.bm implement a Variant system in QB64 PE 4.2.0

A variant is a Long handle which holds a key to an element in an array of value holder records.

A variant may "hold" any of these value types:

- String
- _Byte
- Integer
- Long
- Integer64
- Single
- Double
- _Float
- String(lbound to ubound)
- _Byte(lbound to ubound)
- Integer(lbound to ubound)
- Long(lbound to ubound)
- Integer64(lbound to ubound)
- Single(lbound to ubound)
- Double(lbound to ubound)
- _Float(lbound to ubound)

Only one-dimension arrays are supported.

## Usage

### Session

- `Sub VTInit` initializes the variant system. Call before creating or using variants.

- `Sub VTTerminate` shut down variant system.  Call when finished using variants, to release memory.

- `Sub VTDump` print the contents of the variant storage for each variant, list (handle, type, and value).
  
### Creation

- `Function VTNewStr& (s As String)` returns Long variant handle, identifying a variant containing the String s.

- `Function VTNewByte& (n As _Byte)` returns Long variant handle, identifying a variant containing the _Byte n.

- `Function VTNewInt& (n As Integer)` returns Long variant handle, identifying a variant containing the Integer n.

- `Function VTNewLng& (n As Long)` returns Long variant handle, identifying a variant containing the Long n.

- `Function VTNewInt64& (n As _Integer64)` returns Long variant handle, identifying a variant containing the _Integer64 n.

- `Function VTNewSng& (n As Single)` returns Long variant handle, identifying a variant containing the Single n.

- `Function VTNewDbl& (n As Double)` returns Long variant handle, identifying a variant containing the Double n.

- `Function VTNewFlt& (n As _Float)` returns Long variant handle, identifying a variant containing the _Float n.

- `Function VTNewStringArray& (arr() As String)` returns Long variant handle, identifying a variant containing the String Array arr().

- `Function VTNewByteArray& (arr() As _Byte)` returns Long variant handle, identifying a variant containing the _Byte arr().

- `Function VTNewIntArray& (arr() As Integer)` returns Long variant handle, identifying a variant containing the Integer Array arr().

- `Function VTNewLongArray& (arr() As Long)` returns Long variant handle, identifying a variant containing the Long Array arr().

- `Function VTNewInt64Array& (arr() As _Integer64)` returns Long variant handle, identifying a variant containing the _Integer64 Array arr().

- `Function VTNewSingleArray& (arr() As Single)` returns Long variant handle, identifying a variant containing the Single Array arr().

- `Function VTNewDoubleArray& (arr() As Double)` returns Long variant handle, identifying a variant containing the Double Array arr().

- `Function VTNewFloatArray& (arr() As _Float)` returns Long variant handle, identifying a variant containing the _Float Array arr().

### Access

- `Function VTStr$ (vHandle As Long)` Get the value of a String variant.

- `Function VTByt% (vHandle As Long)` Get the value of a _Byte variant.

- `Function VTInt% (vHandle As Long)` Get the value of an Integer variant.

- `Function VTLng& (vHandle As Long)` Get the value of a Long variant.

- `Function VTInt64&& (vHandle As Long)` Get the value of an _Integer64 variant.

- `Function VTSng! (vHandle As Long)` Get the value of a Single variant.

- `Function VTDbl# (vHandle As Long)` Get the value of a Double variant.

- `Function VTFlt## (vHandle As Long)` Get the value of a _Float variant.

- `Sub VTGetStringArray (vHandle As Long, arr() As String)` Get the value of a String Array variant.

- `Sub VTGetByteArray (vHandle As Long, arr() As _Byte)` Get the value of a _Byte Array variant.

- `Sub VTGetIntArray (vHandle As Long, arr() As Integer)` Get the value of an Integer Array variant.

- `Sub VTGetLongArray (vHandle As Long, arr() As Long)` Get the value of a Long Array variant.

- `Sub VTGetInt64Array (vHandle As Long, arr() As _Integer64)` Get the value of an _Integer64 Array variant.

- `Sub VTGetSingleArray (vHandle As Long, arr() As Single)` Get the value of a Single Array variant.

- `Sub VTGetDoubleArray (vHandle As Long, arr() As Double)` Get the value of a Double Array variant.

- `Sub VTGetFloatArray (vHandle As Long, arr() As _Float)` Get the value of a _Float Array variant.

- `Function VTType$ (vHandle As Long)` Return the type of a variant:  "(NULL)" (probably a VTRelease'd variant) / "STRING" / "BYTE" / "INTEGER" / "LONG" / "INTEGER64" / "SINGLE" / "DOUBLE" / "FLOAT" / "STRING ARRAY" / "BYTE ARRAY" / "INTEGER ARRAY" / "LONG ARRAY" / "INTEGER64 ARRAY" / "SINGLE ARRAY" / "DOUBLE ARRAY" / "FLOAT ARRAY"

- `Function VTToStr$ (vHandle As Long)` - convert value of variant of any typeto a string, i.e. for printing

### Disposal

- `Sub VTRelease (vHandle As Long)` Release the variant identified by vHandle.  vHandle becomes invalid (erased).
- `Sub VTReleaseAll` Release all variants.  All vHandles become invalid and VTStore is shrunk to its initial size.
- `Sub VTCompact (newUB As Long)` If VTStore (the main array containing variant type and value info) will then be <80% full, shrink it to the new upper bound in newUB.

### Internal

- `Function VariantNew&` create a new raw variant handle, with no type or value assigned
- `Function VTStoreIndexOf& (vHandle As Long)` find the VTStore index of a variant handle
- `Sub VTGetStringArrayAt (vsIndex As Long, arr() As String)` helper for VTGetStringArray, without vHandle lookup
- `Sub VTGetByteArrayAt (vsIndex As Long, arr() As _Byte)` helper for VTGetByteArray, without vHandle lookup
- `Sub VTGetIntArrayAt (vsIndex As Long, arr() As Integer)` helper for VTGetIntArray, without vHandle lookup
- `Sub VTGetLongArrayAt (vsIndex As Long, arr() As Long)` helper for VTGetLongArray, without vHandle lookup
- `Sub VTGetInt64ArrayAt (vsIndex As Long, arr() As _Integer64)` helper for VTGetInt64Array, without vHandle lookup
- `Sub VTGetSingleArrayAt (vsIndex As Long, arr() As Single)` helper for VTGetSingleArray, without vHandle lookup
- `Sub VTGetDoubleArrayAt (vsIndex As Long, arr() As Double)` helper for VTGetDoubleArray, without vHandle lookup
- `Sub VTGetFloatArrayAt (vsIndex As Long, arr() As _Float)` helper for VTGetFloatArray, without vHandle lookup
- `Function VTTypeAt$ (nIndex As Long)` return the type name of the variant at VTStore slot nIndex.
- `Function VTToStrAt$ (nIndex As Long)` convert value of any type at VTStore slot to a string, i.e. for printing
- `Function CInt64ToByte%% (n As _Integer64)` extract low order byte from an _Integer64 value
- `Function CInt64ToInteger% (n As _Integer64)` extract low order word from an _Integer64 value
- `Function CInt64ToLong& (n As _Integer64)` extract low order dword from an _Integer64 value
- `Sub VTReleaseAt (vsIndex As Long, autoCompact As _Byte)` release variant at a given slot in VTStore.  Autocompact may be disabled to speed up bulk releasing.
- `Function VTNextVStoreIndex&` return the next available (empty, vHandle=0) VTStore index.

## Potential enhancements

- Cache recent vHandle lookups for performance.
- Use binary search and/or some end-relative search to speed up vHandle lookup (currently a forward linear search - even reverse might be better) (some tradeoffs required, as it would demand a sorted VTStore array by handle).
- Allow user to turn on and off auto-compaction to prevent slowdown at cost of memory use.
- Save and recreate multi-dimension arrays (I believe _MEM stores them the same, but does not preserve index count and bounds).
- Support _Bit values and arrays (IIRC, they're kinda new and incompletely supported, may have to manually pack them into Longs or some such).
- Add error handling and debugging support.
- Add logging support.
- Add `VTAssign<Type>(vHandle, value)` Sub family (or maybe `VTSet<Type>(vHandle, value)`). (an alternative to `VTRelease vHandle : vHandle = VTNew*Type*(value)`)
- Add some performance workarounds for StringArray to extract a single element without rebuilding the whole array, change a single element, insert or delete an element, or fetch the element count.
- Change `VTType(vHandle)` to return the numeric type code, and add `VTTypeName$(vHandle)`
- Add `VTExists%%(vHandle)` to test if a handle is valid
- Implement optional variant names (VTHolderStruct addition, with access methods mimicing a dictionary keyed by name, holding variant handles: `VTFind(name)`, `VTSetName(vHandle, name)`)
- Rename internals VT_INTERNAL_xxx to help prevent accidental use
- Check for publicly visible symbols not beginning with VT (or VT_).