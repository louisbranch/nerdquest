auth = require '../lib/authentication'

exports.index = (req, res) ->
  signed_request = req.param('signed_request')
  auth.user signed_request, (err, user) ->
    if err
      res.render('canvas', {url: auth.url})
    else
      req.session.id = user.id
      req.session.token = user.token
      res.render('index')
