define [
    'underscore'
    '/lib/exObj.js'
], (_) ->

    ro:(ob)->
        str = ''
        for k,v of ob
            str += "#{k}:#{v} \n"
        str
    slice: Array::slice
    isChinese: (text)->
        if escape(text).indexOf('%u') < 0
            false
        else
            true
    findAndGen: (ctn, key)->
        t = ctn.find(key)
        unless t.length
            t = $("<div/>")
            if key.charAt(0) is '#'
                t.attr 'id', key.substring(1)
            else
                t.addClass key.substring(1)
            ctn.append t
        t

    ct: (e)->
        $(e.currentTarget)

    saveLocal: (k, v)->
        return unless localStorage
        localStorage[k] = v

    cleanLocal: (key)->
        return unless localStorage
        for k,v of localStorage
            if k.indexOf(key) > -1
                localStorage.removeItem k

    readLocal: (id, dir)->
        return unless localStorage
        if dir
            for k,v of localStorage
                if dir > 0
                    if k.startsWith id
                        return v
                else
                    if k.endsWith id
                        return v
        else
            localStorage[id]

    del: (x, ctx = window)->
        it = ctx[x]
        #        return unless it is undefined
        try
            delete ctx[x]
        catch e
            ctx[x] = undefined
        it

    iBtn: (cls, key, href)->
        key = cls unless key
        cls: cf.style.btn null, 'sm', false, util.iClass(cls) + ' ' + key
        id: true
        title: iic key
        href: href

    tBtn: (label, href, icon, cls, title, id)->
        unless util.isChinese label
            label = iic iim label
        label: label
        href: href
        icon: icon and util.icon icon
        cls: cls #+' '+label
        title: title and iic title
        id: id

    pureText: (text) ->
        text.replace(/<[^>].*?>/g, "")

    adjustText: (text, length) ->
        text = text.replace(/<[^>].*?>/g, "")
        i = 0
        j = 0
        res = ''
        len = text.length
        while length > i and len > j
            c = text.substr(j++, 1)
            if /^[\u4e00-\u9fa5]+$/.test(c) then i += 2 else i++
            res += c
        if len > j
            res += '...'
        res
    fileExt: (name) ->
        it = name.split(".")
        it[it.length - 1]

    attr: (opt)->
        s = ' '
        for k,v of opt when v
            s += k + '="' + v + '" '
        s

    lcss: (path) ->
        unless $("link[href='#{path}']").length
            $('head').append """<link rel="stylesheet" type="text/css" href="#{path}" media="all">"""

    lr: (url, callback, failCallback, p) ->
        xr = (if W.XMLHttpRequest then new XMLHttpRequest() else new ActiveXObject("MsXml2.XmlHttp"))
        xr.onreadystatechange = ->
            if xr.readyState is 4
                if xr.status is 200 or xr.status is 304
                    if callback then callback xr.responseText, p else eval xr.responseText
                else
                    failCallback and failCallback()
        xr.open "GET", url, true
        xr.send null

    parseLocalDate: (time) ->
        time = time.substring(0, 19) if time.length > 19
        new Date((time or "").replace(/-/g, "/").replace(/[TZ]/g, " "))

    prettyDate: (time, type = 'ys', d) ->
        return unless time
        time = time.substring(0, 19)  if time.length > 19
        date = new Date((time or "").replace(/-/g, "/").replace(/[TZ]/g, " "))
        diff = (((new Date()).getTime() - date.getTime()) / 1000)
        day_diff = (if diff > 0 then Math.floor(diff / 86400) else Math.ceil(diff / 86400))
        if !d or isNaN(day_diff) or day_diff < -31 or day_diff >= 31
            if type is "n"
                return date.getMonth() + 1 + "-" + date.getDate() + " " + date.getHours() + ":" + date.getMinutes()
            else if type is "s"
                return date.getMonth() + 1 + "-" + date.getDate()
            else if type is "ys"
                return date.getFullYear() + "年" + (date.getMonth() + 1) + "月" + date.getDate() + "日"
            else if type is "ysh"
                return "#{date.getFullYear()}-#{date.getMonth() + 1}-#{date.getDate()} #{date.getHours()}:#{date.getMinutes()}"
            else
                return time.toLocaleString()
        if day_diff <= 0
            day_diff *= -1
            diff *= -1
            day_diff is 0 and (diff < 60 and ii("t.j_n") or diff < 120 and ii("t.o_m_l") or diff < 3600 and Math.floor(diff / 60) + ii("t.m_l") or diff < 7200 and ii("t.o_h_l") or diff < 86400 and Math.floor(diff / 3600) + ii("t.h_l")) or day_diff is 1 and ii("t.t") or day_diff < 7 and day_diff + ii("t.d_l") or day_diff < 31 and Math.ceil(day_diff / 7) + ii("t.w_l")
        else
            day_diff is 0 and (diff < 60 and ii("t.j_n") or diff < 120 and ii("t.o_m_a") or diff < 3600 and Math.floor(diff / 60) + ii("t.m_a") or diff < 7200 and ii("t.o_h_a") or diff < 86400 and Math.floor(diff / 3600) + ii("t.h_a")) or day_diff is 1 and ii("t.y") or day_diff < 7 and day_diff + ii("t.d_a") or day_diff < 31 and Math.ceil(day_diff / 7) + ii("t.w_a")

    parseUrl: (url = location.search)->
        res = {}
        unless url.indexOf("?") is -1
            str = url.substr(1).split("&")
            for it in str
                p = it.split("=")
                res[p[0]] = decodeURIComponent(p[1])
        res

    seqProp: (obj, pStr, dV) ->
        v = obj
        for chain in pStr.trim().split(".")
            v = v[chain]
            break unless v?
        if v?
            v
        else
            dV

    setSeqProp: (obj, pStr, v) ->
        for chain in pStr.trim().split(".")
            if chain.indexOf('[') > -1
                k = chain
                chain = k.split('[')[0]
                index = parseInt k.split('[')[1].split(']')[0]
                if _i is (_len - 1)
                    d = if chain then obj[chain] else obj
                    if v
                        d[index] = v
                    else
                        return d[index]
                else
                    obj = if chain then obj[chain][index] else obj[index]
            else if _.isObject(obj[chain])
                obj = obj[chain]
            else
                if v
                    obj[chain] = v
                else
                    return obj[chain]

    delSeqProp: (obj, pStr) ->
        it = pStr.trim().split(".")
        lk = it.pop()
        if it.length > 0
            for chain in it
                obj = obj[chain]
        if lk.indexOf('[') > 0
            chain = lk.split('[')[0]
            index = parseInt lk.split('[')[1].split(']')[0]
            obj[chain].splice(index, 1)
        else
            delete obj[lk]

    randomChar: (len, x = '0123456789qwertyuioplkjhgfdsazxcvbnm') ->
        ret = x.charAt(Math.ceil(Math.random() * 10000000) % x.length)
        for n in [1..len]
            ret += x.charAt(Math.ceil(Math.random() * 10000000) % x.length)
        ret

    log: (msg)->
        console.log msg #if cf.mode

    popMsg: (text, type = 'success', timeout = cf.popTime, closed) ->
        return unless text
        if text.startsWith 'm.'
            text = ii(text)
        alert = $ cf.tmpl.alert
            msg: text
            type: type
            closed: closed
            icon: cf.style.sign[type]
        alert.addClass 'popMsg'
        $('body').append alert.alert()
        alert.fadeIn(500)
        c = (t)->
            t.fadeOut(->
                $(@).remove())
        _.delay(c, timeout, alert) if timeout > 0

    clone: (obj, deep) ->
        return obj  unless typeof obj is "object"
        if $.isArray(obj) then obj.slice() else $.extend(deep, {}, obj)

    getLanguage: ->
        (if navigator.language then navigator.language else navigator.browserLanguage).split('-')[0]

    i18n:
        iCat: (k)->
            _i['cat.' + k]

        ii: (k, m...) ->

            if window._i and res = window._i[k] # res # and _.isString res
                if res and res.indexOf('{') > -1
                    for it in m
                        res = res.substring(0, res.indexOf('{')) + it + res.substring(res.indexOf('}') + 1)
                    if _.isString(res)
                        res = res.replace(new RegExp("{", "gm"), '').replace(new RegExp("}", "gm"), '')
                return res
            else
                if k.indexOf('.') > -1
                    k = k.split('.')[1]
                if k.indexOf('::') > -1
                    k = k.split('::')[1]
                return k.capAll()
        iim: (k, m...) ->
            ii('m.' + k, iin(it) for it in m)

        iie: (k, p) ->
            ii(k + '.' + p)

        iic: (p) ->
            ii('c.' + p)

        iin: (p) ->
            ii('nav.' + p)

             #|| ii('c.' + p) || ii(p) || p

    absPoint: (obj)->
        oRect = obj.getBoundingClientRect()
        left: oRect.left, top: oRect.top

    curRate: (code)->
        u_ex.ex[code]

    rateEx: (total, oRate, nRate)->
        total / oRate * nRate

    initCustObjEvent: (obj, actions, prefix)->
        _.extend obj, Backbone.Events

        obj.set = (k, v, p)->
            @[k] = v if v isnt null
            @trigger(prefix + ':' + k, p)

        for e of actions
            if(e.substr(0, 1) is '_')
                obj[e] = actions[e]
            else
                obj.on(prefix + ':' + e, actions[e])


    delProp: (x, ctx = window)->
        it = ctx[x]
        return unless it
        try
            delete ctx[x]
        catch e
            ctx[x] = undefined
        it

    initTab: (str, act, el = 'li')->
        $("[href*='#{act}']", str).parent().addClass app.active
        str.on 'click', el, util.setActive

    initActive: (b, str, c = 'active') ->
        b.find(str).addClass(c).siblings().removeClass c

    setActive: (t)->
        d = if t instanceof jQuery then t else $(@)
        d.addClass(app.active).siblings().removeClass app.active

    getUrlParams: (url, params) ->
        url + '?' + ("#{k}=#{v}" for k,v of params).join('&')

    langText: (text) ->
        m = $("<div>" + text + "</div>").find("." + _lang)
        (if m.length > 0 then m.html() else text)

    setSubItem: (data, prop = 'id') ->
        for it in data
            if it.pid
                p = data.findBy(prop, it.pid)
                if p
                    p.children = [] if not p.children
                    p.children.push(it)
                    data.splice _i--, 1
                    _len--

    findByType: (items, type)->
        it for it in items when it instanceof type

    resPath: ->
        str = [cf.rPath + cf.resFolder + cf.code]
        str.push it for it in arguments when _.isString it
        str.join('/')

    rPath: ->
        str = [cf.rPath]
        str.push it for it in arguments when _.isString it
        str.join('/')
