_ = require('underscore')

Quest = ->
  {
    score: 0
    duration: 0
    scoreMultiplier: 10
    usedClues: 0
    rightWorlds: 0
    wrongWorlds: 0
    timerStart: 0
    timerEnd: 0
    worlds: []
  }

getWorlds = (json) ->
  _.shuffle(json)

addWorld = (quest, world) ->
  quest.worlds.push(world)

shuffleQuest = (quest) ->
  quest.worlds = _.shuffle(quest.worlds)
  for world in quest.worlds
    delete world.clues
  quest

addClues = ({world, previous_world}) ->
  world.nextClues = _.shuffle(previous_world.clues)

createCorrectPath = ({worlds, quest, levels}) ->
  previous_world = undefined
  while levels >= 0
    world = worlds.pop()
    world.level = levels
    if previous_world
      addClues({world, previous_world})
    else
      world.final = true
    previous_world = world
    addWorld(quest, world)
    levels -= 1

createWrongPath = ({worlds, quest, levels}) ->
  while levels > 0
    times = 2
    while times > 0
      world = worlds.pop()
      world.level = levels
      addWorld(quest, world)
      delete world.clues
      times -= 1
    levels -= 1

exports.createQuestPath = ({levels, worlds}) ->
  quest = new Quest()
  worlds = getWorlds(worlds)
  createCorrectPath({worlds, quest, levels})
  createWrongPath({worlds, quest, levels})
  shuffleQuest(quest)
