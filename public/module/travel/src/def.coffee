require [
    '/lib/init.js'
], (cf) ->
    cf.opt =
        entity:
            categories: ['post', 'brand', 'commodity']
            headRefEntity: ['home', 'post', 'content']
            headRefChannel: ['index', 'about']
        image:
            show:
                maxWidth: 620
                thumb: '_thumb:100'
            portrait:
                maxWidth: 300
            photo:
                maxWidth: 650
            post:
                maxWidth: 620
                thumb: '_thumb:180'
            head:
                maxWidth: 620