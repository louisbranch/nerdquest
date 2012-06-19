module NerdQuest
  require 'koala'

  class Facebook

    attr_reader :oauth_token

    def initialize(oauth_token)
      @oauth_token = oauth_token
    end

    def self.get_friend(oauth_token)
      fb = new(oauth_token)
      id = fb.friends.sample['id']
      fb.get_info(id)
    end

    def get_info(id)
      graph.batch do |g|
        g.get_object(id)
        g.get_connections(id, "likes")
      end
    end

    def friends
      graph.get_connections('me', 'friends')
    end

    def graph
      (Koala.http_service.http_options[:ssl] ||= {})[:ca_path] = '/etc/ssl/certs'
      Koala::Facebook::API.new(oauth_token)
    end

  end

end
