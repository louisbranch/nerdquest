// Generated by CoffeeScript 1.3.3
(function() {

  Nerd.ClueView = Backbone.View.extend({
    tagName: 'article',
    className: 'clue',
    initialize: function() {
      _.bindAll(this, 'render');
      return this.template = _.template($('#clue-template').html());
    },
    render: function() {
      var rendered;
      rendered = this.template(this.model.toJSON());
      $(this.el).html(rendered);
      return this;
    }
  });

  Nerd.CluesView = Backbone.View.extend({
    tagName: 'section',
    className: 'clues',
    currentClueIndex: 0,
    initialize: function() {
      _.bindAll(this, 'render');
      this.collection.bind('reset', this.render);
      this.template = _.template($('#clues-template').html());
      this.render();
      return this.renderNextClue();
    },
    render: function() {
      var $world;
      $world = $('section.world');
      $(this.el).html(this.template({}));
      return $world.append(this.el);
    },
    renderNextClue: function() {
      var clue, view;
      clue = this.collection.at(0);
      return view = new Nerd.ClueView({
        model: clue
      });
    }
  });

}).call(this);
