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

mapMissions = (row) ->
  mission = row.doc
  delete(mission._id)
  delete(mission._rev)
  mission

exports.getMissions = (callback) ->
  missions = nano.db.use('missions')
  missions.list {include_docs: true}, (err, body) ->
    unless err
      missions = body.rows.map(mapMissions)
      callback(missions)

exports.saveMission = (json, callback) ->
  missions = nano.db.use('missions')
  missions.insert json, null, (err, body) ->
    callback(body.id) unless err
