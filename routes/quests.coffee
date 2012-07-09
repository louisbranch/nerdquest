quests = require '../lib/quests'

exports.create = (req, res) ->
  token = req.session.token
  quests.create token, (quest) ->
    res.send quest
