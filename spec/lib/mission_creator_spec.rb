require 'spec_helper'
require './lib/mission_creator'

module NerdQuest

  describe MissionCreator do

    before do
      @levels = 2
      friend_clues = ['male','25','Rio de Janeiro', 'Larissa Voigt', 'Uerj']
      missions = File.read('./spec/data/missions.json')
      @creator = MissionCreator.new(@levels, friend_clues, missions)
    end

    it "adds a mission from the pool" do
      @creator.mission.should have_key('name')
    end

    it "saves the mission to a file" do
      @creator.create_correct_path
      m = @creator.build
      File.open('result.json', 'w') do |f|
        f.write(m)
      end
    end

    context "when creating the right path" do

      before{@creator.create_correct_path}

      it "creates one world for each level plus the first one" do
        @creator.worlds.size.should eq(@levels+1)
      end

      context "when it is the starting world" do

        let(:world) {@creator.worlds.last}

        it "its level should be zero" do
          world['level'].should eq(0)
        end

        it "its first place include a friend's clue" do
          place = world['places'].first
          place['clue_type'].should eq('friend')
        end

        it "its other places include a clue from the next world" do
          places = world['places'][1..2]
          places.each do |place|
            place['clue_type'].should eq('world')
          end
        end

      end

      context "when it is the final world" do

        let(:world) {@creator.worlds.first}

        it "its level should be the equal to the mission level" do
          world['level'].should eq(@levels)
        end

        it "its first place is the final" do
          world['places'][0]['final'].should be_true
        end

        it "its places don't have clues" do
          world['places'].each do |place|
            place['clue_type'].should be_nil
          end
        end
      end

      context "when it's a world in between the starting and the final" do

        let(:world) {@creator.worlds[1]}

        it "its has a level between the starting and the final" do
          world['level'].should be_between(1,@levels-1)
        end

        it "its first place include a friend's clue" do
          place = world['places'].first
          place['clue_type'].should eq('friend')
        end

        it "its other places include a clue to the next world" do
          places = world['places'][1..2]
          places.each do |place|
            place['clue_type'].should eq('world')
          end
        end

      end

    end

    context "when creating the wrong path" do

      before{@creator.create_wrong_path}

      it "creates two worls for each mission level" do
        @creator.worlds.size.should eq(@levels*2)
      end

      it "its has a level more than the first one and equal or less than the final one" do
        @creator.worlds.each do |world|
          world['level'].should be_between(1,@levels)
        end
      end

    end

    context "building a mission" do

      before do
        @creator.create_correct_path
      end

      it "erases the original clues from all worlds" do
        @creator.build
        @creator.worlds.sample['clues'].should be_nil
      end

      it "includes all worlds inside the mission" do
        @creator.build
        @creator.mission['worlds'].should eq(@creator.worlds)
      end

      it "shuffles all worlds" do
        @creator.worlds.should_receive(:shuffle!)
        @creator.build
      end

      it "shuffles all places" do
        @creator.worlds.sample['places'].should_receive(:shuffle!)
        @creator.build
      end

      it "turns into a json file" do
        @creator.mission.should_receive(:to_json)
        @creator.build
      end

    end

  end

end
