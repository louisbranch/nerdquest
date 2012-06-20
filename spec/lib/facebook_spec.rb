require 'spec_helper'
require './lib/facebook'

module NerdQuest

  describe Facebook do

    let(:facebook) {Facebook.new('ABC')}

    before do
      @api = double('api').as_null_object
      Koala::Facebook::API.stub(:new).and_return(@api)
    end

    it "has an oauth_token" do
      facebook = Facebook.get_friend('ABC')
      facebook.oauth_token = 'ABC'
    end

    it "selects a random user friend" do
      @api.should_receive(:fql_query).and_return(['id' => 1])
      facebook.random_friend
    end

    it "gets all user info and likes in a batch" do
      batch = double
      @api.stub(:batch).and_yield(batch)
      batch.should_receive(:get_object)
      batch.should_receive(:get_connections)
      facebook.get_info
    end

  end

end
