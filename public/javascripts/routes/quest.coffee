Nerd.QuestsRouter = Backbone.Router.extend
  routes:
    't': 'index'

  index: ->
    $questLog = $('#quest-log')
    $questLog.empty()
    quests = new Nerd.Quests()
    questsView = new Nerd.QuestsView({collection: quests})
    $questLog.append(questsView.render().el)
    quests.fetch()

$ ->
  new Nerd.QuestsRouter()
  Backbone.history.start(pushState: true)
