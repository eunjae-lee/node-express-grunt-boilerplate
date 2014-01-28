express = require 'express'
path = require 'path'
injector = require 'render-options-injector'
mainRouter = require '../routes/main'
config = require('../config').config

exports.app = (app) ->
  rootPath = process.cwd()
  app.set 'port', config.port
  app.set 'views', path.join(rootPath, 'views')
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger 'dev'
  app.use express.urlencoded()
  app.use express.json()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(path.join(rootPath, 'public'))

  app.configure 'development', ->
    app.use express.errorHandler({dumpExceptions: true, showStack: true})

  app.configure 'production', ->
    app.use express.errorHandler()

  injector.inject app, {env: app.settings.env}

exports.router = (app) ->
  app.get '/', mainRouter.index
  app.get '/login', mainRouter.login