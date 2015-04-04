code = 'travel'
psd = 'psd'

log = console.log

`app = {
    _hk: 'hk'
}
`
community =
    code: code
    name: 'travel in Beijing'
    url: 'tourguideinbeijing.herokuapp.com'

role = [
    title: 'admin'
    label: '管理员'
    lang: 'zh'
    res:
        mgm:
            menu:
                home: 1
                site: 2
                data: 3
                wechat: 4
                tmpl: 5
                file: 6
                userRole: 7
            entity:
                activity: 1
                topic: 2
                content: 3
                post: 4
                head: 5
                thread: 6
                category: 7
                link: 8
                venue: 9
                participant: 10

                community: 'x'
                role: 'x'
                wechat: 'x'
                codeMap: 'x'
        permission:
            page: 'console'
,
    title: 'guest'
    label: '浏览者'
    lang: 'zh'
    res:
        menu: [
            label: "首页"
            href: "/index.html"
        ,
            label: "活动"
            href: "/eventList.html"
        ,
            label: "阅读"
            href: "/postList.html"
        ]
,
    title: 'user'
    label: '登录用户'
    lang: 'zh'
    res:
        mgm:
            entity:
                activity: '1:list:1'
                topic: '2:add-list-del-edit:1'
                post: '3:add-list-del-edit:1'
                user: '4:edit:1'
        menu: [
            label: '我的首页'
            row: 1
            href: '#!/account'
        ,
            label: '我的文章'
            row: 2
            href: '#!/data/list/post'
        ,
            label: '我的活动'
            row: 3
            href: '#!/data/list/topic'
        ,
            label: '个人信息'
            row: 4
            href: '#!/profile'
        ,
            label: '修改密码'
            row: 5
            href: '#!/psd'
        ]
        permission:
            page: 'person'
]

user = [
    username: code
    password: psd
]

insertMember = (title, username)->
    membership = {}
    dao.get code, 'role', title: title, (doc)->
        membership.rid = doc._id
        dao.get code, 'user', username: username, (doc)->
            membership.uid = doc._id
            dao.save code, 'membership:uid,rid', membership, ->
                dao.close()

cl = [
    ->
        dao.save code, 'community:code', community
    ->
        dao.save code, 'role:title', role
    ->
        dao.save code, 'user:username,rid', user
]

async = require('async')
dao = new require('./model/dao') code, ->
    async.parallel cl, ->
        insertMember 'admin', code

