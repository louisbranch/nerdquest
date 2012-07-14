Nerd.WorldView = Backbone.View.extend
  tagName: 'li'
  className: 'world'

  initialize: ->
    _.bindAll(@, 'render')
    @model.bind('change', @render)
    @template = _.template($('#world-template').html())

  events: ->
    'click .world' : 'selectWorld'

  render: ->
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    @

  updateWorld: (world) ->
    alert 'changed'

  selectWorld: (world) ->
    console.log world

Nerd.WorldsView = Backbone.View.extend
  tagName: 'section'
  className: 'worlds-map'

  initialize: ->
    _.bindAll(@, 'render')
    @template = _.template($('#worlds-template').html())
    @collection.bind('reset', @render)
    @render()

  render: ->
    $(@.el).html(@template({}))
    $worlds = @$('.worlds')
    @collection.each (world) ->
      view = new Nerd.WorldView
        model: world
        collection: @collection
      $worlds.append(view.render().el)
    @
