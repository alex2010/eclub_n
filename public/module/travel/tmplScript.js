// Generated by CoffeeScript 1.9.1
module.exports = {
  _init: function(ctx) {
    ctx.css = ctx.cssPath('css');
    return {
      menu: function(cb) {
        return dao.get(ctx.c.code, 'role', {
          title: 'guest'
        }, function(res) {
          return cb(null, res.res.menu);
        });
      }
    };
  },
  index: function(ctx) {
    return {
      city: function(cb) {
        return dao.get(ctx.c.code, 'city', {
          title: 'Beijing'
        }, function(res) {
          return cb(null, res);
        });
      },
      sights: function(cb) {
        var filter;
        filter = {};
        return dao.find(ctx.c.code, 'sight', filter, {}, function(res) {
          return cb(null, res);
        });
      }
    };
  },
  sight: function(ctx) {
    return null;
  }
};
