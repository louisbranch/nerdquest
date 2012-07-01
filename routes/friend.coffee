facebook = require '../lib/facebook'

exports.index = (req, res) ->
  token = req.cookies.token
  facebook.getFriend token, (friend, suspects) ->
    res.send {friend: friend, suspects: suspects}
