Nerd.Quest = Backbone.Model.extend()

Nerd.Quests = Backbone.Collection.extend
  model: Nerd.Quest
  url: '/quests'

