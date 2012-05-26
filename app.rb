module NerdQuest
  require 'sinatra/base'
  require_relative 'lib/authentication'

  class App < Sinatra::Base

    set :protection, :except => :frame_options

    post '/' do
      oauth = Authentication.new(params[:signed_request])
      oauth.parse.to_s
    end

  end
end
