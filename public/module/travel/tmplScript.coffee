module.exports =

    _init: (ctx)->
        ctx.css = ctx.cssPath('css')
        ctx.headMenu = 'sns'
        city: (cb)->
            dao.get ctx.c.code, 'city', {title: 'Beijing'}, (res)->
                cb(null, res)
        menu: (cb)->
            dao.get ctx.c.code, 'role', title: 'guest', (res)->
                menu = res.res.menu
#                log menu
#                log ctx.index
#                rm =
#                log rm
#                if rm.length > 1 and rm[0].children
#                    ctx.headMenu = rm[0].children
#                    log ctx.headMenu
#                else
#                    ctx.headMenu = 'sns'

                cb(null, menu)

    index: (ctx)->
        sights: (cb)->
            filter =
                row:
                    $gt: 1000
            dao.find ctx.c.code, 'sight', filter, {}, (res)->
                cb(null, res)

    top: (ctx)->
        ctx.headTitle = 'Top Collection In Beijing'
        sights: (cb)->
            filter =
                cat: 'top'
            dao.find ctx.c.code, 'sight', filter, {}, (res)->
                ctx.slides = []
                for it in res
                    ctx.slides.push it if it.row > 1000
                cb(null, res)

    sight: (ctx)->
        _recommeded: (cb)->
            filter =
                cat: 'top'
            dao.find ctx.c.code, 'sight', filter, {}, (res)->
                cb(null, res)




