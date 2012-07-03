config = require('../config')
nano = require('nano')(config.db.url)

exports.findUser = (_id, callback) ->
  users = nano.db.use('users')
  user.get _id, {}, (err, body) ->
    callback(err) if err

exports.addUser = (json, callback) ->
  users = nano.db.use('users')
  user = {_id: json.uid, name: json.name}
  missions.insert user, {}, (err, body) ->
    if !err || typeof callback == 'function'
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
    unless err
      callback(body.id)
