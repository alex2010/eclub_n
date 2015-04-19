// Generated by CoffeeScript 1.9.1
var crop, fs, gm, multer, sPath, thumb, thumbPath;

multer = require('multer');

fs = require('fs');

gm = require('gm');

sPath = function(code) {
  var path;
  path = "/public/res/upload/" + code;
  if (app.env) {
    return '.' + path;
  } else {
    return _path + path;
  }
};

app.use(multer({
  dest: './public/res/img',
  rename: function(fieldname, filename) {
    return fieldname;
  },
  onFileUploadComplete: function(file, req, rsp) {
    var qu, rp;
    log('fild cp');
    rp = sPath(req.query.code + "/" + file.fieldname + "." + file.extension);
    log(rp);
    qu = req.query;
    if (qu.maxWidth) {
      thumb(rp, ':' + qu.maxWidth);
    }
    if (qu.thumb) {
      thumb(rp, qu.thumb);
    }
    if (qu.crop) {
      return crop(file.path, crop);
    }
  },
  onFileSizeLimit: function() {
    return log('oversize');
  },
  changeDest: function(dest, req) {
    return sPath(req.query.code);
  }
}));

thumbPath = function(path, folder) {
  var e, p;
  if (!folder) {
    return path;
  }
  p = path.split('/');
  e = p.pop();
  p.push(folder);
  p.push(e);
  return p.join('/');
};

crop = function(path, crop) {
  var h, ref, w, x, y;
  ref = crop.split(','), w = ref[0], h = ref[1], x = ref[2], y = ref[3];
  return gm(path).crop(w, h, x, y).write(path);
};

thumb = function(path, thumb) {
  var folder, ref, tp, w;
  ref = thumb.split(':'), folder = ref[0], w = ref[1];
  tp = thumbPath(path, folder.trim());
  return gm(path).resize(w, null).write(tp, function() {});
};

module.exports = {
  remove: function(req, rsp) {
    var bo, path;
    bo = req.body;
    path = sPath(req.params.code) + '/' + bo.id;
    fs.unlink(path, function() {});
    if (bo.thumb) {
      fs.unlink(thumbPath(path, bo.thumb.split(':')[0]), function() {});
    }
    return rsp.send({
      success: true
    });
  },
  upload: function(req, rsp) {
    var file, qu;
    file = _.values(req.files)[0];
    qu = req.query;
    if (qu.thumb) {
      file.path = thumbPath(file.path, qu.thumb.split(':')[0]);
    }
    return rsp.send({
      success: true,
      entity: file
    });
  }
};
