module.exports = (grunt)->
    dm = 'encorner.org'
    ftp = '113.11.197.232'
    _remote = '/opt/node/'
    _local = __dirname

    #    m = grunt.task.current.args[0]

    backFiles = (nstr)->
        res = []
        for it in nstr.split(',')
            res.push
                expand: true
                cwd: it
                src: ['*.js', '*.json', '*.jade','inc/*.jade']
                dest: _remote + "#{if it is './' then '' else it}"
        res
    require("load-grunt-config") grunt

    grunt.registerTask 'default', ->
        grunt.initConfig {}

    #------------------------------------------backend-------------------------------------------------
    grunt.registerTask 'bk', (code) ->
        bStr = if code
            bStr += "public/module/#{code}/tmpl,public/module/#{code}"
        else
            "./,views,routes,ext,model,i18n,controller,bin"

        grunt.config.init
            ftpscript:
                server:
                    options:
                        host: ftp #port: port
                    files: backFiles(bStr)

        grunt.task.run "ftpscript:server"

    #------------------------------------------frontend-------------------------------------------------
    cssProcess = (content, srcPath)->
        _rres = "http://s.#{dm}/"
        content = content.replace(/..\/..\/..\/res\//g, _rres)
        content = content.replace(/\/res\//g, _rres)
        content

    grunt.registerTask 'ft', (code) ->
        _module = "#{__dirname}/public/module/"
        _res = "public/res/"
        _resSub = "#{_res}upload/#{code}/lib"
        _remoteRes = "/opt/s.#{dm}/res/"
        _remoteResSub = "#{_remoteRes}upload/#{code}/lib"
        _admin = "public/lib/admin/"

        m = "#{_module + code}/src/"

        grunt.log.write(require("#{_module}rfg.js").cfg(code, 'main').out)

        grunt.config.init
            clean:
                all: [m + '/lib/*']
            copy:
                cleanAdmin:
                    expand: true
                    cwd: _res + 'css'
                    src: ['admin.css']
                    dest: _res + 'css'
                    options:
                        process: cssProcess
                cleanCss:
                    expand: true
                    cwd: _resSub
                    src: ['*.css']
                    dest: _resSub
                    options:
                        process: cssProcess
            cssmin:
                combine:
                    options:
                        keepSpecialComments: 0
                    files: [
                        expand: true
                        cwd: m + 'style'
                        src: ['css.css']
                        dest: _resSub
                        ext: '.css'
                    ,
                        expand: true
                        cwd: _admin + 'style'
                        src: ['admin.css']
                        dest: _res + 'css'
                        ext: '.css'
                    ]

            requirejs:
                main:
                    options: require("#{_module}rfg.js").cfg(code, 'main')
                admin:
                    options: require("#{_module}rfg.js").cfg(code, 'admin')
        #                account:
        #                    options: require("#{__dirname}/rfg").cfg(m, 'account')
        #                wechat:
        #                    options: require("#{__dirname}/rfg").cfg(m, 'wechat')
        #
            ftpscript:
                admin:
                    options:
                        host: ftp
                    files: [
                        expand: true
                        cwd: _res + 'css'
                        src: ['admin.css']
                        dest: _remoteRes + 'css'
                    ,
                        expand: true
                        cwd: _resSub
                        src: ['*.js', '*.css']
                        dest: _remoteResSub
#                    ,
#                        expand: true
#                        cwd: _tmpl
#                        src: ['**/*.html']
#                        dest: _dest + m + '/tmpl'
#                    ,
#                        expand: true
#                        cwd: ''
#                        src: ['version.json']
#                        dest: _dest
#                    ,
#                        expand: true
#                        cwd: m + '/src/i18n'
#                        src: ['*.coffee']
#                        dest: _dest + m + '/src/i18n'
#                    ,
#                        expand: true
#                        cwd: _lib + 'i18n'
#                        src: ['**/*.coffee']
#                        dest: _remote + 'lib/i18n'
                    ]


        #        #update version
        #        fn = 'version.json'
        #        v = grunt.file.readJSON(fn)
        #        vv = v.version.split('.')
        #        vv[vv.length - 1] = ++vv[vv.length - 1]
        #        v.version = vv.join('.')
        #        grunt.file.write(fn, JSON.stringify(v))

        grunt.task.run 'clean'
        grunt.task.run "cssmin"
        grunt.task.run "copy:cleanAdmin"
        grunt.task.run "copy:cleanCss"

        grunt.task.run "requirejs:main"
        grunt.task.run "requirejs:admin"

#        if grunt.file.exists("#{__dirname}/#{_dir}main.js")
#            grunt.task.run "requirejs:main"
#
#        grunt.task.run "requirejs:admin"
#
#        if grunt.file.exists("#{__dirname}/#{_dir}geVote.js")
#            grunt.task.run "requirejs:geVote"
#
#
#        if grunt.file.exists("#{__dirname}/#{_dir}account.js")
#            grunt.task.run "requirejs:account"
#
#        if grunt.file.exists("#{__dirname}/#{_dir}wechat.js")
#            grunt.task.run "requirejs:wechat"
#
        grunt.task.run "ftpscript:admin"