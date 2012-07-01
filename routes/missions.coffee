missions = require '../lib/missions'

exports.new = (req, res) ->
  token = req.cookies.token
  missions.create token, (mission) ->
    res.send mission
