// Generated by CoffeeScript 1.3.3
(function() {

  _.templateSettings = {
    interpolate: /\%\%\=(.+?)\%\%/g,
    evaluate: /\%\%(.+?)\%\%/g
  };

  window.Mission = Backbone.Model.extend({});

  window.Missions = Backbone.Collection.extend({
    model: Mission,
    url: '/missions.json'
  });

  window.missions = new Missions();

  window.MissionView = Backbone.View.extend({
    tagName: 'article',
    className: 'mission',
    initialize: function() {
      _.bindAll(this, 'render');
      this.model.bind('change', this.render);
      return this.template = _.template(($('#mission-template')).html());
    },
    render: function() {
      var rendered;
      rendered = this.template(this.model.toJSON());
      ($(this.el)).html(rendered);
      return this;
    }
  });

  window.createMission = function() {
    return $.ajax({
      type: 'GET',
      dataType: 'json',
      url: '/mission.json',
      success: function(json) {
        return missions.add(new Mission(json));
      },
      error: function() {
        return console.log('error');
      }
    });
  };

}).call(this);