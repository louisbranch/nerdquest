module NerdQuest
  require 'sinatra/base'
  require_relative 'lib/authentication'
  require_relative 'lib/mission'
  require_relative 'lib/friend'

  class App < Sinatra::Base

    set :protection, except: :frame_options
    set :views, 'app/views'

    get '/' do
      erb :show
    end

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

    get '/missions' do
      content_type :json
      [].to_json
    end

    post '/missions/new' do
      content_type :json
      mission = Mission.build(oauth_token)
      mission.to_json
    end

    get '/friends/new' do
      content_type :json
      friend = Friend.find(oauth_token)
      friend.to_json
    end

    private

    def oauth_token
      request.cookies['token']
    end

  end
end
