var mongoose = require('mongoose');
mongoose.connect('localhost', 'ptp');

var Bar = require('./app/bars/models/bar');
var json = require('./bars.json');
var geocoder = require('node-geocoder').getGeocoder('google', 'http');


var processBar = function (bar, i) {
	console.log(i, 'processed');
	if (bar.location.length < 1) {
		geocoder.geocode(bar.address, function(err, data) {
			if (data) {
				delete bar.latitude;
				delete bar.longitude;
				bar.location = data;
				console.log(i, 'geodata', data);
				bar.save(function (err, itemSaved) {
					if (err) {
						throw err;
					}
					console.log(i, 'saved');
				});
				
			}
			else {
				console.log(i, 'err', err);
				console.log('     ', i, 'no geocode', bar.address);
			}
		});
	}
}

Bar.find().exec(function (err, bars) {
	if (!err && bars.length > 0) {
		for (i in bars) {
			var bar = bars[i];
			processBar(bar, i)
			console.log(i, '/', bars.length);
		}
	}
});
