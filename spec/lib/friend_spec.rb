require 'spec_helper'
require './lib/friend'

module NerdQuest

  describe Friend do

    before  do
      Facebook.stub(:get_friend).and_return([{'id' => 1, 'name' => 'Luiz'},{}])
      Clue.stub(:extract)
    end

    it "receives Facebook all information and likes from user" do
      Facebook.should_receive(:get_friend)
      Friend.find('ABC')
    end

    it "saves the user id" do
      friend = Friend.find('ABC')
      friend.id.should eq(1)
    end

    it "saves the user name" do
      friend = Friend.find('ABC')
      friend.name.should eq('Luiz')
    end

    it "get his own clues" do
      Clue.should_receive(:extract)
      Friend.find('ABC')
    end

    it "tranforms his data to json" do
      friend = Friend.new(1,'Luiz')
      friend.clues = [{'type' => 'birthday', 'phrase' => '25'}]
      friend.to_json.should eq("{\"id\":1,\"name\":\"Luiz\",\"clues\":[{\"type\":\"birthday\",\"phrase\":\"25\"}]}")
    end

  end

end
