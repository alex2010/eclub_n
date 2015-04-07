router = require('express').Router()
path = require('path')

auth = require '../controller/auth'
data = require '../controller/data'
page = require '../controller/page'
up = require '../controller/upload'


checkPagePattern =  (req, rsp, next, page)->
    if /^\w+$/.test(page)
        next()
    else
        rsp.end('name error')

router.param 'entity', checkPagePattern
router.param 'page', checkPagePattern

#
#router.param 'id', (req, rsp, next, id)->
#    log id
#    if id.length isnt 24
#        rsp.end('row id')
#    else
#        next()

ck = (req)->
    req.hostname + req.originalUrl
pre = (req, rsp, next)->
    k = ck req
    dao.get _mdb, 'cache', k: k, (res)->
        if res and !app.env
            rsp.end res.str
        else
            req.c = app._community[req.hostname]
            req.k = k
            log req.k
            next()

checkPage = (req, rsp, next)->
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


router.get '/cc/:page', (req, rsp)->
    opt =
        k:
            $regex: "#{req.params.page}"

    dao.delItem _mdb, 'cache', k: req.hostname + '/'

    dao.delItem _mdb, 'cache', opt, (res)->
        rsp.end res.toString()

router.all '/a/*', pre
router.all '/r/*', pre

router.get '/', pre
router.get '/', checkPage

router.get '/:page', pre
router.get '/:page', checkPage

router.get '/:entity/:id', pre
router.get '/:entity/:id', checkPage


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

module.exports = router