#TODO Get user to save his own quest

async = require('async')
facebook = require('../lib/facebook')
clue = require('../lib/clue')
creator = require('../lib/creator')
db = require('../lib/db')

organizeQuest = ({path, suspects}) ->
  quest = path
  quest.suspects = suspects
  quest

exports.create = (user_id, token, callback) ->
  quest = {}
  async.parallel
    clues: (callback) ->
      facebook.getFriend token, (friend, suspects) ->
        quest.suspects = suspects
        clue.addClues friend, (clues) ->
          callback(null, clues)
    missions: (callback) ->
      db.getMissions (missions) ->
        callback(null, missions)
    (err, results) ->
      unless err
        callback results
        #quest.path = creator.createQuestPath({levels: 3, clues: results.clues, missions: results.missions})
        #quest = organizeQuest(quest)
        #db.saveQuest (user, quest), (id) ->
        #  console.log id
        #callback(quest)

