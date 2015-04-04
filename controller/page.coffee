u = require '../util'
oid = require('mongodb').ObjectID
async = require('async')
tmplUtil = require('../tmplUtil')

i18n = require('../i18n/lang')('zh')

pageOpt = (code)->
    c = app._community[code]

    title: 'console'
    lang: 'zh'
    mode: app.env
    c: c
    app: 'main'
    f: tmplUtil
    i: i18n.load(code)
    cstr: JSON.stringify(_.pick(c, 'code', 'url'))
    cssPath: (name)->
        if app.env then "/module/#{code}/src/pc/#{name}.css" else "/lib/#{name}.css"
    jsPath: (name)->
        if app.env then "/module/#{code}/src/#{name}.js" else "/lib/#{name}.js"


module.exports =

    page: (req, rsp) ->
        code = req.params.code
        page = req.params.page
        opt = pageOpt(code)
        opt.index = page
        script = app.pickScript(code)
        rc = (opt)->
            rsp.render page, opt
        if script[page]
            script[page] opt, rc
        else
            rc opt

    entity: (req, rsp) ->
        code = req.params.code
        entity = req.params.entity
        script = app.pickScript(code)
        opt = pageOpt(code)

        opt.index = entity
        log 'zxcvcxvzc'
        dao.get code, entity, _id: req.params.id, (item)->
            log item
            unless item
                log '5050'
                req.redirect './404.html'
                return
            opt = _.extend opt, item
            rc = (opt)->
                rsp.render entity, opt
            if script[entity]
                script[entity] opt, rc
            else
                log 'zxcvxcvxzcv'
                rc opt

#
#    console: (req, rsp) ->
#        dao.get 'community', code: _code, (item)->
#            opt =
#                title: 'console'
#                lang: 'zh'
#                index: 'console'
#                app: 'admin'
#                mode: app.env
#                c: item
#            rsp.render 'console', opt
