describe "Sk.ffh", ->

  beforeEach () ->
    Sk.currLineNo = 12345

  describe "add", ->
    it "1+1", ->
      expect(Sk.ffi.typeName Sk.ffh.add Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe 'int'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.add Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe '2'
    it "1.0+1.0", ->
      expect(Sk.ffi.typeName Sk.ffh.add Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe 'float'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.add Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe '2.0'
    it "1L+1L", ->
      expect(Sk.ffi.typeName Sk.ffh.add Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe 'long'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.add Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe '2'
    it "12345678901234567890123456789L+12345678901234567890123456789L", ->
      expect(Sk.ffi.typeName Sk.ffh.add Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe 'long'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.add Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe '24691357802469135780246913578'

  describe "subtract", ->
    it "1 - 1", ->
      expect(Sk.ffi.typeName Sk.ffh.sub Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe 'int'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.sub Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe '0'
    it "1.0 - 1.0", ->
      expect(Sk.ffi.typeName Sk.ffh.sub Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe 'float'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.sub Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe '0.0'
    it "1L - 1L", ->
      expect(Sk.ffi.typeName Sk.ffh.sub Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe 'long'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.sub Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe '0'
    it "12345678901234567890123456789L - 12345678901234567890123456789L", ->
      expect(Sk.ffi.typeName Sk.ffh.sub Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe 'long'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.sub Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe '0'
  
  describe "multiply", ->
    it "1 * 1", ->
      expect(Sk.ffi.typeName Sk.ffh.mul Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe 'int'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.mul Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe '1'
    it "1.0 * 1.0", ->
      expect(Sk.ffi.typeName Sk.ffh.mul Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe 'float'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.mul Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe '1.0'
    it "1L * 1L", ->
      expect(Sk.ffi.typeName Sk.ffh.mul Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe 'long'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.mul Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe '1'
    it "12345678901234567890123456789L * 12345678901234567890123456789L", ->
      expect(Sk.ffi.typeName Sk.ffh.mul Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe 'long'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.mul Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe '152415787532388367504953515625361987875019051998750190521'

  describe "divide", ->
    it "1 / 1", ->
      expect(Sk.ffi.typeName Sk.ffh.div Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe 'int'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.div Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe '1'
    it "1.0 / 1.0", ->
      expect(Sk.ffi.typeName Sk.ffh.div Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe 'float'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.div Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe '1.0'
    it "1L / 1L", ->
      expect(Sk.ffi.typeName Sk.ffh.div Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe 'long'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.div Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe '1'
    it "12345678901234567890123456789L / 12345678901234567890123456789L", ->
      expect(Sk.ffi.typeName Sk.ffh.div Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe 'long'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.div Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe '1'

  describe "pow", ->
    it "1 ** 1", ->
      expect(Sk.ffi.typeName Sk.ffh.pow Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe 'int'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.pow Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe '1'
    it "1.0 ** 1.0", ->
      expect(Sk.ffi.typeName Sk.ffh.pow Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe 'float'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.pow Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe '1.0'
    it "1L ** 1L", ->
      expect(Sk.ffi.typeName Sk.ffh.pow Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe 'long'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.pow Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe '1'

  describe "mod", ->
    it "1 % 1", ->
      expect(Sk.ffi.typeName Sk.ffh.mod Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe 'int'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.mod Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe '0'
    it "1.0 % 1.0", ->
      expect(Sk.ffi.typeName Sk.ffh.mod Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe 'float'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.mod Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe '0.0'
    it "1L % 1L", ->
      expect(Sk.ffi.typeName Sk.ffh.mod Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe 'long'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.mod Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe '0'
    it "12345678901234567890123456789L % 12345678901234567890123456789L", ->
      expect(Sk.ffi.typeName Sk.ffh.mod Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe 'long'
      expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.mod Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe '0'

  describe "eq", ->
    it "1 = 1", ->
      expect(Sk.ffi.typeName Sk.ffh.eq Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe 'bool'
      expect(Sk.ffi.remapToJs Sk.ffh.eq Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe true
    it "1.0 = 1.0", ->
       expect(Sk.ffi.typeName Sk.ffh.eq Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.eq Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe true
    it "1L = 1L", ->
       expect(Sk.ffi.typeName Sk.ffh.eq Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.eq Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe true
    it "12345678901234567890123456789L = 12345678901234567890123456789L", ->
       expect(Sk.ffi.typeName Sk.ffh.eq Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.eq Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe true

  describe "ne", ->
    it "1 = 1", ->
      expect(Sk.ffi.typeName Sk.ffh.ne Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe 'bool'
      expect(Sk.ffi.remapToJs Sk.ffh.ne Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe false
    it "1.0 = 1.0", ->
       expect(Sk.ffi.typeName Sk.ffh.ne Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.ne Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe false
    it "1L = 1L", ->
       expect(Sk.ffi.typeName Sk.ffh.ne Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.ne Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe false
    it "12345678901234567890123456789L = 12345678901234567890123456789L", ->
       expect(Sk.ffi.typeName Sk.ffh.ne Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.ne Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe false

  describe "lt", ->
    it "1 < 1", ->
      expect(Sk.ffi.typeName Sk.ffh.lt Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe 'bool'
      expect(Sk.ffi.remapToJs Sk.ffh.lt Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe false
    it "1.0 < 1.0", ->
       expect(Sk.ffi.typeName Sk.ffh.lt Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.lt Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe false
    it "1L < 1L", ->
       expect(Sk.ffi.typeName Sk.ffh.lt Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.lt Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe false
    it "12345678901234567890123456789L < 12345678901234567890123456789L", ->
       expect(Sk.ffi.typeName Sk.ffh.lt Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.lt Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe false

  describe "le", ->
    it "1 = 1", ->
      expect(Sk.ffi.typeName Sk.ffh.le Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe 'bool'
      expect(Sk.ffi.remapToJs Sk.ffh.le Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe true
    it "1.0 = 1.0", ->
       expect(Sk.ffi.typeName Sk.ffh.le Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.le Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe true
    it "1L = 1L", ->
       expect(Sk.ffi.typeName Sk.ffh.le Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.le Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe true
    it "12345678901234567890123456789L = 12345678901234567890123456789L", ->
       expect(Sk.ffi.typeName Sk.ffh.le Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.le Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe true

  describe "gt", ->
    it "1 < 1", ->
      expect(Sk.ffi.typeName Sk.ffh.gt Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe 'bool'
      expect(Sk.ffi.remapToJs Sk.ffh.gt Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe false
    it "1.0 < 1.0", ->
       expect(Sk.ffi.typeName Sk.ffh.gt Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.gt Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe false
    it "1L < 1L", ->
       expect(Sk.ffi.typeName Sk.ffh.gt Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.gt Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe false
    it "12345678901234567890123456789L < 12345678901234567890123456789L", ->
       expect(Sk.ffi.typeName Sk.ffh.gt Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.gt Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe false

  describe "ge", ->
    it "1 = 1", ->
      expect(Sk.ffi.typeName Sk.ffh.ge Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe 'bool'
      expect(Sk.ffi.remapToJs Sk.ffh.ge Sk.ffi.numberToIntPy(1), Sk.ffi.numberToIntPy(1)).toBe true
    it "1.0 = 1.0", ->
       expect(Sk.ffi.typeName Sk.ffh.ge Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.ge Sk.builtin.numberToPy(1), Sk.builtin.numberToPy(1)).toBe true
    it "1L = 1L", ->
       expect(Sk.ffi.typeName Sk.ffh.ge Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.ge Sk.ffi.longFromString('1'), Sk.ffi.longFromString('1')).toBe true
    it "12345678901234567890123456789L = 12345678901234567890123456789L", ->
       expect(Sk.ffi.typeName Sk.ffh.ge Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe 'bool'
       expect(Sk.ffi.remapToJs Sk.ffh.ge Sk.ffi.longFromString('12345678901234567890123456789'), Sk.ffi.longFromString('12345678901234567890123456789')).toBe true

  describe "xor", -> 
    it "(0, 0) should be 0", -> expect(Sk.ffi.remapToJs Sk.ffh.bitXor Sk.ffi.numberToFloatPy(0), Sk.ffi.numberToFloatPy(0)).toBe 0
    it "(0, 1) should be 1", -> expect(Sk.ffi.remapToJs Sk.ffh.bitXor Sk.ffi.numberToFloatPy(0), Sk.ffi.numberToFloatPy(1)).toBe 1
    it "(1, 0) should be 1", -> expect(Sk.ffi.remapToJs Sk.ffh.bitXor Sk.ffi.numberToFloatPy(1), Sk.ffi.numberToFloatPy(0)).toBe 1
    it "(1, 1) should be 0", -> expect(Sk.ffi.remapToJs Sk.ffh.bitXor Sk.ffi.numberToFloatPy(1), Sk.ffi.numberToFloatPy(1)).toBe 0

  describe "lshift", -> 
    it "(2, 0) should be 2", -> expect(Sk.ffi.remapToJs Sk.ffh.lshift Sk.ffi.numberToFloatPy(2), Sk.ffi.numberToFloatPy(0)).toBe 2
    it "(2, 1) should be 4", -> expect(Sk.ffi.remapToJs Sk.ffh.lshift Sk.ffi.numberToFloatPy(2), Sk.ffi.numberToFloatPy(1)).toBe 4
    it "(1, 0) should be 1", -> expect(Sk.ffi.remapToJs Sk.ffh.lshift Sk.ffi.numberToFloatPy(1), Sk.ffi.numberToFloatPy(0)).toBe 1
    it "(1, 1) should be 2", -> expect(Sk.ffi.remapToJs Sk.ffh.lshift Sk.ffi.numberToFloatPy(1), Sk.ffi.numberToFloatPy(1)).toBe 2

  describe "rshift", -> 
    it "(2, 0) should be 2", -> expect(Sk.ffi.remapToJs Sk.ffh.rshift Sk.ffi.numberToFloatPy(2), Sk.ffi.numberToFloatPy(0)).toBe 2
    it "(2, 1) should be 1", -> expect(Sk.ffi.remapToJs Sk.ffh.rshift Sk.ffi.numberToFloatPy(2), Sk.ffi.numberToFloatPy(1)).toBe 1
    it "(1, 0) should be 1", -> expect(Sk.ffi.remapToJs Sk.ffh.rshift Sk.ffi.numberToFloatPy(1), Sk.ffi.numberToFloatPy(0)).toBe 1
    it "(1, 1) should be 0", -> expect(Sk.ffi.remapToJs Sk.ffh.rshift Sk.ffi.numberToFloatPy(1), Sk.ffi.numberToFloatPy(1)).toBe 0

  describe "positive", -> it "(2) should be +2", -> expect(Sk.ffi.remapToJs Sk.ffh.positive Sk.ffi.numberToFloatPy(2)).toBe +2
  describe "negative", -> it "(2) should be -2", -> expect(Sk.ffi.remapToJs Sk.ffh.negative Sk.ffi.numberToFloatPy(2)).toBe -2

  describe "nonzero", -> 
    it "(1) should be true", -> expect(Sk.ffi.remapToJs Sk.ffh.nonzero Sk.ffi.numberToFloatPy(1)).toBe true
    it "(0) should be false", -> expect(Sk.ffi.remapToJs Sk.ffh.nonzero Sk.ffi.numberToFloatPy(0)).toBe false

  describe "repr", ->
    it "(2) should be '2.0'", -> expect(Sk.ffi.remapToJs Sk.ffh.repr Sk.ffi.numberToFloatPy(2)).toBe '2.0'
    it "should apply apostrophe marks", -> expect(Sk.ffi.remapToJs Sk.ffh.repr Sk.builtin.stringToPy("Hello")).toBe "'Hello'"
    it "should switch to quotation marks", -> expect(Sk.ffi.remapToJs Sk.ffh.repr Sk.builtin.stringToPy("He'llo")).toBe '"He' + "'" + 'llo"'
    it "should not apply quotation marks", -> expect(Sk.ffi.remapToJs Sk.ffh.repr Sk.builtin.stringToPy('He"llo')).toBe "'He" + '"' + "llo'"
    it "should not apply quotation marks", -> expect(Sk.ffi.remapToJs Sk.ffh.repr Sk.builtin.none.none$).toBe 'None'

  describe "str", ->
    it "(2) should be '2.0'", -> expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffi.numberToFloatPy(2)).toBe '2.0'
    it "should not apply quotation marks", -> expect(Sk.ffi.remapToJs Sk.ffh.str Sk.builtin.stringToPy("Hello")).toBe "'Hello'"
    it "should not apply quotation marks", -> expect(Sk.ffi.remapToJs Sk.ffh.str Sk.builtin.stringToPy("He'llo")).toBe '"He' + "'" + 'llo"'
    it "should not apply quotation marks", -> expect(Sk.ffi.remapToJs Sk.ffh.str Sk.builtin.stringToPy('He"llo')).toBe "'He" + '"' + "llo'"
    it "should not apply quotation marks", -> expect(Sk.ffi.remapToJs Sk.ffh.str Sk.builtin.none.none$).toBe 'None'

  describe "acos", ->
    it "of 0.0 should be 0", -> expect(Sk.ffi.remapToJs Sk.ffh.acos Sk.ffi.numberToFloatPy(0)).toBe Math.acos(0.0)
    it "of 0.5 should be Math.acos(0.5)", -> expect(Sk.ffi.remapToJs Sk.ffh.acos Sk.ffi.numberToFloatPy(0.5)).toBe Math.acos(0.5)
    it "of 1.0 should be Math.acos(1.0)", -> expect(Sk.ffi.remapToJs Sk.ffh.acos Sk.ffi.numberToFloatPy(1)).toBe Math.acos(1.0)
    it "of number greater than +1 should be NaN", -> expect(isNaN Sk.ffi.remapToJs Sk.ffh.acos Sk.ffi.numberToFloatPy(+2)).toBe true
    it "of number less than -1 should be NaN", -> expect(isNaN Sk.ffi.remapToJs Sk.ffh.acos Sk.ffi.numberToFloatPy(-2)).toBe true
    it "of None should be None", -> expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.acos Sk.builtin.none.none$).toBe 'None'

  describe "asin", ->
    it "of 0.0 should be 0", -> expect(Sk.ffi.remapToJs Sk.ffh.asin Sk.ffi.numberToFloatPy(0)).toBe Math.asin(0.0)
    it "of 0.5 should be Math.asin(0.5)", -> expect(Sk.ffi.remapToJs Sk.ffh.asin Sk.ffi.numberToFloatPy(0.5)).toBe Math.asin(0.5)
    it "of 1.0 should be Math.asin(1.0)", -> expect(Sk.ffi.remapToJs Sk.ffh.asin Sk.ffi.numberToFloatPy(1)).toBe Math.asin(1.0)
    it "of number greater than +1 should be NaN", -> expect(isNaN Sk.ffi.remapToJs Sk.ffh.asin Sk.ffi.numberToFloatPy(+2)).toBe true
    it "of number less than -1 should be NaN", -> expect(isNaN Sk.ffi.remapToJs Sk.ffh.asin Sk.ffi.numberToFloatPy(-2)).toBe true
    it "of None should be None", -> expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.asin Sk.builtin.none.none$).toBe 'None'

  describe "atan", ->
    it "of 0.0 should be 0", -> expect(Sk.ffi.remapToJs Sk.ffh.atan Sk.ffi.numberToFloatPy(0)).toBe Math.atan(0.0)
    it "of 0.5 should be Math.atan(0.5)", -> expect(Sk.ffi.remapToJs Sk.ffh.atan Sk.ffi.numberToFloatPy(0.5)).toBe Math.atan(0.5)
    it "of 1.0 should be Math.atan(1.0)", -> expect(Sk.ffi.remapToJs Sk.ffh.atan Sk.ffi.numberToFloatPy(1)).toBe Math.atan(1.0)
    it "of None should be None", -> expect(Sk.ffi.remapToJs Sk.ffh.str Sk.ffh.atan Sk.builtin.none.none$).toBe 'None'
