//models
// =============================================================================
var User        = require('../../models/user');
// =============================================================================

var app = require('../../app');


// =============================================================================
exports.signup = function(req, res) {
  var user = new User(req.body) ;
  user.save(function(err){
      if (err){
        res.json({message : "error saving user"}) ;
      }else {
        res.json({user:user}) ;
      }
  });
};
