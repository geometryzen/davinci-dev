describe "Sk.ffi", ->

  beforeEach () ->
    Sk.currLineNo = 12345

  describe "err", ->

    withLineNo = (message) -> message + " on line " + if Sk.currLineNo > 0 then "#{Sk.currLineNo}" else "<unknown>"

    it "argument.mustHaveType when Sk.currLineNo is defined.", ->
      expect(Sk.ffi.err.argument("x").mustHaveType(Sk.ffi.PyType.STR).toString()).toBe withLineNo "TypeError: x must be a <type 'str'>"

    it "argument.mustHaveType when Sk.currLineNo is zero.", ->
      Sk.currLineNo = 0
      expect(Sk.ffi.err.argument("x").mustHaveType("T").toString()).toBe withLineNo "TypeError: x must be a <class 'T'>"

    it "argument.inFunction.mustHaveType when Sk.currLineNo is defined.", ->
      expect(Sk.ffi.err.argument("x").inFunction('foo').mustHaveType(Sk.ffi.PyType.STR).toString()).toBe withLineNo "TypeError: Expecting argument 'x' in function 'foo' to have type <type 'str'>."

    it "argument.inFunction.mustHaveType when Sk.currLineNo is zero.", ->
      Sk.currLineNo = 0
      expect(Sk.ffi.err.argument("x").inFunction('foo').mustHaveType("T").toString()).toBe withLineNo "TypeError: Expecting argument 'x' in function 'foo' to have type <class 'T'>."

    it "argument.mustHaveType when Sk.currLineNo is defined.", ->
      expect(Sk.ffi.err.argument("x").mustHaveType(Sk.ffi.PyType.STR).toString()).toBe withLineNo "TypeError: x must be a <type 'str'>"

    it "argument.mustHaveType when Sk.currLineNo is zero.", ->
      Sk.currLineNo = 0
      expect(Sk.ffi.err.argument("x").mustHaveType("T").toString()).toBe withLineNo "TypeError: x must be a <class 'T'>"

  describe "typeString", ->
    it "typeString PyType.DICT     => <type 'dict'>",     -> expect(Sk.ffi.typeString Sk.ffi.PyType.DICT).toBe          "<type 'dict'>"
    it "typeString PyType.LIST     => <type 'list'>",     -> expect(Sk.ffi.typeString Sk.ffi.PyType.LIST).toBe          "<type 'list'>"
    it "typeString PyType.TUPLE    => <type 'tuple'>",    -> expect(Sk.ffi.typeString Sk.ffi.PyType.TUPLE).toBe         "<type 'tuple'>"
    it "typeString PyType.FLOAT    => <type 'float'>",    -> expect(Sk.ffi.typeString(Sk.ffi.PyType.FLOAT)).toBe        "<type 'float'>"
    it "typeString PyType.INT      => <type 'int'>",      -> expect(Sk.ffi.typeString(Sk.ffi.PyType.INT)).toBe          "<type 'int'>"
    it "typeString PyType.LONG     => <type 'long'>",     -> expect(Sk.ffi.typeString(Sk.ffi.PyType.LONG)).toBe         "<type 'long'>"
    it "typeString PyType.STR      => <type 'str'>",      -> expect(Sk.ffi.typeString(Sk.ffi.PyType.STR)).toBe          "<type 'str'>"
    it "typeString PyType.NONE     => <type 'NoneType'>", -> expect(Sk.ffi.typeString(Sk.ffi.PyType.NONE)).toBe         "<type 'NoneType'>"
    it "typeString PyType.FUNCTION => <type 'function'>", -> expect(Sk.ffi.typeString Sk.ffi.PyType.FUNCTION).toBe      "<type 'function'>"
    it "typeString PyType.INSTANCE => <class 'Foo'>",     -> expect(Sk.ffi.typeString Sk.ffi.PyType.INSTANCE, 'Foo').toBe  "<class 'Foo'>"
    it "typeString 'Foo'           => <class 'Foo'>",     -> expect(Sk.ffi.typeString 'Foo').toBe  "<class 'Foo'>"
    it "typeString [PyType.FLOAT, PyType.INT] => <type 'float'> or <type 'int'>",
      -> expect(Sk.ffi.typeString([Sk.ffi.PyType.FLOAT, Sk.ffi.PyType.INT])).toBe "<type 'float'> or <type 'int'>"

  describe "bool", ->
    it "getType True => PyType.BOOL", -> expect(Sk.ffi.getType Sk.ffi.bool.True).toBe Sk.ffi.PyType.BOOL
    it "remapToJs True => true", -> expect(Sk.ffi.remapToJs Sk.ffi.bool.True).toBe true
    it "typeName True => 'bool'", -> expect(Sk.ffi.typeName Sk.ffi.bool.True).toBe 'bool'
    it "getType False => PyType.BOOL", -> expect(Sk.ffi.getType Sk.ffi.bool.False).toBe Sk.ffi.PyType.BOOL
    it "remapToJs False => false", -> expect(Sk.ffi.remapToJs Sk.ffi.bool.False).toBe false
    it "typeName False => 'bool'", -> expect(Sk.ffi.typeName Sk.ffi.bool.False).toBe 'bool'

  describe "none", ->
    it "getType None => PyType.NONE", -> expect(Sk.ffi.getType Sk.builtin.none.none$).toBe Sk.ffi.PyType.NONE
    it "remapToJs None => null", -> expect(Sk.ffi.remapToJs Sk.builtin.none.none$).toBe null

  describe "booleanToPy", ->
    it "getType booleanToPy true => Sk.ffi.PyType.BOOL", -> expect(Sk.ffi.getType Sk.ffi.booleanToPy true).toBe Sk.ffi.PyType.BOOL
    it "getType booleanToPy false => Sk.ffi.PyType.BOOL", -> expect(Sk.ffi.getType Sk.ffi.booleanToPy false).toBe Sk.ffi.PyType.BOOL
    it "remapToJs booleanToPy true => true", -> expect(Sk.ffi.remapToJs Sk.ffi.booleanToPy true).toBe true
    it "remapToJs booleanToPy false => false", -> expect(Sk.ffi.remapToJs Sk.ffi.booleanToPy false).toBe false
    it "typeName booleanToPy true => 'bool'", -> expect(Sk.ffi.typeName Sk.ffi.booleanToPy true).toBe 'bool'
    it "typeName booleanToPy false => 'bool'", -> expect(Sk.ffi.typeName Sk.ffi.booleanToPy false).toBe 'bool'
    it "true => True", -> expect(Sk.ffi.booleanToPy true ).toBe Sk.ffi.bool.True
    it "false => False", -> expect(Sk.ffi.booleanToPy false).toBe Sk.ffi.bool.False
    it "null => None", -> expect(Sk.ffi.booleanToPy null).toBe Sk.builtin.none.none$
    it "undefined => undefined", -> expect(Sk.ffi.booleanToPy undefined).toBeUndefined()
    it "getType booleanToPy undefined, true => getType booleanToPy true", -> expect(Sk.ffi.getType Sk.ffi.booleanToPy undefined, true).toBe Sk.ffi.getType Sk.ffi.booleanToPy true
    it "remapToPy booleanToJs undefined, true => remapToJs booleanToPy true", -> expect(Sk.ffi.remapToJs Sk.ffi.booleanToPy undefined, true).toBe Sk.ffi.remapToJs Sk.ffi.booleanToPy true
    it "getType booleanToPy undefined, false => getType booleanToPy false", -> expect(Sk.ffi.getType Sk.ffi.booleanToPy undefined, false).toBe Sk.ffi.getType Sk.ffi.booleanToPy false
    it "remapToPy booleanToJs undefined, false => remapToJs booleanToPy false", -> expect(Sk.ffi.remapToJs Sk.ffi.booleanToPy undefined, false).toBe Sk.ffi.remapToJs Sk.ffi.booleanToPy false
    it "string throws TypeError", ->
      foo = () -> Sk.ffi.booleanToPy("s")
      expect(foo).toThrow()
      try
        foo()
      catch e
        expect(e.toString()).toBe Sk.ffi.err.argument('valueJs').inFunction('Sk.ffi.booleanToPy').mustHaveType("boolean or null or undefined").toString()

  describe "numberToFloatPy", ->
    it "getType numberToFloatPy number => PyType.FLOAT", -> expect(Sk.ffi.getType Sk.ffi.numberToFloatPy 6) .toBe Sk.ffi.PyType.FLOAT
    it "remapToJs numberToFloatPy number => number", -> expect(Sk.ffi.remapToJs Sk.ffi.numberToFloatPy 6).toBe 6
    it "typeName numberToFloatPy number => 'float'", -> expect(Sk.ffi.typeName Sk.ffi.numberToFloatPy 6).toBe 'float'
    it "null => None", -> expect(Sk.ffi.numberToFloatPy null).toBe Sk.builtin.none.none$
    it "undefined => undefined", -> expect(Sk.ffi.numberToFloatPy undefined).toBeUndefined()
    it "getType numberToFloatPy undefined, number => getType numberToFloatPy number", -> expect(Sk.ffi.getType Sk.ffi.numberToFloatPy undefined, 23).toBe Sk.ffi.getType Sk.ffi.numberToFloatPy 23
    it "remapToJs numberToFloatPy undefined, number => remapToJs numberToFloatPy number", -> expect(Sk.ffi.remapToJs Sk.ffi.numberToFloatPy undefined, 23).toBe Sk.ffi.remapToJs Sk.ffi.numberToFloatPy 23
    it "undefined, null => None", -> expect(Sk.ffi.numberToFloatPy undefined, null).toBe Sk.builtin.none.none$
    it "string throws TypeError", ->
      foo = () -> Sk.ffi.numberToFloatPy("s")
      expect(foo).toThrow()
      try
        foo()
      catch e
        expect(e.toString()).toBe Sk.ffi.err.argument('valueJs').inFunction('Sk.ffi.numberToFloatPy').mustHaveType("number or null or undefined").toString()

  describe "numberToIntPy", ->
    it "getType numberToIntPy number => PyType.INT", -> expect(Sk.ffi.getType Sk.ffi.numberToIntPy 6) .toBe Sk.ffi.PyType.INT
    it "remapToJs numberToIntPy number => number", -> expect(Sk.ffi.remapToJs Sk.ffi.numberToIntPy 6).toBe 6
    it "typeName numberToIntPy number => 'int'", -> expect(Sk.ffi.typeName Sk.ffi.numberToIntPy 6).toBe 'int'
    it "null => None", -> expect(Sk.ffi.numberToIntPy null).toBe Sk.builtin.none.none$
    it "undefined => undefined", -> expect(Sk.ffi.numberToIntPy undefined).toBeUndefined()
    it "getType numberToIntPy undefined, number => getType numberToIntPy number", -> expect(Sk.ffi.getType Sk.ffi.numberToIntPy undefined, 23).toBe Sk.ffi.getType Sk.ffi.numberToIntPy 23
    it "remapToJs numberToIntPy undefined, number => remapToJs numberToIntPy number", -> expect(Sk.ffi.remapToJs Sk.ffi.numberToIntPy undefined, 23).toBe Sk.ffi.remapToJs Sk.ffi.numberToFloatPy 23
    it "undefined, null => None", -> expect(Sk.ffi.numberToIntPy undefined, null).toBe Sk.builtin.none.none$
    it "string throws TypeError", ->
      foo = () -> Sk.ffi.numberToFloatPy("s")
      expect(foo).toThrow()
      try
        foo()
      catch e
        expect(e.toString()).toBe Sk.ffi.err.argument('valueJs').inFunction('Sk.ffi.numberToFloatPy').mustHaveType("number or null or undefined").toString()

  describe "stringToPy", ->
    it "getType stringToPy 'Hello' => Sk.ffi.PyType.STRING", -> expect(Sk.ffi.getType Sk.builtin.stringToPy 'Hello').toBe Sk.ffi.PyType.STR
    it "remapToJs stringToPy 'Hello' => 'Hello'", -> expect(Sk.ffi.remapToJs Sk.builtin.stringToPy 'Hello').toBe 'Hello'
    it "typeName stringToPy 'Hello' => 'str'", -> expect(Sk.ffi.typeName Sk.builtin.stringToPy 'Hello').toBe 'str'
    it "null => None", -> expect(Sk.builtin.stringToPy null).toBe Sk.builtin.none.none$
    it "undefined => undefined", -> expect(Sk.builtin.stringToPy undefined).toBeUndefined()
    it "undefined, 'foo' => stringToPy 'foo'", -> expect(Sk.builtin.stringToPy undefined, 'foo').toBe Sk.builtin.stringToPy 'foo'
    it "undefined, null => None", -> expect(Sk.builtin.stringToPy undefined, null).toBe Sk.builtin.none.none$
    it "number throws TypeError", ->
      foo = () -> Sk.builtin.stringToPy(6)
      expect(foo).toThrow()
      try
        foo()
      catch e
        expect(e.toString()).toBe Sk.ffi.err.argument('valueJs').inFunction('Sk.builtin.stringToPy').mustHaveType("string or null or undefined").toString()

  describe "referenceToPy", ->
    obj = name:"xyz"
    targetPy = {}
    it "getType referenceToPy obj, 'Foo' => PyType.INSTANCE", -> expect(Sk.ffi.getType Sk.ffi.referenceToPy obj, 'Foo').toBe Sk.ffi.PyType.INSTANCE
    it "remapToJs referenceToPy obj, 'Foo' => obj", -> expect(Sk.ffi.remapToJs Sk.ffi.referenceToPy obj, 'Foo').toBe obj
    it "typeName referenceToPy obj, 'Foo' => 'Foo'", -> expect(Sk.ffi.typeName Sk.ffi.referenceToPy obj, 'Foo').toBe 'Foo'
    xit "getType targetJs", ->
      Sk.ffi.referenceToPy obj, 'Foo', undefined, targetPy
      expect(Sk.ffi.getType targetPy).toBe Sk.ffi.PyType.INSTANCE
    it "remapToJs targetJs", ->
      Sk.ffi.referenceToPy obj, 'Foo', undefined, targetPy
      expect(Sk.ffi.remapToJs targetPy).toBe obj
    it "typeName targetJs", ->
      Sk.ffi.referenceToPy obj, 'Foo', undefined, targetPy
      expect(Sk.ffi.typeName targetPy).toBe 'Foo'

  describe "functionPy", ->
    # The test function has arguments and a return type in the Python value space.
    # This is the kind of function that we would write for an implentation of a function.
    # Python arguments and return types are used so that we can control conversions.
    # Just for the hell of it, we'll add the precondition functions.
    doubleMe = (xPy) ->
      Sk.ffi.checkFunctionArgs 'doubleMe', arguments, 1, 1
      Sk.ffi.checkArgType 'x', 'Number', Sk.ffi.isNum xPy
      x = Sk.ffi.remapToJs xPy
      return Sk.ffi.remapToPy 2 * x

    it "getType functionPy doubleMe => PyType.FUNCTION", ->
      doubleMePy = Sk.ffi.functionPy(doubleMe)
      expect(Sk.ffi.getType doubleMePy).toBe Sk.ffi.PyType.FUNCTION
    it "remapToJs functionPy function", ->
      # The Pythonized version of the function has to be mapped back to JavaScript.
      # This involves a wrapper that automatically converts JavaScript arguments to Python.
      doubleMePy = Sk.ffi.functionPy(doubleMe)
      # The JavaScript function here is twice-wrapped but works in the JavaScript value space.
      twiceWrappedDoubleMeJs = Sk.ffi.remapToJs doubleMePy
      # Now let's compare the execution values.
      x = Math.random()
      # Verify the test function first.
      expect(2 * x).toBe Sk.ffi.remapToJs doubleMe.call Sk.ffi.remapToPy('Hello'), Sk.ffi.remapToPy(x)
      # Finally, verify the twice-wrapped version.
      expect(twiceWrappedDoubleMeJs.call 'Hello', x).toBe 2 * x

  describe "isInstance", ->
    it "isInstance() => false", -> expect(Sk.ffi.isInstance()).toBe false
    it "isInstance remapToJs({}, 'Foo') => true", -> expect(Sk.ffi.isInstance Sk.ffi.remapToPy({}, 'Foo')).toBe true
    it "isInstance remapToJs({}, 'Foo'), 'Foo' => true", -> expect(Sk.ffi.isInstance Sk.ffi.remapToPy({}, 'Foo'), 'Foo').toBe true
    it "isInstance remapToJs({}, 'Foo'), 'Bar' => false", -> expect(Sk.ffi.isInstance Sk.ffi.remapToPy({}, 'Foo'), 'Bar').toBe false
    it "isInstance remapToJs({}, 'Foo'), [] => false", -> expect(Sk.ffi.isInstance Sk.ffi.remapToPy({}, 'Foo'), []).toBe false
    it "isInstance remapToJs({}, 'Foo'), ['Foo'] => true", -> expect(Sk.ffi.isInstance Sk.ffi.remapToPy({}, 'Foo'), ['Foo']).toBe true
    it "isInstance remapToJs({}, 'Foo'), ['Bar'] => false", -> expect(Sk.ffi.isInstance Sk.ffi.remapToPy({}, 'Foo'), ['Bar']).toBe false
    it "isInstance remapToJs({}, 'Foo'), ['Foo','Bar'] => true", -> expect(Sk.ffi.isInstance Sk.ffi.remapToPy({}, 'Foo'), ['Foo','Bar']).toBe true
    it "isInstance remapToJs({}, 'Foo'), ['Fiz','Bar'] => false", -> expect(Sk.ffi.isInstance Sk.ffi.remapToPy({}, 'Foo'), ['Fiz','Bar']).toBe false
    it "isInstance True => false", -> expect(Sk.ffi.isInstance Sk.ffi.bool.True).toBe false
    it "isInstance False => false", -> expect(Sk.ffi.isInstance Sk.ffi.bool.False).toBe false
    it "isInstance None => false", -> expect(Sk.ffi.isInstance Sk.builtin.none.none$).toBe false
