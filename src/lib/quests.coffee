#TODO Save user quest

async = require('async')
facebook = require('../lib/facebook')
clue = require('../lib/clue')
creator = require('../lib/creator')
db = require('../lib/db')

exports.create = (user_id, token, callback) ->
  async.parallel
    suspects: (callback) ->
      facebook.getFriends token, (guilted, suspects) ->
        clue.addClues guilted, (clues) ->
          suspects[0].clues = clues
          callback(null, suspects)
    quest: (callback) ->
      db.getMissions (missions) ->
        quest = creator.createQuestPath({levels: 3, missions: missions})
        callback(null, quest)
    (err, results) ->
      unless err
        quest = results.quest
        quest.suspects = results.suspects
        #db.saveQuest (user_id, quest), (id) ->
        #  console.log id
        callback(quest)

