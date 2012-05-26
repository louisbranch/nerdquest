module NerdQuest
  require 'sinatra/base'

  class App < Sinatra::Base

    set :protection, :except => :frame_options

    post '/' do
    end

  end
end
