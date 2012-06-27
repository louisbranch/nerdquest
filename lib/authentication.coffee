base64url = require('b64url')

exports.parse_signed_request = (signed_request) ->
  encoded_data = signed_request.split('.',2)
  json = base64url.decode(encoded_data[1])
  data = JSON.parse(json)
  data.oauth_token
