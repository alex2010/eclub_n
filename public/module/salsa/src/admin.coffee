require [
    '/lib/init.js'
    '/lib/admin/router.js'
    '/lib/admin/user.js'

    '/module/travel/src/tmpl/meta.js',
    '/module/travel/src/tmpl/admin.js'

    '/module/after/src/status.js'
    '/module/after/src/def.js'
    '/module/after/src/i18n/message_zh.js'

], (cf, router) ->
    new router()
    app.start()