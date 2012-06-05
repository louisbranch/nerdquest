require 'spec_helper'
require './app'

module NerdQuest

  describe App do

    def app
      App
    end

    context "when authenticating the signed request from Facebook" do

      it "parses the request" do
        Authentication.should_receive(:new).with('123')
        post '/', signed_request: '123'
      end

      context "when the authentication is valid" do

        before do
          @oauth = double('authentication', {:token => 'ABC', :valid? => true})
          Authentication.stub(:new).and_return(@oauth)
        end

        it "stores the user token in the cookie" do
          post '/'
          rack_mock_session.cookie_jar['token'].should eq('ABC')
        end

        it "renders the game" do
          post '/'
          last_response.status.should eq(200)
        end

      end

      context "when the authentication is invalid" do

        it "asks for the user authorization" do
          @oauth = double('authentication', {:valid? => false, :authorization_url => 'http://...'})
          Authentication.stub(:new).and_return(@oauth)
          post '/'
          last_response.status.should eq(401)
        end

      end

    end

    context "when creating a new mission" do
    end

  end
end