#        cf.rPath + folder + '/' + name

#    userPicPath: (func = 'avatar', id)->
#        res = "#{func}_"
#        if _.isString(id)
#            res += "#{id.split('__')[0]}.jpg"
#        else
#            res += "#{id}.jpg"
#        util.resPath(res)

    rootsPath: ()->
        s = ''
        for it in arguments
            s += '/' + it
        cf.resPrefix + s.substring(1)

    html5Check: ->
        return if W.Worker is "undefined" then false else true

    serializeObj: (form)->
        o = {}
        for it in $(form).serializeArray()
            if o[it.name]
                unless o[it.name].push
                    o[it.name] = [o[it.name]]
                o[it.name].push it.value
            else o[it.name] = it.value if it.value.length > 0
        o

    sTop: (pos = 'body', offset = 0, time = 0) ->
        pz = $(pos).scrollTop() - offset
        if pz > 0
            $("body").animate(scrollTop: offset, time)

    isInView: (t)->
        de = document.documentElement
        top = $('body').scrollTop()
        bottom = top + de.clientHeight
        left = $('body').scrollLeft()
        right = left + de.clientWidth
        x = t[0].getBoundingClientRect().left + left
        y = t[0].getBoundingClientRect().top + top
        return true if left <= x <= right and top <= y <= bottom and t.is(':visible')
        return false

    loadPic: ()->
        for it in $('div.markImg[src]')
            return if cf.index is 'console'
            t = $(it).empty()
            opt = {}
            if t.attr('pop')
                opt.style = "cursor: pointer"
                opt.onclick = "app.showPic('#{t.attr('src')}')"
            if util.isInView(t)
                util.loadImg(t, t.attr('src'), t.attr('def'), opt)
                t.removeAttr('src')
                t.removeAttr('def')

    loadImg: (box, href, isDef = false, opt, id, callback)->
        img = new Image()
        $(img).load(->
            $(this).hide()
            box.empty().css("background", "").append $(this)
            $(this).fadeIn()
            #            if opt.slide is 'true' and $(this).height() > box.height() * 1.3 or $(this).width() > box.width() * 1.3
            #                opt.onmouseover = 'app.showWhole(this)'
            #                $(this).css
            #                    left: '0'
            #                    top: '0'
            #                    position: 'absolute'
            $(this).attr 'pop', opt.pop if opt.pop
            callback() if callback
        ).on('error', ->
            suff = href.split('?')[1]
            if suff
                dImg = new Image()
                $(dImg).load(->
                    box.css("background", "").append $(this).addClass(box.attr("cls"))
                ).attr "src", "http://placehold.it/" + suff
            if box.attr('empty')
                box.remove()
        ).addClass('img-responsive').attr "src", href

    loadCurImg: (id)->
        pic = cf._cImg.find(id)
        util.loadImg($('#' + id), pic.href, pic.isDef, pic.opt)
        cf._cImg.del(id)

    propRef: (it, prop)->
        if it[prop] then it[prop] + '.html' else null

    packParams: (arr, fm, opt)->
        o = {}
        for it in arr
            if it.name.indexOf('::') > 0
                a = it.name.split('::')
                o[a[0]] = {} unless o[a[0]]
                if o[a[0]][a[1]]
                    o[a[0]][a[1]] += '<br/>' + it.value
                else
                    o[a[0]][a[1]] = it.value
                arr.splice _i--, 1
                _len--
        for it of o
            arr.push
                name: it
                value: JSON.stringify o[it]

    pImg: (it, func = 'head')->
        if _.isString it.refFile
            it.refFile = JSON.parse(it.refFile)
        if it.refFile and it.refFile[func]
            it.refFile[func][0]

    img: (name, cls, pop = false)->
        """<div id="#{util.randomChar(4)}" class="markImg #{cls}" src="#{util.resPath()}/#{name}" pop="#{pop}" style="background:url(#{util.resPath()}/img/loading-bk.gif) no-repeat 50% 50%"></div>"""

    tStr:(o)->
        if _.isObject o
            JSON.stringify o
        else
            o

    pStr: (it, p)->
        if it and it[p] is null
            it[p] = {}
        else if it and _.isString(it[p]) and it[p].length > 1
            try
                it[p] = JSON.parse(it[p])
            catch e
                log 'parse JSON str error'
                log it
                log p
                log e
        else
            it[p]
        it[p]

    langPath: ->
        if cf.community.getDefLang is cf.lang then '/' else ('/' + cf.lang + '/')

    iClass: (val, cls)->
        "#{cf.style.iconStr} #{cf.style.iconStr}-#{val} #{cls || ''}"

    icon: (p, cls, tag)->
        """<#{tag||'i'} class="#{util.iClass(p,cls)}"></#{tag||'i'}>"""

