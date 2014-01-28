express = require 'express'
http = require 'http'
config = require('./config').config
init = require './src/init'

unless config.port
  console.error "config.port is missing. Check out \"config.coffee\" file."
  process.exit 1

app = express()
init.app app
init.router app

http.createServer(app).listen app.get('port'), ->
  console.log "Express server listening on port #{app.get('port')} in #{app.settings.env} mode"