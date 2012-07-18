// Generated by CoffeeScript 1.3.3
(function() {

  Nerd.Quest = Backbone.RelationalModel.extend({
    relations: [
      {
        type: Backbone.HasMany,
        key: 'worlds',
        relatedModel: 'Nerd.World',
        collectionType: 'Nerd.Worlds',
        reverseRelation: {
          key: 'quest'
        }
      }, {
        type: Backbone.HasMany,
        key: 'suspects',
        relatedModel: 'Nerd.Suspect',
        collectionType: 'Nerd.Suspects',
        reverseRelation: {
          key: 'quest'
        }
      }
    ],
    start: function(callback) {
      return this.get('worlds').start(callback);
    },
    scoreRightWorld: function(level, callback) {
      var nextWorlds;
      nextWorlds = this.get('worlds').worldsByLevel(level + 1);
      if (nextWorlds.length === 0) {
        return this.trigger('finalLevel');
      } else {
        return callback(null, {
          nextWorlds: nextWorlds
        });
      }
    },
    scoreWrongWorld: function() {
      return console.log('meh');
    },
    finish: function() {
      return console.log('Finish HIM!');
    }
  });

  Nerd.Quests = Backbone.Collection.extend({
    model: Nerd.Quest,
    url: '/quests'
  });

}).call(this);
