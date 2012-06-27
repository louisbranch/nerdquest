express = require 'express'
routes = require './routes'
friend = require './routes/friend'
http = require 'http'

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

app.post('/', routes.index)
app.get('/friend.json', friend.index)

http.createServer(app).listen(app.get('port'))
