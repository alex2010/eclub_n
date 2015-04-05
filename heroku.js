// Generated by CoffeeScript 1.9.1
var app, http, onError, server;

app = require('./app');

http = require('http');

onError = function(error) {
  var bind;
  if (error.syscall !== 'listen') {
    throw error;
  }
  bind = typeof port === 'string' ? 'Pipe ' + port : 'Port ' + port;
  switch (error.code) {
    case 'EACCES':
      console.error(bind + ' requires elevated privileges');
      process.exit(1);
      break;
    case 'EADDRINUSE':
      console.error(bind + ' is already in use');
      process.exit(1);
      break;
    default:
      throw error;
  }
};

app.set('port', process.env.PORT || 3000);

app._hk = 'hk';

server = http.createServer(app);

server.listen(app.get('port'));

server.on('error', onError);
