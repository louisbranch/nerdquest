module NerdQuest

  class Clue

    attr_reader :data, :clues
    attr_writer :clues

    def initialize(data)
      @data = data
      @clues = {}
    end

    def extract
      data.each_pair do |k,v|
        if respond_to?(k)
          send(k,v)
        end
      end
      clues
    end

    def gender(data)
      clues['gender'] = "The suspect was #{data}"
    end

    def birthday(data)
      year_regex = /\d\d\/\d\d\/\d\d\d\d/
      if data.match(year_regex)
        years = Time.now.year - data.match(/\d\d\d\d/)[0].to_i
        clues['age'] = "He was #{years} years old"
      else
        clues['birthday'] = "He was born on #{data}"
      end
    end

    def hometown(data)
      city = data['name']
      clues['hometowm'] = "He was born in #{city}" if city
    end

    def location(data)
      city = data['name']
      clues['location'] = "He lives in #{city}" if city
    end

    def education(data)
      school = data.sample['school']['name']
      clues['education'] = "He has studied at #{school}"
    end

    def work(data)
      employer = data.sample['employer']['name']
      clues['work'] = "He has worked at #{employer}"
    end

    def language(data)
      language = data.sample['name']
      clues['language'] = "I heard he speaking #{language}"
    end

    def relationship_status(data)
      case data
      when 'Single'
        status = "He looks single"
      when 'In a relationship'
        status = "I think he's dating someone"
      when 'Engaged'
        status = "He had a ring on his left hand"
      when 'Married'
        status = "He had a ring on his right hand"
      when 'It\'s complidated'
        status = "He seems to be in a complicated relationship"
      when 'In a open relationship'
        status = "He is in a open relationship. If you know what I mean"
      when 'Widowed'
        status = "He said being widowed"
      when 'Separated'
        status = "He is separated"
      when 'Divorced'
        status = "He is divorced"
      end
      clues['relationship_status'] = status
    end

    def sports(data)
      sport = data.sample['name']
      clues['sports'] = "He had invited me to play #{sport}"
    end

    def favorite_teams(data)
      team = data.sample['name']
      clues['favorite_teams'] = "He was wearing a #{team} shirt"
    end

    def favorite_athletes(data)
      athlete = data.sample['name']
      clues['favorite_athletes'] = "He has an autograph from #{athlete}"
    end

    def significant_other(data)
      person = data['name']
      clues['significant_other'] = "He showed me a few photos from #{person}"
    end

    def inspirational_people(data)
      person = data['name']
      clues['inspirational_people'] = "He had a #{person} tattoo"
    end

    def quotes(data)
      clues['quotes'] = "&quot;data&quot;"
    end

    def interested_in(data)
      interest = data.sample['name']
      clues['interested_in'] = "He has a strong interest in #{interest}"
    end

    def political(data)
      clues['political'] = "He has a #{data} political view"
    end

    def religion(data)
      clues['religion'] = "He believes in #{data} religion"
    end

  end
end