#    oToA: (obj, key = 'id', val = 'title')->
#        d = []
#        for it of obj
#            o = {}
#            o[key] = it
#            o[val] = obj[it]
#            d.push o
#        d

    rId: (str) ->
        return str.substr(1)  if str.charAt(0) is "#"
        str

    getTargetId: (event) ->
        return null  unless event
        return event  if typeof event is "string" or typeof event is "number"
        t = $(event.currentTarget).attr("id")
        (if t then t.substr(t.indexOf('-') + 1) else null)

    getIframeElem: (id, str) ->
        $(id).contents().find str

    initCenter: (fun) ->
        fun()
        $(window).resize ->
            fun()

    restUrl: (str) ->
        cf.rsPre + str

    actUrl: (entity, action, param) ->
        url = cf.actPre + entity
        if action
            url += '/' + action
        if param
            url += '/' + param
        url

    pageUrl: (it)->
#        "#{cf.community.url}#{util.langPath()}page/#{it.class.toLowerCase()}-#{it.id}.html"
        "/#{it._entity}/#{it.id}"

    uri: (e, it, lang = util.langPath(), full = true)->
        if full
            "#{cf.community.url}#{lang}page/#{e}-#{it.id}.html"
        else
            "#{lang}page-#{it.id}.html"

    navUrl: (p)->
        return '#' unless p
        if arguments[0].charAt(0) is '#'
            k = arguments[0]
        else
            k = "#!"
            for it in arguments
                if _.isString(it) or _.isNumber(it)
                    k += '/' + it
        k

    layout2C: (tag, type, noRow)->
        ru = ['col-lg-', 'col-md-', 'col-sm-', 'col-xs-']
        if !noRow
            tag.addClass('row')
        for e in type.split(',')
            ee = e.split('-')
            cs = ''
            for d in ee[1].split(':')
                cs += ru[_j] + d + ' '
            tag.append """<div id="#{ee[0]}" class="#{cs}"></div>"""


    setLoading: (e)->
        e.css "background", "url(#{cf.rPath}/img/loading-bk.gif) no-repeat 50% 50%"

    stopLoading: (e)->
        e.css "background", ""

    BForm: (opt)->
        fm = $('<form/>').attr('action', opt.action).attr('target', opt.target)
        for it of opt.data
            fm.append util.addHidden(it, opt.data[it])
        $('#connect').append(fm)
        fm

    getIFrame: (id, src, width, height) ->
        $("<iframe></iframe>")
        .addClass("ifr-map")
        .attr("id", id)
        .attr("src", src + "?" + (if W.cf.mode then randomChar(2) else W.cf.ver))
        .attr("width", (if width then width else "100%"))
        .attr("height", (if height then height else "100%"))
        .attr "frameborder", 0

    layout2C: (tag, type, noRow)->
        ru = ['col-lg-', 'col-md-', 'col-sm-', 'col-xs-']
        if !noRow
            tag.addClass('row')
        for e in type.split(',')
            ee = e.split('-')
            cs = ''
            for d in ee[1].split(':')
                cs += ru[_j] + d + ' '
            tag.append """<div id="#{ee[0]}" class="#{cs}"></div>"""

