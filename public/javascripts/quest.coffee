window.Quest = Backbone.Model.extend()

Quests = Backbone.Collection.extend
  model: Quest

window.QuestView = Backbone.View.extend
  tagName: 'article'
  className: 'quest'

  initialize: ->
    _.bindAll(@, 'render')
    @model.bind('change', @render)
    @template = _.template($('#quest-template').text())

  render: ->
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    @

QuestsView = Backbone.View.extend
  tagName: 'section'
  className: 'quests'

  initialize: ->
    _.bindAll(@, 'render')
    @template = _.template($('#quests-template').text())
    @render()

  render: ->
    $(@.el).html(@template({}))
    quests = @$('.quests')
    @collection.each (quest) ->
      view = new QuestView
        model: quest
        collection: @collection
      quests.append(view.render().el)
    @
