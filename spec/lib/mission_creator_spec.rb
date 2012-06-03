require 'spec_helper'
require './lib/mission_creator'

module NerdQuest

  describe MissionCreator do

    before do
      friend_clues = ['male','25','Rio de Janeiro', 'Larissa Voigt', 'Uerj']
      @mission = MissionCreator.new(3, friend_clues)
    end

    it "builds a new mission" do
      @mission.create_correct_path
      @mission.create_wrong_path
      m = @mission.build
      File.open('result.json', 'w') do |f|
        f.write(m)
      end
    end

    private

    def world
      JSON.parse(File.read('./eg.json'))
    end

  end

end
