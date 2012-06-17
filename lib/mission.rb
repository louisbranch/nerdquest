module NerdQuest
  require_relative 'friend'
  require_relative 'mission_creator'

  class Mission

    attr_reader :oauth_token

    def initialize(oauth_token)
      @oauth_token = oauth_token
    end

    def create
      friend = Friend.new(oauth_token).find
      creator = MissionCreator.new(3, friend['clues'], missions)
      mission_json = creator.create_mission
      #DB.save_mission(user.id, friend.id, mission_json)
      mission_json
    end

    def missions
      @missions ||= File.read('./spec/data/missions.json')
    end

  end
end
