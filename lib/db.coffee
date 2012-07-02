config = require('../config')
nano = require('nano')(config.db.url)

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
