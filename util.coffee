_ = require('underscore')

resetId = (it)->
    it.id = it._id

util =
    d: (it, p)->
        rs = it[p]
        delete it[p]
        rs
    r: (it, extra)->
        if _.isArray it
            for item in it
                resetId item
            entities: it
            count: extra
        else if it
            resetId it

            entity: it
            msg: extra || 'ok'

module.exports = util