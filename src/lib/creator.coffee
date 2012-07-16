_ = require('underscore')

getMissions = (json) ->
  _.shuffle(json)

getFriendClues = (json) ->
  _.shuffle(json)

setQuest = (missions) ->
  quest = missions.pop()
  quest.worlds = []
  quest

getWorlds = (missions) ->
  missions.worlds = missions.map (mission) ->
    mission.world

addWorld = (quest, world) ->
  quest.worlds.push(world)

shuffleQuest = (quest) ->
  quest.worlds = _.shuffle(quest.worlds)
  for world in quest.worlds
    delete world.clues
  delete quest.shuffleQuest
  quest

addClues = ({clues, world, previous_world}) ->
  world.friend_clue = clues.pop()
  if previous_world
    world.nextClues = _.shuffle(previous_world.clues)

setFirstWorld = (quest, clues, previous_world) ->
  world = quest.world
  delete quest.world
  addClues({clues, world, previous_world})
  world.level = 0
  addWorld(quest, world)

createCorrectPath = ({missions, quest, clues, levels}) ->
  previous_world = undefined
  while levels > 0
    world = missions.worlds.pop()
    world.level = levels
    unless previous_world
      world.final = true
    addClues({clues, world, previous_world})
    previous_world = world
    addWorld(quest, world)
    levels -= 1
  setFirstWorld(quest, clues, previous_world)

createWrongPath = ({missions, quest, levels}) ->
  while levels > 0
    times = 2
    while times > 0
      world = missions.worlds.pop()
      world.level = levels
      addWorld(quest, world)
      times -= 1
    levels -= 1

exports.createQuestPath = ({levels, missions, clues}) ->
  missions = getMissions(missions)
  quest = setQuest(missions)
  getWorlds(missions)
  clues = getFriendClues(clues)
  createCorrectPath({missions, quest, clues, levels})
  createWrongPath({missions, quest, levels})
  shuffleQuest(quest)
