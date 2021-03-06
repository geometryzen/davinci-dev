/**
 * Check arguments to Python functions to ensure the correct number of
 * arguments are passed.
 * 
 * @param {string} name the name of the function
 * @param {Object} args the args passed to the function
 * @param {number} minargs the minimum number of allowable arguments
 * @param {number=} maxargs optional maximum number of allowable
 * arguments (default: Infinity)
 * @param {boolean=} kwargs optional true if kwargs, false otherwise
 * (default: false)
 * @param {boolean=} free optional true if free vars, false otherwise
 * (default: false)
 */
Sk.builtin.pyCheckArgs = function (name, args, minargs, maxargs, kwargs, free) {
    var nargs = args.length;
    var msg = "";

    if (maxargs === undefined) { maxargs = Infinity; }
    if (kwargs) { nargs -= 1; }
    if (free) { nargs -= 1; }
    if ((nargs < minargs) || (nargs > maxargs)) {
        if (minargs === maxargs) {
            msg = name + "() takes exactly " + minargs + " arguments";
        } else if (nargs < minargs) {
            msg = name + "() takes at least " + minargs + " arguments";
        } else {
            msg = name + "() takes at most " + maxargs + " arguments";
        }
        msg += " (" + nargs + " given)";
        throw new Sk.builtin.TypeError(msg);
    }
};
goog.exportSymbol("Sk.builtin.pyCheckArgs", Sk.builtin.pyCheckArgs);

/**
 * Check type of argument to Python functions.
 * 
 * @param {string} name the name of the argument
 * @param {string} exptype string of the expected type name
 * @param {boolean} check truthy if type check passes, falsy otherwise
 */

Sk.builtin.pyCheckType = function (name, exptype, check) {
    if (!check) {
        throw new Sk.builtin.TypeError(name + " must be a " + exptype);
    }
};
goog.exportSymbol("Sk.builtin.pyCheckType", Sk.builtin.pyCheckType);

Sk.builtin.checkSequence = function (arg) {
    return (arg !== null && arg.mp$subscript !== undefined);
};
goog.exportSymbol("Sk.builtin.checkSequence", Sk.builtin.checkSequence);

Sk.builtin.checkIterable = function (arg) {
    return (arg !== null && arg.tp$iter !== undefined);
};
goog.exportSymbol("Sk.builtin.checkIterable", Sk.builtin.checkIterable);

Sk.builtin.checkNumber = function (arg) {
    return (arg !== null && (typeof arg === "number" || arg instanceof Sk.builtin.NumberPy || arg instanceof Sk.builtin.lng));
};
goog.exportSymbol("Sk.builtin.checkNumber", Sk.builtin.checkNumber);

Sk.builtin.checkInt = function (arg)
{
    if (arg instanceof Sk.builtin.NumberPy)
    {
        return arg.skType === Sk.builtin.NumberPy.int$;
    }
    else if (arg instanceof Sk.builtin.lng)
    {
        return true;
    }
    else if (typeof arg === 'number')
    {
        // TODO: This should not be needed for Pythonic arguments.
        return true;
    }
    else
    {
        return false;
    }
    /*
    return (arg !== null) && ((typeof arg === "number" && arg === (arg|0))
                  || (arg instanceof Sk.builtin.NumberPy && arg.skType === Sk.builtin.NumberPy.int$)
                  || arg instanceof Sk.builtin.lng);
    */
};
goog.exportSymbol("Sk.builtin.checkInt", Sk.builtin.checkInt);

Sk.builtin.checkClass = function (arg) {
    return (arg !== null && arg.sk$type);
};
goog.exportSymbol("Sk.builtin.checkClass", Sk.builtin.checkClass);

Sk.builtin.checkBool = function (arg)
{
    return (arg instanceof Sk.builtin.bool);
};
goog.exportSymbol("Sk.builtin.checkBool", Sk.builtin.checkBool);

Sk.builtin.checkFunction = function (arg)
{
    return (arg !== null && arg.tp$call !== undefined);  
};
goog.exportSymbol("Sk.builtin.checkFunction", Sk.builtin.checkFunction);

