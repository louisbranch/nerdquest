facebook = require '../lib/facebook'

exports.index = (req, res) ->
  token = req.session.token
  facebook.getFriend token, (friend, suspects) ->
    res.send({friend, suspects})
