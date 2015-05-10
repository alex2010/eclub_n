_ = require('underscore')

util =
    d: (it, p)->
        rs = it[p]
        delete it[p]
        rs

    r: (it, extra)->
        if _.isArray it
            entities: it
            count: extra
        else if it
            entity: it

module.exports = util