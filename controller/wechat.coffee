async = require('async')

tmplUtil = require '../ext/tmpl'

wtApi = require('wechat-api')
OAuth = require('wechat-oauth')

getApi = (code, pubCode,func)->
    if wtCtn[pubCode]
        func(wtCtn[pubCode])
    else
        dao.get code, 'pubAccount', code: pubCode, (res)->
            if res
                api = new wtApi(res.appId, res.secret)
                wtCtn[pubCode] = api
                func(api)

module.exports =
    apiCall:(name, opt)->
        getApi

    createMenu: (req, rsp)->
        getApi req.body.code, req.body.pubCode, (api)->
            api.createMenu req.body.menu, (err, res) ->
                rsp.send res

    createLimitQRCode:(req,rsp)->
        code = req.body.code
        getApi code, req.body.pubCode, (api)->
            api.createLimitQRCode req.body.sceneId, (err, res) ->
                filter =
                    pubCode: req.body.pubCode
                    $query:{}
                    $orderby:
                        row: -1
                opt =
                    limit:1
                dao.find code, 'ticketTable', filter,opt,(rTicket)->
                    row = 1
                    if rTicket.length > 0
                        row = rTicket[0].row + 1
                    opt =
                        pubCode: req.body.pubCode
                        ticket: res.ticket
                        uid: new oid(req.body.uid)
                        row: row
                    dao.save code, 'ticketTable', opt, ->
                        rsp.send url: api.showQRCodeURL(res.ticket)

    showQRCodeURL:(req,rsp)->
        filter =
            uid: new oid(req.body.uid)
            pubCode: req.body.pubCode
        code = req.body.code
        dao.get code, 'ticketTable', filter, (res)->
            if res
                getApi code, req.body.pubCode, (api)->
                    rsp.send url: api.showQRCodeURL(res.ticket)
            else
                rsp.send msg: '二维码未生产'

    uploadNews:(req,rsp)->
        wCode = req.body.pAccount
        code = req.c.code
        opt = req.body.sendOpt
        isPre = req.body.isPre
        log opt
        dao.get code, 'codeMap', type: 'wtStyle', (resStyle)->
            style = resStyle.value if resStyle
            getApi code, wCode,(api)->
                async.each opt, (n,cb)->
                    log util.sPath(code+'/'+n.thumb_media_id)
                    unless n.thumb_media_id.startsWith 'http'
                        n.thumb_media_id = util.sPath(code+'/'+n.thumb_media_id)
                    api.uploadMaterial n.thumb_media_id, 'image', (err,res)->
                        log res
                        n.thumb_media_id = res.MEDIA_ID
                        entity = util.del 'entity', n
                        _id = util.del '_id', n
                        tmpl = util.del 'tmpl', n
                        log tmpl
                        if entity and _id
                            dao.get wCode, entity, _id: _id, (et)->
                                log et
                                ctx =
                                    code: code
                                    f: tmplUtil
                                    c: req.c
                                ctx[entity] = et
                                path = "#{_path}/public/module/#{code}/tmpl/wechat/#{tmpl}.jade"
                                content = jade.renderFile path,ctx
                                if styles
                                    for k,v of styles
                                        content.replaceAll("<#{k}>","<#{k} style='#{v}'>")
                                if entity is 'post'
                                    content.replaceAll "<div id=", "<img id="
                                    content.replaceAll 'Loading...</div>', ''
                                n.content = content
                                n.digest = et.brief
                                cb()
                        else
                            n.content || n.content = 'no content'
                            n.digest || n.brief = 'no digest'
                            cb()
                ,->
                    api.uploadNews opt,(err, res) ->
                        log err

                        if isPre
                            dao.get wCode, 'user', _id: isPre, (user)->
                                api.previewNews user.woid, res.media_id,(err, res) ->
                                    rsp.send
                                        success: true
                                        msg: '测试通过'
                        else
                            api.massSendNews res.media_id,
                                is_to_all: true
                            ,->
                                rsp.send
                                    success: true
                                    msg: '发送成功'

    massSend:(req,rsp)->
        getApi req.body.code, (api)->
            api.massSend req.body.qrNum,(err, res) ->
                log 'create qrcode'
                log res
                api.showQRCodeURL res.ticket, (res)->
                    log 'qrcode'
                    log res
                    rsp.send res

    userInfoByCode:(req,rsp)->
        log 'userInfoByCode'
        qy = req.query
        [wCode,page,func] = qy.state.split('::')
        log req.c
        code = req.c.code
        log wCode
        log page
        log func
        if ctCtn[wCode]
            log 'in this ctctn'
            ctCtn[wCode].getAccessToken qy.code, (err,result)->
                accessToken = result.data.access_token
                openid = result.data.openid
                ru = "#{req.c.url}/#{page}?woid=#{openid}&aToken=#{accessToken}"
                ru = 'http://'+ru if ru.indexOf('http') is -1
                ru += "#!/#{func.replace('azbzc','/')}" if func
                if result.data.scope is 'snsapi_userinfo'
                    ctCtn[wCode].getUser openid, (err,res)->
                        return unless res
                        dao.get code, 'user', woid: openid, (user)->
                            if user
                                user.wunid = res.unionid
                            else
                                _id = new oid()
                                user =
                                    _id: _id
                                    username: res.nickname
                                    gender: if res.sex is 1 then true else false
                                    country: res.country
                                    woid: res.openid
                                    wunid: res.unionid
                                    info:
                                        address: "#{res.province} #{res.city}"
                            if res.headimgurl and (!user.refFile or !user.refFile.portrait)
                                fn = user._id.toString() + '.jpg'
#                                log res.headimgurl
#                                log "#{util.sPath(code)}/#{fn}"
                                gs('fetchFile') res.headimgurl, "#{util.sPath(code)}/#{fn}",->
                                user.refFile =
                                    portrait:[fn]
                            dao.save code, 'user', user

                            rsp.redirect ru
                else
                    rsp.redirect ru
        else
            dao.get code, 'pubAccount', code: wCode, (res)->
                ctCtn[wCode] = new OAuth(res.appId,res.secret)
                log 'zzz'
                log "http://#{req.c.url}/#{page}"
                rsp.redirect "http://#{req.c.url}/#{page}"
        return
#    previewNews:(req,rsp)->
#        getApi req.body.code, (api)->
#            api.previewNews req.body.opended, mid, ->
#
#                api.showQRCodeURL res.ticket, (res)->
#                    log 'qrcode'
#                    log res
#                    rsp.send res

#    sendSth(req,rsp)->
#        api.send