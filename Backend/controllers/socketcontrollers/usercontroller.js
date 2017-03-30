//models
// =============================================================================
var User        = require('../../models/user');
// =============================================================================

exports.handleUsers = function(socket){
  socket.on("test" , function(test){

    console.log(test);
    socket.emit("test" , "Hey Dear Client !!! u alive ?" , "This is the content you  like to see") ;

  })
};
