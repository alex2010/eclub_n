module.exports =

    _init: (ctx)->
        ctx.css = ctx.cssPath('main')
        ctx.headMenu = 'sns'
        ctx.siteMap = []

        btm_opt =
            limit: 15
            sort:
                row: -1

        city: (cb)->
            dao.get ctx.c.code, 'city', title: 'Beijing', (res)->
                cb(null, res)

        menu: (cb)->
            dao.get ctx.c.code, 'role', title: 'guest', (res)->
                menu = res.res.menu
                ctx.foot = res.res.foot
                for it in menu
                    it.cls = 'chevron-right'
                cb(null, menu)

        btm_top: (cb)->
            dao.find ctx.c.code, 'top', {}, btm_opt, (res)->
                for it in res
                    it._e = it.refClass
                    it._id = it.ref
                ctx.siteMap.push
                    top: true
                    title: 'Top Choices'
                    items: res
                    row: 10
                cb(null, res)

        btm_food: (cb)->
            dao.find ctx.c.code, 'food', {}, btm_opt, (res)->
                ctx.siteMap.push
                    title: 'Famous Food'
                    items: res
                    row: 9
                cb(null, res)

        btm_show: (cb)->
            dao.find ctx.c.code, 'show', {}, btm_opt, (res)->
                ctx.siteMap.push
                    title: 'Beijing Shows'
                    items: res
                    row: 8
                cb(null, res)

        btm_handicraft: (cb)->
            dao.find ctx.c.code, 'handicraft', {}, btm_opt, (res)->
                ctx.siteMap.push
                    title: 'Handicrafts'
                    items: res
                    row: 7
                cb(null, res)

        btm_cg: (cb)->
            dao.find ctx.c.code, 'cat', {type: 'cg'}, btm_opt, (res)->
                ctx.siteMap.push
                    title: 'Cars & Guides'
                    items: res
                    row: 6
                cb(null, res)

        btm_tour: (cb)->
            dao.find ctx.c.code, 'cat', {type: 'tour'}, btm_opt, (res)->
                ctx.siteMap.push
                    title: 'Tours'
                    items: res
                    row: 5
                cb(null, res)

        btm_map: (cb)->
            dao.find ctx.c.code, 'cat', {type: 'map'}, btm_opt, (res)->
                cb(null, res)


    index: (ctx)->
        top: (cb)->
            filter =
                type: 'top'
            dao.get ctx.c.code, 'head', filter, (res)->
                cb(null, res)

        head: (cb)->
            filter =
                type: 'index'
            dao.get ctx.c.code, 'head', filter, (res)->
                cb(null, res)

    top: (ctx)->
        ctx.headTitle = 'Top Choices In Beijing'
        topList: (cb)->
            dao.find ctx.c.code, 'top', {}, {}, (res)->
                for it in res
                    it.href = "#{it.refClass}/#{it.ref}"
                    it.hasTop = true
                    it.small = it.subTitle
                    if it.refFile && it.refFile.list
                        it.imgPath = ctx.f.resPath ctx.c.code, it.refFile.list[0]
                cb(null, res)

        head: (cb)->
            dao.get ctx.c.code, 'head', {type: 'top'}, (res)->
                cb(null, res)

#    sightList: (ctx, req)->
#        headMenu: (cb)->
#            dao.find ctx.c.code, 'cat', {type: 'sight'}, {}, (res)->
#                for it in res
#                    it.href = "/#{it.type}List?cat=#{it.code}"
#                cb(null, res)
#        sightList: (cb)->
#            filter =
#                cat: req.query.cat
#            dao.find ctx.c.code, 'sight', filter, {}, (res)->
#                cb(null, res)

    sight: (ctx)->
        headMenu: (cb)->
            dao.find ctx.c.code, 'cat', {type: 'sight'}, {}, (res)->
                for it in res
                    it.href = "/itemList?entity=#{it.type}&cat=#{it.code}"
                cb(null, res)

        allSights: (cb)->
            dao.find ctx.c.code, 'sight', {}, {}, (res)->
                cb(null, res)

        recommeded: (cb)->
            filter =
                cat: 'top'
            dao.find ctx.c.code, 'sight', filter, {}, (res)->
                cb(null, res)

        map: (cb)->
            filter =
                ref: ctx._id.toString()
            dao.get ctx.c.code, 'map', filter, (res)->
                ctx.info.map = ctx.f.imgItem(res,ctx.c.code,'slide')
                cb(null, res)


    itemList: (ctx, req)->
        et = req.query.entity
        ctx.title = "#{et.capitalize()} in Beijing"
        ctx._entity = et

        _slides: (cb)->
            if req.query.cat
                cb()
            else
                filter =
                    row:
                        $gt: 1000
                dao.find ctx.c.code, et, filter, {}, (res)->
                    cb(null, res)

        headMenu: (cb)->
            dao.find ctx.c.code, 'cat', {type: et}, {}, (res)->
                for it in res
                    it.href = "/itemList?entity=#{it.type}&cat=#{it.code}"
                cb(null, res)

        item: (cb)->
            if req.query.cat
                cb()
            else
                filter =
                    type: et
                dao.get ctx.c.code, 'cat', filter, (res)->
                    cb(null, res)

        _items: (cb)->
            filter = {}
            qu = req.query
            if qu.cat
                filter.cat = qu.cat
            dao.find ctx.c.code, et, filter, {}, (res)->
                dao.count ctx.c.code, et, filter, (count)->
                    for it in res
                        it.href = "/#{it._e}/#{it._id}"
                        it.hasTop = false
                        it.small = it.cat
                        if it.refFile && it.refFile.list
                            le = it.refFile.list.length
                            if le > 1
                                idx = ctx.f.randomInt(0,le-1)
                            it.imgPath = ctx.f.resPath ctx.c.code, it.refFile.list[idx]

                    if et in ['sight','map'] and count > res.length
                        qu.max || qu.max = 10
                        offset = (qu.offset||0) + qu.max
                        ctx.morePath = "/itemList?entity=#{filter.cat}&offset=#{offset}&max=#{qu.max}"

                    cb(null, res)

    content:(ctx, req)->
        log 'zzzzzz'


#
#                dao.find ctx.c.code, 'food', {}, {}, (res)->
#                ctx.slides = []
#                for it in res
#                    ctx.slides.push it if it.row > 1000
#                cb(null, res)
#    attraction: (ctx)->
#        ctx.pageTitle = "The Attractions in Beijing"
#        headMenu: (cb)->
#            dao.find ctx.c.code, 'cat', {type: 'sight'}, {}, (res)->
#                for it in res
#                    it.href = "/#{it.type}List?cat=#{it.code}"
#                cb(null, res)
#
#        sightList: (cb)->
#            dao.find ctx.c.code, 'sight', {}, {}, (res)->
#                cb(null, res)


