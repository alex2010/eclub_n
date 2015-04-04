
module.exports =
    console: (item, callback)->
        item.css = '/lib/admin/style/admin.css'
        item.app = 'admin'
        callback item