/**
 * @constructor
 *
 * @param {Function} code the javascript implementation of this function
 * @param {Object=} globals the globals where this function was defined.
 * Can be undefined (which will be stored as null) for builtins. (is
 * that ok?)
 * @param {Object=} cellVars dict of free variables
 * @param {Object=} freeVars another dict of free variables that will be
 * merged into 'cellVars'. there's 2 to simplify generated code (one is $free,
 * the other is $cell)
 *
 * cellVars is the cell variables from the parent scope that we need to close
 * over. freeVars is the free variables in the parent scope that we also might
 * need to access.
 *
 * NOTE: co_varnames and co_name are defined by compiled code only, so we have
 * to access them via dict-style lookup for cellVars.
 *
 */
Sk.builtin.func = function(code, globals, cellVars, freeVars)
{
    this.func_code = code;
    this.func_globals = globals || null;
    if (freeVars !== undefined)
    {
        // todo; confirm that modification here can't cause problems
        for (var k in freeVars)
            cellVars[k] = freeVars[k];
    }
    // This is Python 2.x. Python 3 uses __closure__.
    // But does this actually work?
    this.func_closure = cellVars;
    return this;
};
goog.exportSymbol("Sk.builtin.func", Sk.builtin.func);


Sk.builtin.func.prototype.tp$name = "function";
Sk.builtin.func.prototype.tp$descr_get = function(obj, objtype)
{
    goog.asserts.assert(obj !== undefined && objtype !== undefined);
    if (obj == null) return this;
    return new Sk.builtin.method(this, obj);
};
Sk.builtin.func.prototype.tp$call = function(args, kw)
{
    var name;

    // note: functions expect 'this' to be globals to avoid having to
    // slice/unshift onto the main args
    if (this.func_closure)
    {
        // todo; OK to modify?
        args.push(this.func_closure);
    }

    var expectskw = this.func_code['co_kwargs'];
    var kwargsarr = [];

    if (this.func_code['no_kw'] && kw) {
        name = (this.func_code && this.func_code['co_name'] && this.func_code['co_name'].v) || '<native JS>';
        throw new Sk.builtin.TypeError(name + "() takes no keyword arguments");
    }

    if (kw)
    {
        // bind the kw args
        var kwlen = kw.length;
        var varnames = this.func_code['co_varnames'];
        var numvarnames = varnames && varnames.length;
        for (var i = 0; i < kwlen; i += 2)
        {
            // todo; make this a dict mapping name to offset
            for (var j = 0; j < numvarnames; ++j)
            {
                if (kw[i] === varnames[j])
                    break;
            }
            if (varnames && j !== numvarnames)
            {
                args[j] = kw[i+1];
            }
            else if (expectskw)
            {
                // build kwargs dict
                kwargsarr.push(Sk.builtin.stringToPy(kw[i]));
                kwargsarr.push(kw[i + 1]);
            }
            else
            {
                name = (this.func_code && this.func_code['co_name'] && Sk.ffi.remapToJs(this.func_code['co_name'])) || '<native JS>';
                throw new Sk.builtin.TypeError(name + "() got an unexpected keyword argument '" + kw[i] + "'");
            }
        }
    }
    if (expectskw)
    {
        args.unshift(kwargsarr);
    }

    //print(JSON.stringify(args, null, 2));

    return this.func_code.apply(this.func_globals, args);
};

Sk.builtin.func.prototype.tp$getattr = function(key) {
    return this[key];
};

Sk.builtin.func.prototype.tp$setattr = function(key,value) {
    this[key] = value;
};

//todo; investigate why the other doesn't work
//Sk.builtin.type.makeIntoTypeObj('function', Sk.builtin.func);
Sk.builtin.func.prototype.ob$type = Sk.builtin.type.makeTypeObj('function', new Sk.builtin.func(null, null));

Sk.builtin.func.prototype.tp$repr = function()
{
    var name = (this.func_code && this.func_code['co_name'] && Sk.ffi.remapToJs(this.func_code['co_name'])) || '<native JS>';
    return Sk.builtin.stringToPy("<function " + name + ">");
};
