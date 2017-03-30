
//controllers
var userController = require('../controllers/socketcontrollers/usercontroller');
var feedsController = require('../controllers/socketcontrollers/feedscontroller');
// Routing
module.exports = function(server){
  var io = require('socket.io')(server);

  // catch errors
  io.on('error', function(err){
    throw err;
  });
  // All Io methodes will be routed only if there is a connection
  io.on('connection', function (socket) {

      console.log('a user connected');

      userController.handleUsers(socket);
      feedsController.handleFeeds(socket);

      // notify when a user has gone offline
      // =============================================================================
      socket.on('disconnect', function(){
        console.log('user disconnected');
      });

  });

  return io; // so it can be used in app.js ( if need be )
}
