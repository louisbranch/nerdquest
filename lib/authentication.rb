module NerdQuest
  require 'koala'

  class Authentication

    APP_ID       = '390782924297392'
    APP_KEY      = '2779b26c27700b8626a0bf89edb1f994'
    CANVAS_URL   = 'https://apps.facebook.com/nerd_quest/'
    SCOPE        = ['friends_about_me', 'friends_activities', 'friends_birthday', 'friends_checkins',
                    'friends_education_history', 'friends_events', 'friends_groups', 'friends_hometown',
                    'friends_interests', 'friends_likes', 'friends_location', 'friends_relationships',
                    'friends_religion_politics', 'friends_website', 'friends_work_history']

    attr_reader :user_id, :token

    def initialize(signed_request)
      request = Authentication.api(signed_request)
      if request
        @user_id = request['user_id']
        @token = request['oauth_token']
      end
    end

    def valid?
      user_id && token
    end

    def authorization_url
      "https://www.facebook.com/dialog/oauth?client_id=#{APP_ID}&redirect_uri=#{CANVAS_URL}&scope=#{SCOPE.join(',')}"
    end

    def self.api(signed_request)
      Koala::Facebook::OAuth.new(APP_ID, APP_KEY).parse_signed_request(signed_request)
    end

  end

end
