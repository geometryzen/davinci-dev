/**
 * @constructor
 * @param {Array.<Object>|Object} L
 */
Sk.builtin.tuple = function(L)
{
    if (!(this instanceof Sk.builtin.tuple)) return new Sk.builtin.tuple(L);

    if (L === undefined)
    {
        L = [];
    }

    if (Object.prototype.toString.apply(L) === '[object Array]')
    {
        this.v = L;
    }
    else
    {
        if (L.tp$iter)
        {
            this.v = [];
            for (var it = L.tp$iter(), i = it.tp$iternext(); i !== undefined; i = it.tp$iternext())
                this.v.push(i);
        }
        else
            throw new Sk.builtin.ValueError("expecting Array or iterable");
    }

    this.__class__ = Sk.builtin.tuple;

    this["v"] = this.v;
    return this;
};

Sk.builtin.tuple.prototype.tp$name = "tuple";
Sk.builtin.tuple.prototype.tp$str = function()
{
    if (this.v.length === 0) return Sk.builtin.stringToPy("()");
    var bits = [];
    for (var i = 0; i < this.v.length; ++i)
    {
        bits[i] = Sk.ffi.remapToJs(Sk.ffh.str(this.v[i]));
    }
    var ret = bits.join(', ');
    if (this.v.length === 1) ret += ",";
    return Sk.builtin.stringToPy("(" + ret + ")");
};
Sk.builtin.tuple.prototype.tp$repr = function()
{
    if (this.v.length === 0) return Sk.builtin.stringToPy("()");
    var bits = [];
    for (var i = 0; i < this.v.length; ++i)
    {
        bits[i] = Sk.misceval.objectRepr(this.v[i]).v;
    }
    var ret = bits.join(', ');
    if (this.v.length === 1) ret += ",";
    return Sk.builtin.stringToPy("(" + ret + ")");
};

Sk.builtin.tuple.prototype.mp$subscript = function(index)
{
    if (Sk.misceval.isIndex(index))
    {
        var i = Sk.misceval.asIndex(index);
        if (i !== undefined)
        {
            if (i < 0) i = this.v.length + i;
            if (i < 0 || i >= this.v.length) {
                throw new Sk.builtin.IndexError("tuple index out of range");
            }
            return this.v[i];
        }
    }
    else if (index instanceof Sk.builtin.slice)
    {
        var ret = [];
        index.sssiter$(this, function(i, wrt) {
            ret.push(wrt.v[i]);
        });
        return new Sk.builtin.tuple(ret);
    }

    throw new Sk.builtin.TypeError("tuple indices must be integers, not " + Sk.ffi.typeName(index));
};

// todo; the numbers and order are taken from python, but the answer's
// obviously not the same because there's no int wrapping. shouldn't matter,
// but would be nice to make the hash() values the same if it's not too
// expensive to simplify tests.
Sk.builtin.tuple.prototype.tp$hash = function()
{
    var mult = 1000003;
    var x = 0x345678;
    var len = this.v.length;
    for (var i = 0; i < len; ++i)
    {
        var y = Sk.builtin.hash(this.v[i]);
        if (y === -1) return -1;
        x = (x ^ y) * mult;
        mult += 82520 + len + len;
    }
    x += 97531;
    if (x === -1) x = -2;
    return x;
};

Sk.builtin.tuple.prototype.sq$repeat = function(n)
{
    n = Sk.builtin.asnum$(n);
    var ret = [];
    for (var i = 0; i < n; ++i)
        for (var j = 0; j < this.v.length; ++ j)
            ret.push(this.v[j]);
    return new Sk.builtin.tuple(ret);
};
Sk.builtin.tuple.prototype.nb$mul = Sk.builtin.tuple.prototype.sq$repeat;
Sk.builtin.tuple.prototype.nb$inplace_multiply = Sk.builtin.tuple.prototype.sq$repeat;


