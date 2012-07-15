// Generated by CoffeeScript 1.3.3
(function() {

  Nerd.QuestBriefingView = Backbone.View.extend({
    tagName: 'section',
    className: 'quest-briefing',
    initialize: function() {
      _.bindAll(this, 'render');
      this.model.bind('change', this.render);
      return this.template = _.template($('#quest-briefing-template').html());
    },
    events: function() {
      return {
        'click .quest-start': 'start'
      };
    },
    render: function() {
      var rendered;
      rendered = this.template(this.model.toJSON());
      $(this.el).html(rendered);
      return this;
    },
    start: function() {
      return this.model.start(function(world) {
        return new Nerd.WorldView({
          model: world
        });
      });
    },
    nextLevel: function() {
      return this.model.start(function(world) {
        var worlds, worldsListView;
        worlds = new Nerd.Worlds();
        worldsListView = new Nerd.WorldsListView({
          collection: worlds
        });
        return worlds.reset([world]);
      });
    }
  });

  Nerd.QuestRowView = Backbone.View.extend({
    tagName: 'li',
    className: 'quest',
    initialize: function() {
      _.bindAll(this, 'render');
      this.model.bind('change', this.render);
      return this.template = _.template($('#quest-row-template').html());
    },
    events: function() {
      return {
        'click .quest-title': 'briefing'
      };
    },
    render: function() {
      var rendered;
      rendered = this.template(this.model.toJSON());
      $(this.el).html(rendered);
      return this;
    },
    briefing: function(e) {
      var view;
      view = new Nerd.QuestBriefingView({
        model: this.model
      });
      $('#content').html(view.render().el);
      return e.preventDefault();
    }
  });

  Nerd.QuestListView = Backbone.View.extend({
    tagName: 'section',
    className: 'quest-log',
    initialize: function() {
      _.bindAll(this, 'render');
      this.template = _.template($('#quest-list-template').html());
      this.collection.bind('reset', this.render);
      return this.render();
    },
    render: function() {
      var $quests;
      $(this.el).html(this.template({}));
      $quests = this.$('.quests');
      this.collection.each(function(quest) {
        var view;
        view = new Nerd.QuestRowView({
          model: quest,
          collection: this.collection
        });
        return $quests.append(view.render().el);
      });
      return this;
    }
  });

}).call(this);
