define [
    '/lib/init.js'
], (cf)->

    cf.router = Backbone.Router.extend
        initialize: (opt) ->
            $.extend @, util.parseUrl()
            if localStorage
                if @woid
                    localStorage.setItem 'woid', @woid
                else
                    @woid = localStorage.getItem('woid')

            $.extend @, opt
            window.app = @
            window.user = new cf._user() if cf._user
            @init?()
            if @checkAuth and window.user
                window.user.offlineCheck()

        parent: 'body'
        checkAuth: true
        curView: null
        regions: {}
        views: {} #stored page instance
        active: 'active'
        wtAutoLogin: false

        blockBox: null
        blockLine: null
        blockMsg: "Please wait..."
#################################################################
        init: ->
            @ctn = $('#content')
            @sta = $('#static')

        before: ->
            if location.hash.length is 0
                @ctn.hide()
                @sta.show()
            else
                @ctn.attr('class', "#{@atHash(1)}").show()
                @sta.hide()
            true

        after: ->
            util.sTop(null, 0, 500)
            util.loadPic()

        context: ->

        layout: ->

        render: ->
            @layout()
            v.render() for k,v of @regions when not v.isShow or v.isShow()
            @rendered = true
            util.loadPic() if cf._dImg.length

        execute: (cb, args)->
            if cb
                @before?()
                cb.apply @, args
                @after?()

        def: ->
            @navigate '', trigger: true

        started: ->
            Backbone.History.started

        clean: ->
            $(app.parent).empty()
            app.rendered = false

        start: (callback)->
            log 'app start'
            return if Backbone.History.started
            if @user and user.isLogin()
                @initAfterAuth?()
            @render()
            callback?()
            @initAjax()
            Backbone.history.start()
            @

        login: (p = @ctn)->
            new cf.widget.loginForm
                noLabel: false
                parent: p
                cleanAll: true
                asterisk: false
                
        account: ->
            new cf.widget.changePsdForm
                mode: 'modal'

        setting: ->
            new cf.widget.settingForm
                title: iic('cfg')
                mode: 'modal'
                entity: 'user'
                items: ['username']
                btns: ['save']

        sTop: ->
            u.sTop(location.hash, 0, 1000)

        addRegion: (name, comp) ->
            @regions[name] = comp

        noView: ->

        initLayout: (key, cols, cb)->
            if !@ctn.hasClass(key)
                @ctn.attr('class', "row #{@atHash(1)}").show()
                n = cols.split('-')
                @ctn.html util.layout
                    side: "col-md-#{n[0]}"
                    main: "col-md-#{n[1]}"
                if cb
                    res = cb()
                    if _.isObject res
                        opt = $.extend true,
                            className: 'navbar-collapse collapse'
                            mode: 'panel'
                            data: []
                            parent: @ctn.find('#side')
                            context:
                                bodyStyle: 'list-group'
                            enhanceContent: ->
                                for it in @data
                                    @ctn.append """<a class="list-group-item" href="#{it.path}">#{it.label}#{util.icon 'chevron-right','i'}</a>"""
                                $("[href*='#{app.atHash(3)}']", @ctn).addClass app.active
                                @ctn.on 'click', 'a', util.setActive
                        , res
                        new cf.view.tag(opt).render()

                    if cf.mob
                        $('.navbar-header').prepend cf.tmpl.mobBtn
                            icon: 'th-list'
                            target: '#side>div'
                            cls: 'pull-right icon'
                    else
                        s = $('#side')
                        m = $('#main')
                        s.find('.panel-title').append util.icon('chevron-left pull-right btn btn-primary btn-xs closeSide')
                        s.on 'click', '.closeSide', =>
                            s.hide()
                            cols = m.attr('class')
                            m.attr 'class', 'col-md-12'
                            t = $(util.icon('chevron-right btn btn-primary btn-xs openSide'))
                            t.click ->
                                m.attr 'class', cols
                                s.show()
                                t.remove()
                            $('#content').append t

                if cf.mob and location.hash.split('/').length < 3
                    $('#header button.pull-right').trigger 'click'

        waiting: ()->
            $('#waiting').fadeIn(100)

        initAjax: ->
            $(document).ajaxStart(->
                @blockDiv() if @blockBox
                @blockBtn() if @blockLine
            ).ajaxStop(->
                @ajaxStop()  if @ajaxStop
            ).ajaxSuccess((e, xhr, settings) ->
#                if settings.dataType is 'json'
                if xhr.responseText.charAt(0) is '{'
                    result = $.parseJSON(xhr.responseText)
                    eval(result.action) if result.action
                    if result.msg and !cf.noReply
                        m = if result.msg.startsWith('m.') then ii(result.msg, result.p) else result.msg
                        popMsg(m, "success")
                    cf.noReply = false
            ).ajaxError (e, xhr, settings) ->
                result = $.parseJSON(xhr.responseText)
                if xhr.status < 300
                    sign = "success"
                else if xhr.status >= 300 and xhr.status < 500
                    sign = "warning"
                else
                    sign = "danger"
                eval(result.action) if result.action
                popMsg(result.msg, sign) if result.msg and !cf.noReply
                cf.noReply = false

        blockBtn: ()->
            if @blockLine.hasClass('glyphicon')
                @blockClass = @blockLine.attr('class')
                @blockLine.removeAttr('class')
            @blockText = @blockLine.text()
            @blockLine.addClass('disabled')
            @blockLine.html "<span class='ajax-loader'>#{iic('loading')}...</span>"
            @ajaxStop = @blockBtnStop

        blockBtnStop: () ->
            @blockLine.removeClass('disabled')
            @blockLine.html @blockText
            if @blockClass
                @blockLine.attr('class', @blockClass)
            @blockClass = @lockText = @blockLine = @ajaxStop = null

        atHash: (num = 1, splitter = '/')->
            location.hash.split(splitter)[num]
