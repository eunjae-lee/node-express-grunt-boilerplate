exports.config =
  appname: "your appname for pm2"
  port: 3000
  # Configure debug levels
  # Available options ordered by the level
  # which a log line is triggered
  # Example: Setting the server level to error and calling
  # logger.debug('Foo') will not create a log line
  # Levels:
  #   verbose
  #   prompt
  #   debug
  #   info
  #   data
  #   help
  #   warn
  #   error
  levels:
    server: 'debug'
