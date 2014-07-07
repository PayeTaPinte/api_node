var mongoose = require('mongoose');
var bcrypt = require('bcrypt-nodejs')
var Bar = require('../../bars/models/bar')


var UserSchema = new mongoose.Schema({

	local: {
		username: String,
		email: String,
		password: String,
	},
	roles: {
		type: [String],
		default: ['user']
	},

	facebook: {
		id: String,
		token: String,
		displayName: String,
		username: String,
	},

	twitter: {
		id: String,
		token: String,
		displayName: String,
		username: String,
	},

	google: {
		id: String,
		token: String,
		email: String,
		name: String,
	}

});

UserSchema.methods.generateHash = function(password) {
	return bcrypt.hashSync(password, bcrypt.genSaltSync(8), null);
};

UserSchema.methods.validPassword = function(password) {
	return bcrypt.compareSync(password, this.local.password);
};

module.exports = mongoose.model('User', UserSchema);