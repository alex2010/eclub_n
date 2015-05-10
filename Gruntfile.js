// Generated by CoffeeScript 1.9.2
module.exports = function(grunt) {
  var _local, _remote, _remoteRes, backFiles, cssProcess, dm, ftp;
  dm = 'wikibeijing.com';
  ftp = '45.33.59.69';
  _remote = '/opt/node/';
  _remoteRes = '/opt/node/public/res/';
  _local = __dirname;
  backFiles = function(nstr) {
    var i, it, len, ref, res;
    res = [];
    ref = nstr.split(',');
    for (i = 0, len = ref.length; i < len; i++) {
      it = ref[i];
      res.push({
        expand: true,
        cwd: it,
        src: ['*.js', '*.json', '*.jade', 'inc/*.jade'],
        dest: _remote + ("" + (it === './' ? '' : it))
      });
    }
    return res;
  };
  require("load-grunt-config")(grunt);
  grunt.registerTask('default', function() {
    return grunt.initConfig({});
  });
  grunt.registerTask('bk', function(code) {
    var bStr;
    bStr = code ? "public/module/" + code + "/tmpl,public/module/" + code + ",public/module/" + code + "/data,public/module/" + code + "/src/i18n" : "./,views,routes,ext,model,i18n,controller,bin";
    grunt.config.init({
      ftpscript: {
        server: {
          options: {
            host: ftp,
            auth: {
              username: 'root',
              password: 'rock200*'
            }
          },
          files: backFiles(bStr)
        }
      }
    });
    return grunt.task.run("ftpscript:server");
  });
  cssProcess = function(content, srcPath) {
    var _rres;
    _rres = "http://s." + dm + "/";
    content = content.replace(/..\/..\/..\/res\//g, _rres);
    content = content.replace(/\/res\//g, _rres);
    return content;
  };
  return grunt.registerTask('ft', function(code) {
    var _admin, _module, _remoteResSub, _res, _resSub, m;
    _module = __dirname + "/public/module/";
    _res = "public/res/";
    _resSub = _res + "upload/" + code + "/lib";
    _remoteResSub = _remoteRes + "upload/" + code + "/lib";
    _admin = "public/lib/admin/";
    m = (_module + code) + "/src/";
    grunt.log.write(require(_module + "rfg.js").cfg(code, 'main').out);
    grunt.config.init({
      clean: {
        all: [m + '/lib/*']
      },
      copy: {
        cleanCss: {
          expand: true,
          cwd: _resSub,
          src: ['*.css'],
          dest: _resSub,
          options: {
            process: cssProcess
          }
        }
      },
      cssmin: {
        combine: {
          options: {
            keepSpecialComments: 0
          },
          files: [
            {
              expand: true,
              cwd: m + 'style',
              src: ['*.css'],
              dest: _resSub,
              ext: '.css'
            }, {
              expand: true,
              cwd: _admin + 'style',
              src: ['*.css'],
              dest: _resSub,
              ext: '.css'
            }
          ]
        }
      },
      requirejs: {
        main: {
          options: require(_module + "rfg.js").cfg(code, 'main')
        },
        admin: {
          options: require(_module + "rfg.js").cfg(code, 'admin')
        }
      },
      ftpscript: {
        admin: {
          options: {
            host: ftp
          },
          files: [
            {
              expand: true,
              cwd: _resSub,
              src: ['*.js', '*.css'],
              dest: _remoteResSub
            }
          ]
        }
      }
    });
    grunt.task.run('clean');
    grunt.task.run("cssmin");
    grunt.task.run("copy:cleanCss");
    return grunt.task.run("ftpscript:admin");
  });
};
