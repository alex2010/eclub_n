module.exports =
    img: (path)->
        id = randomChar(4)
        """<div id="#{id}" class="#{cls||''}" src="#{path}"
        pop="#{pop||false}" style="background:url(#{this.rPath}/img/loading-bk.gif) no-repeat 50% 50%">loading...</div>"""

    link: (name, it, cls)->
        "<a href='/#{name}/#{it.id}' title='#{it.title}' class='#{cls || ''}'>#{it.title}</a>"

    resPath: (code, path)->
        _resPath + 'upload/' + code + '/' + path

    navPage: (code, it)->
        "/sight/#{it._id}"

    crumbItem: (items)->
        [
            label: '首页'
            href: '/'
        ].concat items

