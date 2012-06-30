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

build = (mission) ->
  mission.worlds.shuffle()
  for world in mission.worlds
    delete world.clues
    world.places.shuffle()
    delete mission.build

addClues = ({clues, world, previous_world, final_world}) ->
  first_place = true
  for place in world.places
    if first_place && final_world
      place.final = true
      first_place = false
    else if first_place
      clue = clues.pop()
      place.phrase = clue.phrase
      place.type = clue.type
      first_place = false
    else if previous_world
      place.phrase = previous_world.clues.shuffle().pop()
      place.type = 'world'

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
    addClues({clues: clues, world: world, previous_world: previous_world, final_world: final_world})
    final_world = false
    previous_world = world
    addWorld(mission, world)
    levels--
  setFirstWorld(mission, clues, previous_world)

createWrongPath = ({missions, mission, levels}) ->
  while levels > 0
    times = 2
    while times > 0
      world = missions.worlds.pop()
      world.level = levels
      addWorld(mission, world)
      times--
    levels--

exports.createMission = ({levels, missions, clues}) ->
  missions = getMissions(missions)
  mission = setMission(missions)
  getWorlds(missions)
  clues = getFriendClues(clues)
  createCorrectPath({missions: missions, mission: mission, clues: clues, levels: 3})
  createWrongPath({missions: missions, mission: mission, levels: 2})
  build(mission)
