// Generated by CoffeeScript 1.7.1
module.exports = {
  all: function(item) {
    return item.css = item.cssPath('css');
  },
  index: function(item, callback) {
    item.css = item.cssPath('css');
    log(item.c.code);
    return dao.find(item.c.code, 'sight', {}, {}, function(res) {
      log('zzcv');
      log(res);
      item.sights = res;
      return callback(item);
    });
  },
  sight: function(item, callback) {
    log('sight page');
    item.css = item.cssPath('css');
    return callback(item);
  }
};