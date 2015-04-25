require [
    '/lib/init.js'
    '/lib/i18n/message_en.js'

    '/lib/admin/router.js'
    '/lib/admin/user.js'

    '/module/travel/src/tmpl/meta.js',
    '/module/travel/src/tmpl/admin.js'

    '/module/after/src/status.js'
    '/module/after/src/def.js'
], (cf, lang, router) ->
    cf.opt =
        entity:
            categories: ['post', 'brand', 'commodity']
            headRefEntity: ['sight', 'show', 'food','handicraft','post','content']
            headRefChannel: ['top', 'index']
        image:
            index:
                maxWidth: 500
                text: '宽高比1:2或者1:1，宽度最小210px'
            top:
                thumb: '_thumb:180'
                text:'宽高比5:2，宽度最小1200px'
            list:
                maxWidth: 250
                text: '宽高比1:2，宽度最小210px'
            slide:
                maxWidth: 1000
                text: '宽高比8:3，宽度最小800px'

    W._i = lang
    W._lang = 'en'
    new router()
    app.start()