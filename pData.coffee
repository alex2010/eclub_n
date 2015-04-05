async = require('async')

_db = 'main'
_code = ''
process.argv.forEach (val, index, array)->
    _code = array[2]


`app = {};
log = console.log;
oid = require('mongodb').ObjectID;
code = _code;
`
dao = new require('./model/dao')(_db)
data = require("./public/module/#{code}/data")


setTimeout ->
    dao.save _db, 'community:code', data.community

    for k, v of data.data
        dao.save code, k, v,->
            log code

    setTimeout ->
        dao.close()
    , 3000
, 500
