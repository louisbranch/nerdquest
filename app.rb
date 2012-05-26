module NerdQuest
  require 'sinatra/base'
  require_relative 'lib/authentication'

  class App < Sinatra::Base

    set :protection, :except => :frame_options
    set :views, 'app/views'

    get '/' do
      200
    end

    post '/' do
      oauth = Authentication.new(params[:signed_request])
      if oauth.valid?
        erb :show
      else
        @url = oauth.authorization_url
        erb :new
      end
    end

  end
end
