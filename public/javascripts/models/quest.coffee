Nerd.Quest = Backbone.Model.extend
  start: ->
    console.log('starting')

Nerd.Quests = Backbone.Collection.extend
  model: Nerd.Quest
  url: '/quests'

