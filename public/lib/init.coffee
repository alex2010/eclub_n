define [
    'bootstrap'
    'underscore'
    'backbone'

    '/lib/util/base.js'

    '/lib/i18n/message_zh.js'

    'hbs!/lib/tmpl/blank'
    'hbs!/lib/tmpl/modal'
    'hbs!/lib/tmpl/panel'
    'hbs!/lib/tmpl/lia'
    'hbs!/lib/tmpl/alert'
    'hbs!/lib/tmpl/formItem'
    'hbs!/lib/tmpl/btnGroup'
    'hbs!/lib/tmpl/searchBox'
    'hbs!/lib/tmpl/pagination'
    'hbs!/lib/tmpl/tab'
    'hbs!/lib/tmpl/table'
    'hbs!/lib/tmpl/mobBtn'

    '/lib/tmplHelper.js'

    'finger'
], ($, _, Backbone, u, lang, blank, modal, panel, lia, alert, formItem, btnGroup, searchBox, pagination, tab, table, mobBtn)->
    cf.W = window.W = window

    $.extend W,
        util: u
        popMsg: u.popMsg
        log: u.log
        _: _
        _i: lang

    $.extend W, u.i18n

    cf.style =
        inputClass: 'form-control'
        labelClass: 'control-label'
        inputBox: 'form-group'
        iconStr: 'glyphicon'
        active: 'active'
        btn: (style = 'default', size, block, etc)->
            b = 'btn'
            s = ''
            s += " #{b}-#{style}" if style
            s += " #{b}-#{size}" if size
            s += " #{b}-block" if block
            s += " #{etc}" if etc
            b + s

        sign:
            success: 'ok'
            warning: 'warning-sign'
            info: 'info-sign'
            danger: 'exclamation-sign'
    cid = cf.community.id
    code = cf.community.code

    cf.dm = 'encorner.org'
    #    cf.dm = 'hailaihui.com'


    cf.minuteTime = 1000 * 60
    cf.hourTime = cf.minuteTime * 60
    cf.dayTime = cf.hourTime * 24
    cf.tp = {}
    cf.delayPic = true
    cf._dImg = []
    cf._exr = []
    cf.scEvent = []
    window.onscroll = ->
        it() for it in cf.scEvent

    cf._adminApp = []
    cf.addAdminApp = (p)->
        cf._adminApp.push p
        p

    cf.url = ->
#        if cf.mode
#            "http://localhost:8080/module/#{cf.code}"
#        else
        cf.community.url

    cf.agent =
        iphone: /iPhone/i.test(navigator.userAgent)
        android: /android/i.test(navigator.userAgent)
        ipad: /iPad/i.test(navigator.userAgent)

    cf.wechat = if W.WeixinJSBridge then true else false
    cf.mob = cf.agent.iphone || cf.agent.android || cf.wechat || (document.body.clientWidth < 480)

    if !cf.mob
        cf.scEvent.push ->
            if window.scrollY > 200
                if !cf.noGoTop and !$('#go-top').length
                    t = $('<span id="go-top" title="返回顶部"></span>').click ->
                        util.sTop(null, 55, 500)
                        $(@).remove()
                    $('body').append t
            else
                $('#go-top').remove()

    #pic delay loading
    if cf.delayPic
        cf.scEvent.push ->
            util.loadPic()


    $.extend cf,
        meta: {}
        model: {}
        view: {}
        collection: {}
        page: {_: {}}
        widget: {}
        i18n: {}
        cid: cid
        code: code
        popTime: 2500

        ss: 'show'
        rsPre: "/r/"
        actPre: "/a/"
        root: (if cf.mode then "/module/#{code}/" else "/")
        resPrefix: (if cf.mode then "/module/#{code}/" else "/")
        resFolder: "upload/"
#        rPath: (if cf.mode then "/res/" else "http://s.#{cf.dm}/")
        rPath: "http://s.#{cf.dm}/"
        _es: []
        tmpl:
            blank: blank
            panel: panel
            modal: modal
            lia: lia
            alert: alert
            btnGroup: btnGroup
            searchBox: searchBox
            pagination: pagination
            formItem: formItem
            tab: tab
            table: table
            mobBtn: mobBtn
        uSize:
            img:
                max: 1024 * 1024 * 6
                ext: ["jpg", "jpeg", "png", "gif"]
            doc:
                max: 1000 * 1024 * 4
                ext: ["doc", "docx", "ppt", "pptx", "txt", "pdf", "rtf"]
            audio:
                max: 1000 * 1024 * 5
                ext: ["wmv", "mp3", "mid"]
            video:
                max: 1000 * 1024 * 12
                ext: ["swf", "fla", "mp4"]
    cf
