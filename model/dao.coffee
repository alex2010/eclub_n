s = require('../setting')
Mongodb = require('mongodb')
_ = require('underscore')

oid = require('mongodb').ObjectID

Db = Mongodb.Db
Connection = Mongodb.Connection
Server = Mongodb.Server

#log = console.log
_opt = {w: 1}
module.exports = (@name, callback) ->
    if app and app._hk
        opt = s[app._hk]
        that = @
        Mongodb.MongoClient.connect "mongodb://#{opt.user}:#{opt.psd}@#{opt.host}:#{opt.port}/#{opt.db}", (err, db)->
            log 'connect to hk'
            that.db = db
            callback?()
    else
        @db = new Db(@name || s.db, new Server(s.host, s.port)) #, safe: true
        @db.open ->
#            @db.setMaxListeners(0)
            callback?()

#    emitter.setMaxListeners()

    @pick = (name, cName)->
        if @name isnt name and !app._hk
            @name = name
#            log @db._emitter
#            log @db.removeAllListeners()
            @db.removeAllListeners()
            @db = @db.db(name)

        if @cName isnt cName or !@collection
            @cName = cName
            @collection = @db.collection cName

        @collection

    #    @index = (db, entity, index, opt)->
    #
    #        @pick(db, entity).createIndex index, opt

    @get = (db, entity, opt, callback)->
        opt = @cleanOpt(opt)
        @pick(db, entity).findOne opt, (err, doc)->
            log err if err
            doc._e = entity if doc
            callback?(doc)

    @find = (db, entity, filter, op, callback)->
        @pick(db, entity).find(filter, op).toArray (err, docs)->
            log err if err
            for it in docs
                it._e = entity
            callback?(docs)


    @cleanOpt = (opt) ->
        if opt._id
            if _.isArray opt._id
                opt._id = (new oid(it) for it in opt._id)
            else
                opt._id = new oid(opt._id)
        opt

    @count = (db, entity, opt, callback)->
        @pick(db, entity).count opt, (err, count)->
            log err if err
            callback(count)


    @findAndUpdate = (db, entity, filter, opt, callback)->
        filter = @cleanOpt(filter)
        delete opt._id
        @pick(db, entity).findOneAndUpdate filter, opt, (err, doc)->
            log err if err
            callback?(doc)

    @save = (db, entity, items, callback)->
        [entity,keys] = entity.split(':')
        items = [items] unless _.isArray items
        if keys
            keys = keys.split(',')
            for it in items
                filter = _.pick(it, keys)
                @pick(db, entity).update filter, it, upsert: true, (err, docs)->
                    throw err if err
                    callback?(docs)
        else
            @pick(db, entity).insert items, {safe: true}, (err, docs)->
                log err if err
                callback?(docs)

    @del = ()->
        log 'rm'

    @delItem = (db, entity, filter, opt = _opt, callback)->
        filter = @cleanOpt(filter)
        if filter._id
            m = 'deleteOne'
        else
            m = 'deleteMany'
        @pick(db, entity)[m] filter, opt, (err, res)->
            log err if err
            log 'del finish'
            callback?(res)

    @remove = (db, entity, filter, opt = _opt, callback)->
        @pick(db, entity).remove(filter, opt, callback)

    @close = ->
        log 'closed'
        @db.close()

    @


#    @pick = (name, cName)->
#        if @name isnt name
#            @name = name
#            @db = @db.db(name)
#
#        if @cName isnt cName or !@collection
#            @collection = @db.collection cName
#            @cName = cName
#
#        @collection

#
#    @open = ->
#        unless @db.openCalled
#            @db.open (err)->
#                log err if err