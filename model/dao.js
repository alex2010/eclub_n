// Generated by CoffeeScript 1.9.1
var Connection, Db, Mongodb, Server, _, _opt, log, oid, s;

s = require('../setting');

Mongodb = require('mongodb');

_ = require('underscore');

oid = require('mongodb').ObjectID;

Db = Mongodb.Db;

Connection = Mongodb.Connection;

Server = Mongodb.Server;

log = console.log;

_opt = {
  w: 1
};

module.exports = function(name1, callback) {
  var opt, that;
  this.name = name1;
  if (app && app._hk) {
    opt = s[app._hk];
    that = this;
    Mongodb.MongoClient.connect("mongodb://" + opt.user + ":" + opt.psd + "@" + opt.host + ":" + opt.port + "/" + opt.db, function(err, db) {
      log('connect to hk');
      that.db = db;
      return typeof callback === "function" ? callback() : void 0;
    });
  } else {
    this.db = new Db(this.name || s.db, new Server(s.host, s.port));
    this.db.open(function() {
      return typeof callback === "function" ? callback() : void 0;
    });
  }
  this.pick = function(name, cName) {
    if (this.name !== name && !app._hk) {
      this.name = name;
      this.db.removeAllListeners();
      this.db = this.db.db(name);
    }
    if (this.cName !== cName || !this.collection) {
      this.cName = cName;
      this.collection = this.db.collection(cName);
    }
    return this.collection;
  };
  this.get = function(db, entity, opt, callback) {
    opt = this.cleanOpt(opt);
    return this.pick(db, entity).findOne(opt, function(err, doc) {
      if (err) {
        log(err);
      }
      return typeof callback === "function" ? callback(doc) : void 0;
    });
  };
  this.find = function(db, entity, filter, op, callback) {
    return this.pick(db, entity).find(filter, op).toArray(function(err, docs) {
      if (err) {
        log(err);
      }
      return typeof callback === "function" ? callback(docs) : void 0;
    });
  };
  this.cleanOpt = function(opt) {
    var it;
    if (opt._id) {
      if (_.isArray(opt._id)) {
        opt._id = (function() {
          var i, len, ref, results;
          ref = opt._id;
          results = [];
          for (i = 0, len = ref.length; i < len; i++) {
            it = ref[i];
            results.push(new oid(it));
          }
          return results;
        })();
      } else {
        opt._id = new oid(opt._id);
      }
    }
    return opt;
  };
  this.count = function(db, entity, opt, callback) {
    return this.pick(db, entity).count(opt, function(err, count) {
      if (err) {
        log(err);
      }
      return callback(count);
    });
  };
  this.findAndUpdate = function(db, entity, filter, opt, callback) {
    filter = this.cleanOpt(filter);
    delete opt._id;
    return this.pick(db, entity).findOneAndUpdate(filter, opt, function(err, doc) {
      if (err) {
        log(err);
      }
      return typeof callback === "function" ? callback(doc) : void 0;
    });
  };
  this.save = function(db, entity, items, callback) {
    var i, it, keys, len, ref, results;
    ref = entity.split(':'), entity = ref[0], keys = ref[1];
    if (keys) {
      keys = keys.split(',');
    }
    if (!_.isArray(items)) {
      items = [items];
    }
    if (keys) {
      results = [];
      for (i = 0, len = items.length; i < len; i++) {
        it = items[i];
        results.push(this.pick(db, entity).update(_.pick(it, keys), it, {
          upsert: true
        }, function(err, docs) {
          if (err) {
            throw err;
          }
          return typeof callback === "function" ? callback(docs) : void 0;
        }));
      }
      return results;
    } else {
      return this.pick(db, entity).insert(items, {
        safe: true
      }, function(err, docs) {
        if (err) {
          log(err);
        }
        return typeof callback === "function" ? callback(docs) : void 0;
      });
    }
  };
  this.del = function() {
    return log('rm');
  };
  this.delItem = function(db, entity, filter, opt, callback) {
    var m;
    if (opt == null) {
      opt = _opt;
    }
    filter = this.cleanOpt(filter);
    if (filter._id) {
      m = 'deleteOne';
    } else {
      m = 'deleteMany';
    }
    log(m);
    return this.pick(db, entity)[m](filter, opt, function(err, res) {
      if (err) {
        log(err);
      }
      log('del finish');
      return typeof callback === "function" ? callback(res) : void 0;
    });
  };
  this.remove = function(db, entity, filter, opt, callback) {
    if (opt == null) {
      opt = _opt;
    }
    return this.pick(db, entity).remove(filter, opt, callback);
  };
  this.close = function() {
    log('closed');
    return this.db.close();
  };
  return this;
};
