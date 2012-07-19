Nerd.ClueView = Backbone.View.extend
  tagName: 'p'

  initialize: ->
    _.bindAll(@, 'render')
    @template = _.template($('#clue-template').html())

  render: ->
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    @

Nerd.CluesView = Backbone.View.extend
  tagName: 'ul'
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
    $clues = $('ul.clues')
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
