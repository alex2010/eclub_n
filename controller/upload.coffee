multer = require('multer')
fs = require('fs')
gm = require('gm')

sPath = (code)->
    path = "/public/res/upload/#{code}"
    if app.env
        '.' + path
    else
        _path + path


app.use multer
    dest: './public/res/img'
    rename: (fieldname, filename)->
        fieldname

    onFileUploadComplete: (file, req, rsp)->
        log 'fild cp'
        rp = sPath("#{req.query.code}/#{file.fieldname}.#{file.extension}")
        log rp
        qu = req.query
        if qu.maxWidth
            thumb(rp, ':' + qu.maxWidth)
        if qu.thumb
            thumb(rp, qu.thumb)
        if qu.crop
            crop(file.path, crop)

    onFileSizeLimit: ->
        log 'oversize'

    changeDest: (dest, req)->
        sPath(req.query.code)

thumbPath = (path, folder)->
    return path unless folder
    p = path.split('/')
    e = p.pop()
    p.push folder
    p.push e
    p.join('/')

crop = (path, crop)->
    [w,h,x,y] = crop.split(',')
    gm(path)
    .crop(w, h, x, y)
    .write(path)

thumb = (path, thumb)->
    [folder,w] = thumb.split(':')
    tp = thumbPath path, folder.trim()
    gm(path).resize(w, null).write(tp, ->)
#    gm(path).thumb(w, null, 'test.jpg', 50, ->)

module.exports =
    remove: (req, rsp)->
        bo = req.body
        path = sPath(req.params.code) + '/' + bo.id
        fs.unlink path, ->
        if bo.thumb
            fs.unlink thumbPath(path, bo.thumb.split(':')[0]), ->
        rsp.send
            success: true

    upload: (req, rsp)->
        file = _.values(req.files)[0]
        qu = req.query
        if qu.thumb
            file.path = thumbPath file.path, qu.thumb.split(':')[0]
        rsp.send
            success: true
            entity: file
            msg: 'm.upload'


