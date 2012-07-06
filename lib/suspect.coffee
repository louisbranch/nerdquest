_ = require('underscore')

# Ignore 8 default FB attributes
# Must have at least 3 info for clues
filterSuspect = (suspect) ->
  _.keys(suspect).length > 11

exports.select = (suspects, callback) ->
  for suspect in suspects
    if filterSuspect(suspect)
      suspect.guilt = true
      guilt_id = suspect.id
      break
  if guilt_id
    callback(null, guilt_id, suspects)
  else
    callback('No friends with enough valid information found')

