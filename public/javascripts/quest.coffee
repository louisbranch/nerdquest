$ ->
  quests = new Nerd.Quests()
  questsView = new Nerd.QuestsView({collection: quests})
  $('body').append(questsView.render().el)
  quests.fetch()
