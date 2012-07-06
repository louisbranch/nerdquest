# TODO move secrets to app config
http = require('http')
express = require('express')
socket = require('socket.io')
routes = require('./routes')
friend = require('./routes/friend')
missions = require('./routes/missions')

app = express()

app.configure ->
  app.set('port', process.env.PORT || 9393)
  app.set('views', __dirname + '/views')
  app.set('view engine', 'jade')
  app.use(express.favicon())
  app.use(express.logger('dev'))
  app.use(express.bodyParser())
  app.use(express.methodOverride())
  app.use(express.cookieParser('your secret here'))
  app.use(express.session())
  app.use(app.router)
  app.use(express.static(__dirname + '/public'))

app.configure 'development', ->
  app.use(express.errorHandler())

app.get('/', routes.index)
app.post('/', routes.index)
app.get('/friend.json', friend.index)
app.get('/missions', missions.new)

server = http.createServer(app).listen(app.get('port'))

io = socket.listen(server)
io.sockets.on 'connection', (socket) ->
  socket.emit('news', { hello: 'world' })
  socket.on 'my other event', (data) ->
    console.log(data)
