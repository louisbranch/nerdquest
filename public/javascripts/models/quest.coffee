Nerd.Quest = Backbone.RelationalModel.extend

  relations: [
    {
      type: Backbone.HasMany
      key: 'worlds'
      relatedModel: 'Nerd.World'
    }
  ]

  worlds: ->
    @get('worlds')

  currentWorld: {}

  worldsByLevel: (lvl) ->
    _.select @worlds(), (world) ->
      world.level == lvl

  gotToWorld: (world) ->
    @currentWorld = world
    @trigger('worldChange', world)

  nextWorld: ->
    console.log 'changing world'

  start: ->
    console.log('starting')
    first = @worldsByLevel(0)[0]
    @gotToWorld(first)
    console.log @currentWorld

Nerd.Quests = Backbone.Collection.extend
  model: Nerd.Quest
  url: '/quests'

