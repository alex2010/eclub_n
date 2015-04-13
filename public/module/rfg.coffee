exports || (exports = {})
exports.cfg = (module = '', t) ->
#    resPath = if !cf? or cf.mode is 'prod' then 'http://s.pet.org/' else '/res/'
    if t #zip
#        pathPrefix = 'module/'
        pathPrefix = "res/js/"
        devApp = []
    else #run
        pathPrefix = '../res/js/'
        devApp = ["/module/#{module}/src/#{cf.app}.js"]

    devApp: devApp
    baseUrl: 'public'
    preserveLicenseComments: false
    removeCombined: true,
    findNestedDependencies: true,
    skipSemiColonInsertion: true,
    include: ["#{pathPrefix}requirejs/require", "module/#{module}/src/#{t}"]
    out: "/Users/alexwang/Projects/eclub_n/public/res/upload/#{module}/lib/#{t}.js"

    optimize: "uglify2"

    paths:
        jquery: pathPrefix + "jquery/dist/jquery"
        zepto: pathPrefix + "zepto/zepto"
        underscore: pathPrefix + "underscore/underscore"
        ratchet: pathPrefix + "ratchet/dist/js/ratchet"
        handlebars: pathPrefix + "handlebars/handlebars"
        backbone: pathPrefix + "backbone/backbone"
        text: pathPrefix + "text/text"
        finger: pathPrefix + "jquery.finger/dist/jquery.finger"
        hbs: pathPrefix + "requirejs-hbs/hbs"
        layoutEngine: pathPrefix + "layout.engine"
        bootstrap: pathPrefix + "bootstrap/dist/js/bootstrap"

        CodeMirror: '//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/codemirror'
        CodeMirrorXml: '//cdnjs.cloudflare.com/ajax/libs/codemirror/3.20.0/mode/xml/xml.min'
        CodeMirrorFormatting: '//cdnjs.cloudflare.com/ajax/libs/codemirror/2.36.0/formatting.min'

    shim:
        layoutEngine:
            exports: "layout"
        finger:
            deps: ["jquery"]
        zepto:
            exports: "$"
            deps: [
                "layoutEngine"
            ]
        handlebars:
            exports: "Handlebars"
        ratchet:
            exports: "ratchet"
        backbone:
            exports: "Backbone"
            deps: [
                "underscore"
            ]
        underscore:
            exports: "_"
        bootstrap:
            exports: "$"
            deps: ["jquery", 'layoutEngine']
        localstorage:
            deps: ["backbone"]
#        CodeMirror:
#            exports: 'CodeMirror'
#        CodeMirrorXml: ['CodeMirror']
#        CodeMirrorFormatting: ['CodeMirror', 'CodeMirrorXml']