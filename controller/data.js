// Generated by CoffeeScript 1.9.1
var _, async, attrs, buildQuery, cleanItem, dataController, u;

_ = require('underscore');

u = require('../util');

async = require('async');

attrs = function(attr) {
  var i, it, len, op, ref;
  op = {};
  ref = attr.split(',');
  for (i = 0, len = ref.length; i < len; i++) {
    it = ref[i];
    if (it.charAt(0) === '_') {
      continue;
    }
    op[it] = 1;
  }
  return op;
};

buildQuery = function(q) {
  return q;
};

cleanItem = function(q) {
  var k, v;
  if (q.dateCreated) {
    if (q.dateCreated !== 'true') {
      delete q.dateCreated;
    } else {
      q.dateCreate = new Date();
    }
  }
  if (q.lastUpdated) {
    q.lastUpdated = new Date();
  }
  for (k in q) {
    v = q[k];
    if (v.toString().charAt(0) === '_') {
      delete q[k];
    }
  }
  return q;
};

dataController = {
  list: function(req, rsp) {
    var code, entity, op, q;
    code = req.c.code;
    log(code);
    if (req.query) {
      op = {
        skip: u.d(req.query, 'offset') || 0,
        limit: u.d(req.query, 'max') || 5
      };
      if (req.query._attrs) {
        op.fields = attrs(u.d(req.query, '_attrs'));
      }
    }
    q = buildQuery(req.query.q);
    entity = req.params.entity;
    return dao.find(code, entity, q, op, function(entities) {
      return dao.count(code, entity, q, function(count) {
        return rsp.send(u.r(entities, count));
      });
    });
  },
  get: function(req, rsp) {
    var code, entity;
    code = req.c.code;
    entity = req.params.entity;
    return dao.get(code, entity, {
      _id: req.params.id
    }, function(item) {
      return rsp.send(u.r(item));
    });
  },
  edit: function(req, rsp) {
    var _attrs, bo, code, entity;
    code = req.c.code;
    entity = req.params.entity;
    bo = req.body;
    _attrs = bo._attrs;
    cleanItem(bo);
    return dao.findAndUpdate(code, entity, {
      _id: req.params.id
    }, req.body, function(item) {
      return rsp.send(u.r(_.pick(item, _attrs)));
    });
  },
  save: function(req, rsp) {
    var _attrs, bo, code, entity;
    code = req.c.code;
    entity = req.params.entity;
    bo = req.body;
    _attrs = bo._attrs;
    cleanItem(bo);
    return dao.save(code, entity, bo, function(item) {
      return rsp.send(u.r(_.pick(item, _attrs)));
    });
  },
  del: function(req, rsp) {
    var code, entity;
    code = req.c.code;
    entity = req.params.entity;
    return dao.del(code, entity, {
      _id: req.params.id
    }, function() {
      return rsp.send({
        msg: 'del.ok'
      });
    });
  }
};

module.exports = dataController;
