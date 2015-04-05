all = (ctx)->
    ctx.css = ctx.cssPath('css')
    ctx

module.exports =

    index: (ctx, callback)->
        dao.find ctx.c.code, 'course', {}, {}, (res)->
            ctx.course = res
            callback all ctx

    courseList: (ctx, callback)->
        callback all ctx