#    b3Input: (tag, id, name) ->
#        tag = $(tag)
#        name and tag.is('input') and tag.attr('name', name)
#        id and tag.attr('id', id)
#
#        if tag.is('div')
#            tag.addClass('form-controls')
#        else
#            tag.addClass('form-control')
#        tag

    addHidden: (name, value, id) ->
        """<input #{if id then 'id="'+id+'"' else ''} type="hidden" name="#{name}" value="#{value}"/>"""

    updateHidden: (form, name, value) ->
        h = form.find "input[name=#{name}]"
        if h.length > 0
            h.val value
        else
            form.append util.addHidden(name, value)

    genBtn: (cfg, it)->
        return unless cfg
        if cfg.btn
            tag = $('<button type="button"/>')
        else
            tag = $("<a/>")
        tag.addClass cfg.key
        cfg.href and tag.attr 'href', cfg.href
        cfg.id and tag.attr 'id', util.randomChar(4) + '-' + it?.id
        cfg.label and tag.text cfg.label
        cfg.title and tag.attr 'title', cfg.title
        if cfg.attr
            for k,v of cfg.attr
                tag.attr k, v
        cfg.cls and tag.addClass cfg.cls
        if cfg.icon
            if cfg.icon.startsWith '<'
                icon = cfg.icon
            else
                icon = util.icon(cfg.icon)
            tag[cfg.iconPlace || 'prepend'] icon
        cfg.callback?(tag)
        if cfg.action # event for larger tag
            tag.on(cfg.action.type || 'click', cfg.action.fun)
        tag

