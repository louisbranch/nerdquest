Nerd.Suspect = Backbone.RelationalModel.extend

  relations: [
    type: Backbone.HasMany
    key: 'clues'
    relatedModel: 'Nerd.Clue'
    collectionType: 'Nerd.Clues'
    reverseRelation:
      key: 'suspect'
  ]

  isRight: (callback) ->
    if @get('clues')
      callback(null, true)
    else
      callback('Wrong suspect')

Nerd.Suspects = Backbone.Collection.extend
  model: Nerd.Suspect
