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
    @

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
    @collection.each (suspect) ->
      view = new Nerd.SuspectView
        model: suspect
        collection: @collection
      $suspects.append(view.render().el)
    $world.html(@el)
    @
