facebook = require '../lib/facebook'
clue = require '../lib/clue'
creator = require '../lib/creator'
# db = require '../lib/db'

exports.create = (token, callback) ->
  # Run in parallel
  facebook.getFriend token, (friend, suspects) ->
    clue.addClues friend, (friend) ->
      res.send {friend: friend, suspects: suspects}
  # db.getMissions (missions) ->
  #   missions = missions
  # new_mission = creator.createMission({levels: 3, clues: friend.clues, missions: missions})
  # db.saveMission (new_mission), ->
  #   console.log('mission saved')
  # new_mission
