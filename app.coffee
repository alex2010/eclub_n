express = require('express')
path = require('path')
favicon = require('serve-favicon')
logger = require('morgan')
cookieParser = require('cookie-parser')
bodyParser = require('body-parser')

`_ = require('underscore');
app = express();
app.env = app.get('env') == 'development';
app.setting = require('./setting');
log = console.log;
_path = __dirname;
_resPath = app.env ? '/res/' : setting.res_path;
dao = new require('./model/dao')('main');
dbCache = new require('./model/cache')()`

app._script = {}
app._community = {}

_ts = require('./tmplScript')
app.pickScript = (code)->
    sc = app._script[code]
    if sc
        sc
    else
        sc = _.extend _.clone(_ts), require("./public/module/#{code}/tmplScript")
        app._script[code] = sc
    sc


app.setCommunity = (dao, code, callback)->
    if app._community[code]
        callback()
    else
        dao.get code, 'community', code: code, (c)->
            dao.get code, 'role', title: 'guest', (item)->
                c.menu = item.res.menu
                app._community[code] = c
                callback()

# view engine setup
app.set 'view engine', 'jade'


# uncomment after placing your favicon in /public
#app.use(favicon(__dirname + '/public/favicon.ico'));

#app.use logger('dev')
app.use bodyParser.json()
app.use bodyParser.urlencoded(extended: false)
app.use cookieParser()

app.use express.static(path.join(__dirname, 'public'))
#app.use express.static(path.join(__dirname, 'public/res'))

app.use '/', require('./routes/index')


# catch 404 and forward to error handler
app.use (req, res, next) ->
    err = new Error('Not Found')
    err.status = 404
    next err
    return
# error handlers
# development error handler
# will print stacktrace
if app.env
    app.use (err, req, res, next) ->
        res.status err.status or 500
        res.render 'error',
            message: err.message
            error: err
        return

# production error handler
# no stacktraces leaked to user
app.use (err, req, res, next) ->
    res.status err.status or 500
    res.render 'error',
        message: err.message
        error: {}
    return

module.exports = app
