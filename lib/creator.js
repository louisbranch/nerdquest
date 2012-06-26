// Generated by CoffeeScript 1.3.3
(function() {
  var addClues, addWorld, build, createCorrectPath, createNewMission, createWrongPath, fs, getFriendClues, getMissions, getWorlds, setFirstWorld, setMission;

  fs = require('fs');

  Array.prototype.shuffle = function() {
    return this.sort(function() {
      return 0.5 - Math.random();
    });
  };

  getMissions = function(json) {
    return json.shuffle();
  };

  getFriendClues = function(json) {
    return json.shuffle();
  };

  setMission = function(missions) {
    var mission;
    mission = missions.pop();
    mission.worlds = [];
    return mission;
  };

  getWorlds = function(missions) {
    return missions.worlds = missions.map(function(mission) {
      return mission.world;
    });
  };

  addWorld = function(mission, world) {
    return mission.worlds.push(world);
  };

  build = function(mission) {
    var world, _i, _len, _ref, _results;
    mission.worlds.shuffle();
    _ref = mission.worlds;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      world = _ref[_i];
      delete world.clues;
      world.places.shuffle();
      _results.push(delete mission.build);
    }
    return _results;
  };

  addClues = function(_arg) {
    var clue, clues, final_world, first_place, place, previous_world, world, _i, _len, _ref, _results;
    clues = _arg.clues, world = _arg.world, previous_world = _arg.previous_world, final_world = _arg.final_world;
    first_place = true;
    _ref = world.places;
    _results = [];
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      place = _ref[_i];
      if (first_place && final_world) {
        place.final = true;
        _results.push(first_place = false);
      } else if (first_place) {
        clue = clues.pop();
        place.phrase = clue.phrase;
        place.type = clue.type;
        _results.push(first_place = false);
      } else if (previous_world) {
        place.phrase = previous_world.clues.shuffle().pop();
        _results.push(place.type = 'world');
      } else {
        _results.push(void 0);
      }
    }
    return _results;
  };

  setFirstWorld = function(mission, clues, previous_world) {
    var world;
    world = mission.world;
    delete mission.world;
    addClues({
      clues: clues,
      world: world,
      previous_world: previous_world
    });
    world.level = 0;
    return addWorld(mission, world);
  };

  createCorrectPath = function(_arg) {
    var clues, final_world, levels, mission, missions, previous_world, world;
    missions = _arg.missions, mission = _arg.mission, clues = _arg.clues, levels = _arg.levels;
    previous_world = void 0;
    final_world = true;
    while (levels > 0) {
      world = missions.worlds.pop();
      world.level = levels;
      addClues({
        clues: clues,
        world: world,
        previous_world: previous_world,
        final_world: final_world
      });
      final_world = false;
      previous_world = world;
      addWorld(mission, world);
      levels--;
    }
    return setFirstWorld(mission, clues, previous_world);
  };

  createWrongPath = function(_arg) {
    var levels, mission, missions, times, world, _results;
    missions = _arg.missions, mission = _arg.mission, levels = _arg.levels;
    _results = [];
    while (levels > 0) {
      times = 2;
      while (times > 0) {
        world = missions.worlds.pop();
        world.level = levels;
        addWorld(mission, world);
        times--;
      }
      _results.push(levels--);
    }
    return _results;
  };

  createNewMission = function(_arg) {
    var clues, levels, mission, missions;
    levels = _arg.levels, missions = _arg.missions, clues = _arg.clues;
    missions = getMissions(missions);
    mission = setMission(missions);
    getWorlds(missions);
    clues = getFriendClues(clues);
    createCorrectPath({
      missions: missions,
      mission: mission,
      clues: clues,
      levels: 3
    });
    createWrongPath({
      missions: missions,
      mission: mission,
      levels: 2
    });
    return build(mission);
  };

}).call(this);