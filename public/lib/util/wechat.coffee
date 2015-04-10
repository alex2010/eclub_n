onBridgeReady = ->
    mainTitle = $('title').text()
    mainDesc = $('meta[name="description"]').attr('content')
    mainURL = "#{cf.community.url}/#{_pName}.html"
    mainImgUrl = $('.iconPic').attr('src')

    #转发朋友圈
    WeixinJSBridge.on "menu:share:timeline", (e) ->
        data =
            img_url: mainImgUrl
            img_width: "120"
            img_height: "120"
            link: mainURL
        #desc这个属性要加上，虽然不会显示，但是不加暂时会导致无法转发至朋友圈，
            desc: mainDesc
            title: mainDesc

        WeixinJSBridge.invoke "shareTimeline", data, (res) ->
            WeixinJSBridge.log res.err_msg


    #同步到微博
    WeixinJSBridge.on "menu:share:weibo", ->
        WeixinJSBridge.invoke "shareWeibo",
            content: mainDesc
            url: mainURL
        , (res) ->
            WeixinJSBridge.log res.err_msg
            return

        return


    #分享给朋友
    WeixinJSBridge.on "menu:share:appmessage", (argv) ->
        WeixinJSBridge.invoke "sendAppMessage",
            img_url: mainImgUrl
            img_width: "120"
            img_height: "120"
            link: mainURL
            desc: mainDesc
            title: mainTitle
        , (res) ->
            WeixinJSBridge.log res.err_msg
            return
        return
    return
document.addEventListener 'WeixinJSBridgeReady', ->
    onBridgeReady()