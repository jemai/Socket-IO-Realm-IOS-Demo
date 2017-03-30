var mongoose = require('mongoose');

var UserSchema = new mongoose.Schema({

	nickname : { type: String, unique: true, required: true },

	photo : { type: String,  required: true },

});// EndOf UserSchema

// Export the Mongoose model
module.exports = mongoose.model('user', UserSchema);
