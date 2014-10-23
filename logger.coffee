appdir  = process.cwd()
config  = require("#{appdir}/config").config
winston = require 'winston'

env = process.env.NODE_ENV || 'development'

for loggerName of config.loggers
  level = config.loggers[loggerName]
  appenders =
    console:
      label: loggerName
      level: level
      colorize: true
      handleExceptions: true
    file:
      label: loggerName
      level: level
      stripColors: true
      handleExceptions: true
      timestamp: true
      filename: "#{appdir}/log/#{env}.log"
      json: false
  logger = winston.loggers.add loggerName, appenders
  logger.exitOnError = false

module.exports = winston.loggers
