ss = require('../setting')
Mongodb = require('mongodb')
Db = Mongodb.Db
Server = Mongodb.Server

if _heroku
    db = ss.hk_db
    host = ss.hk_host
    port = ss.hk_port

else
    db = ss.db
    port = ss.port
    host = ss.host
    module.exports = new Db(db, new Server(host, port), safe: true)