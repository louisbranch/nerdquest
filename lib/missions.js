// Generated by CoffeeScript 1.3.3
(function() {
  var clue, creator, db, facebook;

  facebook = require('../lib/facebook');

  clue = require('../lib/clue');

  creator = require('../lib/creator');

  db = require('../lib/db');

  exports.create = function(token, callback) {
    return facebook.getFriend(token, function(friend, suspects) {
      clue.addClues(friend, function(friend) {
        return res.send({
          friend: friend,
          suspects: suspects
        });
      });
      return db.saveMission(new_mission, function(id) {
        return console.log(id);
      });
    });
  };

}).call(this);