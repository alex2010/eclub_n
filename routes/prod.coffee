router = require('express').Router()
path = require('path')


router.get '/', (req, res, next) ->
    res.render 'index', title: 'Express'

router.get '/p/*', (req, rsp, next)->
    code = req.params.code
    app.set 'views', path.join(_path, "public/module/#{code}/tmpl")
    app.setCommunity dao, code, ->
        next()


auth = require '../controller/auth'
data = require '../controller/data'
page = require '../controller/page'
up = require '../controller/upload'

router.post '/a/upload', up.upload
router.post '/a/upload/remove', up.remove

router.post '/a/auth/login', auth.login
router.post '/a/auth/logout', auth.logout

router.get '/r/:entity', data.list
router.get '/r/:entity/:id', data.get

router.put '/r/:entity/:id', data.edit
router.post '/r/:entity', data.save
router.delete '/r/:entity/:id', data.del

router.get '/p/:page', page.page
router.get '/p/:entity/:id', page.entity

module.exports = router