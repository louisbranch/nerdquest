module NerdQuest
  require 'koala'

  class Authentication

    APP_ID       = '390782924297392'
    APP_KEY      = '2779b26c27700b8626a0bf89edb1f994'
    CALLBACK_URL = ''

    attr_reader :signed_request

    def initialize(signed_request)
      @signed_request = signed_request
    end

    def parse
      api.parse_signed_request(signed_request)
    end

    private

    def api
      Koala::Facebook::OAuth.new(APP_ID, APP_KEY, CALLBACK_URL)
    end

  end

end
