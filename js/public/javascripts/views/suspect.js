// Generated by CoffeeScript 1.3.3
(function() {

  Nerd.SuspectView = Backbone.View.extend({
    tagName: 'li',
    initialize: function() {
      _.bindAll(this, 'render');
      return this.template = _.template($('#suspect-template').html());
    },
    events: {
      'click': 'selectSuspect'
    },
    render: function() {
      var rendered;
      rendered = this.template(this.model.toJSON());
      $(this.el).html(rendered);
      this.renderClues();
      return this;
    },
    renderClues: function() {
      var clues;
      clues = this.model.get('clues');
      if (_.any(clues.models)) {
        return new Nerd.CluesView({
          collection: clues
        });
      }
    },
    selectSuspect: function() {
      var _this = this;
      return this.model.isRight(function(err, result) {
        if (err) {
          return $(_this.el).addClass('wrong');
        } else {
          $(_this.el).addClass('right');
          return _this.model.get('quest').finish();
        }
      });
    }
  });

  Nerd.SuspectsView = Backbone.View.extend({
    className: 'suspects-canvas',
    initialize: function() {
      _.bindAll(this, 'render');
      this.collection.bind('reset', this.render);
      this.template = _.template($('#suspects-template').html());
      console.log('created');
      return this.render();
    },
    render: function() {
      var $canvas, $suspects;
      $canvas = $('.quest-canvas');
      $(this.el).html(this.template({}));
      $suspects = this.$('.suspects');
      $canvas.html(this.el);
      this.collection.each(function(suspect) {
        var view;
        view = new Nerd.SuspectView({
          model: suspect,
          collection: this.collection
        });
        return $suspects.append(view.render().el);
      });
      return this;
    }
  });

}).call(this);