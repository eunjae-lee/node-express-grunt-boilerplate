express = require 'express'
routes = require './routes/routes'
http = require 'http'
path = require 'path'
config = require('./config').config

app = express()

app.set 'port', config.port
app.set 'views', __dirname + '/views'
app.set 'view engine', 'jade'
app.use express.favicon()
app.use express.logger 'dev'
app.use express.bodyParser()
app.use express.methodOverride()
app.use app.router
app.use express.static(path.join __dirname, 'public_built')

app.configure 'development', ->
  app.use express.errorHandler({dumpExceptions: true, showStack: true})

app.configure 'production', ->
  app.use express.errorHandler()

app.get '/', routes.index
app.get '/login', routes.login

http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port #{app.get('port')} in #{app.settings.env} mode"