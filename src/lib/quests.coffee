#TODO Save user quest

async = require('async')
facebook = require('../lib/facebook')
clue = require('../lib/clue')
creator = require('../lib/creator')
db = require('../lib/db')

organizeQuest = (path, suspects) ->
  quest = path
  quest.suspects = suspects
  quest

exports.create = (user_id, token, callback) ->
  quest_suspects = []
  async.parallel
    clues: (callback) ->
      facebook.getFriend token, (friend, suspects) ->
        quest_suspects = suspects
        clue.addClues friend, (clues) ->
          callback(null, clues)
    missions: (callback) ->
      db.getMissions (missions) ->
        callback(null, missions)
    (err, results) ->
      unless err
        path = creator.createQuestPath({levels: 3, clues: results.clues, missions: results.missions})
        quest = organizeQuest(path, quest_suspects)
        #db.saveQuest (user_id, quest), (id) ->
        #  console.log id
        callback(quest)

