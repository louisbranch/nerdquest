require 'spec_helper'
require './lib/mission_creator'

module NerdQuest

  describe MissionCreator do

    before do
      @levels = 2
      @friend_clues = ['male','25','Rio de Janeiro', 'Larissa Voigt', 'Uerj']
      @mission = MissionCreator.new(@levels, @friend_clues)
      fake_missions = []
      4.times {fake_missions << fake_mission}
      @mission.stub(:missions).and_return(fake_missions)
    end

    it "adds a mission from the pool" do
      @mission.mission.should eq(fake_mission)
    end

    context "when creating the right path" do

      before{@mission.create_correct_path}

      it "creates one world for each level plus the first one" do
        @mission.worlds.size.should eq(@levels+1)
      end

      context "when it is the starting world" do

        let(:world) {@mission.worlds.last}

        it "its level should be zero" do
          world['level'].should eq(0)
        end

        it "its first place include a friend's clue" do
          place = world['places'].first
          @friend_clues.should_not include(place['phrase'])
        end

        it "its other places include a clue to the next world" do
          pending "The clue got deleted before the test"
          next_world = @mission.worlds[1]
          places = world['places'][1..2]
          places.each do |p|
            next_world['clues'].should include(p['phrase'])
          end
        end

      end

      context "when it is the final world" do

        let(:world) {@mission.worlds.first}

        it "its level should be the equal to the mission level" do
          world['level'].should eq(@levels)
        end

        it "its first place is the final" do
          world['places'][0]['final'].should be_true
        end

        it "its places don't have a friend's clue" do
          world['places'].each do |p|
            @friend_clues.should_not include(p['phrase'])
          end
        end
      end

      context "when it's a world in between the starting and the final" do

        let(:world) {@mission.worlds[1]}

        it "its has a level between the starting and the final" do
          world['level'].should be_between(1,@levels-1)
        end

        it "its first place include a friend's clue" do
          place = world['places'].first
          @friend_clues.should_not include(place['phrase'])
        end

        it "its other places include a clue to the next world" do
          pending "The clue got deleted before the test"
          next_world = @mission.worlds[1]
          places = world['places'][1..2]
          places.each do |p|
            next_world['clues'].should include(p['phrase'])
          end
        end

      end

    end

    def fake_mission
      JSON.parse(File.read('./spec/data/mission.json'))
    end

  end

end
