Array::shuffle = -> @sort -> 0.5 - Math.random()

getMissions = (json) ->
  json.shuffle()

getFriendClues = (json) ->
  json.shuffle()

setMission = (missions) ->
  mission = missions.pop()
  mission.worlds = []
  mission

getWorlds = (missions) ->
  missions.worlds = missions.map (mission) ->
    mission.world

addWorld = (mission, world) ->
  mission.worlds.push(world)

shuffleMission = (mission) ->
  mission.worlds.shuffle()
  for world in mission.worlds
    delete world.clues
  delete mission.shuffleMission
  mission

addClues = ({clues, world, previous_world}) ->
  world.friend_clue = clues.pop()
  world.world_clues = previous_world.clues.shuffle()

setFirstWorld = (mission, clues, previous_world) ->
  world = mission.world
  delete mission.world
  addClues({clues: clues, world: world, previous_world: previous_world})
  world.level = 0
  addWorld(mission, world)

createCorrectPath = ({missions, mission, clues, levels}) ->
  previous_world = undefined
  final_world = true
  while levels > 0
    world = missions.worlds.pop()
    world.level = levels
    unless final_world
      addClues({clues: clues, world: world, previous_world: previous_world})
    final_world = false
    previous_world = world
    addWorld(mission, world)
    levels -= 1
  setFirstWorld(mission, clues, previous_world)

createWrongPath = ({missions, mission, levels}) ->
  while levels > 0
    times = 2
    while times > 0
      world = missions.worlds.pop()
      world.level = levels
      addWorld(mission, world)
      times -= 1
    levels -= 1

exports.createMissionPath = ({levels, missions, clues}) ->
  missions = getMissions(missions)
  mission = setMission(missions)
  getWorlds(missions)
  clues = getFriendClues(clues)
  createCorrectPath({missions: missions, mission: mission, clues: clues, levels: levels})
  createWrongPath({missions: missions, mission: mission, levels: levels})
  shuffleMission(mission)
