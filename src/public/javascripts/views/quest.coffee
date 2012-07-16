Nerd.QuestBriefingView = Backbone.View.extend
  tagName: 'section'
  className: 'quest-canvas'

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
    $('.quest-description').remove()
    @model.start (result) ->
      new Nerd.WorldView(model: result.firstWorld)
      nextWorlds = new Nerd.Worlds(result.nextWorlds)
      new Nerd.WorldsListView(collection: nextWorlds)

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
