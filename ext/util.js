// Generated by CoffeeScript 1.9.3
var util;

util = {
  del: function(x, ctx) {
    var e, it;
    if (ctx == null) {
      ctx = window;
    }
    it = ctx[x];
    try {
      delete ctx[x];
    } catch (_error) {
      e = _error;
      ctx[x] = void 0;
    }
    return it;
  },
  sPath: function(code) {
    var path;
    path = "/public/res/upload/" + code;
    if (app.env) {
      return '.' + path;
    } else {
      return _path + path;
    }
  },
  d: function(it, p) {
    var rs;
    rs = it[p];
    delete it[p];
    return rs;
  },
  r: function(it, extra) {
    if (_.isArray(it)) {
      return {
        entities: it,
        count: extra
      };
    } else if (it) {
      return {
        entity: it
      };
    }
  },
  randomInt: function(low, high) {
    return Math.floor(Math.random() * (high - low + 1) + low);
  },
  randomChar: function(len, x) {
    var i, n, ref, ret;
    if (x == null) {
      x = '0123456789qwertyuioplkjhgfdsazxcvbnm';
    }
    ret = x.charAt(Math.ceil(Math.random() * 10000000) % x.length);
    for (n = i = 1, ref = len; 1 <= ref ? i <= ref : i >= ref; n = 1 <= ref ? ++i : --i) {
      ret += x.charAt(Math.ceil(Math.random() * 10000000) % x.length);
    }
    return ret;
  }
};

module.exports = util;
