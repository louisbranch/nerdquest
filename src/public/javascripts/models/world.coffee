Nerd.World = Backbone.RelationalModel.extend
  initialize: ->
    console.log 'world created'
    #view = new Nerd.WorldView(model: @)
    #ss = view.render().el
    #$('body').append(ss)
    #@trigger('change')

Nerd.Worlds = Backbone.Collection.extend
  model: Nerd.World

