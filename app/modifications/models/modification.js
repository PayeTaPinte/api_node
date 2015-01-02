var mongoose = require('mongoose');
var Schema = mongoose.Schema;

var ModificationSchema = new Schema({
	barId: String,
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
	activities: {
		babyfoot: Boolean,
		pool: Boolean,
		darts: Boolean,
		concert: Boolean
	},
	isCb: Boolean,
	minCb: Number,
	isOn: Boolean
});

module.exports = mongoose.model('Modification', ModificationSchema);
