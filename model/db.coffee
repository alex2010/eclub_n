settings = require('../setting')
Mongodb = require('mongodb')
Db = Mongodb.Db
Server = Mongodb.Server

module.exports = new Db(settings.db, new Server(settings.host, settings.port), safe: true)