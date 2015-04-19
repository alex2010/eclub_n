folder = '/opt/node/public/'
url = 'wikibeijing.com'
module.exports =
    url: url
    upload_path: folder
    res_path: "http://s.#{url}/"
    log_path: folder + 'log/'
