Nerd.World = Backbone.RelationalModel.extend()

Nerd.Worlds = Backbone.Collection.extend
  model: Nerd.World

  currentWorld: {}

  worldsByLevel: (lvl) ->
    _.select @models, (world) ->
      world.get('level') == lvl

  gotToWorld: (world) ->
    @currentWorld = world
    world.trigger('new')

  firstWorld: ->
    first = @worldsByLevel(0)[0]
    @gotToWorld(first)

