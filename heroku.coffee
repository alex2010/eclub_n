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

#
#onListening = ->
#    addr = server.address()
#    bind = if typeof addr == 'string' then 'pipe ' + addr else 'port ' + addr.port
#    debug 'Listening on ' + bind
#    return

app._hk = 'hk'
#app.set 'hk', 'hk'
server = http.createServer(app)
server.listen(3000)
server.on('error', onError)
#server.on('listening', onListening)
