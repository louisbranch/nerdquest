require 'spec_helper'
require './lib/authentication'

module NerdQuest

  describe Authentication do

    let(:auth) {Authentication.new('123')}

    it "parses the signed request when instanciated" do
      Authentication.should_receive(:api)
      auth
    end

    it "saves the facebook user id from a successful request" do
      Authentication.stub(:api).and_return({'user_id' => 1})
      auth.user_id.should eq(1)
    end

    it "is valid when has an user_id" do
      Authentication.stub(:api).and_return({'user_id' => 1})
      auth.should be_valid
    end

    it "is invalid when doesn't have an user_id" do
      Authentication.stub(:api)
      auth.should_not be_valid
    end

    it "has an authorization url to redirect the user" do
      Authentication.stub(:api)
      auth.authorization_url.should match(/^https:\/\/www.facebook.com\/dialog\/oauth/)
    end

  end
end
