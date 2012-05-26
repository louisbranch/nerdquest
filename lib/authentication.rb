module NerdQuest
  require 'koala'

  class Authentication

    APP_ID       = '390782924297392'
    APP_KEY      = '2779b26c27700b8626a0bf89edb1f994'
    CANVAS_URL   = 'https://apps.facebook.com/nerd_quest/'

    attr_reader :user_id

    def initialize(signed_request)
      request = api.parse_signed_request(signed_request)
      @user_id = request['user_id']
    end

    def valid?
      user_id
    end

    def authorization_url
      "https://www.facebook.com/dialog/oauth?client_id=#{APP_ID}&redirect_uri=#{CANVAS_URL}"
    end

    private

    def api
      Koala::Facebook::OAuth.new(APP_ID, APP_KEY)
    end

  end

end
