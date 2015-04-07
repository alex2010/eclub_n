module.exports =

    _init: (ctx)->
        ctx.css = ctx.cssPath('css')
        menu: (cb)->
            dao.get ctx.c.code, 'role', title: 'guest', (res)->
                cb(null, res.res.menu)

    index: (ctx)->
        course: (cb)->
            dao.find ctx.c.code, 'course', {}, {}, (res)->
                cb(null, res)


    courseList: (ctx)->
        null