#    genViewItem: (it, k, v, entity, meta)->
#        text = if v.val then v.val(it) else util.seqProp(it, k)
#        switch v.type
#            when "ckb"
#                """<input class='ckb' type="checkbox" id="ckb-#{it.id}">"""
#            when "img"
#                """<img src="#{text}" width='#{v.width}'>"""
#            when "email"
#                """<a href="mailto:#{it[v.type]}">#{text}</a>"""
##            when "del"
##                """<a href="#{util.navUrl(@entity,v.type,it.id)}">#{text}</a>"""
#            when "view","edit"
#                k = 'data/' + v.type
#                """<a href="#{util.navUrl(k,entity,it.id)}">#{text}</a>"""
#            when "view"
#                """<a href="#{util.langPath()}page/#{entity}-#{it.id}.html" target='_blank'>#{text}</a>"""
#            when "link"
#                """<a href="#{v.href}" class="#{v.cls}">#{text}</a>"""
#            when "status"
#                m = cf.st["#{entity}_#{k}_hash"]
#                if m
#                    m[text]
#                else
#                    text
#            when 'input'
#                v.opt.val = text
#                util.genInput(v.opt)
#            when 'money'
#                if text
#                    (+text || 0).formatMoney(2)
#            when 'map'
#                v.__map || (v.__map = _.result cf.meta.elem(cf.meta[entity], k), 'data')
#                v.__map[text]
#            when "date"
#                util.prettyDate(text, v.pt, v.tr)
#            when "show", "modify"
#                cf._link(null, text, null, 'show', @entity + '-' + it.id)
#            else
#                if v.converter
#                    v.converter(text, it)
#                else
#                    text

