module NerdQuest
  require 'json/ext'
  class MissionCreator

    attr_reader :levels

    def initialize(levels, friend_clues)
      @levels, @friend_clues = levels, friend_clues
    end

    def build
      mission = missions.slice!(0)
      first_loc = mission.delete('location')
      final_locs = correct_path(first_loc) + wrong_path
      mission['locations'] = final_locs.shuffle!
      mission
    end

    private

    def missions
      @missions ||= JSON.parse(File.read('./data/missions.json'))
      @missions.shuffle!
    end

    def locations
      @locations ||= missions.map {|m| m['location']}
      @locations.shuffle!
    end

    def friend_clues
      @friend_clues.shuffle!
    end

    def correct_path(first_loc)
      next_loc = nil
      locs = []
      [levels..1].each do |level|
        loc = locations.slice!(0)
        loc['level'] = level
        if next_loc
          add_clues(loc, next_loc)
        else
          add_final_clues(loc)
        end
        next_loc = loc
        locs << loc
      end
      locs << add_clues(first_loc, next_loc)
      locs
    end

    def wrong_path
      locs = []
      [levels..1].each do |level|
        2.times do
          loc = locations.slice!(0)
          loc['level'] = level
          locs << loc
        end
      end
      locs
    end

    def add_clues(loc, next_loc)
      first = true
      places = loc['places']
      places.each do |place|
        if first
          place['phrase'] = friend_clues.slice!(0)
          first = false
        else
          place['phrase'] = next_loc['clues'].slice!(0)
        end
        place.delete('filler')
      end
      places = loc['places'].shuffle!
    end

    def add_final_clues(loc)
      first = true
      places = loc['places']
      places.each do |place|
        place['phrase'] = place['filler']
        if first
          place['final'] = true
        end
        place.delete('filler')
      end
      places = loc['places'].shuffle!
    end

  end
end
