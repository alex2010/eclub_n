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

    randomInt: (low,high)->
        Math.floor(Math.random() * (high - low + 1) + low)
module.exports = util