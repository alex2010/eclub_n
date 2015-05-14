router = require('express').Router()
path = require('path')

auth = require '../controller/auth'
data = require '../controller/data'
page = require '../controller/page'
up = require '../controller/upload'


checkPagePattern = (req, rsp, next, page)->
    if /^\w+$/.test(page)
        next()
    else
        rsp.end('name error')

router.param 'entity', checkPagePattern
router.param 'page', checkPagePattern


ck = (req)->
    req.hostname + req.url

pre = (req, rsp, next)->

    unless app.env
        req.hostname = req.get('Host')

    cc = req.query._c
    if cc
        if cc is '0' and req.query._e
            opt =
                $regex:
                    k: "#{req.query._e}"
        else if cc is '1'
            req.url = req.url.replace('&_c=1', '')
            req.url = req.url.replace('?_c=1', '')
#            if req.url.endsWith('?')
#                req.url = req.url.substr(0, req.url.length - 1)
            opt =
                k: ck(req)

        if opt
            dao.delItem _mdb, 'cache', opt, (res)->
                log 'del...'

    k = ck req
    dao.get _mdb, 'cache', k: k, (res)->
        if res and !app.env
            rsp.end res.str
        else
            req.c = app._community[req.hostname]
            req.k = k
            next()

checkPage = (req, rsp, next)->
#    log ck req
    pm = req.params
    page = pm.page || pm.entity || 'index'
    if page is 'r'
        next()
        return
    req.fp = path.join(_path, "public/module/#{req.c.code}/tmpl")
    if fs.existsSync("#{req.fp}/#{page}.jade")
        next()
    else
        rsp.end 'no page'


router.all '/a/*', pre
router.all '/r/*', pre

router.get '/', pre
router.get '/', checkPage

router.get '/:page', pre
router.get '/:page', checkPage

router.get '/:entity/:id', pre
router.get '/:entity/:id', checkPage

router.get '/:entity/:attr/:id', pre
router.get '/:entity/:attr/:id', checkPage


router.get '/', page.page

router.post '/a/upload', up.upload
router.post '/a/upload/remove', up.remove

router.post '/a/auth/login', auth.login
router.post '/a/auth/logout', auth.logout

router.get '/r/:entity', data.list
router.get '/r/:entity/:id', data.get

router.put '/r/:entity/:id', data.edit
router.post '/r/:entity', data.save
router.delete '/r/:entity/:id', data.del

router.get '/:page', page.page
router.get '/:entity/:id', page.entity

router.get '/:entity/:attr/:id', page.entity

module.exports = router