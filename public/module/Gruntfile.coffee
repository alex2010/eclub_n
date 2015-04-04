module.exports = (grunt)->
#    m = 'hepa'
#	 m = 'admin'
#    m = 'gwsport'
#    m = 'anchoret'
    m = 'after'
#    m = 'upup/geVote'
#    m = 'upup/scarf'
#    m = 'upup'

#    m = 'house'
    dm = 'encorner.org'
    ftp = '113.11.197.232'
    dest = '/usr/local/tomcat/apache-tomcat-7.0.29/webapps'

#    m = 'hailai'
#    dm = 'hailaihui.com'
#    ftp = '119.254.110.21'
#    dest = '/home/app/apache-tomcat-7.0.55/webapps'

    _url = "http://#{dm}/"
    _rres = "http://s.#{dm}/"
    _remote = "/opt/s.#{dm}/"
    _dest = _remote + 'module/'
    _remoteRes = _remote + 'res/'
    _dir = m + '/src/'
    _tmp = m + '/tmp/'
    _script = _dir
    _style = _dir + 'pc/'
    _view = _dir + 'view/'
    _tmpl = m + '/tmpl/'
    _dist = m + '/lib/'
    _lib = '../lib/'
    _admin = _lib + 'admin/'
    _res = '../res/'

    #grunt.log.write(require("#{__dirname}/rfg").cfg(m, 'admin').paths.hbs)

    require("load-grunt-config") grunt
    #    m = grunt.task.current.args[0]
    #    grunt.initConfig
    #        less:
    #            development:
    #                files: [
    #                    expand: true
    #                    cwd: _style
    #                    src: ['css.less']
    #                    dest: _dist
    #                    ext: '.css'
    #                ,
    #                    expand: true
    #                    cwd: '../lib/admin/style'
    #                    src: ['admin.less']
    #                    dest: '../res/css'
    #                    ext: '.css'
    #                ]

    grunt.registerTask 'default', ->
        grunt.initConfig
            connect:
                development:
                    options:
                        hostname: 'localhost'
                        port: '80816'
                        open: 'http://localhost:8080/module/' + m + '/index.html'
            watch:
                options:
                    livereload: true
                    debounceDelay: 0
                    interval: 20

                scripts:
                    files: [
                            _lib + '**/*.{js,css,hbs}' #,coffee
                            _script + '**/*.{js}'#,coffee
                            _tmpl + '**/*.html'
                            _view + '**/*.{hbs,handlebars}'
                            _dir + 'require-config.js'
                    ]
        #				other: # images, fonts change? livereload browser
        #					files: [
        #						'public/**/*'
        #					]

        grunt.task.run "connect"
        grunt.task.run 'watch'

    cssProcess = (content, srcPath)->
        content = content.replace(/..\/..\/..\/res\//g, _rres)
        content = content.replace(/\/res\//g, _rres)
        content

    grunt.registerTask 'p', ->
        grunt.config.init
            clean:
                all: [m + '/lib/*']
            copy:
#                src:
#                    expand: true
#                    cwd: m + '/src'
#                    src: ['**/*.js', '**/*.hbs']
#                    dest: m + '/tmp'
#                    options:
#                        process: (content, srcPath)->
#                            if srcPath.indexOf('.js') > 0
#                                content.replace(/\/module\/\w+\/src/g, '.')
#                            else
#                                content
#                lib:
#                    expand: true
#                    cwd: '../lib/'
#                    src: ['**/*.js', '**/*.hbs']
#                    dest: m + '/tmp/lib'
                cleanAdmin:
                    expand: true
                    cwd: _res + 'css'
                    src: ['admin.css']
                    dest: _res + 'css'
                    options:
                        process: cssProcess
                cleanCss:
                    expand: true
                    cwd: m + '/lib'
                    src: ['*.css']
                    dest: m + '/lib'
                    options:
                        process: cssProcess

            cssmin:
                combine:
                    options:
                        keepSpecialComments: 0
                    files: [
                        expand: true
                        cwd: _dir + 'pc'
                        src: ['css.css']
                        dest: m + '/lib'
                        ext: '.css'
                    ,
                        expand: true
                        cwd: _dir + 'pc'
                        src: ['wechat.css']
                        dest: m + '/lib'
                        ext: '.css'
                    ,
                        expand: true
                        cwd: _admin + 'style'
                        src: ['admin.css']
                        dest: _res + 'css'
                        ext: '.css'
#                    ,
#                        expand: true
#                        cwd: _dir + 'pc'
#                        src: ['geVote.css']
#                        dest: m + '/lib'
#                        ext: '.css'
                    ]
            requirejs:
                main:
                    options: require("#{__dirname}/rfg").cfg(m, 'main')

                admin:
                    options: require("#{__dirname}/rfg").cfg(m, 'admin')

                account:
                    options: require("#{__dirname}/rfg").cfg(m, 'account')

                wechat:
                    options: require("#{__dirname}/rfg").cfg(m, 'wechat')

#                geVote:
#                    options: require("#{__dirname}/rfg").cfg(m, '../geVote/src/geVote')

            connect:
                admin:
                    options:
                        hostname: 'localhost'
                        port: '180818'
                        open: 'http://localhost:8080/module/' + m + '/console.html?mode=prod'

                console:
                    options:
                        hostname: 'localhost'
                        port: '180819'
                        open: _url + 'a/console'

            ftpscript:
                admin:
                    options:
                        host: ftp
#                        port:'10021'
                    files: [
                        expand: true
                        cwd: _res + 'css'
                        src: ['admin.css']
                        dest: _remoteRes + 'css'
                    ,
                        expand: true
                        cwd: _dist
                        src: ['*.js', '*.css']
                        dest: _dest + m + '/lib'
                    ,
                        expand: true
                        cwd: _tmpl
                        src: ['**/*.html']
                        dest: _dest + m + '/tmpl'
#                    ,
#                        expand: true
#                        cwd: m
#                        src: ['console.html']
#                        dest: _dest + m
                    ,
                        expand: true
                        cwd: m + '/_script'
                        src: ['**/*.groovy']
                        dest: _dest + m + '/_script'
                    ,
                        expand: true
                        cwd: ''
                        src: ['version.json']
                        dest: _dest
                    ,
                        expand: true
                        cwd: m + '/src/role'
                        src: ['*.js']
                        dest: _dest + m + '/src/role'
                    ,
                        expand: true
                        cwd: m + '/src/i18n'
                        src: ['*.coffee']
                        dest: _dest + m + '/src/i18n'
                    ,
                        expand: true
                        cwd: _lib + 'i18n'
                        src: ['**/*.coffee']
                        dest: _remote + 'lib/i18n'
                    ]

        #update version
        fn = 'version.json'
        v = grunt.file.readJSON(fn)
#        grunt.log.write(v)
        vv = v.version.split('.')
        vv[vv.length - 1] = ++vv[vv.length - 1]
        v.version = vv.join('.')
        grunt.file.write(fn, JSON.stringify(v))

        grunt.task.run 'clean'
#        grunt.task.run 'copy:src'
#        grunt.task.run 'copy:lib'
        grunt.task.run "cssmin"
        grunt.task.run "copy:cleanAdmin"
        grunt.task.run "copy:cleanCss"

        if grunt.file.exists("#{__dirname}/#{_dir}main.js")
            grunt.task.run "requirejs:main"

        grunt.task.run "requirejs:admin"

        if grunt.file.exists("#{__dirname}/#{_dir}geVote.js")
            grunt.task.run "requirejs:geVote"


        if grunt.file.exists("#{__dirname}/#{_dir}account.js")
#            grunt.log.write("!!account.js")
            grunt.task.run "requirejs:account"

        if grunt.file.exists("#{__dirname}/#{_dir}wechat.js")
            grunt.task.run "requirejs:wechat"

#        grunt.task.run "connect:admin"
#        grunt.task.run "connect:console"
        grunt.task.run "ftpscript:admin"

    #upload the war
    grunt.registerTask 'war', ->
        grunt.config.init
            ftpscript:
                war:
                    options:
                        host: ftp
#                        port:'10021'
                    files: [
                        expand: true
                        cwd: '../../target'
                        src: ['ROOT.war']
                        dest: dest
                    ]
            connect:
                tomcat:
                    options:
                        hostname: 'localhost'
                        port: '80818'
                        open: "http://#{dm}/manager/html"

        grunt.task.run "ftpscript:war"
        grunt.task.run "connect:tomcat"


#    grunt.registerTask 'cust', ->
#        grunt.config.init
#            ftpscript:
#                cust:
#                    options:
#                        host: '113.11.197.232'
#                    files: [
#                        expand: true
#                        cwd: m + 'admin/i18n'
#                        src: ['*.js']
#                        dest: '/opt/s.encorner.org/module/anchoret/lib/admin/i18n'
#                    ]
#        grunt.task.run "ftpscript:war"

#ctx.resService.initSite('house','partner','zh')
#ctx.resService.initSite('house','manager','zh')
#ctx.resService.initSite('house','admin','zh')
