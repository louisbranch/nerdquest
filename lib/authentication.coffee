app = require('../config').app
base64url = require('b64url')
db = require('../lib/db')
facebook = require('../lib/facebook')

exports.url = "https://www.facebook.com/dialog/oauth?client_id=#{app.id}&redirect_uri=#{app.canvas_url}&scope=#{app.scope.join(',')}"

getToken = (signed_request) ->
  encoded_data = signed_request.split('.',2)
  json = base64url.decode(encoded_data[1])
  data = JSON.parse(json)
  {id: data.user_id, token: data.oauth_token}

exports.user = (signed_request, callback) ->
  user = getToken(signed_request)
  db.findUser user.id, (err) ->
    if err
      facebook.getUser user.token, (id, data) ->
        db.saveUser(id, data)
  callback(user)
