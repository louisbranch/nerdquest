clues = []

likeParser = {

  'Musician/band': (i) ->
    type: 'music'
    phrase: "The suspect was listening to #{i}"

  'Movie': (i) ->
    type: 'movie'
    phrase: "The suspect dropped a movie ticket from #{i}"

  'Game/toys': (i) ->
    type: 'game'
    phrase: "The suspect invited me to play #{i}"

  'Tv show': (i) ->
    type: 'tv show'
    phrase: "The suspect told something about the last episode from #{i}"

  'Musical gender': (i) ->
    type: 'musical genre'
    phrase: "The suspect bet me at RockBand playing #{i}"

  'Sport': (i) ->
    type: 'sport'
    phrase: "The suspect practices #{i}"

  'Book': (i) ->
    type: 'book'
    phrase: "The suspect was carrying #{i}"

  'Writer': (i) ->
    type: 'writer'
    phrase: "The suspect was reading a book from #{i}"

  'App page': (i) ->
    type: 'app'
    phrase: "The suspect sent me an annoying invite from #{i}"
}

parser = {
  gender: (i) ->
   clues.push
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
    clues.push
      type: 'birthday'
      phrase: phrase

  hometown: (i) ->
    clues.push
      type: 'hometown'
      phrase: "The suspect was born in #{i.name}"

  location: (i) ->
    clues.push
      type: 'location'
      phrase: "The suspect lives in #{i.name}"

  significant_other: (i) ->
    clues.push
      type: 'In a relationship with'
      phrase: "The suspect showed me a few photos from #{i.name}"

  quotes: (i) ->
    clues.push
      type: 'quotes'
      phrase: "The suspect left this: '#{i}'"

  political: (i) ->
    clues.push
      type: 'political'
      phrase: "The suspect has a #{i} political view"

  religion: (i) ->
    clues.push
      type: 'religion'
      phrase: "The suspect believes in the #{i} religion"

  education: (i) ->
    for item in i
      clues.push
        type: 'education'
        phrase: "The suspect has studied at #{item.school.name}"

  work: (i) ->
    for job in i
      clues.push
        type: 'work'
        phrase: "The suspect has worked at #{job.employer.name}"
      if job.position
        clues.push
          type: 'position'
          phrase: "The suspect has worked as #{job.position.name}"

  language: (i) ->
    for lang in i
      clues.push
        type: 'language'
        phrase: "I heard the suspect speaking #{lang.name}"

  sports: (i) ->
    for sport in i
      clues.push
        type: 'sports'
        phrase: "The suspect had invited me to #{sport.name}"

  favorite_teams: (i) ->
    for team in i
      clues.push
        type: 'favorite teams'
        phrase: "The suspect was wearing a #{team.name} shirt"

  favorite_athletes: (i) ->
    for athlete in i
      clues.push
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
    clues.push
      type: 'relationship status'
      phrase: status

  likes: (i) ->
    for like in i
      if likeParser.hasOwnProperty(like.category)
        clue = likeParser[like.category](like.name)
        clues.push(clue)
}

parseInfo = (friend) ->
  clues = []
  for k,v of friend
    if parser.hasOwnProperty(k)
      parser[k](v)
  clues

exports.addClues = (friend, callback) ->
  clues = parseInfo(friend)
  callback(clues)
