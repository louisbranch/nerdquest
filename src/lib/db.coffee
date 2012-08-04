config = require('../config')
nano = require('nano')(config.db)

exports.findUser = (id, callback) ->
  users = nano.db.use('users')
  users.get id, (err, body) ->
    callback(err) if err

exports.saveUser = (id, data, callback) ->
  users = nano.db.use('users')
  users.insert data, id, (err, body) ->
    if err
      console.log err
    else if typeof callback == 'function'
      callback(body.id)

mapWorlds = (row) ->
  world = row.doc
  delete(world._id)
  delete(world._rev)
  world

exports.getWorlds = (callback) ->
  worlds = nano.db.use('worlds')
  worlds.list {include_docs: true}, (err, body) ->
    return if err
    worlds = body.rows.map(mapWorlds)
    callback(worlds)
