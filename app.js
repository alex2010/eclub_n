// Generated by CoffeeScript 1.9.1
var _ts, bodyParser, cookieParser, express, favicon, logger, path;

express = require('express');

path = require('path');

favicon = require('serve-favicon');

logger = require('morgan');

cookieParser = require('cookie-parser');

bodyParser = require('body-parser');

_ = require('underscore');
app = express();
app.env = app.get('env') == 'development';
app.setting = require('./setting');
log = console.log;
_path = __dirname;
_resPath = app.env ? '/res/' : setting.res_path;
dao = new require('./model/dao')('main');
dbCache = new require('./model/cache')();

app._script = {};

app._community = {};

_ts = require('./tmplScript');

app.pickScript = function(code) {
  var sc;
  sc = app._script[code];
  if (sc) {
    sc;
  } else {
    sc = _.extend(_.clone(_ts), require("./public/module/" + code + "/tmplScript"));
    app._script[code] = sc;
  }
  return sc;
};

app.setCommunity = function(dao, code, callback) {
  if (app._community[code]) {
    return callback();
  } else {
    return dao.get(code, 'community', {
      code: code
    }, function(c) {
      return dao.get(code, 'role', {
        title: 'guest'
      }, function(item) {
        c.menu = item.res.menu;
        app._community[code] = c;
        return callback();
      });
    });
  }
};

app.set('view engine', 'jade');

app.use(bodyParser.json());

app.use(bodyParser.urlencoded({
  extended: false
}));

app.use(cookieParser());

app.use(express["static"](path.join(__dirname, 'public')));

app.use('/', require('./routes/index'));

app.use(function(req, res, next) {
  var err;
  err = new Error('Not Found');
  err.status = 404;
  next(err);
});

if (app.env) {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});

module.exports = app;