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
    W._i = lang
    W._lang = 'en'
    new router()
    app.start()