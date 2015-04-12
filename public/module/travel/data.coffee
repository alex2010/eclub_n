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
        ,
            label: 'Attractions'
            href: '/attraction'
        ,
            label: 'Famous Food good'
            href: '/foodList'
        ,
            label: 'Beijing Shows'
            href: '/showList'
        ,
            label: 'Handicrafts'
            title: 'xzcvxcvzxcv'
            href: '/handicraftList'
        ,
            label: 'Cars & Guides'
            href: '/cg'
        ,
            label: 'Beijing Maps'
            href: '/mapList'
        ,
            label: 'Tours'
            href: '/tourList'
        ]
        foot: [
            label: 'About Us'
            href: '/content/about'
        ,
            label: 'Contact Us'
            href: '/content/contact'
        ,
            label: 'Privacy Policy'
            href: '/content/pp'
        ,
            label: 'Your Suggestion'
            href: '/content/ys'
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
    subTitle: 'at the very heart of Beijing'
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
    extra: [
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
    subTitle: 'at the very heart of Beijing'
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

cat = [

    title: 'UNESCO'
    code: 'unesco'
    type: 'sight'
    row: 100
,
    title: 'Great Wall'
    code: 'gw'
    type: 'sight'
    row: 90
,
    title: 'Museum'
    code: 'museum'
    type: 'sight'
    row: 80
,
    title: 'Temple'
    code: 'temple'
    type: 'sight'
    row: 70
,
    title: 'Park/Garden'
    code: 'park'
    type: 'sight'
    row: 60
,
    title: 'Historical'
    code: 'historical'
    type: 'sight'
    row: 50
,
    title: 'Free'
    code: 'free'
    type: 'sight'
    row: 40
,
    title: 'other'
    code: 'other'
    type: 'sight'
    row: 30
,


    title: 'Most Famous Food in Beijing'
    code: 'food'
    content: "Underscore is a utility-belt library for JavaScript that provides a lot of the functional programming support that you would expect in Prototype.js (or Ruby), but without extending any of the built-in JavaScript objects. It's the tie to go along with jQuery's tux, and Backbone.js's suspenders. Underscore provides 80-odd functions that support both the usual functional suspects: map, select, invoke — as well as more specialized helpers: function binding, javascript templating, deep equality testing, and so on. It delegates to built-in functions, if present, so modern browsers will use the native implementations of forEach, map, reduce, filter, every, some and indexOf."
    type: 'food'
,
    title: 'Private Cars'
    code: 'cg_car'
    content: "Underscore is a utility-belt library for JavaScript that provides a lot of the functional programming support that you would expect in Prototype.js (or Ruby), but without extending any of the built-in JavaScript objects. It's the tie to go along with jQuery's tux, and Backbone.js's suspenders. Underscore provides 80-odd functions that support both the usual functional suspects: map, select, invoke — as well as more specialized helpers: function binding, javascript templating, deep equality testing, and so on. It delegates to built-in functions, if present, so modern browsers will use the native implementations of forEach, map, reduce, filter, every, some and indexOf."
    type: 'cg'
,
    title: 'Private Guides'
    code: 'cg_guide'
    content: "Underscore is a utility-belt library for JavaScript that provides a lot of the functional programming support that you would expect in Prototype.js (or Ruby), but without extending any of the built-in JavaScript objects. It's the tie to go along with jQuery's tux, and Backbone.js's suspenders. Underscore provides 80-odd functions that support both the usual functional suspects: map, select, invoke — as well as more specialized helpers: function binding, javascript templating, deep equality testing, and so on. It delegates to built-in functions, if present, so modern browsers will use the native implementations of forEach, map, reduce, filter, every, some and indexOf."
    type: 'cg'
,
    title: 'City Highlight'
    content: "Underscore is a utility-belt library for JavaScript that provides a lot of the functional programming support that you would expect in Prototype.js (or Ruby), but without extending any of the built-in JavaScript objects. It's the tie to go along with jQuery's tux, and Backbone.js's suspenders. Underscore provides 80-odd functions that support both the usual functional suspects: map, select, invoke — as well as more specialized helpers: function binding, javascript templating, deep equality testing, and so on. It delegates to built-in functions, if present, so modern browsers will use the native implementations of forEach, map, reduce, filter, every, some and indexOf."
    type: 'tour'
,
    title: 'Great Wall'
    content: "Underscore is a utility-belt library for JavaScript that provides a lot of the functional programming support that you would expect in Prototype.js (or Ruby), but without extending any of the built-in JavaScript objects. It's the tie to go along with jQuery's tux, and Backbone.js's suspenders. Underscore provides 80-odd functions that support both the usual functional suspects: map, select, invoke — as well as more specialized helpers: function binding, javascript templating, deep equality testing, and so on. It delegates to built-in functions, if present, so modern browsers will use the native implementations of forEach, map, reduce, filter, every, some and indexOf."
    type: 'tour'
,
    title: 'depth Tour'
    content: "Underscore is a utility-belt library for JavaScript that provides a lot of the functional programming support that you would expect in Prototype.js (or Ruby), but without extending any of the built-in JavaScript objects. It's the tie to go along with jQuery's tux, and Backbone.js's suspenders. Underscore provides 80-odd functions that support both the usual functional suspects: map, select, invoke — as well as more specialized helpers: function binding, javascript templating, deep equality testing, and so on. It delegates to built-in functions, if present, so modern browsers will use the native implementations of forEach, map, reduce, filter, every, some and indexOf."
    type: 'tour'
,
    title: 'Jump in Tour'
    content: "Underscore is a utility-belt library for JavaScript that provides a lot of the functional programming support that you would expect in Prototype.js (or Ruby), but without extending any of the built-in JavaScript objects. It's the tie to go along with jQuery's tux, and Backbone.js's suspenders. Underscore provides 80-odd functions that support both the usual functional suspects: map, select, invoke — as well as more specialized helpers: function binding, javascript templating, deep equality testing, and so on. It delegates to built-in functions, if present, so modern browsers will use the native implementations of forEach, map, reduce, filter, every, some and indexOf."
    type: 'tour'
]

top = [
    title: 'Summer Place'
    subTitle: 'The Biggest indd sdfsdf sdf'
    entity: 'sight'
    id: 'vcxvsdfsdfsdf'
    refFile:
        head: ['p1.jpg']
,
    title: 'Beijing Duck'
    subTitle: 'The Biggest indd sdfsdf sdf'
    entity: 'food'
    id: 'vcxvsdfsdfsdf'
    refFile:
        head: ['p1.jpg']
,
    title: 'Zhongguo GongFu'
    subTitle: 'The Biggest indd sdfsdf sdf'
    entity: 'show'
    id: 'vcxvsdfsdfsdf'
    refFile:
        head: ['p1.jpg']
]
head = [
    type: 'top'
    list: [
        title: 'Summer Place'
        subTitle: 'The Biggest indd sdfsdf sdf'
        href: '/sight/xzcvxcvcv'
        refFile:
            head: ['p1.jpg']
    ,
        title: 'Summer Place'
        subTitle: 'The Biggest indd sdfsdf sdf'
        href: '/sight/xzcvxcvcv'
        refFile:
            head: ['p2.jpg']
    ]
,
    type: 'index'
    list: [
        title: 'Top Choices'
        subTitle: 'A collection of most-see orders in Beijing'
        cls: 'col-md-6'
        href: '/top'
    ,
        title: 'Attraction'
        subTitle: 'A collection of most-see orders in Beijing'
        cls: 'col-md-3'
        href: '/attraction'
    ,
        title: 'Famous Food'
        subTitle: 'A collection of most-see orders in Beijing'
        cls: 'col-md-3'
        href: '/foodList'
    ,
        title: 'Beijing Shows'
        subTitle: 'A collection of most-see orders in Beijing'
        cls: 'col-md-3'
        href: '/showList'
    ,
        title: 'Handicrafts'
        subTitle: 'A collection of most-see orders in Beijing'
        cls: 'col-md-3'
        href: '/handicraftList'
    ]

]

food = [
    title: 'Beijing Roast Duck'
    subTitle: 'The Biggest sdfsdfsdf gorden in China'
    content: "Underscore is a utility-belt library for JavaScript that provides a lot of the functional programming support that you would expect in Prototype.js (or Ruby), but without extending any of the built-in JavaScript objects. It's the tie to go along with jQuery's tux, and Backbone.js's suspenders. Underscore provides 80-odd functions that support both the usual functional suspects: map, select, invoke — as well as more specialized helpers: function binding, javascript templating, deep equality testing, and so on. It delegates to built-in functions, if present, so modern browsers will use the native implementations of forEach, map, reduce, filter, every, some and indexOf."
    row: 1001
    refFile:
        head: ['p1.jpg', 'p2.jpg']
        p1:
            title: 'Spring'
            description: 'amazing spring'
        p2:
            title: 'Summer'
            description: 'amazing Fall'
,
    title: 'Beijing Kaorou'
    subTitle: 'The Biggest sdfsdfsdf gorden in China'
    content: "Underscore is a utility-belt library for JavaScript that provides a lot of the functional programming support that you would expect in Prototype.js (or Ruby), but without extending any of the built-in JavaScript objects. It's the tie to go along with jQuery's tux, and Backbone.js's suspenders. Underscore provides 80-odd functions that support both the usual functional suspects: map, select, invoke — as well as more specialized helpers: function binding, javascript templating, deep equality testing, and so on. It delegates to built-in functions, if present, so modern browsers will use the native implementations of forEach, map, reduce, filter, every, some and indexOf."
    row: 1002
    refFile:
        head: ['p1.jpg', 'p2.jpg']
        p1:
            title: 'Spring'
            description: 'amazing spring'
        p2:
            title: 'Summer'
            description: 'amazing Fall'
]
show = [
    title: 'Jingju'
    subTitle: 'The Biggest sdfsdfsdf gorden in China'
,
    title: 'Jingju'
    subTitle: 'The Biggest sdfsdfsdf gorden in China'
]

handicraft = [
    title: 'Jingju'
    subTitle: 'The Biggest sdfsdfsdf gorden in China'
,
    title: 'Jingju'
    subTitle: 'The Biggest sdfsdfsdf gorden in China'
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

        'cat:title': cat
        'food:title': food
        'head:title': head
        'top:title': top


    reset: ['post']