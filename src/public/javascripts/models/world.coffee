Nerd.World = Backbone.RelationalModel.extend
  isRight: ->
    false

Nerd.Worlds = Backbone.Collection.extend
  model: Nerd.World

  currentWorld: {}

  worldsByLevel: (lvl) ->
    _.select @models, (world) ->
      world.get('level') == lvl

  gotToWorld: (world) ->
    @currentWorld = world

  firstWorld: ->
    first = @worldsByLevel(0)[0]
    @gotToWorld(first)

  start: (callback) ->
    firstWorld = @firstWorld()
    nextWorlds = @worldsByLevel(1)
    callback({firstWorld, nextWorlds})
