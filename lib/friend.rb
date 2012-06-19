module NerdQuest
  require 'json/ext'
  require_relative 'facebook'
  require_relative 'clue'

  class Friend

    attr_reader :id, :name
    attr_accessor :clues

    def initialize(id, name)
      @id, @name = id, name
    end

    def self.find(oauth_token)
      info, likes = Facebook.get_friend(oauth_token)
      friend = new(info['id'], info['name'])
      friend.clues = Clue.extract(info, likes)
      friend
    end

    def to_json
      {
        'id' => id,
        'name' => name,
        'clues' => clues
      }.to_json
    end

  end

end
