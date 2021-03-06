var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var BarSchema = new Schema({
	address: String,
	end_happy: String,
	name: String,
	price: Number,
	price_happy: Number,
	start_happy: String,
	has_happy: Boolean,
	addedBy: String,
	modifiedBy: String,
	location: {
		type: [Schema.Types.Mixed]
	},
	terrass: Boolean,
	activities:	{
		babyfoot: Boolean,
		pool: Boolean,
		darts: Boolean,
		concert: Boolean
	},
	isOn: Boolean,
	isCb: Boolean,
	minCb: Number,
	metro: {
		type: [Schema.Types.Mixed]
	}
});

module.exports = mongoose.model('Bar', BarSchema);
