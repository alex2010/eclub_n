define [
    '/lib/init.js'
    '/lib/router.js'

    'hbs!/lib/admin/view/role/res'
    'hbs!/lib/tmpl/tree/res'
    'hbs!/lib/tmpl/tree/res_file'
    'hbs!/lib/tmpl/tree/res_add'
    'hbs!/lib/admin/view/wtInfo'
    'hbs!/lib/admin/view/fileTreeItem'
    'hbs!/lib/tmpl/inputTip'
], (cf, router)->
    #cf._router
    router = router.extend
        before: ->
            user.check()
            if cf.mob
                $('.navbar-toggle.pull-right').remove()

        ctn: $('#content')
        cb: $('#crumb')

        init: ->
            #'!/data(/:act)(/:entity)(/:p)': 'data'
            new it().init @ for it in cf._adminApp

        after: ->
            if cf.mob
                $('#topbar').hide()
                $('#side>div').removeClass('in')

        layout: ->
            nav = $("nav")
            if nav.length
                $("[href*='#{location.hash.split('/')[1]}']", nav).parent().addClass(@active)
                nav.on 'click', 'li', util.setActive

################################################################################################
#        initTab: (key, tabs, act)->
#            unless $('.' + key, @ctn).length
#                items = for it in tabs
#                    label: iin it
#                    href: util.navUrl(key, it)
#                @ctn.html $("<ul class='nav nav-tabs ${key}'>").append cf.tmpl.lia items
#                @ctn.append '<div id="main" class="tab-content"/>'
#                $("[href*='#{act}']", @ctn).parent().addClass app.active
#                @ctn.on 'click', 'a', util.setActive

################################################################################################
#        home: ->
#            @initLayout 'tmpl', '3-9'
#            $('#main').append('<div class="row"/>')
#            new _collection
#                mode: 'panel'
#                parent: '#side'
#                entity: 'event'
#                toFetch: false
#                context: ->
#                    title: '您的消息'
#                    style: 'panel-danger'
#                    bodyStyle: 'list-group'
#                event:
#                    'click .list-group-item': (e)->
#                        m = @collection.get util.getTargetId(e)
#                        m.set 'status', 1
#                        m.save()
#                addOne: (d)->
#                    d = d.toJSON()
#                    i = $ "<a id='ev-#{d.id}' class='list-group-item'>#{d.msg}</a>"
#                    $.data 'item', d
#                    @ctn.append i
#                criteriaOpt:
#                    tid: "eq_s_#{cf.cid}:#{user.id}"
#                    status: 'eq_i_0'
#
#            new _table
#                title: '紧急事件'
#                style: 'panel-info'
#                parent: '#main .row'
#                className: 'col-md-6'
#                toFetch: false
#                cleanAll: false
#                entity: 'eme'
#
#            new _table
#                title: '我的任务'
#                style: 'panel-info'
#                parent: '#main .row'
#                entity: 'task'
#                className: 'col-md-6'
#                toFetch: false
#                cleanAll: false
#                criteriaOpt:
#                    source: 'eq_s_' + user.id
#                    status: 'eq_i_10'

################################################################################################

#        site: (act, p, ps)->
#            @initLayout 'site', '2-10', ->
#                context:
#                    title: iim('mgm', 'codeMap')
#                data: (for it in ['community', 'codeMap']
#                    label: iin it
#                    path: util.navUrl 'site', it)
#
#            @_site.fun(act, p, ps)
################################################################################################

#        tmpl: (act, name)->
#            @initLayout 'tmpl', '3-9'
#
#            @_tmpl.fun(act, name)

################################################################################################
#        file: (act = 'img', p) ->
#            @initLayout 'file', '2-10', ->
#                context:
#                    title: iim('mgm', 'file')
#                data: (for it in ['img', 'doc', 'video']
#                    label: iin it
#                    path: util.navUrl 'file', it)
#
#            @_file.fun(act, p)


################################################################################################
#        userRole: (act = 'user', entity, eid)->
#            @initLayout 'userRole', '2-10', ->
#                context:
#                    title: iim('mgm', 'user')
#                data: (for it in ['user', 'role', 'org', 'userGroup']
#                    label: iin it
#                    path: util.navUrl 'userRole', it)
#
#            @_userRole.fun(act, entity, eid)

################################################################################################
#        qrcode: (act, entity, eid)->
#            @initLayout 'qrcode', '2-10', =>
#                context:
#                    title: iim('mgm', 'qrcode')
#                data: (for it in ['show', 'follower', 'purchase']
#                    label: iie 'qrcode', it
#                    path: util.navUrl 'qrcode', it)
#
#            @_qrcode.fun(act, entity, eid)
#

#################################################################################################
#        data: (act, entity, eid)->
#            return if !user.mgm or !user.mgm.entity
#            @_dataNav || @_dataNav = (for k,v of _.invert(user.mgm.entity)
#                if k isnt 'x' and k.length < 3
#                    label: iin v
#                    path: util.navUrl 'data/list', v)
#
#            @initLayout 'data', '2-10', =>
#                context:
#                    title: iim('mgm', 'entity')
#                data: @_dataNav
#
#            @_data.fun(act, entity, eid)

################################################################################################
#        wechat: (act, p, ps)->
#            @initLayout 'wechat', '2-10', ->
#                context:
#                    title: iim('mgm', 'wechat')
#                data: (for it in ['info', 'code', 'post']
#                    label: iin it
#                    path: util.navUrl 'wechat', it)
#
#            @_wechat.fun(act, p, ps)
#
#    $.extend _user::,
#        check: ->
#            log 'user check......'
#            @isAdmin() || @hasRole('manager')
#
#        afterLogin: ->
#            if @isRoot()
#                @mgm.entity.community = 75
#            @renderMenu()
#            app.navigate location.hash || util.navUrl('home'), trigger: true
#
#        afterLogout: ->
#            @id = null
#            @mgm = null
#            @roles = null
#            $('#topbar').empty()
#            app.navigate '', trigger: true
#            app.login()