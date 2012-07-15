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
    @get('worlds').start(callback)

Nerd.Quests = Backbone.Collection.extend
  model: Nerd.Quest
  url: '/quests'
