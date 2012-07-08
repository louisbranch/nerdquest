missions = require '../lib/missions'

exports.create = (req, res) ->
  token = req.cookies.token
  missions.create token, (mission) ->
    res.send mission
