Nerd.QuestsRouter = Backbone.Router.extend
  routes:
    't': 'index'

  index: ->
    $canvas = $('.quest-canvas')
    quests = new Nerd.Quests()
    questsView = new Nerd.QuestListView(collection: quests)
    $canvas.html(questsView.render().el)
    quests.fetch()

$ ->
  new Nerd.QuestsRouter()
  Backbone.history.start(pushState: true)
