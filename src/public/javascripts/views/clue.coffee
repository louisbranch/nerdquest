Nerd.ClueView = Backbone.View.extend
  tagName: 'article'
  className: 'clue'

  initialize: ->
    _.bindAll(@, 'render')
    @template = _.template($('#clue-template').html())

  render: ->
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    @

Nerd.CluesView = Backbone.View.extend
  tagName: 'section'
  className: 'clues'

  currentClueIndex: 0

  initialize: ->
    _.bindAll(@, 'render')
    @collection.bind('reset', @render)
    @template = _.template($('#clues-template').html())
    @render()
    @renderNextClue()

  render: ->
    $world = $('section.world')
    $(@el).html(@template({}))
    $world.html(@el)

  renderNextClue: ->
    clue = @collection.at(0)
    view = new Nerd.ClueView(model: clue)
