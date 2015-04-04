settings = require('../setting')
Mongodb = require('mongodb')

oid = require('mongodb').ObjectID

Db = Mongodb.Db
Connection = Mongodb.Connection
Server = Mongodb.Server

log = console.log

module.exports = (@name) ->
    @db = new Db(@name || settings.code, new Server(settings.host, settings.port), safe: true)

    @switch = (name, cName)->
        if @name isnt name
            @name = name
            @db = @db.db(name)

        @collection = @db.collection cName


    @open = ->
        unless @db.openCalled
            @db.open (err)->
                log err if err


    @cleanOpt = (opt) ->
        if opt._id
            opt._id = new oid(opt._id)
        opt

    @count = (entity, opt, callback)->
        @db.collection entity, (err, ct) ->
            log err if err
            ct.count opt, (err, count)->
                log err if err
                callback(count)


    @get = (entity, opt, callback)->
        opt = @cleanOpt(opt)
        @db.collection entity, (err, ct) ->
            ct.findOne opt, (err, doc)->
                log err if err
                callback?(doc)

    @findAndUpdate = (entity, filter, opt, callback)->
        filter = @cleanOpt(filter)
        delete opt._id
        @db.collection entity, (err, ct) ->
            ct.findOneAndUpdate filter, opt, (err, doc)->
                log err if err
                callback?(doc)

    @find = (entity, opt, op, callback)->
        @db.collection entity, (err, ct) ->
            log ct
            ct.find(opt, op).toArray (err, docs)->
                log err if err
                callback?(docs)

    @save = (entity, items, callback)->
        [entity,keys] = entity.split(':')
        keys = keys.split(',') if keys
        log entity
        @db.collection entity, (err, ct) ->
            log err if err
            items = [items] unless _.isArray items
            if keys
                for it in items
                    ct.update _.pick(it, keys), it, upsert: true, (err, docs)->
                        throw err if err
                        callback?(docs)
            else
                ct.insert items, {safe: true}, (err, docs)->
                    log err if err
                    callback?(docs)

    @del = (entity, opt, callback)->
        opt = @cleanOpt(opt)
        @db.collection entity, (err, ct) ->
            log err if err
            if opt._id
                m = 'deleteOne'
            else
                m = 'deleteMany'
            ct[m] opt, null, (err, res)->
                log err if err
                callback(res)

    @remove = (entity)->
        @db.collection entity, (err, ct)->
            log err if err
            ct.remove()

    @close = ->
        log 'closed'
        @db.close()

    @
