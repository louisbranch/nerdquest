require 'spec_helper'
require './lib/mission_creator'

module NerdQuest

  describe MissionCreator do

    before do
      friend_clues = ['male','25','Rio de Janeiro', 'Larissa Voigt', 'Uerj']
      @mission = MissionCreator.new(3, friend_clues)
    end

    it "builds a new mission" do
      @mission.build
    end

  end

end
