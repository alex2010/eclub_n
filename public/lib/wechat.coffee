define [
    '/lib/init.js'
], (cf)->
    cf.Wechat = (opt)->
        $.extend true, @, opt
        @url = 'https://api.weixin.qq.com/cgi-bin/'
        @getToken()
        @

    cf.Wechat.one = (opt)->
        unless app.wt
            unless opt
                return unless window._appId
                opt =
                    appId: _appId
                    code: _code
            app.wt = new cf.Wechat(opt)
        app.wt

    $.extend cf.Wechat::,

        userBaseUrl:(scope, state)->
            "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{@appId}&redirect_uri=#{encodeURIComponent(cf.community.url + "/a/#{cf.cid}/wechat/userInfoByCode")}&response_type=code&scope=#{scope}&state=#{state}#wechat_redirect"

        userInfoUrl: (simple, p, text)->
            if simple
                href = @userBaseUrl('snsapi_base', @code + '::' + p)
            else
                href = @userBaseUrl('snsapi_userinfo', @code + '::' + p)
#            href = "https://open.weixin.qq.com/connect/oauth2/authorize?appid=#{@appId}&redirect_uri=#{encodeURIComponent(cf.community.url + "/a/#{cf.cid}/wechat/userInfoByCode")}&response_type=code&scope=snsapi_userinfo&state=#{@code + '::' + p}#wechat_redirect"
            if text
                "<a href='#{href}'>#{text}</a>"
            else
                href

        tokenStr: (act, ps, url = @url)->
            p = ['access_token=' + @token]
            if ps
                p = p.concat ps
            "#{@url}#{act}?#{p.join('&')}"

        jsInit: ->
            that = @
            if cf.wjsa
                #alert(@appId + @jsTime + cf.code + @jsToken + cf.wjsa)
                wx.config
#                    debug: true
                    appId: @appId
                    timestamp: @jsTime
                    nonceStr: cf.code
                    signature: @jsToken
                    jsApiList: cf.wjsa.split(',')
                wx.ready ->
                    log 'wx ready!!!'
                wx.error (rs)->
                    log rs
                    alert util.ro(rs)
                    that.rToken()
                    that.getToken()
#                    util.cleanLocal('wejs_expire')
#                    util.cleanLocal('wejs_token')
#                    that.getJsToken()


        getJsToken: ->
            @jsTime = util.readLocal('wejs_expire')
            if @jsTime and (+@jsTime + 7190 - new Date().getTime() / 1000) > 0
                @jsToken = util.readLocal('wejs_token')
                @jsInit()
            else
                opt =
                    appId: @appId
                    ns: cf.code
                    url: location.href
                    token: @token
                $.get util.actUrl('wechat', 'getJsToken'), opt, (res)=>
                    [@jsToken,@jsTime] = res.split('___')
                    util.saveLocal 'wejs_token', @jsToken
                    util.saveLocal 'wejs_expire', @jsTime
                    @jsInit()

        rToken: ->
            util.cleanLocal('we_expire')
            util.cleanLocal('we_token')
            util.cleanLocal('wejs_expire')
            util.cleanLocal('wejs_token')
            log('token refreshed')

        getToken: ->
            left = util.readLocal('we_expire')
            if left and (+left - new Date().getTime() / 1000) > 0
                @token = util.readLocal('we_token')
                if W.wx
                    @getJsToken()
            else
                opt =
                    url: @url + 'token?grant_type=client_credential'
                    code: @code
                    appId: @appId
                $.get util.actUrl('wechat', 'getToken'), opt, (res)=>
                    [@token,now] = res.split('___')
                    util.saveLocal 'we_token', @token
                    util.saveLocal 'we_expire', (+now + 7196)
                    if W.wx
                        @getJsToken()

        getAudio: (mid, cb)->
            opt =
                url: @tokenStr('get', ["media_id=#{mid}"], 'http://file.api.weixin.qq.com/cgi-bin/media')
            @request opt, (res)->
                cb?(res)

        createMenu: (menu)->
            opt =
                type: 'post'
                wtCode: @code
                url: @tokenStr 'menu/create'
                opt: menu
            @request opt, (res)->
                if res.errcode
                    popMsg '创建菜单失败，请重新尝试', 'danger'
                else
                    popMsg '创建菜单成功', 'success'

        getUserInfo: ()->
            opt =
                url: @tokenStr 'user/info', ["openid=#{'OPENID'}", "lang=zh_CN"]
                type: 'get'
            @request opt, (res)->
                log res

        uploadRes: (type, url, success)->
