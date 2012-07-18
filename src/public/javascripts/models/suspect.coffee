Nerd.Suspect = Backbone.RelationalModel.extend
  isRight: (callback) ->
    if @get('clues')
      callback(null, true)
    else
      callback('Wrong suspect')

Nerd.Suspects = Backbone.Collection.extend
  model: Nerd.Suspect
