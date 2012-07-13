Quest = Backbone.Model.extend()

window.Quests = Backbone.Collection.extend
  model: Quest
  url: '/quests'

QuestView = Backbone.View.extend
  tagName: 'li'
  className: 'quest'

  initialize: ->
    _.bindAll(@, 'render')
    @model.bind('change', @render)
    @template = _.template($('#quest-template').html())

  render: ->
    rendered = @template(@model.toJSON())
    $(@el).html(rendered)
    @

window.QuestsView = Backbone.View.extend
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
      view = new QuestView
        model: quest
        collection: @collection
      $quests.append(view.render().el)
    @

$ ->
  quests = new Quests()
  questsView = new QuestsView({collection: quests})
  $('body').append(questsView.render().el)
  quests.fetch()
