router = require('express').Router()
path = require('path')


router.get '/', (req, res, next) ->
    res.render 'index', title: 'Express'

router.get '/p/:code/*', (req, rsp, next)->
    code = req.params.code
    app.set 'views', path.join(_path, "public/module/#{code}/tmpl")
    app.setCommunity dao, code, ->
        next()


auth = require '../controller/auth'
data = require '../controller/data'
page = require '../controller/page'
up = require '../controller/upload'

router.post '/a/:code/upload', up.upload
router.post '/a/:code/upload/remove', up.remove

router.post '/a/:code/auth/login', auth.login
router.post '/a/:code/auth/logout', auth.logout

router.get '/r/:code/:entity', data.list
router.get '/r/:code/:entity/:id', data.get

router.put '/r/:code/:entity/:id', data.edit
router.post '/r/:code/:entity', data.save
router.delete '/r/:code/:entity/:id', data.del

router.get '/p/:code/:page', page.page
router.get '/p/:code/:entity/:id', page.entity

module.exports = router