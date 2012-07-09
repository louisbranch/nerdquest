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

exports.create = (user, callback) ->
  mission = {}
  async.parallel
    clues: (callback) ->
      facebook.getFriend user.token, (friend, suspects) ->
        mission.suspects = suspects
        clue.addClues friend, (clues) ->
          callback(null, clues)
    missions: (callback) ->
      db.getMissions (missions) ->
        callback(null, missions)
    (err, results) ->
      unless err
        callback results
        #mission.path = creator.createMissionPath({levels: 3, clues: results.clues, missions: results.missions})
        #mission = organizeMission(mission)
        #db.saveMission (user, mission), (id) ->
        #  console.log id
        #callback(mission)

