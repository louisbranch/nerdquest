Nerd.QuestFinalView = Backbone.View.extend
  className: 'quest-final'

  initialize: ->
    _.bindAll(@, 'render')
    @template = _.template($('#quest-final-template').html())
    @render()

  render: ->
    $world = $('.world-canvas')
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    $world.html(@el)
    @

Nerd.QuestView = Backbone.View.extend
  tagName: 'section'
  className: 'quest-canvas'

  initialize: ->
    _.bindAll(@, 'render', 'renderSuspects', 'renderFinal')
    @model.bind('finalLevel', @renderSuspects)
    @model.bind('finished', @renderFinal)
    @template = _.template($('#quest-template').html())

  events: ->
    'click .quest-start' : 'start'

  render: ->
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    @

  start: ->
    $('.quest-description').remove()
    @model.start (result) ->
      new Nerd.WorldView(model: result.firstWorld)
      nextWorlds = new Nerd.Worlds(result.nextWorlds)
      new Nerd.WorldsListView(collection: nextWorlds)

  renderSuspects: ->
    suspects = @model.get('suspects')
    new Nerd.SuspectsView(collection: suspects)

  renderFinal: ->
    new Nerd.QuestFinalView(model: @model)

Nerd.QuestRowView = Backbone.View.extend
  tagName: 'li'
  className: 'quest'

  initialize: ->
    _.bindAll(@, 'render')
    @template = _.template($('#quest-row-template').html())

  events: ->
    'click .quest-title' : 'briefing'

  render: ->
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    @

  briefing: (e) ->
    view = new Nerd.QuestView(model: @model)
    $('#content').html(view.render().el)
    e.preventDefault()

Nerd.QuestListView = Backbone.View.extend
  tagName: 'section'
  className: 'quest-log'

  initialize: ->
    _.bindAll(@, 'render')
    @template = _.template($('#quest-list-template').html())
    @collection.bind('reset', @render)
    @render()

  render: ->
    $(@el).html(@template({}))
    $quests = @$('.quests')
    @collection.each (quest) ->
      view = new Nerd.QuestRowView
        model: quest
        collection: @collection
      $quests.append(view.render().el)
    @
