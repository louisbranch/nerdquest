module NerdQuest
  require 'json/ext'
  class MissionCreator

    attr_reader :levels
    attr_accessor :mission, :worlds

    def initialize(levels, friend_clues)
      @levels, @friend_clues = levels, friend_clues
      @mission = missions.slice!(0)
      @worlds = []
    end

    def build
      create_correct_path
      create_wrong_path
      shuffle_mission
    end

    def to_json
      mission['worlds'] = worlds
      mission.to_json
    end

    def create_correct_path
      previous_world = nil
      levels.downto(1) do |level|
        world = all_worlds.slice!(0)
        world['level'] = level
        if previous_world
          add_clues(world, previous_world)
        else
          add_final_clues(world)
        end
        previous_world = world
        @worlds << world
      end
      first_world = set_first_world
      @worlds << add_clues(first_world, previous_world)
    end

    def create_wrong_path
      levels.downto(1) do |level|
        2.times do
          world = all_worlds.slice!(0)
          world['level'] = level
          world.delete('clues')
          @worlds << world
        end
      end
    end

    def add_clues(world, previous_world)
      first = true
      places = world['places']
      places.each do |place|
        if first
          place['phrase'] = friend_clues.slice!(0)
          first = false
        else
          place['phrase'] = previous_world['clues'].slice!(0)
        end
      end
      previous_world.delete('clues')
      world
    end

    def add_final_clues(world)
      first = true
      places = world['places']
      places.each do |place|
        if first
          place['final'] = true
          first = false
        end
      end
      world
    end

    def shuffle_mission
      worlds.each do |world|
        world['places'].shuffle!
      end
    end

    private

    def missions
      @missions ||= JSON.parse(File.read('./data/missions.json'))
      @missions.shuffle!
    end

    def all_worlds
      @all_worlds ||= missions.map {|m| m['world']}
      @all_worlds.shuffle!
    end

    def friend_clues
      @friend_clues.shuffle!
    end

    def set_first_world
      world = mission.delete('world')
      world['level'] = 0
      world.delete('clues')
      world
    end

  end
end
