var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var BarSchema = new Schema({
	address: String,
	end_happy: String,
	longitude: Number,
	name: String,
	slug: String,
	price: Number,
	price_happy: Number,
	start_happy: String,
	location: {
		type: [Schema.Types.Mixed]
	}
});

module.exports = mongoose.model('Bar', BarSchema);
