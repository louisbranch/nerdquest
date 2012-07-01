# TODO: create filter function

exports.select = (friends) ->
  suspects = friends
  suspects[0].guilt = true
  guilt_uid = suspects[0].uid
  [guilt_uid, suspects]

