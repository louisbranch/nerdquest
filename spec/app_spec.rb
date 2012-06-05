require 'spec_helper'
require './app'

module NerdQuest

  describe App do

    def app
      App
    end

    it "parses the request" do
      Authentication.should_receive(:new).with('123')
      post '/', signed_request: '123'
    end

    context "when authenticating the signed request from Facebook" do

      before do
        @oauth = double('authentication', {:token => 'ABC'})
        Authentication.stub(:new).and_return(@oauth)
      end

      it "stores the user token in the cookie" do
        @oauth.stub(:valid?).and_return(true)
        post '/'
        rack_mock_session.cookie_jar['token'].should eq('ABC')
      end

      it "renders the game if the request is valid" do
        @oauth.stub(:valid?).and_return(true)
        post '/'
        last_response.status.should eq(200)
      end

      it "asks for the user authorization if the request is invalid" do
        @oauth.stub(:valid?).and_return(false)
        @oauth.stub(:authorization_url)
        post '/'
        last_response.status.should eq(401)
      end

    end
  end
end