#    genInput: (it)->
#        if it.view
#            text = it.val
#            if it.name is 'status'
#                text = cf.st.text(it.form.entity, it.val)
##            else if it.type is 'radio'
##                text = it.showText()
#            else if it.type in ['select','radio']
#                if it.showText
#                    text = it.showText(it.val)
#                else if +it.val
#                    if it.data
#                        text = _.result(it, 'data')[+it.val]
#            else if it.type is 'custom'
#                text = it.content(it)
#            inp = $("<div class='form-control-static'>#{text}</div>")
#            it.cls = it.type
#        else
#            switch it.type
#                when 'text','file','url','password','email','number','range','tel', 'texteara','search','datetime','date'
#                    inp = $('<input/>')
#                    inp.attr "type", it.type
#                    it.val? and inp.attr 'value', it.val
#                when 'textarea'
#                    inp = $('<textarea></textarea>')
#                    it.rows and inp.attr 'rows', it.rows
#                    it.val and inp.text (if _.isObject it.val then JSON.stringify it.val else it.val)
#                when 'select'
#                    inp = $("<select value='#{it.val}'></select>")
#                    id = util.randomChar(5)
#                    inp.attr 'id', id
#                    if it.data
#                        d = _.result(it, 'data')
#                        inp.append util.genOptionItem(d,it.keyVal)
#                        inp.data 'sdata', d
#                    else if it.entity
#                        it.url || (it.url = util.restUrl(it.entity))
#                        opt = $.extend _.result(it, 'criteria'),
#                            _attrs: it._attrs || it.keyVal
#                        $.get it.url, opt, (res)->
#                            return if res.count is 0
#                            inp = $('#' + id,if it.form then it.form.$el else 'body')
#                            d = res.entities
#                            if it.parse
#                                d = it.parse d
#                            inp.append util.genOptionItem d, it.keyVal
#                            it.val and inp.children("option[value='#{it.val}']").attr('selected', true)
#                            if it.addBtn
#                                inp.append "<label><a class='new'>#{iim('add')}</a></label>"
#                            inp.data 'sdata',d
#                    if it.title
#                        inp.prepend "<option value='0'>#{it.title}</option>"
#                    it.val and inp.children("option[value='#{it.val}']").attr('selected', true)
#
#                when 'checkbox','radio'
#                #alert it.val
#                    inp = $('<div class="radioBox"></div>')
#                    id = util.randomChar(5)
#                    inp.attr 'id', id
#                    if it.keyVal
#                        [k,v] = it.keyVal.split(',')
#                    else
#                        k = 'val'
#                        v = 'label'
#                    if it.data
#                        inp.append util.genCheckItem _.result(it, 'data'), it.name, it.type, k, v, it.val
#                    else if it.entity
#                        it.url || (it.url = util.restUrl(it.entity))
#                        opt = $.extend it.criteria,
#                            _attrs: it.keyVal
#                        $.get it.url, opt, (res)->
#                            inp = $('#' + id)
#                            inp.append util.genCheckItem res.entities, it.name, it.type, k, v, it.val
#                            if it.addBtn
#                                btn = $("<label class='checkbox-inline'><a class='new'>#{iim('add')}</a></label>").click (e)->
#                                    new _sForm
#                                        entity: it.entity
#                                        mode: 'modal'
#                                        items: ['code', 'label', 'description']
#                                        data:
#                                            type: 'commodity'
#                                        _saveSuccess: (model, res)=>
#                                            $('#' + id).children().append util.genCheckItem [res.entity], it.name, it.type, k, v, it.val
#                                            model.view.$el.modal("hide")
#                                inp.children('div').append btn
#
##                when 'status'
##                    inp = $('<button></button>')
##                    inp.attr "type", it.type
##                when 'button'
##                    inp = $('<button></button>')
##                    inp.attr "type", it.type
##                when 'button'
##                    inp = $('<button></button>')
##                    inp.attr "type", it.type
#                when 'view','label'
#                    inp = $("<label class='form-control-static'>#{it.val}</label>")
#                when 'holder'
#                    inp = $('<div class="holder"></div>')
#                when 'custom'
#                    inp = it.content(it)
#        if it.events
#            inp.on(k, _.bind(v, it.form)) for k,v of it.events
#
#        if ['text', 'url', 'password', 'email', 'number', 'range', 'tel', 'select', 'textarea','datetime','date'].has it.type
#            it.ph and inp.attr "placeholder", ii(it.ph) || it.ph
#            inp.attr 'name', it.name
#            it.readonly and inp.attr 'readOnly', true
#            inp.addClass it.cls || cf.style.inputClass
#
#        it.id and inp.attr 'id', it.id
#        it.cls and inp.addClass(it.cls)
#        inp
#
#    genOptionItem: (data, kv) ->
#        if kv
#            [k,v] = kv.split(',')
#        else
#            k = 'val'
#            v = 'label'
#        if _.isArray data
#            for d in data
#                if _.isString d
#                    "<option value='#{d}'>#{d}</option>"
#                else
#                    "<option value='#{d[k]}'>#{d[v]}</option>"
#        else
#            "<option value='#{k}'>#{v}</option>" for k,v of data
#
#
#    genCheckItem: (data, name, type = 'checkbox', k, v, val = '')->
#        val = val.toString().split(',')
#        res = $('<div/>')
#
#        if !_.isArray data
#            data = (for kk,vv of data
#                rs = {}
#                rs[k] = kk
#                rs[v] = vv
#                rs)
#        for d in data
#            if _.isString d
#                ck = d
#                cv = d
#            else
#                ck = d[v]
#                cv = d[k]
#
#            p = $("<label class='checkbox-inline'></label>")
#            i = $("<input type='#{type}' name='#{name}' value='#{cv}'/>")
#            if val.has(cv) or d.selected
#                i.attr 'checked', true
#            p.append i
#            p.append ck
#            res.append p
#        res

