var mongoose = require('mongoose');
mongoose.connect('localhost', 'ptp'	);
var Bar = require('./app/bars/models/bar');

var request = require('request');
var json = require('./bars.json');

var onlineJson = 'http://payetapinte.herokuapp.com/bars.json';
request(onlineJson, function(error, response, body) {
	json = JSON.parse(body);
	Bar.remove(function(err,bars) {
		console.log('Bars Deleted');
		if(err) {
			console.log(err);
		}
		else {
			for (var i = 0; i < json.length; i++) {
				bar = json[i];
				var newbar = new Bar()
				newbar.name = bar.name;
				newbar.price = bar.price;
				newbar.address = bar.address;
				newbar.latitude = bar.latitude;
				newbar.longitude = bar.longitude;
				newbar.price_happy = bar.price_happy;
				newbar.end_happy = bar.end_happy;
				newbar.start_happy = bar.start_happy;
				// newbar.slug

				newbar.save(function(err, qmfsdlj){
					if (err) {
						throw err;
					}
				});
				console.log(newbar.name + "Addes, num: " + i);
			}
		}
	});

});
