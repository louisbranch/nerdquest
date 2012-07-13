quests = require '../lib/quests'

exports.create = (req, res) ->
  id = req.session.id
  token = req.session.token
  quests.create id, token, (quest) ->
    res.send [quest]
