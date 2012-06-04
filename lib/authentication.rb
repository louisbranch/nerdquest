module NerdQuest
  require 'koala'

  class Authentication

    APP_ID       = '390782924297392'
    APP_KEY      = '2779b26c27700b8626a0bf89edb1f994'
    CANVAS_URL   = 'https://apps.facebook.com/nerd_quest/'

    attr_reader :user_id, :oauth_token

    def initialize(signed_request)
      request = Authentication.api(signed_request)
      if request
        @user_id = request['user_id']
        @oauth_token = request['oauth_token']
      end
    end

    def valid?
      user_id && oauth_token
    end

    def authorization_url
      "https://www.facebook.com/dialog/oauth?client_id=#{APP_ID}&redirect_uri=#{CANVAS_URL}"
    end

    def self.api(signed_request)
      Koala::Facebook::OAuth.new(APP_ID, APP_KEY).parse_signed_request(signed_request)
    end

  end

end
