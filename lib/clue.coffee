#TODO Add likes parser
#TODO Refactor parser to no be reacreated
# on every funcition call

parseInfo = (friend) ->
  parser = {
    clues: []

    gender: (i) ->
      parser.clues.push
        type: 'gender'
        phrase: "The suspect was #{i}"

    birthday: (i) ->
      phrase = ''
      year_regex = /\d\d\/\d\d\/\d\d\d\d/
      if i.match(year_regex)
        today = new Date
        year = i.match(/\d\d\d\d/)[0]
        years = today.getFullYear() - parseInt(year)
        phrase = "The suspect was #{years} years old"
      else
        phrase = "The suspect was born on #{i}"
      parser.clues.push
        type: 'birthday'
        phrase: phrase

    hometown: (i) ->
      parser.clues.push
        type: 'hometown'
        phrase: "The suspect was born in #{i.name}"

    location: (i) ->
      parser.clues.push
        type: 'location'
        phrase: "The suspect lives in #{i.name}"

    significant_other: (i) ->
      parser.clues.push
        type: 'In a relationship with'
        phrase: "The suspect showed me a few photos from #{i.name}"

    quotes: (i) ->
      parser.clues.push
        type: 'quotes'
        phrase: "The suspect left this: '#{i}'"

    political: (i) ->
      parser.clues.push
        type: 'political'
        phrase: "The suspect has a #{i} political view"

    religion: (i) ->
      parser.clues.push
        type: 'religion'
        phrase: "The suspect believes in the #{i} religion"

    education: (i) ->
      for item in i
        parser.clues.push
          type: 'education'
          phrase: "The suspect has studied at #{item.school.name}"

    work: (i) ->
      for job in i
        parser.clues.push
          type: 'work'
          phrase: "The suspect has worked at #{job.employer.name}"
        if job.position
          parser.clues.push
            type: 'position'
            phrase: "The suspect has worked as #{job.position.name}"

    language: (i) ->
      for lang in i
        parser.clues.push
          type: 'language'
          phrase: "I heard the suspect speaking #{lang.name}"

    sports: (i) ->
      for sport in i
        parser.clues.push
          type: 'sports'
          phrase: "The suspect had invited me to #{sport.name}"

    favorite_teams: (i) ->
      for team in i
        parser.clues.push
          type: 'favorite teams'
          phrase: "The suspect was wearing a #{team.name} shirt"

    favorite_athletes: (i) ->
      for athlete in i
        parser.clues.push
          type: 'favorite athletes'
          phrase: "The suspect has an autograph from #{athlete.name}"

    relationship_status: (i) ->
      status = ''
      switch i
        when 'Single'
          status = "The suspect looks single"
        when 'In a relationship'
          status = "I think the suspect is dating someone"
        when 'Engaged'
          status = "The suspect had a ring on his left hand"
        when 'Married'
          status = "The suspect had a ring on his right hand"
        when 'It\'s complidated'
          status = "The suspect seems to be in a complicated relationship"
        when 'In a open relationship'
          status = "The suspect is in a open relationship. If you know what I mean"
        when 'Widowed'
          status = "The suspect said being widowed"
        when 'Separated'
          status = "The suspect is separated"
        when 'Divorced'
          status = "The suspect is divorced"
      parser.clues.push
        type: 'relationship status'
        phrase: status
  }

  for k,v of friend
    if parser.hasOwnProperty(k)
      parser[k](v)
  parser.clues

exports.addClues = (friend, callback) ->
  clues = parseInfo(friend)
  callback(clues)
