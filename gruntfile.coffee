module.exports = (grunt)->
    ftp = '113.11.197.232'

    _remote = '/opt/node/'

    _local = __dirname

    backFiles = (nstr)->
        for it in nstr.split(',')
            expand: true
            cwd: it
            src: ['*.js', '*.json']
            dest: _remote + "#{if it is './' then '' else it}"

    require("load-grunt-config") grunt

    grunt.registerTask 'default', ->
        grunt.initConfig {}

    grunt.registerTask 'su', ->
        grunt.config.init
            ftpscript:
                server:
                    options:
                        host: ftp
                #port: port
                    files: backFiles './,views,routes,model,i18n,controller,bin'

        grunt.task.run "ftpscript:server"
