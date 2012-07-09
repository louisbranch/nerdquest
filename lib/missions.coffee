#TODO Get user to save his own mission

async = require('async')
facebook = require('../lib/facebook')
clue = require('../lib/clue')
creator = require('../lib/creator')
db = require('../lib/db')

organizeMission = ({path, suspects}) ->
  mission = path
  mission.suspects = suspects
  mission

exports.create = (token, callback) ->
  mission = {}
  async.parallel
    clues: (callback) ->
      facebook.getFriend token, (friend, suspects) ->
        mission.suspects = suspects
        clue.addClues friend, (clues) ->
          callback(null, clues)
    missions: (callback) ->
      db.getMissions (missions) ->
        callback(null, missions)
    (err, results) ->
      callback results
  #mission.path = creator.createMissionPath({levels: 3, clues: mission.clues, missions: mission.missions})
  #mission = organizeMission(mission)
  #db.saveMission (new_mission), (id) ->
  #  console.log id
  #mission

