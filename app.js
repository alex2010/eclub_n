// Generated by CoffeeScript 1.9.1
var bodyParser, cookieParser, express, favicon, logger, path;

express = require('express');

path = require('path');

favicon = require('serve-favicon');

logger = require('morgan');

cookieParser = require('cookie-parser');

bodyParser = require('body-parser');

_ = require('underscore');
async = require('async');
fs = require('fs');
app = express();
app.env = app.get('env') == 'development';
app.setting = require('./setting');
oid = require('mongodb').ObjectID;
log = console.log;
_path = __dirname;
_resPath = app.env ? '/res/' : app.setting.res_path;
_mdb = 'main';
dao = new require('./model/dao')(_mdb);
dbCache = new require('./model/cache')();
;

require('./ext/string');

app.set('view engine', 'jade');

app.set('views', path.join(_path, "views"));

app.use(favicon(__dirname + '/public/favicon.ico'));

app.use(bodyParser.json());

app.use(bodyParser.urlencoded({
  extended: false
}));

app.use(cookieParser());

app.use(express["static"](path.join(__dirname, 'public')));

app._community = {};

log('init app');

setTimeout(function() {
  return dao.find(_mdb, 'community', {}, {}, function(res) {
    var i, it, len, results;
    log('init data...');
    results = [];
    for (i = 0, len = res.length; i < len; i++) {
      it = res[i];
      results.push(app._community[it.url] = it);
    }
    return results;
  });
}, 2000);

app.use('/', require('./routes/prod'));

app.use(function(req, res, next) {
  var err;
  err = new Error('Not Found');
  err.status = 404;
  next(err);
});

app.use(function(err, req, res, next) {
  log(err.message);
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});

module.exports = app;
