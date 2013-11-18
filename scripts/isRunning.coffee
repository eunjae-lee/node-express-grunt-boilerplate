colors = require 'colors'
helper = require './helper'

helper.getApp (app, index) ->
  if app
    console.log "App(#{app.pid}) is running.".green
    console.log "Path : #{app.spawnWith.cwd}".cyan
    console.log "Log File : #{app.logFile}".cyan
  else
    console.log "App is not running".red