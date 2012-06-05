require 'spec_helper'
require './lib/authentication'

module NerdQuest

  describe Authentication do

    let(:auth) {Authentication.new('123')}

    it "requests the Koala Facebook API" do
      api = double('koala')
      Koala::Facebook::OAuth.stub(:new).and_return(api)
      api.should_receive(:parse_signed_request).with('123')
      Authentication.api('123')
    end

    it "parses the signed request when instanciated" do
      Authentication.should_receive(:api)
      auth
    end

    it "has a facebook user id when the request succceed" do
      Authentication.stub(:api).and_return({'user_id' => 1})
      auth.user_id.should eq(1)
    end

    it "has a facebook oauth token when the request succceed" do
      Authentication.stub(:api).and_return({'oauth_token' => 'ABC'})
      auth.token.should eq('ABC')
    end

    it "is valid when has an user_id and an oauth_token" do
      Authentication.stub(:api).and_return({'user_id' => 1, 'oauth_token' => 'ABC'})
      auth.should be_valid
    end

    it "is invalid when doesn't have an user_id or an oauth_token" do
      Authentication.stub(:api)
      auth.should_not be_valid
    end

    it "has an authorization url to redirect the user" do
      Authentication.stub(:api)
      auth.authorization_url.should match(/^https:\/\/www.facebook.com\/dialog\/oauth/)
    end

  end
end
