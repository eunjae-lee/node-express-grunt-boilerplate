forever = require 'forever'

exports.getApp = (callback) ->
  forever.list false, (ignore, apps) ->
    for i in [0..apps.length - 1]
      app = apps[i]
      if process.cwd() == app.spawnWith.cwd
        callback app, i
        return
    callback null