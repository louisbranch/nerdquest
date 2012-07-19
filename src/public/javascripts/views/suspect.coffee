Nerd.SuspectView = Backbone.View.extend
  tagName: 'li'

  initialize: ->
    _.bindAll(@, 'render')
    @template = _.template($('#suspect-template').html())

  events:
    'click' : 'selectSuspect'

  render: ->
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    @renderClues()
    @

  renderClues: ->
    clues = @model.get('clues')
    if _.any(clues.models)
      new Nerd.CluesView(collection: clues)

  selectSuspect: ->
    @model.isRight (err, result) =>
      #TODO animate selection
      #TODO extract this in a reusable method
      if err
        $(@el).addClass('wrong')
      else
        $(@el).addClass('right')
        @model.get('quest').finish()

Nerd.SuspectsView = Backbone.View.extend
  className: 'suspects'

  initialize: ->
    _.bindAll(@, 'render')
    @collection.bind('reset', @render)
    @template = _.template($('#suspects-template').html())
    @render()

  render: ->
    $world = $('section.world')
    $(@el).html(@template({}))
    $suspects = @$('.suspects')
    $world.html(@el)
    @collection.each (suspect) ->
      view = new Nerd.SuspectView
        model: suspect
        collection: @collection
      $suspects.append(view.render().el)
    @
