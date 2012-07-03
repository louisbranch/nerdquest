https = require('https')
qs = require('querystring')
suspect = require('../lib/suspect')

graphAPI = (path, callback) ->
  buffer = ''

  parseResult = ->
    json = JSON.parse(buffer)
    callback(json.data)

  options = {
    host: 'graph.facebook.com'
    path: path
  }

  req = https.get options, (res) ->
    res.setEncoding('utf8')

    res.on 'data', (chunk) ->
      buffer += chunk.toString()

    res.on('end', parseResult)

  req.on 'error', (e) ->
    console.log e

# Gets the user information
exports.getUser = (token, callback) ->
  path = "/me?access_token=#{token}"
  graphAPI(path, callback)

# Gets a random friend from Facebook
# using the FQL
getRandomFriends = (token, callback) ->
  path = "/fql?q=SELECT+uid,+name+FROM+user+WHERE+uid+IN+(SELECT+uid2+FROM+friend+WHERE+uid1+=+me())+ORDER+BY+rand()+limit+3&access_token=#{token}"
  graphAPI(path, callback)

# Gets a friend information and all
# his likes using a Gaph.API batch query
getFriendInfo = (uid, token, callback) ->

  buffer = ''

  parseResult = ->
    json = JSON.parse(buffer)
    friend = JSON.parse(json[0].body)
    likes = JSON.parse(json[1].body)
    friend.likes = likes.data
    callback(friend)

  params = {
    access_token: token
    batch: "[ { 'method': 'GET', 'relative_url': '#{uid}' }, { 'method': 'GET', 'relative_url': '#{uid}/likes' } ]"
  }

  batch_request = qs.stringify(params)

  options = {
    host: 'graph.facebook.com'
    path: "/"
    method: 'POST'
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded'
      'Content-Length': batch_request.length
    }
  }

  req = https.request options, (res) ->
    res.setEncoding('utf8')

    res.on 'data', (chunk) ->
      buffer += chunk.toString()

    res.on('end', parseResult)

  req.on 'error', (e) ->
    console.log e

  req.write(batch_request)
  req.end()

exports.getFriend = (token, callback) ->
  getRandomFriends token, (friends) ->
    [uid, suspects] = suspect.select(friends)
    getFriendInfo uid, token, (friend) ->
      callback(friend, suspects)
