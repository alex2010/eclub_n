exports || (exports = {})
exports.cfg = (module = '', t) ->

#    resPath = if !cf? or cf.mode is 'prod' then 'http://s.pet.org/' else '/res/'
#    pathPrefix = 'module/'
    if t #zip
        lrPath = 'res/'
        pathPrefix = 'module/'
        devApp = []
    else #run
        lrPath = '../res/'
        pathPrefix = ''
        devApp = ["/module/#{module}/src/#{cf.app}.js"]

    devApp: devApp
    baseUrl: '../'
    preserveLicenseComments: false
    removeCombined: true,
    findNestedDependencies: true,
    skipSemiColonInsertion: true,
    include: ["module/bower_components/requirejs/require.js", "module/#{module}/src/#{t}"]
    out: "#{module}/lib/#{t}.js"

    optimize: "uglify2"

    paths:
        jquery: pathPrefix + "bower_components/jquery/jquery"
        jquery: lrPath + "js/jquery-2.1.1.min"
        zepto: pathPrefix + "bower_components/zepto/zepto"
        underscore: pathPrefix + "bower_components/underscore/underscore"
        ratchet: pathPrefix + "bower_components/ratchet/dist/js/ratchet"
        handlebars: pathPrefix + "bower_components/handlebars/handlebars"
        backbone: pathPrefix + "bower_components/backbone/backbone"
        text: pathPrefix + "bower_components/text/text"
        finger: pathPrefix + "bower_components/jquery.finger/dist/jquery.finger"
        hbs: pathPrefix + "bower_components/requirejs-hbs/hbs"
        layoutEngine: lrPath + "js/layout.engine"
        bootstrap: pathPrefix + "bower_components/bootstrap/dist/js/bootstrap"

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