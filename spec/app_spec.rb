require 'spec_helper'
require './app'

module NerdQuest

  describe App do

    def app
      App
    end

    it "says hello" do
      get '/'
      last_response.should be_ok
    end

  end
end
