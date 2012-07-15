Array::shuffle = -> @sort -> 0.5 - Math.random()

getMissions = (json) ->
  json.shuffle()

getFriendClues = (json) ->
  json.shuffle()

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
  quest.worlds.shuffle()
  for world in quest.worlds
    delete world.clues
  delete quest.shuffleQuest
  quest

addClues = ({clues, world, previous_world}) ->
  world.friend_clue = clues.pop()
  if previous_world
    world.world_clues = previous_world.clues.shuffle()

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
  createCorrectPath({missions: missions, quest: quest, clues: clues, levels: levels})
  createWrongPath({missions: missions, quest: quest, levels: levels})
  shuffleQuest(quest)
