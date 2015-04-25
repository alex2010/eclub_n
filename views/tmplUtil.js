// Generated by CoffeeScript 1.9.2
var util;

util = {};

_.extend(util, {
  userLink: function() {},
  icon: function(icon, tag, str, cls) {
    if (tag == null) {
      tag = 'i';
    }
    if (str == null) {
      str = '';
    }
    if (cls == null) {
      cls = '';
    }
    return "<" + tag + " class='glyphicon glyphicon-" + icon + " " + cls + "'>" + str + "</" + tag + ">";
  },
  imgItem: function(it, code, name) {
    var path;
    if (name == null) {
      name = 'head';
    }
    if (it.refFile && it.refFile[name]) {
      path = it.refFile[name][0];
    } else {
      path = '';
    }
    return util.img(util.resPath(code, path));
  },
  img: function(path, cls, pop) {
    var id;
    if (cls == null) {
      cls = 'markImg';
    }
    if (pop == null) {
      pop = false;
    }
    id = String.randomChar(4);
    return "<div id=\"" + id + "\" class=\"" + cls + "\" src=\"" + path + "\" pop=\"" + pop + "\"\nstyle=\"background:url(" + _resPath + "img/loading-bk.gif) no-repeat 50% 50%\">loading...</div>";
  },
  link: function(name, it, prop, cls) {
    var text;
    if (prop == null) {
      prop = 'title';
    }
    text = prop === '_str' ? it : it[prop];
    return "<a href='/" + name + "/" + it._id + "' title='" + text + "' class='" + (cls || '') + "'>" + text + "</a>";
  },
  href: function(name, id) {
    return "/" + name + "/" + id;
  },
  resPath: function(code, path) {
    return _resPath + 'upload/' + code + '/' + path;
  },
  navPage: function(code, it) {
    return "/sight/" + it._id;
  },
  crumbItem: function(items) {
    return [
      {
        label: '首页',
        href: '/'
      }
    ].concat(items);
  },
  copyRight: function(c, name, id) {
    var path;
    path = "http://" + c.url + "/" + name + "/" + id;
    return "<div class=\"copyright\"><strong>C</strong><div>\n    <p>除非特别声明，本站文章均为" + c.title + "原创文章，转载请注明原文链接</p>\n    <p>原文地址：<a href=\"" + path + "\">" + path + "</a></p>\n</div></div>";
  }
});

module.exports = util;
