// Generated by CoffeeScript 1.7.1
module.exports = function(grunt) {
  var cssProcess, dest, dm, ftp, m, _admin, _dest, _dir, _dist, _lib, _remote, _remoteRes, _res, _rres, _script, _style, _tmp, _tmpl, _url, _view;
  m = 'after';
  dm = 'encorner.org';
  ftp = '113.11.197.232';
  dest = '/usr/local/tomcat/apache-tomcat-7.0.29/webapps';
  _url = "http://" + dm + "/";
  _rres = "http://s." + dm + "/";
  _remote = "/opt/s." + dm + "/";
  _dest = _remote + 'module/';
  _remoteRes = _remote + 'res/';
  _dir = m + '/src/';
  _tmp = m + '/tmp/';
  _script = _dir;
  _style = _dir + 'pc/';
  _view = _dir + 'view/';
  _tmpl = m + '/tmpl/';
  _dist = m + '/lib/';
  _lib = '../lib/';
  _admin = _lib + 'admin/';
  _res = '../res/';
  require("load-grunt-config")(grunt);
  grunt.registerTask('default', function() {
    grunt.initConfig({
      connect: {
        development: {
          options: {
            hostname: 'localhost',
            port: '80816',
            open: 'http://localhost:8080/module/' + m + '/index.html'
          }
        }
      },
      watch: {
        options: {
          livereload: true,
          debounceDelay: 0,
          interval: 20
        },
        scripts: {
          files: [_lib + '**/*.{js,css,hbs}', _script + '**/*.{js}', _tmpl + '**/*.html', _view + '**/*.{hbs,handlebars}', _dir + 'require-config.js']
        }
      }
    });
    grunt.task.run("connect");
    return grunt.task.run('watch');
  });
  cssProcess = function(content, srcPath) {
    content = content.replace(/..\/..\/..\/res\//g, _rres);
    content = content.replace(/\/res\//g, _rres);
    return content;
  };
  grunt.registerTask('p', function() {
    var fn, v, vv;
    grunt.config.init({
      clean: {
        all: [m + '/lib/*']
      },
      copy: {
        cleanAdmin: {
          expand: true,
          cwd: _res + 'css',
          src: ['admin.css'],
          dest: _res + 'css',
          options: {
            process: cssProcess
          }
        },
        cleanCss: {
          expand: true,
          cwd: m + '/lib',
          src: ['*.css'],
          dest: m + '/lib',
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
              cwd: _dir + 'pc',
              src: ['css.css'],
              dest: m + '/lib',
              ext: '.css'
            }, {
              expand: true,
              cwd: _dir + 'pc',
              src: ['wechat.css'],
              dest: m + '/lib',
              ext: '.css'
            }, {
              expand: true,
              cwd: _admin + 'style',
              src: ['admin.css'],
              dest: _res + 'css',
              ext: '.css'
            }
          ]
        }
      },
      requirejs: {
        main: {
          options: require("" + __dirname + "/rfg").cfg(m, 'main')
        },
        admin: {
          options: require("" + __dirname + "/rfg").cfg(m, 'admin')
        },
        account: {
          options: require("" + __dirname + "/rfg").cfg(m, 'account')
        },
        wechat: {
          options: require("" + __dirname + "/rfg").cfg(m, 'wechat')
        }
      },
      connect: {
        admin: {
          options: {
            hostname: 'localhost',
            port: '180818',
            open: 'http://localhost:8080/module/' + m + '/console.html?mode=prod'
          }
        },
        console: {
          options: {
            hostname: 'localhost',
            port: '180819',
            open: _url + 'a/console'
          }
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
              cwd: _res + 'css',
              src: ['admin.css'],
              dest: _remoteRes + 'css'
            }, {
              expand: true,
              cwd: _dist,
              src: ['*.js', '*.css'],
              dest: _dest + m + '/lib'
            }, {
              expand: true,
              cwd: _tmpl,
              src: ['**/*.html'],
              dest: _dest + m + '/tmpl'
            }, {
              expand: true,
              cwd: m + '/_script',
              src: ['**/*.groovy'],
              dest: _dest + m + '/_script'
            }, {
              expand: true,
              cwd: '',
              src: ['version.json'],
              dest: _dest
            }, {
              expand: true,
              cwd: m + '/src/role',
              src: ['*.js'],
              dest: _dest + m + '/src/role'
            }, {
              expand: true,
              cwd: m + '/src/i18n',
              src: ['*.coffee'],
              dest: _dest + m + '/src/i18n'
            }, {
              expand: true,
              cwd: _lib + 'i18n',
              src: ['**/*.coffee'],
              dest: _remote + 'lib/i18n'
            }
          ]
        }
      }
    });
    fn = 'version.json';
    v = grunt.file.readJSON(fn);
    vv = v.version.split('.');
    vv[vv.length - 1] = ++vv[vv.length - 1];
    v.version = vv.join('.');
    grunt.file.write(fn, JSON.stringify(v));
    grunt.task.run('clean');
    grunt.task.run("cssmin");
    grunt.task.run("copy:cleanAdmin");
    grunt.task.run("copy:cleanCss");
    if (grunt.file.exists("" + __dirname + "/" + _dir + "main.js")) {
      grunt.task.run("requirejs:main");
    }
    grunt.task.run("requirejs:admin");
    if (grunt.file.exists("" + __dirname + "/" + _dir + "geVote.js")) {
      grunt.task.run("requirejs:geVote");
    }
    if (grunt.file.exists("" + __dirname + "/" + _dir + "account.js")) {
      grunt.task.run("requirejs:account");
    }
    if (grunt.file.exists("" + __dirname + "/" + _dir + "wechat.js")) {
      grunt.task.run("requirejs:wechat");
    }
    return grunt.task.run("ftpscript:admin");
  });
  return grunt.registerTask('war', function() {
    grunt.config.init({
      ftpscript: {
        war: {
          options: {
            host: ftp
          },
          files: [
            {
              expand: true,
              cwd: '../../target',
              src: ['ROOT.war'],
              dest: dest
            }
          ]
        }
      },
      connect: {
        tomcat: {
          options: {
            hostname: 'localhost',
            port: '80818',
            open: "http://" + dm + "/manager/html"
          }
        }
      }
    });
    grunt.task.run("ftpscript:war");
    return grunt.task.run("connect:tomcat");
  });
};
