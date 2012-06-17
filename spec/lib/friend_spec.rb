require 'spec_helper'
require './lib/friend'

module NerdQuest

  describe Friend do

    let(:friend) {Friend.new('1234')}
    let(:graph) { double('graph')}
    let(:batch) { double('batch').as_null_object}

    it "has an oauth_token" do
      friend.oauth_token.should eq('1234')
    end

    it "has an Facebook API" do
      Koala::Facebook::API.should_receive(:new).with('1234')
      friend.graph
    end

    context "when finding a random friend" do

      before do
        friend.stub(:graph).and_return(graph)
        graph.stub(:batch).and_return(batch)
        Clue.any_instance.stub(:extract)
      end

      it "gets all friends from the user" do
        graph.should_receive(:get_connections).with('me','friends')
        friend.friends
      end

      it "selects a random user friend" do
        friend_list = double
        friend.stub(:friends).and_return(friend_list)
        friend_list.should_receive(:sample).and_return({'id'=>1})
        friend.find
      end

      it "grabs all his personal information" do
        pending
        batch.should_receive(:get_object).with(1)
        friend.batch_request(1)
      end

      it "grabs all his likes" do
        pending
        batch.should_receive(:get_connections).with(1, 'friends')
        friend.batch_request(1)
      end

    end

  end

end
