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

            label: 'Top Choices'
            code: 'top'
            href: '/top'
            children: [
                label: 'UNESCO'
                href: '/sightList?cat=unesco'
            ,
                label: 'Great Wall'
                href: '/sightList?cat=great'
            ,
                label: 'Museum'
                href: '/sightList?cat=great'
            ,
                label: 'Temple'
                href: '/sightList?cat=great'
            ,
                label: 'Park/Garden'
                href: '/sightList?cat=great'
            ,
                label: 'Historical'
                href: '/sightList?cat=great'
            ,
                label: 'Free'
                href: '/sightList?cat=great'
            ,
                label: 'Call'
                href: '/sightList?cat=great'
            ]
        ,
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
    slogan: 'at the very heart of Beijing'
    phone: '12233322'
    cat: 'top'
    address: 'sadfsd sdfsdfsadf'
    fee: 200
    route: 'sadfsd dsfdsfsdaf'
    lat: '100'
    lng: '200'
    row: 1009
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
            title: 'Summer'
            description: 'amazing Fall'
    extra:[
        title: 'Empress Dowsdf CiXi'
        content: 'Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably'
    ,
        title: 'Tai hou'
        content: 'Anim pariatur cliche reprehenderit, enim eiusmod high life accusamus terry richardson ad squid. 3 wolf moon officia aute, non cupidatat skateboard dolor brunch. Food truck quinoa nesciunt laborum eiusmod. Brunch 3 wolf moon tempor, sunt aliqua put a bird on it squid single-origin coffee nulla assumenda shoreditch et. Nihil anim keffiyeh helvetica, craft beer labore wes anderson cred nesciunt sapiente ea proident. Ad vegan excepteur butcher vice lomo. Leggings occaecat craft beer farm-to-table, raw denim aesthetic synth nesciunt you probably'
    ]
    sub: [
        title: 'RenShoudian'
        content: "asdfsdf sadfsdf'sdfsdfsadf"
    ,
        title: 'cixi'
        content: 'asdasdsads asd asdasdasdasd'
    ]
,
    title: 'great wall'
    slogan: 'at the very heart of Beijing'
    phone: '1231231231'
    address: 'sdvxcvzcvcvxczv'
    row: 1008
    cat: 'top'
    content: "de moat at the very heart of Beijing, the For"
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
]
city = [
    title: 'Beijing'
    description: "Underscore is a utility-belt library for JavaScript that provides a lot of the functional programming support that you would expect in Prototype.js (or Ruby), but without extending any of the built-in JavaScript objects. It's the tie to go along with jQuery's tux, and Backbone.js's suspenders. Underscore provides 80-odd functions that support both the usual functional suspects: map, select, invoke — as well as more specialized helpers: function binding, javascript templating, deep equality testing, and so on. It delegates to built-in functions, if present, so modern browsers will use the native implementations of forEach, map, reduce, filter, every, some and indexOf."
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
        url: 't.travel.com'

    data:
        'role:title': role
        'user:username': user
        'membership:uid,rid': membership

        'post:title': post
        'sight:title': sight
        'city:title': city
        'content:title': content

    reset: ['post']