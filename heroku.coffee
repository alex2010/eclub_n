#!/usr/bin/env coffee

app = require('./app')
http = require('http')


onError = (error) ->
    if error.syscall != 'listen'
        throw error
    bind = if typeof port == 'string' then 'Pipe ' + port else 'Port ' + port
    switch error.code
        when 'EACCES'
            console.error bind + ' requires elevated privileges'
            process.exit 1
        when 'EADDRINUSE'
            console.error bind + ' is already in use'
            process.exit 1
        else
            throw error
    return

app.set('port', (process.env.PORT || 3000))
app._hk = 'hk'
server = http.createServer(app)
server.listen(app.get('port'))
server.on('error', onError)
