//models
// =============================================================================
var User        = require('../../models/user');
// =============================================================================

exports.handleFeeds = function(socket){

  socket.on("feed" , function(feed){
    console.log(feed);
    socket.emit("feed" , "Boring feeds ?") ;
  })

};
