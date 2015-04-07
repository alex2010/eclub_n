adminRoleId = new oid()
adminUserId = new oid()

role = [
    _id: adminRoleId
    title: 'admin'
    res:
        mgm:
            menu:
                home: 1
                site: 2
                data: 3
                file: 6
            entity:
                course: 1
                content: 3
                post: 4
                head: 5
                category: 7
                link: 8
        permission:
            page: 'console'
,
    title: 'guest'
    res:
        menu: [
            label: '首页'
            href: '/'
        ,
            label: '课程列表'
            href: '/courseList'
        ,
            label: '关于我们'
            href: '/about'
        ]
]

user = [
    _id: adminUserId
    username: code
    password: 'psd'
]

membership = [
    uid: adminUserId
    rid: adminRoleId
]

course = [
    title: 'Salsa Basic'
    phone: '12233322'
    fee: '800元/月'
    brief: 'Ringed by a 52m-wide moat at the very heart of Beijing, the Forb'
    content: "Ringed by a 52m-wide moat at the very heart of Beijing, the Forbidden City is China’s largest and best-preserved collectionm of ancient buildings, and the largest
palace complex in the world."
    startDate: new Date()
    endDate: new Date()

,
    title: 'great wall'
    phone: '1231231231'
    address: 'sdvxcvzcvcvxczv'
]

post = [
    title: 'Travel rule'
    content: 'sdfsdfsdfdsfsdfsfdsf'
,
    title: 'Travel tip'
    content: 'sdfsdfsdzxcvcxv xzcvxzcv'
]


module.exports =
    community:
        code: code
        name: 'YMSalsa'
        url: 't.salsa.com'

    data:
        'role:title': role
        'user:username': user
        'membership:uid,rid': membership

        'post:title': post
        'course:title': course

    reset: ['post']
