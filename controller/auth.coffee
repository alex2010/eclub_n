_ = require('underscore')
async = require('async')

checkType = (k)->
    if /\S+@\S+\.\S+/.test k
        email: k
    else if /^(13[0-9]|15[0|1|2|3|6|7|8|9]|18[5|6|8|9])\d{8}$/.test k
        phone: k
    else
        username: k

authController =

    login: (req, rsp) ->
        code = req.params.code
        opt = checkType req.body.username
        log opt
        dao.get code, 'user', opt, (user)->
            unless user
                rsp.status(300).send msg: 'm.login_f'
                return
            if user.psd isnt req.body.psd
                rsp.status(301).send msg: 'm.login_f'
            else
                delete user.password
                dao.find code, 'membership', uid: user._id, {}, (ms)->
                    opt =
                        _id:
                            $in: (it.rid for it in ms)
                    dao.find code, 'role', opt, {}, (rs)->
                        user.roles = for r in rs
                            title: r.title
                            label: r.label
                        _.extend user, role.res for role in rs
                        rsp.send
                            user: user
                            msg: 'm.login_s'

#                    cl = for it in ms
#                        (cb)->
#                            dao.get 'role', _id: it.rid, (role)->
#                                user.roles.push role
#                                cb null, role
#                    async.parallel cl, (err, res)->
#                        _.extend user, role.res for role in res
#                        rsp.send
#                            user: user
#                            msg: 'm.login_s'

    logout: (req, rsp) ->
        #del user session
        rsp.send msg: 'm.logout_s'


module.exports = authController