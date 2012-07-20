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
    @timerStart = new Date()
    @get('worlds').start(callback)

  finish: ->
    @timerEnd = new Date()
    @stats()
    @trigger('finished')

  score: 0
  scoreMultiplier: 10
  usedClues: 0
  rightWorlds: 0
  wrongWorlds: 0
  timerStart: 0
  timerEnd: 0

  increaseScore: (n) ->
    @score = @score + (n * @scoreMultiplier)
    @scoreMultiplier += 1

  decreaseScore: (n) ->
    @score = @score - n
    unless @scoreMultiplier == 0
      @scoreMultiplier -= 1

  scoreRightWorld: (level, callback) ->
    @increaseScore(300)
    @rightWorlds +=1
    nextWorlds = @get('worlds').worldsByLevel(level+1)
    if nextWorlds.length == 0
      @trigger('finalLevel')
    else
      callback(null, {nextWorlds})

  scoreWrongWorld: ->
    @decreaseScore(800)
    @wrongWorlds += 1

  scoreRightSuspect: ->
    @increaseScore(1000)

  scoreWrongSuspect: ->
    @increaseScore(2500)

  useClue: ->
    @decreaseScore(300)
    @usedClues += 1

  duration: ->
    time = @timerEnd - @timerStart
    seconds = parseInt(time / 1000)
    minutes = parseInt(time / 1000 / 60)
    "#{minutes}:#{seconds}"

  stats: ->
    @set({
      score: @score
      rightWorlds: @rightWorlds
      wrongWorlds: @wrongWorlds
      usedClues: @usedClues
      duration: @duration()
    })

Nerd.Quests = Backbone.Collection.extend
  model: Nerd.Quest
  url: '/quests'
