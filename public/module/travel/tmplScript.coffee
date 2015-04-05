all = (ctx)->
    ctx.css = ctx.cssPath('css')
    ctx

module.exports =

    index: (ctx, callback)->
        log 'index page'
        dao.find ctx.c.code, 'sight', {}, {}, (res)->
            ctx.sights = res
            callback all ctx

    sight: (ctx, callback)->
        log 'sight page'
        callback all ctx


