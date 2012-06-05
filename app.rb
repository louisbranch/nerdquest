module NerdQuest
  require 'sinatra/base'
  require_relative 'lib/authentication'

  class App < Sinatra::Base

    set :protection, :except => :frame_options
    set :views, 'app/views'

    post '/' do
      oauth = Authentication.new(params[:signed_request])
      if oauth.valid?
        response.set_cookie('token', {:value => oauth.token})
        erb :show
      else
        @url = oauth.authorization_url
        status 401
        erb :new
      end
    end

  end
end
