define [
    '/lib/meta/common.js'
    '/lib/view/jsonTable.js'
], (meta, _jsonTable)->
#oKa6ZjrT3RnGum208ml6cj0yN1rw
    uploadOpt = (opt)->
        meta.util.uploadPic
            label: '景点图片'
            attrs:
                ordered: true
                pickBtn: true
                style: ' '
                itemBtns: ['popEdit', 'zoom', 'del']
                uploader:
                    multi: true
                uploaderOpt:
                    func: 'head'
                    entity: 'sight'

    textOp =
        type: 'text'

    $.extend meta.common,
        'info::opening': textOp
        'info::price': textOp
        'info::address': textOp
        'info::distance': textOp
        'info::gettingThere': textOp
        'info::bestTimeToSee': textOp
        'info::englishMap': textOp
        'info::travelTips': textOp
        'info::officialWebsite': textOp
        'info::watchVideo': textOp
        'info::words': textOp
        'info::lastUpdated': textOp
        'info::showTime': textOp
        'info::priceSeats': textOp


    meta.subSight =
        refFile: uploadOpt
            attrs:
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
                'refFile'
            ]
            tbItem:
                row:
                    w: 50
                title: {}
                _opt:
                    type: 'btns'
                    w: 120

    meta.handicraft =

        meta.food =

            meta.show =
                refFile: meta.util.uploadPic
                    label: '景点图片'
                    attrs:
                        ordered: true
                        pickBtn: true
                        style: ' '
                        itemBtns: ['popEdit', 'zoom', 'del']
                        uploader:
                            multi: true
                        uploaderOpt:
                            func: 'head'
                            entity: 'sight'

                theater:
                    xtype: _jsonTable
                    attrs:
                        entity: 'subSight'
                        toFetch: false
                        _func: null
                        _prop: 'sub'
                        _dv: []
                        callback: ->

                _:
                    tbItem:
                        title: {}
                        lastUpdated:
                            type: 'date'
                        _opt:
                            type: 'btns'
                            w: 120

                    item: [
                        'title'
                        'subTitle'
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

                        'sub'
                        'refFile'
                        '_dateCreated_true'
                        '_lastUpdated_true'
                    ]
                    action: ->
                        ['edit', 'del']
    meta.sight =
        refFile: meta.util.uploadPic
            attrs:
                ordered: true
                pickBtn: true
                style: ' '
                itemBtns: ['popEdit', 'zoom', 'del']
                uploader:
                    multi: true
                uploaderOpt:
                    func: 'head'
                    entity: 'sight'

        sub:
            xtype: _jsonTable
            attrs:
                entity: 'subSight'
                toFetch: false
                _func: null
                _prop: 'sub'
                _dv: []
                callback: ->

        _:
            tbItem:
                title: {}
                lastUpdated:
                    type: 'date'
                _opt:
                    type: 'btns'
                    w: 120

            item: [
                'title'
                'subTitle'
                'content'

                'info::opening'
                'info::price'
                'info::address'
                'info::distance'
                'info::gettingThere'
                'info::englishMap'
                'info::travelTips'
                'info::website'
                'info::watchVideo'
                'info::words'
                'info::lastUpdated'

                'sub'
                'refFile'
                '_dateCreated_true'
                '_lastUpdated_true'
            ]
            action: ->
                ['edit', 'del']

