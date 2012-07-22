Nerd.ClueView = Backbone.View.extend
  tagName: 'p'

  initialize: ->
    _.bindAll(@, 'render')
    @template = _.template($('#clue-template').html())
    @setQuest()

  quest: {}

  render: ->
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    @quest.useClue()
    @

  setQuest: ->
    if @model.get('world')
      @quest = @model.get('world').get('quest')
    else if @model.get('suspect')
      @quest = @model.get('suspect').get('quest')

Nerd.CluesView = Backbone.View.extend
  className: 'clues'

  currentClueIndex: 0

  initialize: ->
    _.bindAll(@, 'render')
    @collection.bind('reset', @render)
    @template = _.template($('#clues-template').html())
    @render()
    @renderNextClue()

  events:
    'click .next-clue': 'renderNextClue'

  render: ->
    $clues = $('.clues')
    $(@el).html(@template({}))
    $clues.replaceWith(@el)
    @

  renderNextClue: ->
    $clue = $('.clue')
    clue = @collection.at(@currentClueIndex)
    view = new Nerd.ClueView(model: clue)
    $clue.html(view.render().el)
    @incrementCounter()

  incrementCounter: ->
    @currentClueIndex += 1
    if @collection.length == @currentClueIndex
      $('.next-clue').remove()
