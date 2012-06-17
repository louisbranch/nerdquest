module NerdQuest
  require 'sinatra/base'
  require_relative 'lib/authentication'
  require_relative 'lib/mission'
  require_relative 'lib/friend'

  class App < Sinatra::Base

    set :protection, except: :frame_options
    set :views, 'app/views'

    post '/' do
      oauth = Authentication.new(params[:signed_request])
      if oauth.valid?
        response.set_cookie('token', {value: oauth.token})
        erb :show
      else
        @url = oauth.authorization_url
        status 401
        erb :new
      end
    end

    get '/mission.json' do
      content_type :json
      mission = Mission.new(oauth_token).create
      if mission
        mission
      else
        # possible errors: no friend suitable // invalid token
      end
    end

    get '/friend.json' do
      content_type :json
      Friend.new(oauth_token).find.to_json
    end

    private

    def oauth_token
      oauth_token = request.cookies['token']
    end

  end
end
