s = require('../setting')
Mongodb = require('mongodb')
_ = require('underscore')

oid = require('mongodb').ObjectID

Db = Mongodb.Db
Connection = Mongodb.Connection
Server = Mongodb.Server

log = console.log

module.exports = (@name, callback) ->
    if app._hk
        opt = s[app._hk]
        that = @
        Mongodb.MongoClient.connect "mongodb://#{opt.user}:#{opt.psd}@#{opt.host}:#{opt.port}/#{opt.db}", (err, db)->
            log 'ping t'
            that.db = db
            callback?()
    else
        @db = new Db(@name || s.db, new Server(s.host, s.port)) #, safe: true
        @db.open()

    @pick = (name, cName)->
        if @name isnt name and !app.get('hk')
            @name = name
            @db = @db.db(name)

        if @cName isnt cName or !@collection
            @cName = cName
            @collection = @db.collection cName

        @collection


    @get = (db, entity, opt, callback)->
        opt = @cleanOpt(opt)
        @pick(db, entity).findOne opt, (err, doc)->
            log err if err
            callback?(doc)

    @find = (db, entity, opt, op, callback)->
        @pick(db, entity).find(opt, op).toArray (err, docs)->
            log err if err
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
        keys = keys.split(',') if keys
        items = [items] unless _.isArray items
        if keys
            for it in items
                @pick(db, entity).update _.pick(it, keys), it, upsert: true, (err, docs)->
                    throw err if err
                    callback?(docs)
        else
            @pick(db, entity).insert items, {safe: true}, (err, docs)->
                log err if err
                callback?(docs)

    @del = (db, entity, opt, callback)->
        opt = @cleanOpt(opt)
        if opt._id
            m = 'deleteOne'
        else
            m = 'deleteMany'
        @pick(db, entity)[m] opt, null, (err, res)->
            log err if err
            callback(res)

    @remove = (db, entity)->
        @pick(db, entity).remove()

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