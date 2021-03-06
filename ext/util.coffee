util =
    del: (x, ctx = window)->
        it = ctx[x]
        try
            delete ctx[x]
        catch e
            ctx[x] = undefined
        it
    sPath: (code)->
        path = "/public/res/upload/#{code}"
        if app.env
            '.' + path
        else
            _path + path

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

    randomInt: (low, high)->
        Math.floor(Math.random() * (high - low + 1) + low)

#    fetchFile: (url, name, callback)->
#        request.head url, (err, res, body)->
#            request(url).pipe(fs.createWriteStream(name)).on('close', callback)

    randomChar: (len, x = '0123456789qwertyuioplkjhgfdsazxcvbnm') ->
        ret = x.charAt(Math.ceil(Math.random() * 10000000) % x.length)
        for n in [1..len]
            ret += x.charAt(Math.ceil(Math.random() * 10000000) % x.length)
        ret

module.exports = util