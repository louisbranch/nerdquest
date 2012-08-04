#TODO Save user quest

async = require('async')
_ = require('underscore')
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
      db.getWorlds (worlds) ->
        quest = creator.createQuestPath({levels: 3, worlds})
        callback(null, quest)
    (err, results) ->
      unless err
        quest = results.quest
        quest.suspects = _.shuffle(results.suspects)
        #db.saveQuest (user_id, quest), (id) ->
        #  console.log id
        callback(quest)

