define [
    'handlebars'
    '/lib/util/base.js'
], (Handlebars)->
    Handlebars.registerHelper 'p', (obj, str, opt)->
        util.setSeqProp(obj,str)

    Handlebars.registerHelper 'n', (n, opt)->
        cf.tmpl[n](opt)

    Handlebars.registerHelper 'm', (n)->
        (+n || 0).formatMoney()

    Handlebars.registerHelper 'st', (n, e)->
        cf.st["#{e}_status_hash"][+n]

    Handlebars.registerHelper 'd', (n, p)->
        if n
            p = 'yyyy-MM-dd HH:mm:ss' if _.isObject p
            util.parseLocalDate(n).pattern p

    Handlebars.registerHelper 'or', (i, n)->
        i || n

    Handlebars.registerHelper 'i', (opt)->
        iin(opt)
    Handlebars.registerHelper 'iCat', (k,v)->
        iCat(k)[v]

    Handlebars.registerHelper 'ie', (e, o)->
        ii(e + '.' + o) || iin(o)

    Handlebars.registerHelper 'navUrl', ()->
        util.navUrl.apply @, arguments

    Handlebars.registerHelper 'pageUrl', (it)->
        util.pageUrl it

    Handlebars.registerHelper 'resPath', ()->
        util.resPath.apply @, arguments

    Handlebars.registerHelper 'rPath', ()->
        util.rPath.apply @, arguments

    Handlebars.registerHelper 'refFile', (obj,name)->
        util.pStr obj, 'refFile'
        if obj.refFile[name]
            util.resPath obj.refFile[name][0]

    Handlebars.registerHelper 'loadUserImg', (obj)->
        img = util.resPath "portrait-#{obj.id}.jpg"
        "<div id='#{util.randomChar(4)}' class='markImg' src='#{img}'></div>"

    Handlebars.registerHelper 'loadImg', (obj,name)->
        if obj.refFile[name]
            img = util.resPath obj.refFile[name][0]
        "<div id='#{util.randomChar(4)}' class='markImg' src='#{img}'></div>"

    Handlebars.registerHelper 'icon', (e = '', a)->
        tag = a || 'i'
        [c1,c2] = e.split('.')
        new Handlebars.SafeString "<#{tag} class='#{util.iClass(c1, c2)}'></#{tag}>"

    audaciousFn = null
    Handlebars.registerHelper 'rec', (children, options)->
        out = ''
        if options.fn
            audaciousFn = options.fn
        #        if children && children.forEach
        children.forEach (child)->
            out = out + audaciousFn(child)
        out

    Handlebars.registerHelper 'listen', (name, ctx, options)->
        id = util.randomChar 4
        ctx.listenTo ctx.collection, name, =>
            $('#' + id).html options.fn(this)
        "<span id='#{id}'>#{options.fn(this)}</span>"

    Handlebars.registerHelper 'collection', (item, tag, opt)->
        [tag,cls] = tag.split('.')
        out = "<#{tag} class='#{cls || ''}'>"
        for it in item
            out += opt.fn(it)
        out += "</#{tag}>"
        out

    Handlebars.registerHelper 'input', (it)->
        new Handlebars.SafeString(util.genInput(it)[0].outerHTML)

#    Handlebars.registerHelper 'showStatus', (status)->
#        out = ""
#        for it in cf.st.project_status
#            ac = ''
#            if it.q
#                if it.v <= status
#                    ac = 'active'
#                out += "<div class='status #{ac}'>#{it.q}</div><i class='glyphicon glyphicon-chevron-right'></i>"
#        log out
#        out


    Handlebars.registerHelper "cp", (lvalue, operator, rvalue, options) ->
        throw new Error("Handlerbars Helper 'compare' needs 2 parameters")  if arguments.length < 3
        #        operator = options.hash.operator or "=="
        operators =
            "==": (l, r) ->
                l is r

            "!=": (l, r) ->
                l isnt r

            "<": (l, r) ->
                l < r

            ">": (l, r) ->
                l > r

            "<=": (l, r) ->
                l <= r

            ">=": (l, r) ->
                l >= r

            typeof: (l, r) ->
                typeof l is r

        throw new Error("Handlerbars Helper 'compare' doesn't know the operator " + operator)  unless operators[operator]
        result = operators[operator](lvalue, rvalue)
        if result
            options.fn this
        else
            options.inverse this
