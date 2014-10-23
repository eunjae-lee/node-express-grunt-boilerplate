appdir = process.cwd()
config = require("#{appdir}/config").config
require 'shelljs/global'

exec "wrk -t12 -c400 -d30s http://localhost:#{config.port}"
