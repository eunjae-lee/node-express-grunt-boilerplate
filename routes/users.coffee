express = require 'express'
router  = express.Router()

router.get '/login', (req, res) ->
  res.render 'login', {title: "Login"}

module.exports = router
