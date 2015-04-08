_ = require('underscore')
u = require '../util'
async = require('async')

attrs = (attr)->
    op = {}
    for it in attr.split(',')
        continue if it.charAt(0) is '_'
        op[it] = 1
    op
buildQuery =  (q)->
    q

cleanItem = (q)->
    if q.dateCreated
        if q.dateCreated isnt 'true'
            delete q.dateCreated
        else
            q.dateCreate = new Date()
    if q.lastUpdated
        q.lastUpdated = new Date()

    for k,v of q
        if v.toString().charAt(0) is '_'
            delete q[k]
    q

dataController =

    list: (req, rsp) ->
        code = req.c.code
        qu = req.query
        log code
        if req.query
            op =
                skip: u.d(req.query, 'offset') || 0
                limit: u.d(req.query, 'max') || 5
            if req.query._attrs
                op.fields = attrs u.d req.query, '_attrs'
        q = buildQuery req.query.q
        entity = req.params.entity
        dao.find code, entity, q, op, (entities)->
            dao.count code, entity, q, (count)->
                rsp.send u.r entities, count

    get: (req, rsp) ->
        code = req.c.code
        entity = req.params.entity

        dao.get code, entity, _id: req.params.id, (item)->
            rsp.send u.r item

    edit: (req, rsp) ->
        code = req.c.code
        entity = req.params.entity
        bo = req.body
        _attrs = bo._attrs
        cleanItem(bo)

        dao.findAndUpdate code, entity, _id: req.params.id, req.body, (item)->
            rsp.send u.r _.pick(item, _attrs)

    save: (req, rsp) ->
        code = req.c.code
        entity = req.params.entity
        bo = req.body
        _attrs = bo._attrs
        cleanItem(bo)

        dao.save code, entity, bo, (item)->
            rsp.send u.r _.pick(item, _attrs)

    del: (req, rsp) ->
        code = req.c.code
        entity = req.params.entity
        dao.del code, entity, _id: req.params.id, ->
            rsp.send msg: 'del.ok'

module.exports = dataController