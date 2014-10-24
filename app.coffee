appdir       = process.cwd()
express      = require 'express'
app          = express()
http         = require 'http'
config       = require("#{appdir}/config").config
init         = require "#{appdir}/src/init"
logger       = require "#{appdir}/logger"
serverLogger = logger.get 'server'

unless config.port
  serverLogger.error "config.port is missing. Check out \"config.coffee\" file."
  process.exit 1

init.app app
init.router app

http.createServer(app).listen app.get('port'), ->
  serverLogger.info "Express server listening on port #{app.get('port')} in #{app.settings.env} mode"
