module NerdQuest
  require 'koala'
  require_relative 'clue'

  class Friend

    attr_reader :oauth_token

    def initialize(oauth_token)
      @oauth_token = oauth_token
    end

    def find
      friend = random_friend
      friend['likes'] = likes(friend['id'])
      {
        'id' => friend['id'],
        'name' => friend['name'],
        'clues' => clues(friend)
      }
    end

    def clues(data)
     Clue.new(data).extract
    end

    def random_friend
      friend = friends.sample
      graph.get_object(friend['id'])
    end

    def likes(id)
      graph.get_connections(id, "likes")
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
