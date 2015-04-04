define [
    '/lib/meta/common.js'
    '/lib/view/jsonTable.js'
], (meta, _jsonTable)->
    meta.subSight =
        refFile: meta.util.uploadPic
            label: '景点图片'
            attrs:
                ordered: true
                pickBtn: true
                style: ' '
                itemBtns: ['popEdit','zoom', 'del']
                uploader:
                    multi: true
                uploaderOpt:
                    func: 'head'
                    entity: 'sight'
        _:
            item:[
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

    meta.sight =

        refFile: meta.util.uploadPic
            label: '景点图片'
            attrs:
                ordered: true
                pickBtn: true
                style: ' '
                itemBtns: ['popEdit','zoom', 'del']
                uploader:
                    multi: true
                uploaderOpt:
                    func: 'head'
                    entity: 'sight'

        sub:
            label: '子景点'
            xtype: _jsonTable
            attrs:
                entity: 'subSight'
                title: '子景点'
                toFetch: false
                _func: null
                _prop: 'sub'
                _dv:[]
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
                'phone'
                'address'
                'route'
                'fee'
                'brief'
                'content'
                'opening'
                'sub'
                'refFile'
                '_dateCreated_true'
                '_lastUpdated_true'
            ]
            action: ->
                ['edit', 'del']

