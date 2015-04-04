module.exports =
    crumb: (m, text)->
        str = """<div id="crumb"><ul class="breadcrumb"><li>${icon('home')} <a href="/index.html">首页</a></li>"""
#        for k,v of m

    b3Menu: (res)->
        str = ''

    resPath: (code, path)->
        _resPath + 'upload/' + code + '/' + path

    crumbItem: (items)->
        [
            label: '首页'
            href: '/'
        ].concat items