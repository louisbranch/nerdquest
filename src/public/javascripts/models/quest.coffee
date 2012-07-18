Nerd.Quest = Backbone.RelationalModel.extend

  relations: [
    {
      type: Backbone.HasMany
      key: 'worlds'
      relatedModel: 'Nerd.World'
      collectionType: 'Nerd.Worlds'
      reverseRelation:
        key: 'quest'
    }
    {
      type: Backbone.HasMany
      key: 'suspects'
      relatedModel: 'Nerd.Suspect'
      collectionType: 'Nerd.Suspects'
      reverseRelation:
        key: 'quest'
    }
  ]

  start: (callback) ->
    @get('worlds').start(callback)

  scoreRightWorld: (level, callback) ->
    nextWorlds = @get('worlds').worldsByLevel(level+1)
    if nextWorlds.length == 0
      @trigger('finalLevel')
    else
      callback(null, {nextWorlds})

  scoreWrongWorld: ->
    console.log 'meh'

  finish: ->
    console.log 'Finish HIM!'

Nerd.Quests = Backbone.Collection.extend
  model: Nerd.Quest
  url: '/quests'
