WechatAPI = require('wechat-api')

api = new WechatAPI(appid, appsecret)


module.exports =
    uploadMenus: (req, rsp)->
        api.createMenu req.body.menu, (err, res) ->
            rsp.send res
