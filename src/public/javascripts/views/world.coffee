Nerd.WorldView = Backbone.View.extend
  tagName: 'section'
  className: 'world'

  initialize: ->
    _.bindAll(@, 'render')
    @model.bind('change', @render)
    @template = _.template($('#world-template').html())
    @render()

  render: ->
    $map = $('#map')
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    $map.html(@el)
    @

Nerd.WorldListView = Backbone.View.extend
  tagName: 'li'
  className: 'world'

  initialize: ->
    _.bindAll(@, 'render')
    @model.bind('change', @render)
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
        new Nerd.WorldView(model: @model)
        nextWorlds = new Nerd.Worlds(result.nextWorlds)
        new Nerd.WorldsListView(collection: nextWorlds)

Nerd.WorldsListView = Backbone.View.extend
  tagName: 'section'
  className: 'next-worlds'

  initialize: ->
    _.bindAll(@, 'render')
    @template = _.template($('#worlds-list-template').html())
    @collection.bind('reset', @render)
    @render()

  render: ->
    $map = $('#map')
    $(@el).html(@template({}))
    $worlds = @$('.worlds')
    @collection.each (world) ->
      view = new Nerd.WorldListView
        model: world
        collection: @collection
      $worlds.append(view.render().el)
    $map.append(@el)
    @
