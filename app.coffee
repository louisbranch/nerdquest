express = require 'express'
routes  = require './routes'
http    = require 'http'
auth    = require './lib/authentication'

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

app.get '/', routes.index

app.post '/', (req, res) ->
  signed_request = req.param('signed_request')
  if signed_request
    token = auth.parse_signed_request(signed_request)
    res.render 'index', { token: token }
  else
    res.render 'index'

http.createServer(app).listen(app.get('port'))
