define [
    '/lib/meta/common.js'
    '/lib/view/jsonTable.js'
], (meta, _jsonTable)->

    lsOpt = (opt)->
        $.extend
            tbItem:
                title: {}
                lastUpdated:
                    type: 'date'
                _opt:
                    type: 'btns'
                    w: 120
            action: ->
                ['edit', 'del']
        , opt


    textOp =
        type: 'textarea'
        row: 3

    $.extend meta.common,
        'info::openingHours': textOp
        'info::price': textOp
        'info::address': textOp
        'info::distance': textOp
        'info::gettingThere': textOp
        'info::bestTimeToSee': textOp
        'info::englishMap': textOp
        'info::travelTips': textOp
        'info::officialWebsite': textOp
        'info::watchVideo': textOp
        'info::lastUpdated': textOp
        'info::showTime': textOp
        'info::priceSeats': textOp

        slidePic: meta.util.uploadPic
            attrs:
                ordered: true
                pickBtn: true
                itemBtns: ['popEdit', 'zoom', 'del']
                uploader:
                    multi: true
                uploaderOpt:
                    func: 'show'
                    entity: 'entity'

        listPic: meta.util.uploadPic
            attrs:
                pickBtn: true
                itemBtns: ['popEdit', 'zoom', 'del']
                uploader:
                    multi: false
                uploaderOpt:
                    func: 'head'
                    entity: 'entity'


    meta.theater = meta.extra = meta.subSight = meta.restaurant =
        refPic: meta.util.uploadPic
            attrs:
                ordered: true
                pickBtn: true
                itemBtns: ['popEdit', 'zoom', 'del']
                uploader:
                    multi: true
                uploaderOpt:
                    func: 'head'
                    entity: 'sight'
        _:
            item: [
                'title'
                'fee'
                'row'
                'content'
                'refPic'
            ]
            tbItem:
                row:
                    w: 50
                title: {}
                _opt:
                    type: 'btns'
                    w: 120

    meta.handicraft =
        _: lsOpt
            item: [
                'title'
                'subTitle'
                'row'
                'content'
                'slidePic'
                'listPic'
            ]

    meta.food =
        restaurant:
            xtype: _jsonTable
            attrs:
                entity: 'restaurant'
                toFetch: false
                _func: null
                _prop: 'sub'
                _dv: []
                callback: ->

        _: lsOpt
            item: [
                'title'
                'subTitle'
                'row'
                'content'
                'restaurant'
                'slidePic'
                'listPic'
            ]

    meta.show =
        theater:
            xtype: _jsonTable
            attrs:
                entity: 'theater'
                toFetch: false
                _func: null
                _prop: 'sub'
                _dv: []
                callback: ->
        _: lsOpt
            item: [
                'title'
                'subTitle'
                'row' # top choice great than 1000
                'content'

                'info::opening'
                'info::price'
                'info::address'
                'info::distance'
                'info::gettingThere'
                'info::website'
                'info::watchVideo'
                'info::words'
                'info::lastUpdated'
                'info::showTime'
                'info::priceSeats'

                'theater'
                'slidePic'
                'listPic'
                '_dateCreated_true'
                '_lastUpdated_true'
            ]

    meta.sight =
        sub:
            xtype: _jsonTable
            attrs:
                entity: 'subSight'
                toFetch: false
                _func: null
                _prop: 'sub'
                _dv: []
                callback: ->
        extra:
            xtype: _jsonTable
            attrs:
                entity: 'extra'
                toFetch: false
                _func: null
                _prop: 'extra'
                _dv: []
                callback: ->

        _: lsOpt
            item: [
                'title'
                'subTitle'
                'row'
                'content'

                'info::openingHours'
                'info::price'
                'info::address'
                'info::distance'
                'info::gettingThere'
                'info::englishMap'
                'info::travelTips'
                'info::website'
                'info::watchVideo'
                'info::officialWebsite'
                'info::lastUpdated'

                'sub'
                'extra'
                'slidePic'
                'listPic'
                '_dateCreated_true'
                '_lastUpdated_true'
            ]

