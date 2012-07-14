Nerd.QuestView = Backbone.View.extend
  tagName: 'li'
  className: 'quest'

  initialize: ->
    _.bindAll(@, 'render')
    @model.bind('change', @render)
    @template = _.template($('#quest-template').html())

  events: ->
    'click .start-quest' : 'start'

  render: ->
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    @

  start: ->
    @model.start()
    console.log('started')

Nerd.QuestsView = Backbone.View.extend
  tagName: 'section'
  className: 'quest-log'

  initialize: ->
    _.bindAll(@, 'render')
    @template = _.template($('#quests-template').html())
    @collection.bind('reset', @render)
    @render()

  render: ->
    $(@.el).html(@template({}))
    $quests = @$('.quests')
    @collection.each (quest) ->
      view = new Nerd.QuestView
        model: quest
        collection: @collection
      $quests.append(view.render().el)
    @
