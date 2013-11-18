colors = require 'colors'
require 'shelljs/global'
fs = require 'fs'
helper = require './helper'
forever = require 'forever'

helper.getApp (app, index) ->
  return console.log "Nothing stopped!".red unless app

  forever.stop index
  console.log "The process(#{app.pid}) has been stopped".green
  console.log "Path : #{app.spawnWith.cwd}".cyan
  console.log "Log File : #{app.logFile}".cyan