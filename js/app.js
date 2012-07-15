// Generated by CoffeeScript 1.3.3
(function() {
  var app, config, express, friend, http, io, quests, routes, server, socket;

  http = require('http');

  express = require('express');

  socket = require('socket.io');

  config = require('./config');

  routes = require('./routes');

  friend = require('./routes/friend');

  quests = require('./routes/quests');

  app = express();

  app.configure(function() {
    app.set('port', process.env.PORT || 9393);
    app.set('views', __dirname + '/views');
    app.set('view engine', 'jade');
    app.use(express.favicon());
    app.use(express.logger('dev'));
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(express.cookieParser(config.secret));
    app.use(express.session());
    app.use(app.router);
    return app.use(express["static"](__dirname + '/public'));
  });

  app.configure('development', function() {
    return app.use(express.errorHandler());
  });

  app.get('/t', routes.tester);

  app.get('/', routes.index);

  app.post('/', routes.index);

  app.get('/friend.json', friend.index);

  app.get('/quests', quests.create);

  server = http.createServer(app).listen(app.get('port'));

  io = socket.listen(server);

  io.sockets.on('connection', function(socket) {
    socket.emit('news', {
      hello: 'world'
    });
    return socket.on('my other event', function(data) {
      return console.log(data);
    });
  });

}).call(this);