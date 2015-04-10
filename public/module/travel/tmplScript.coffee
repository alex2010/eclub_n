module.exports =

    _init: (ctx)->
        ctx.css = ctx.cssPath('css')
        menu: (cb)->
            dao.get ctx.c.code, 'role', title: 'guest', (res)->
                cb(null, res.res.menu)

    index: (ctx)->
        city: (cb)->
            dao.get ctx.c.code, 'city', {title: 'Beijing'}, (res)->
                cb(null, res)

        sights: (cb)->
            filter =
                row:
                    $gt: 1000
            dao.find ctx.c.code, 'sight', filter, {}, (res)->
                cb(null, res)

    top: (ctx)->
        sights: (cb)->
            filter =
                cat: 'top'
            dao.find ctx.c.code, 'sight', filter, {}, (res)->
                ctx.slides = []
                for it in res
                    ctx.slides.push it if it.row > 1000
                cb(null, res)
    sight: (ctx)->
        null


