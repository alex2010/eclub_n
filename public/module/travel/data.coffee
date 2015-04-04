code = 'travel'
log = console.log

role = [
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
            label: 'Famous Food'
            href: '/food.html'
        ,
            label: 'Beijing Shows'
            href: '/shows.html'
        ,
            label: 'Handicrafts'
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
    sub: [
        title: 'RenShoudian'
        content: "asdfsdf sadfsdf'sdfsdfsadf"
    ,
        title: 'cixi'
        content: 'asdasdsads asd asdasdasdasd'
    ]
]

dao = new require('../../../model/dao')(code)

setTimeout ->
    dao.save code, 'role:title', role
    dao.save code, 'sight:title', sight
, 500

setTimeout ->
    dao.close()
, 1000

