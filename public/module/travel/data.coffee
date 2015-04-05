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
                sight: 1
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
            label: 'Attractions'
            href: '/attractions.html'
            children: [
                label: 'UNESCO'
                href: '/sightList.html?category=unesco'
            ,
                label: 'Great Wall'
                href: '/sightList.html?category=great'
            ]
        ,
            label: 'Famous Food good'
            href: '/food.html'
        ,
            label: 'Beijing Shows'
            href: '/shows.html'
        ,
            label: 'Handicrafts'
            title: 'xzcvxcvzxcv'
            href: '/crafts.html'
        ,
            label: 'Cars & Guides'
            href: '/cg.html'
        ,
            label: 'Beijing Maps'
            href: '/maps.html'
        ,
            label: 'Tours'
            href: '/tours.html'
        ]
        foot: [
            label: 'sdfsdfsdf'
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

sight = [
    title: 'Summer Palace'
    phone: '12233322'
    address: 'sadfsd sdfsdfsadf'
    fee: 200
    route: 'sadfsd dsfdsfsdaf'
    lat: '100'
    lng: '200'
    brief: 'Ringed by a 52m-wide moat at the very heart of Beijing, the Forb'
    content: "Ringed by a 52m-wide moat at the very heart of Beijing, the Forbidden City is China’s largest and best-preserved collectionm of ancient buildings, and the largest
palace complex in the world."
    opening: [
        '17:00-18:00 19:00-21:00 (Monday)'
        '17:00-18:00 19:00-21:00 (Tuesday)'
        '17:00-18:00 19:00-21:00 (Wenday)'
        '17:00-18:00 19:00-21:00 (Thursday)'
    ]
    refFile:
        head: ['p1.jpg', 'p2.jpg']
        p1:
            title: 'Spring'
            description: 'amazing spring'
        p2:
            title: 'Fall'
            description: 'amazing Fall'
    sub: [
        title: 'RenShoudian'
        content: "asdfsdf sadfsdf'sdfsdfsadf"
    ,
        title: 'cixi'
        content: 'asdasdsads asd asdasdasdasd'
    ]
,
    title: 'great wall'
    phone: '1231231231'
    address: 'sdvxcvzcvcvxczv'
    content: "de moat at the very heart of Beijing, the For"
    refFile:
        head: ['p1.jpg', 'p2.jpg']
        p1:
            title: 'Spring'
            description: 'amazing spring'
        p2:
            title: 'Fall'
            description: 'amazing Fall'
]

post = [
    title: 'Travel rule'
    content: 'sdfsdfsdfdsfsdfsfdsf'
,
    title: 'Travel tip'
    content: 'sdfsdfsdzxcvcxv xzcvxzcv'
]

content = [
    title: '网站内容'
    content: '对方水电费水电费'
    brief: '121223'
]

module.exports =
    community:
        code: code
        name: 'travel in Beijing'
        url: 'tourguideinbeijing.herokuapp.com'

    data:
        'role:title': role
        'user:username': user
        'membership:uid,rid': membership

        'post:title': post
        'sight:title': sight
        'content:title': content

    reset: ['post']
