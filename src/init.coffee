appdir         = process.cwd()
express        = require 'express'
bodyParser     = require 'body-parser'
multer         = require 'multer'
methodOverride = require 'method-override'
favicon        = require 'serve-favicon'
serveStatic    = require 'serve-static'
morgan         = require 'morgan'
errorhandler   = require 'errorhandler'
path           = require 'path'
injector       = require 'render-options-injector'
mainRouter     = require '../routes/main'
config         = require('../config').config

exports.app = (app) ->
  rootPath = process.cwd()
  app.set 'port', config.port
  app.set 'views', path.join(rootPath, 'views')
  app.set 'view engine', 'jade'
  app.use favicon("#{appdir}/public/favicon.ico")
  app.use morgan('dev')
  app.use bodyParser.urlencoded({ extended: true })
  app.use multer()
  app.use bodyParser.json()
  app.use methodOverride('_method')
  app.use serveStatic(path.join(rootPath, 'public'))

  if app.get 'env' is 'development'
    app.use errorhandler({dumpExceptions: true, showStack: true})
  else
    app.use errorhandler()

  injector.inject app, {env: app.settings.env}

exports.router = (app) ->
  app.use '/', require("#{appdir}/routes/main")
  app.use '/', require("#{appdir}/routes/users")
