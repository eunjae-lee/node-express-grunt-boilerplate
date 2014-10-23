appdir  = process.cwd()
config  = require("#{appdir}/config").config
winston = require 'winston'

env = process.env.NODE_ENV || 'development'

for loggerName of config.logger.levels
  level = config.logger.levels[loggerName]
  appenders =
    console:
      label: loggerName
      level: level
      colorize: true
    file:
      label: loggerName
      level: level
      filename: "#{appdir}/log/#{env}.log"
      # Use config value or default to 10 MB
      maxSize: config.logger.file.maxSize || 10*1024*1024
      # Use config value or default to 1 file
      maxFiles: config.logger.file.maxFiles || 1
      stripColors: true
      timestamp: true
      json: false
  logger = winston.loggers.add loggerName, appenders
  logger.exitOnError = false

module.exports = winston.loggers
