// Generated by CoffeeScript 1.9.2
var auth, checkPage, checkPagePattern, ck, data, page, path, pre, router, up;

router = require('express').Router();

path = require('path');

auth = require('../controller/auth');

data = require('../controller/data');

page = require('../controller/page');

up = require('../controller/upload');

checkPagePattern = function(req, rsp, next, page) {
  if (/^\w+$/.test(page)) {
    return next();
  } else {
    return rsp.end('name error');
  }
};

router.param('entity', checkPagePattern);

router.param('page', checkPagePattern);

ck = function(req) {
  return req.hostname + req.url;
};

pre = function(req, rsp, next) {
  var cc, k, opt;
  if (!app.env) {
    req.hostname = req.get('Host');
  }
  cc = req.query._c;
  if (cc) {
    if (cc === '0' && req.query._e) {
      opt = {
        $regex: {
          k: "" + req.query._e
        }
      };
    } else if (cc === '1') {
      req.url = req.url.replace('_c=1', '');
      if (req.url.endsWith('?')) {
        req.url = req.url.substr(0, req.url.length - 1);
      }
      opt = {
        k: ck(req)
      };
    }
    if (opt) {
      dao.delItem(_mdb, 'cache', opt, function(res) {
        return log('del...');
      });
    }
  }
  k = ck(req);
  return dao.get(_mdb, 'cache', {
    k: k
  }, function(res) {
    if (res && !app.env) {
      return rsp.end(res.str);
    } else {
      req.c = app._community[req.hostname];
      req.c = app._community['t.travel.com'];
      req.k = k;
      return next();
    }
  });
};

checkPage = function(req, rsp, next) {
  var pm;
  pm = req.params;
  page = pm.page || pm.entity || 'index';
  if (page === 'r') {
    next();
    return;
  }
  req.fp = path.join(_path, "public/module/" + req.c.code + "/tmpl");
  if (fs.existsSync(req.fp + "/" + page + ".jade")) {
    return next();
  } else {
    return rsp.end('no page');
  }
};

router.all('/a/*', pre);

router.all('/r/*', pre);

router.get('/', pre);

router.get('/', checkPage);

router.get('/:page', pre);

router.get('/:page', checkPage);

router.get('/:entity/:id', pre);

router.get('/:entity/:id', checkPage);

router.get('/', page.page);

router.post('/a/upload', up.upload);

router.post('/a/upload/remove', up.remove);

router.post('/a/auth/login', auth.login);

router.post('/a/auth/logout', auth.logout);

router.get('/r/:entity', data.list);

router.get('/r/:entity/:id', data.get);

router.put('/r/:entity/:id', data.edit);

router.post('/r/:entity', data.save);

router["delete"]('/r/:entity/:id', data.del);

router.get('/:page', page.page);

router.get('/:entity/:id', page.entity);

module.exports = router;
