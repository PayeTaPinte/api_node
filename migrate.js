var mongoose = require('mongoose');
geocoder = require('node-geocoder').getGeocoder('google', 'http')
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
			// for (var i = 0; i < json.length; i++) {
			// 	bar = json[i];
			// 	var newbar = new Bar()
			// 	newbar.name = bar.name;
			// 	newbar.price = bar.price;
			// 	newbar.address = bar.address;
			// 	newbar.latitude = bar.latitude;
			// 	newbar.longitude = bar.longitude;
			// 	newbar.price_happy = bar.price_happy;
			// 	newbar.end_happy = bar.end_happy;
			// 	newbar.start_happy = bar.start_happy;
			// 	newbar.isOn = true;
			// 	geocoder.geocode(bar.address, function(err, result){
			// 		console.log(result);
			// 		newbar.location.push(result);
			// 		newbar.save(function(err, qmfsdlj){
			// 			if (err) {
			// 				throw err;
			// 			}
			// 		});
			// 	});

			// 	newbar.save(function(err, qmfsdlj){
			// 		if (err) {
			// 			throw err;
			// 		}
			// 	});
			// }


			var i = 0;

			function savebar(bar){
				setTimeout(function(){
					var newbar = new Bar();
					newbar.name = bar.name;
					newbar.price = bar.price;
					newbar.address = bar.address;
					newbar.has_happy = bar.has_happy;
					newbar.price_happy = bar.price_happy;
					newbar.end_happy = bar.end_happy;
					newbar.start_happy = bar.start_happy;
					newbar.terrass = false;
					newbar.activities.babyfoot = false;
					newbar.activities.pool = false;
					newbar.activities.darts = false;
					newbar.activities.concert = false;
					newbar.isCb = false;
					newbar.minCb = null;
					newbar.isOn = true;
					geocoder.geocode(bar.address, function(err, result){
						console.log(result);
						newbar.location = result;
						newbar.save(function(err, qmfsdlj){
							if (err) {
								throw err;
							}else{

								if(i < json.length-1){
									console.log(i);
									i++;
									savebar(json[i]);
								}else{
									console.log('no more bar');
								}
							}
						});
					});
				}, 100);
			}
			savebar(json[0]);



		}
	});

});
