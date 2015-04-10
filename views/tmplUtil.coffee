util = {}

_.extend util,

    userLink: ->


    icon: (icon, tag = 'i', str = '', cls = '')->
        "<#{tag} class='glyphicon glyphicon-#{icon} #{cls}'>#{str}</#{tag}>"

    imgItem: (it, code, name = 'head')->
        if it.refFile and it.refFile[name]
            path = it.refFile[name][0]
        else
            path = ''
        util.img util.resPath(code, path)

    img: (path, cls = 'markImg', pop = false)->
        id = String.randomChar(4)
        """<div id="#{id}" class="#{cls}" src="#{path}" pop="#{pop}"
        style="background:url(#{_resPath}/img/loading-bk.gif) no-repeat 50% 50%">loading...</div>"""

    link: (name, it, prop = 'title', cls)->
        text = if prop is '_str'
            it
        else
            it[prop]
        "<a href='/#{name}/#{it._id}' title='#{text}' class='#{cls || ''}'>#{text}</a>"

    href: (name, id)->
        "/#{name}/#{id}"

    resPath: (code, path)->
        _resPath + 'upload/' + code + '/' + path

    navPage: (code, it)->
        "/sight/#{it._id}"

    crumbItem: (items)->
        [
            label: '首页'
            href: '/'
        ].concat items

    copyRight: (c, name, id)->
        path = "http://#{c.url}/#{name}/#{id}"
        """
        <div class="copyright"><strong>C</strong><div>
            <p>除非特别声明，本站文章均为#{c.title}原创文章，转载请注明原文链接</p>
            <p>原文地址：<a href="#{path}">#{path}</a></p>
        </div></div>
        """

module.exports = util