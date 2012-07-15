Nerd.QuestBriefingView = Backbone.View.extend
  tagName: 'section'
  className: 'quest-briefing'

  initialize: ->
    _.bindAll(@, 'render')
    @model.bind('change', @render)
    @template = _.template($('#quest-briefing-template').html())

  events: ->
    'click .quest-start' : 'start'

  render: ->
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    @

  start: ->
    @model.start (world) ->
      new Nerd.WorldView(model: world)

  nextLevel: () ->
    @model.start (world) ->
      worlds = new Nerd.Worlds()
      worldsListView = new Nerd.WorldsListView(collection: worlds)
      worlds.reset([world])

Nerd.QuestRowView = Backbone.View.extend
  tagName: 'li'
  className: 'quest'

  initialize: ->
    _.bindAll(@, 'render')
    @model.bind('change', @render)
    @template = _.template($('#quest-row-template').html())

  events: ->
    'click .quest-title' : 'briefing'

  render: ->
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    @

  briefing: (e) ->
    view = new Nerd.QuestBriefingView(model: @model)
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