#            url = 'https://ss0.bdstatic.com/5a21bjqh_Q23odCf/static/superplus/img/logo_white_ee663702.png'
#            fd = new FormData()
#            fr = new FileReader()
#            fr.readAsArrayBuffer(url)
#            fd.append("media", fr)
#            xhr = new XMLHttpRequest()
#            xhr.open("POST", @tokenStr('media/upload', "type=#{type}"))
#            xhr.send(fd)
#            xhr
            $.ajax
                type: 'POST'
                url: @tokenStr('media/upload', "type=#{type}")
                data: fd
                contentType: false
                processData: false
                success: success

        uploadNews: (p, cb)->
            opt =
                url: @tokenStr('media/uploadnews')
                resUrl: @tokenStr('media/upload', "type=image", 'https://file.api.weixin.qq.com/cgi-bin/')
                type: 'post'

            if p.preUrl
                p.preUrl = @tokenStr('message/mass/preview')
                p.username = user.username unless p.username
            if p.sendUrl
                p.sendUrl = @tokenStr('message/mass/sendall')


            @request $.extend(opt, p), (res) =>
                cb?()
                popMsg '微信图文信息同步成功'
            , 'uploadNews'
#                return unless confirm('群发信息吗？')
#                nop =
#                    url: @tokenStr('message/mass/sendall')
#                    type: 'post'
#                    opt:
#                        filter:
#                            is_to_all: true
#                        mpnews:
#                            media_id: res.media_id
#                        msgtype: 'mpnews'
#                @request nop, (res) ->

        createQRCode: (sid, ref)->
            opt =
                url: @tokenStr('qrcode/create')
                type: 'post'
                opt:
                    action_name: "QR_LIMIT_SCENE"
                    action_info:
                        scene:
                            scene_id: sid
            @request opt, (res) =>
                #save res.ticket
                if res.ticket
                    $.postJSON util.restUrl('ticketTable'),
                        cid: cf.cid
                        ticket: res.ticket
                        ref: ref + '_' + sid
                    , @renderQRImg
                else
                    popMsg '二维码获取失败，请与技术人员联系', 'warning'

        renderQRImg: (rs)->
            if rs.entity and rs.entity.ticket
                $('#qrBox').html "<img class='img-responsive' src='https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=#{rs.entity.ticket}'/>"
            else
                $('#qrBox').html '<p class="bg-danger">请先生成二维码</p>'

        showQRImg: (key)->
            $.get util.restUrl('ticketTable') + '/' + key, @renderQRImg


        request: (opt, res, act = 'remote')->
            opt.opt = JSON.stringify(opt.opt) if _.isObject(opt.opt)
            $.post util.actUrl('wechat', act), opt, res

# js api -----------
        pay: (opt, success, error)->
            $.ajax
                url: util.actUrl('customer', 'wechat')
                dataType: 'json'
                data: $.extend
                    nstr: util.randomChar(16)
                    code: @code
                    nonce_str: util.randomChar(16)
                    tradeType: 'JSAPI'
                    oid: app.woid
                , opt
                success: (res)->
                    #http://weixin.qq.com?showwxpaytitle=1。
                    #alert util.ro(res)
                    if res.paySign # and W.WeixinJSBridge
                        wx.chooseWXPay
                            timestamp: res.timeStamp
                            nonceStr: res.nonceStr
                            package: res.package
                            signType: res.signType
                            paySign: res.paySign
                            success: (res)->
#                                alert util.ro(res)
                                if res.err_msg == "get_brand_wcpay_request:ok"
#                                    alert 'pay success'
                                    success?()
                                else
#                                    alert 'pay fail'
                                    error?()

#                        WeixinJSBridge.invoke 'getBrandWCPayRequest', res,
#                            (res)->
#                                alert util.ro(res)
#                                if res.err_msg == "get_brand_wcpay_request:ok"
#                                    alert 'pay success'
#                                    success?()
#                                else
#                                    alert 'pay fail'
#                                    error?()
                    else
                        popMsg('支付失败', 'warning')
                        error?()
        editAddr: ->
            opt =
                accessToken: @aToken
                appId: @appId
                nonceStr: util.randomChar(4)
                timeStamp: parseInt(new Date().getTime()/1000).toString()
                url: location.href
            sd = for k,v of opt
                "#{k.toLowerCase()}=#{v}"
            sd = sd.join '&'
            addSign = hex_sha1 sd

            WeixinJSBridge.invoke 'editAddress',
                appId: @appId
                scope: "jsapi_address"
                signType: "sha1"
                addrSign: addSign
                timeStamp: opt.timeStamp
                nonceStr: opt.nonceStr
            , (res)->
                alert util.ro(res)

        chooseImg: (p)->
            wx.chooseImage
                success: (res)->
                    log res
                    for it in res.localIds
                        p.append "<img src='#{it}'/>"

        uploadImg: (lids)->
            wx.uploadImage
                localId: li
                isShowProgressTips: 1
                success: (res)->
                    log res

        uploadImg: (lids)->
            wx.uploadImage
                localId: li
                isShowProgressTips: 1
                success: (res)->
                    log res






