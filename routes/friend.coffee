facebook = require '../lib/facebook'

exports.index = (req, res) ->
  token = req.cookies.token
  facebook.get_friend token, (friend) ->
    res.send friend
