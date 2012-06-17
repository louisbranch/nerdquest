module NerdQuest

  require_relative 'friend'
  require_relative 'mission_creator'

  class Mission

    attr_reader :user

    def initialize(user)
      @user = user
    end

    def create
      creator = MissionCreator.new(user.level, friend.clues, missions)
      mission_json = creator.create_mission
      DB.save_mission(user.id, friend.id, mission_json)
      mission_json
    end

  end
end
