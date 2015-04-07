async = require('async')

args = null
process.argv.forEach (val, index, array)->
    args = array

`app = {};
_ = require('underscore')
_db = 'main';
log = console.log;
oid = require('mongodb').ObjectID;
code = args[2]
`
require('./ext/string')

dao = new require('./model/dao') _db, ->
    if args.length > 3
        entity = args[3]
        dao.remove code, entity, {}, {}, ->
            list = []
            for it in require("./public/module/#{code}/data/#{entity}")
                ob = {}
                for k, v of it
                    if v isnt null and !(k in ['cid','version'])
                        if k.indexOf('_') > -1
                            [a,b] = k.split('_')
                            b = b.capitalize()
                            k = [a, b].join('')
                        if v.toString().indexOf('{') is 0
                            v = JSON.parse v
                        else if v.length is 19 and v.indexOf('20') is 0
                            v = Date.parseLocal(v)

                        k = 'refFile' if k is 'ref_file'
                        ob[k] = v
                list.push ob
            dao.save code, args[3], list

    else
        data = require("./public/module/#{code}/data")
        dao.save _db, 'community:code', data.community

        for k, v of data.data
            dao.save code, k, v, ->
                log code


_.delay ->
    dao.close()
, 5000
