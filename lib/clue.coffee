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
        phrase = "He was #{years} years old"
      else
        phrase = "He was born on #{i}"
      parser.clues.push
        type: 'birthday'
        phrase: phrase


    hometown: (i) ->
      parser.clues.push
        type: 'hometown'
        phrase: "He was born in #{i.name}"

    location: (i) ->
      parser.clues.push
        type: 'location'
        phrase: "He lives in #{i.name}"

    significant_other: (i) ->
      parser.clues.push
        type: 'In a relationship with'
        phrase: "He showed me a few photos from #{i.name}"

    quotes: (i) ->
      parser.clues.push
        type: 'quotes'
        phrase: "He left this: '#{i}'"

    political: (i) ->
      parser.clues.push
        type: 'political'
        phrase: "He has a #{i} political view"

    religion: (i) ->
      parser.clues.push
        type: 'religion'
        phrase: "He believes in the #{i} religion"

    education: (i) ->
      for item in i
        parser.clues.push
          type: 'education'
          phrase: "He has studied at #{item.school.name}"

    work: (i) ->
      for job in i
        parser.clues.push
          type: 'work'
          phrase: "He has worked at #{job.employer.name}"
        if job.position
          parser.clues.push
            type: 'position'
            phrase: "He has worked as #{job.position.name}"

    language: (i) ->
      for lang in i
        parser.clues.push
          type: 'language'
          phrase: "I head he speaking #{lang.name}"

    sports: (i) ->
      for sport in i
        parser.clues.push
          type: 'sports'
          phrase: "He had invited me to #{sport.name}"

    favorite_teams: (i) ->
      for team in i
        parser.clues.push
          type: 'favorite teams'
          phrase: "He was wearing a #{team.name} shirt"

    favorite_athletes: (i) ->
      for athlete in i
        parser.clues.push
          type: 'favorite athletes'
          phrase: "He has an autograph from #{athlete.name}"

    relationship_status: (i) ->
      status = ''
      switch i
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
  friend = {uid: friend.uid, name: friend.name, clues: clues}
  callback(friend)
