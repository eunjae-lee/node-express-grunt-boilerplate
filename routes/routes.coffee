exports.index = (req, res) ->
  res.render 'index', {title: "Hello world"}

exports.login = (req, res) ->
  res.render 'login', {title: "Login"}