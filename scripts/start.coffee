colors = require 'colors'
require 'shelljs/global'

exec "grunt"
exec "forever start -c coffee app.coffee"
console.log "\n\nNow running via forever".green