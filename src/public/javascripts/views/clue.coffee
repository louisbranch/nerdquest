Nerd.ClueView = Backbone.View.extend
  tagName: 'article'
  className: 'clue'

  initialize: ->
    _.bindAll(@, 'render')
    @model.bind('change', @render)
    @template = _.template($('#clue-template').html())
    @render()

  render: ->
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    @

  renderClues: ->
    nextClues = new Nerd.Clues(@get('nextClues')
    new Nerd.CluesView(collection: nextClues)

Nerd.CluesView = Backbone.View.extend
  tagName: 'section'
  className: 'clues'

  initialize: ->
    _.bindAll(@, 'render')
    @model.bind('change', @render)
    @template = _.template($('#clues-template').html())

  render: ->
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    @
