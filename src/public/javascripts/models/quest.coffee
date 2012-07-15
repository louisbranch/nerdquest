Nerd.Quest = Backbone.RelationalModel.extend

  relations: [
    type: Backbone.HasMany
    key: 'worlds'
    relatedModel: 'Nerd.World'
    collectionType: 'Nerd.Worlds'
    reverseRelation:
      key: 'quest'
  ]

  start: (callback) ->
    world = @get('worlds').firstWorld()
    callback(world)

Nerd.Quests = Backbone.Collection.extend
  model: Nerd.Quest
  url: '/quests'
