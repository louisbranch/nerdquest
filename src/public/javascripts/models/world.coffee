Nerd.World = Backbone.RelationalModel.extend

  relations: [
    type: Backbone.HasMany
    key: 'nextClues'
    relatedModel: 'Nerd.Clue'
    collectionType: 'Nerd.Clues'
    reverseRelation:
      key: 'world'
  ]

  isRight: (callback) ->
    nextClues = @get('nextClues').models
    if _.any(nextClues) || @get('final')
      level = @get('level')
      @get('quest').scoreRightWorld(level, callback)
    else
      @get('quest').scoreWrongWorld()
      callback('Wrong world', null)

Nerd.Worlds = Backbone.Collection.extend
  model: Nerd.World

  worldsByLevel: (lvl) ->
    _.select @models, (world) ->
      world.get('level') == lvl

  firstWorld: ->
    @worldsByLevel(0)[0]

  start: (callback) ->
    firstWorld = @firstWorld()
    nextWorlds = @worldsByLevel(1)
    callback({firstWorld, nextWorlds})