Sk.builtin.tuple.prototype.ob$type = Sk.builtin.type.makeIntoTypeObj('tuple', Sk.builtin.tuple);

Sk.builtin.tuple.prototype.tp$iter = function()
{
    var ret =
    {
        tp$iter: function() { return ret; },
        $obj: this,
        $index: 0,
        tp$iternext: function()
        {
            // todo; StopIteration
            if (ret.$index >= ret.$obj.v.length) return undefined;
            return ret.$obj.v[ret.$index++];
        }
    };
    return ret;
};

Sk.builtin.tuple.prototype['__iter__'] = new Sk.builtin.func(function(self)
{
    Sk.builtin.pyCheckArgs("__iter__", arguments, 1, 1);

    return self.tp$iter();
});

Sk.builtin.tuple.prototype.tp$getattr = Sk.builtin.object.prototype.GenericGetAttr;

/**
 * @param {*} w
 * @param {Sk.misceval.compareOp} op
 */
Sk.builtin.tuple.prototype.tp$richcompare = function(w, op)
{
    //print("  tup rc", JSON.stringify(this.v), JSON.stringify(w), op);
        
    // w not a tuple
    if (!w.__class__ || w.__class__ != Sk.builtin.tuple)
    {
        // shortcuts for eq/not
        if (op === Sk.misceval.compareOp.Eq) return false;
        if (op === Sk.misceval.compareOp.NotEq) return true;

        // todo; other types should have an arbitrary order
        return false;
    }

    var v = this.v;
    var w = w.v;
    var vl = v.length;
    var wl = w.length;

    var i;
    for (i = 0; i < vl && i < wl; ++i)
    {
        var k = Sk.misceval.richCompareBool(v[i], w[i], Sk.misceval.compareOp.Eq);
        if (!k) break;
    }

    if (i >= vl || i >= wl)
    {
        // no more items to compare, compare sizes
        switch (op)
        {
            case Sk.misceval.compareOp.Lt: return vl < wl;
            case 'LtE': return vl <= wl;
            case Sk.misceval.compareOp.Eq: return vl === wl;
            case Sk.misceval.compareOp.NotEq: return vl !== wl;
            case Sk.misceval.compareOp.Gt: return vl > wl;
            case Sk.misceval.compareOp.GtE: return vl >= wl;
            default: goog.asserts.fail();
        }
    }

    // we have an item that's different

    // shortcuts for eq/not
    if (op === Sk.misceval.compareOp.Eq) return false;
    if (op === Sk.misceval.compareOp.NotEq) return true;

    return Sk.misceval.richCompareBool(v[i], w[i], op);
};

Sk.builtin.tuple.prototype.sq$concat = function(other)
{
    return new Sk.builtin.tuple(this.v.concat(other.v));
};

Sk.builtin.tuple.prototype.nb$add = Sk.builtin.tuple.prototype.sq$concat;
Sk.builtin.tuple.prototype.nb$inplace_add = Sk.builtin.tuple.prototype.sq$concat;

Sk.builtin.tuple.prototype.sq$length = function() { return this.v.length; };


Sk.builtin.tuple.prototype['index'] = new Sk.builtin.func(function(self, item)
{
    var len = self.v.length;
    var obj = self.v;
    for (var i = 0; i < len; ++i)
    {
        if (Sk.misceval.richCompareBool(obj[i], item, Sk.misceval.compareOp.Eq))
        {
            return i;
        }
    }
    throw new Sk.builtin.ValueError("tuple.index(x): x not in tuple");
});

Sk.builtin.tuple.prototype['count'] = new Sk.builtin.func(function(self, item)
{
    var len = self.v.length;
    var obj = self.v;
    var count = 0;
    for (var i = 0; i < len; ++i)
    {
        if (Sk.misceval.richCompareBool(obj[i], item, Sk.misceval.compareOp.Eq))
        {
            count += 1;
        }
    }
    return count;
});

goog.exportSymbol("Sk.builtin.tuple", Sk.builtin.tuple);
