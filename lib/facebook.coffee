https = require 'https'

api = (path, callback) ->

  buffer = ''

  options = {
    host: 'graph.facebook.com'
    path: path
    method: 'GET'
  }

  https.get options, (res) ->
    res.setEncoding('utf8')

    res.on 'data', (data) ->
      buffer += data.toString()

    res.on 'error', (e) ->
      console.log e

    res.on 'end', parse

  parse = ->
    json = JSON.parse(buffer)
    callback(json.data)

exports.get_friend = (token, callback) ->
  path = "/fql?q=SELECT+uid,+name+FROM+user+WHERE+uid+IN+(SELECT+uid2+FROM+friend+WHERE+uid1+=+me())+ORDER+BY+rand()+limit+1&access_token=#{token}"
  api path, (friend) ->
    callback(friend)
