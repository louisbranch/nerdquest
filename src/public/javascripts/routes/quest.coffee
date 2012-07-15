Nerd.QuestsRouter = Backbone.Router.extend
  routes:
    't': 'index'

  index: ->
    $content = $('#content')
    $content.empty()
    quests = new Nerd.Quests()
    questsView = new Nerd.QuestListView(collection: quests)
    $content.append(questsView.render().el)
    quests.fetch()

$ ->
  new Nerd.QuestsRouter()
  Backbone.history.start(pushState: true)
