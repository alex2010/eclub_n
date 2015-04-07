module.exports =

    _init: (ctx)->
        ctx.css = ctx.cssPath('css')
        menu: (cb)->
            dao.get ctx.c.code, 'role', title: 'guest', (res)->
                cb(null, res.res.menu)

    index: (ctx)->
        sights: (cb)->
            dao.find ctx.c.code, 'sight', {}, {}, (res)->
                cb(null, res)

    sight: (ctx)->
        null


