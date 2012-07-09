missions = require '../lib/missions'

exports.create = (req, res) ->
  token = req.session.token
  console.log token
  missions.create token, (mission) ->
    res.send mission
