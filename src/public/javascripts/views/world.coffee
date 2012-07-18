Nerd.WorldView = Backbone.View.extend
  tagName: 'section'
  className: 'world'

  initialize: ->
    _.bindAll(@, 'render')
    @template = _.template($('#world-template').html())
    @render()
    @renderClues()

  render: ->
    $worldCanvas = $('.world-canvas')
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    $worldCanvas.html(@el)
    @

  renderClues: ->
    nextClues = @model.get('nextClues')
    new Nerd.CluesView(collection: nextClues)

Nerd.WorldListView = Backbone.View.extend
  tagName: 'li'

  initialize: ->
    _.bindAll(@, 'render')
    @template = _.template($('#world-row-template').html())

  events: ->
    'click' : 'selectWorld'

  render: ->
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    @

  selectWorld: ->
    @model.isRight (err, result) =>
      #TODO animate selection
      if err
        $(@el).addClass('wrong')
      else
        $(@el).addClass('right')
        #TODO move this logic to quest view
        new Nerd.WorldView(model: @model)
        nextWorlds = new Nerd.Worlds(result.nextWorlds)
        new Nerd.WorldsListView(collection: nextWorlds)

Nerd.WorldsListView = Backbone.View.extend
  className: 'next-worlds'

  initialize: ->
    _.bindAll(@, 'render')
    @template = _.template($('#worlds-list-template').html())
    @collection.bind('reset', @render)
    @render()

  render: ->
    $world = $('section.world')
    $(@el).html(@template({}))
    $worlds = @$('.worlds')
    @collection.each (world) ->
      view = new Nerd.WorldListView
        model: world
        collection: @collection
      $worlds.append(view.render().el)
    $world.append(@el)
    @
