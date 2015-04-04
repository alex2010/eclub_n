module.exports =
    all: (item)->
        item.css = item.cssPath('css')

    index: (item, callback)->
        item.css = item.cssPath('css')
        log item.c.code
        dao.find item.c.code, 'sight', {}, {}, (res)->
            log 'zzcv'
            log res
            item.sights = res
            callback item

    sight: (item, callback)->
        log 'sight page'
        item.css = item.cssPath('css')
        callback item


