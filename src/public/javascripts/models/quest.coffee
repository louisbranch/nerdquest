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
    @set('timerStart', new Date())
    @get('worlds').start(callback)

  finish: ->
    @set('timerEnd', new Date())
    @duration()
    @trigger('finished')

  increaseScore: (n) ->
    multiplier = @get('scoreMultiplier')
    newScore = @get('score') + (n * multiplier)
    @set('score', newScore)
    @set('scoreMultiplier', multiplier + 1)

  decreaseScore: (n) ->
    multiplier = @get('scoreMultiplier')
    newScore = @get('score') - n
    @set('score', newScore)
    unless multiplier == 0
      @set('scoreMultiplier', multiplier - 1)

  scoreRightWorld: (level, callback) ->
    @increaseScore(300)
    @set('rightWorlds', @get('rightWorlds') + 1)
    nextWorlds = @get('worlds').worldsByLevel(level+1)
    if nextWorlds.length == 0
      @trigger('finalLevel')
    else
      callback(null, {nextWorlds})

  scoreWrongWorld: ->
    @decreaseScore(800)
    @set('wrongWorlds', @get('wrongWorlds') + 1)

  scoreRightSuspect: ->
    @increaseScore(1000)

  scoreWrongSuspect: ->
    @increaseScore(2500)

  useClue: ->
    @decreaseScore(300)
    @set('usedClues', @get('usedClues') + 1)

  duration: ->
    time = @get('timerEnd') - @get('timerStart')
    seconds = parseInt(time / 1000)
    minutes = parseInt(time / 1000 / 60)
    @set('duration', "#{minutes}:#{seconds}")

Nerd.Quests = Backbone.Collection.extend
  model: Nerd.Quest
  url: '/quests'
