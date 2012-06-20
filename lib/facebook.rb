module NerdQuest
  require 'koala'

  class Facebook

    attr_reader :oauth_token

    def initialize(oauth_token)
      @oauth_token = oauth_token
    end

    def self.get_friend(oauth_token)
      fb = new(oauth_token)
      fb.get_info
    end

    def get_info
      id = random_friend['uid']
      graph.batch do |g|
        g.get_object(id)
        g.get_connections(id, "likes")
      end
    end

    def random_friend
      friend = graph.fql_query("SELECT uid, name FROM user WHERE uid IN (SELECT uid2 FROM friend WHERE uid1 = me()) ORDER BY rand() limit 1")
      friend.first
    end

    def graph
      (Koala.http_service.http_options[:ssl] ||= {})[:ca_path] = '/etc/ssl/certs'
      Koala::Facebook::API.new(oauth_token)
    end

  end

end
