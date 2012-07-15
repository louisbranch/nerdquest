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

  scoreRightWorld: (level, callback) ->
    nextWorlds = @get('worlds').worldsByLevel(level+1)
    callback(null, {nextWorlds})

  scoreWrongWorld: ->
    console.log 'meh'

Nerd.Quests = Backbone.Collection.extend
  model: Nerd.Quest
  url: '/quests'
