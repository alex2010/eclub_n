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
                    if v isnt null and !(k in ['cid', 'version'])
                        if _.isString(v) and v.isEmpty()
                            continue
                        if k.indexOf('_') > -1
                            [a,b] = k.split('_')
                            b = b.capitalize()
                            k = [a, b].join('')
                        else if k is 'category'
                            k = 'cat'

                        if _.isString(v) and v.indexOf('{') is 0
                            v = JSON.parse v
                        else if v.length is 19 and v.indexOf('20') is 0
                            v = Date.parseLocal(v)

                        k = 'refFile' if k is 'ref_file'
                        ob[k] = v

                    if entity is 'user'
                        if it.woid
                            ob.wt =
                                oid: it.woid
                            delete it.woid
                            if it.wid
                                ob.wt.id = it.wid
                                delete it.wid
                            if it.wunid
                                ob.wt.unid = it.wunid
                                delete it.wunid
                list.push ob


            if entity is 'role'
                entity += ':title'
            else if entity is 'user'
                entity += ':username'

            for it in list
                dao.save code, entity, it, (res)->
                    act = res.ops[0]
                    if act and entity is 'activity' and act.master and !act.master.isEmpty()
                        filter =
                            username:
                                $in: act.master.split(',')
                        act.master = {}
                        dao.find code, 'user', filter, {}, (ru)->
                            for u in ru
                                act.master[u._id] = _.pick(u, 'id', 'username', 'title', 'industry', 'introduction')
                            dao.save code, entity+':_id', act

    else
        data = require("./public/module/#{code}/data")
        dao.save _db, 'community:code', data.community

        for k, v of data.data
            dao.save code, k, v, ->
                log code

_.delay ->
    dao.close()
, 6000
