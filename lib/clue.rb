module NerdQuest

  class Clue

    attr_reader :info, :clues, :likes
    attr_writer :clues

    def initialize(info,likes)
      @info, @likes = info, likes
      @clues = []
    end

    def extract
      info.each_pair do |k,v|
        if respond_to?(k)
          phrase = send(k,v)
          clues.push({'type' => k, 'phrase' => phrase})
        end
      end
      likes_parser
      clues
    end

    def gender(info)
      "The suspect was #{info}"
    end

    def birthday(info)
      year_regex = /\d\d\/\d\d\/\d\d\d\d/
      if info.match(year_regex)
        years = Time.now.year - info.match(/\d\d\d\d/)[0].to_i
        "He was #{years} years old"
      else
        "He was born on #{info}"
      end
    end

    def hometown(info)
      city = info['name']
      "He was born in #{city}"
    end

    def location(info)
      city = info['name']
      "He lives in #{city}"
    end

    def education(info)
      school = info.sample['school']['name']
      "He has studied at #{school}"
    end

    def work(info)
      employer = info.sample['employer']['name']
      "He has worked at #{employer}"
    end

    def language(info)
      language = info.sample['name']
      "I heard he speaking #{language}"
    end

    def relationship_status(info)
      case info
      when 'Single'
        "He looks single"
      when 'In a relationship'
        "I think he's dating someone"
      when 'Engaged'
        "He had a ring on his left hand"
      when 'Married'
        "He had a ring on his right hand"
      when 'It\'s complidated'
        "He seems to be in a complicated relationship"
      when 'In a open relationship'
        "He is in a open relationship. If you know what I mean"
      when 'Widowed'
        "He said being widowed"
      when 'Separated'
        "He is separated"
      when 'Divorced'
        "He is divorced"
      end
    end

    def sports(info)
      sport = info.sample['name']
      "He had invited me to play #{sport}"
    end

    def favorite_teams(info)
      team = info.sample['name']
      "He was wearing a #{team} shirt"
    end

    def favorite_athletes(info)
      athlete = info.sample['name']
      "He has an autograph from #{athlete}"
    end

    def significant_other(info)
      person = info['name']
      "He showed me a few photos from #{person}"
    end

    def inspirational_people(info)
      person = info.sample['name']
      "He had a #{person} tattoo"
    end

    def quotes(info)
      "&quot;#{info}&quot;"
    end

    def interested_in(info)
      interest = info.sample['name']
      "He has a strong interest in #{interest}"
    end

    def political(info)
      "He has a #{info} political view"
    end

    def religion(info)
      "He believes in #{info} religion"
    end

    def likes_parser
      likes.each do |like|
        case like['category']
        when 'Musician/band'
          clues << {
            'type' => 'music',
            'phrase' => "He was listen to #{like['name']}"
          }
        when 'Movie'
          clues << {
            'type' => 'movie',
            'phrase' => "He sent me a link of #{like['name']}'s torrent'"
          }
        when 'Games/toys'
          clues << {
            'type' => 'game',
            'phrase' => "He owned me playing #{like['name']}"
          }
        when 'Tv show'
          clues << {
            'type' => 'tv_show',
            'phrase' => "He gave me a #{like['name']} spoiler"
          }
        when 'Musical genre'
          clues << {
            'type' => 'musical_genre',
            'phrase' => "He bet me at RockBand playing #{like['name']}"
          }
        when 'Sport'
          clues << {
            'type' => 'sport',
            'phrase' => "He practices #{like['name']}"
          }
        end
      end
    end

  end
end
