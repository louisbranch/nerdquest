facebook = require '../lib/facebook'
clue = require '../lib/clue'
creator = require '../lib/creator'
# db = require '../lib/db'

exports.index = (req, res) ->
  friend = ''
  missions = ''
  token = req.cookies.token
  # Run in parallel
  facebook.getFriend token, (friend) ->
    clue.addClues friend, (friend) ->
      friend = friend
  db.getMissions (missions) ->
    missions = missions
  new_mission = creator.createMission({levels: 3, clues: friend.clues, missions: missions})
  db.saveMission (new_mission), ->
    console.log('mission saved')
  new_mission