#    genResItem: (it) ->
#        if it.type is "img"
#            """<img class="img-responsive img-thumbnail"  src="#{it.path}?#{util.randomChar(2)}" title="#{it.title||''} #{it.username||''} #{it.dateCreated||''}">"""
#        else if it.type is "doc"
#            """#{util.icon('file')}<a target="_blank" href="#{it.path}">#{it.fName}<span class="float-right timestamp">#{it.username||''} #{it.dateCreated||''}</span>"""
#        else if it.type is "audio"
#            if util.html5Check()
#                """<audio controls=""><source src="#{it.path}"/></audio>"""
#            else
#                "<div>#{it.path}</div>"
#        else if it.type is "video"
#            if util.html5Check()
#                """<video controls="controls"><source src="#{it.path}"/></video>"""
#            else
#                "<li><div>#{it.path}</div></li>"

#    addOptions: (t, data, iv)->
#        if iv isnt null
#            t.append """<option value="0">#{iv || ''}</option>"""
#        if data and $.isArray data
#            for v in data
#                if v.code
#                    msg = ii('cat.' + v.type)
#                    t.append """<option value="#{v.code}">#{if msg[v.code] then msg[v.code] else v.code}</option>"""
#                else if v.id
#                    t.append """<option value="#{v.id}">#{v.code || v.label || v.username || v.title}</option>"""
#                else
#                    t.append """<option value="#{v}">#{v}</option>"""
#        else if typeof data is 'object'
#            t.append """<option value="#{k}">#{v}</option>""" for k,v of data

    now: ->
        new Date().getTime()

    crumb: (items, single = false, ctn = $('#crumb'))->
        if single
            la = ctn.find('li:last-child')
            la.html "<a href='#'>#{la.text()}</a>"
        else
            d = [
                icon: 'home'
                label: '首页'
                href: '/index.html'
            ]
            ctn.html $('<ul class="breadcrumb"/>').append(cf.tmpl.lia(d))

        ctn.children('ul').append cf.tmpl.lia(items)

    layout: (cols)->
        str = ''
        str += "<div id='#{k}' class='#{v}'></div>" for k,v of cols
        str

    weekDay: (date)->
        iCat('w')[util.parseLocalDate(date).getDay()]

    resetSelect: ->
        nua = navigator.userAgent
        isAndroid = (nua.indexOf("Mozilla/5.0") > -1 and nua.indexOf("Android ") > -1 and nua.indexOf("AppleWebKit") > -1 and nua.indexOf("Chrome") is -1)
        $("select.form-control").removeClass("form-control").css "width", "100%"  if isAndroid

    initScroll: (ctx, num) ->
        for s in $('.scrollBox', ctx || 'body')
            s = $(s)
            if !num or s.children().length > num
                s.wrapInner('<div class="viewport" style="height: ' + s.height() + 'px"><div class="overview"></div></div>')
                s.prepend('<div class="scrollbar"><div class="track"><div class="thumb"><div class="end"></div></div></div></div>')
                s.addClass('scrollBox')
                require [
                    cf.rPath + "js/jquery.tinyscrollbar.js"
                ], ->
                    s.tinyscrollbar()
                    if s.children('.scrollbar').height() > 0
                        s.mouseleave(=> s.find('.track').fadeOut(400)).mouseenter(=> s.find('.track').fadeIn(200))

    isWechat:->
        ua = navigator.userAgent.toLowerCase()
        res = ua.match(/MicroMessenger/i)
        if res and res[0] is "micromessenger"
            return true
        else
            return false
