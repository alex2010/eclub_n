u = require '../util'
oid = require('mongodb').ObjectID
async = require('async')
tmplUtil = require('../views/tmplUtil')
ts = require('../views/tmplScript')
jade = require('jade')
i18n = require('../i18n/lang')('zh')

pageOpt = (c)->
    code = c.code

    title: c.title
    lang: 'zh'
    mode: app.env
    c: c
    app: 'main'
    f: tmplUtil
    i18: i18n.load(code)
    cstr: JSON.stringify(_.pick(c, 'code', 'url'))
    cssPath: (name)->
        if app.env then "/module/#{code}/src/style/#{name}.css" else "/lib/#{name}.css"
    jsPath: (name)->
        if app.env then "/module/#{code}/src/#{name}.js" else "/lib/#{name}.js"


pre =(req)->
    ctx = pageOpt(req.c)
    ps = req.params
    ctx.index = ps.page || ps.entity || 'index'
    ctx

pickScript = (ctx)->
    sc = require("../public/module/#{ctx.c.code}/tmplScript")

    initOpt = sc._init(ctx) || {}

    opt = if sc[ctx.index]
        sc[ctx.index](ctx) || {}
    else if ts[ctx.index]
        ts[ctx.index](ctx) || {}
    else
        {}

    _.extend initOpt, opt

render = (req, rsp, ctx)->
    opt = pickScript(ctx)
    dao.pick(_mdb, 'cache').ensureIndex time: 1,
        expireAfterSeconds: 7200
        background: true
    async.parallel opt, (err, res)->
        _.extend ctx, res
        str = jade.renderFile("#{req.fp}/#{ctx.index}.jade", ctx)
        unless app.env
            dao.save _mdb, 'cache',
                k: req.k
                str: str
                time: new Date()
        rsp.end str

module.exports =
    page: (req, rsp) ->
        render req, rsp, pre(req)

    entity: (req, rsp) ->
        ctx = pre(req)
        dao.get ctx.c.code, req.params.entity, _id: req.params.id, (item)->
            unless item
                rsp.end('no item')
            ctx = _.extend ctx, item
            render req, rsp, ctx
