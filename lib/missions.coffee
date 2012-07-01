facebook = require '../lib/facebook'
clue = require '../lib/clue'
creator = require '../lib/creator'
db = require '../lib/db'

exports.create = (token, callback) ->
  suspects = []
  clues = []
  missions = []
  # Run in parallel
  facebook.getFriend token, (friend, suspects) ->
    suspects = suspects
    clue.addClues friend, (clues) ->
      clues = clues
  db.getMissions (missions) ->
    missions = missions
  new_mission = creator.createMissionPath({levels: 3, clues: clues, missions: missions})
    db.saveMission (new_mission), (id) ->
      console.log id

