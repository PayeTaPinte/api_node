express = require('express')
geocoder = require('node-geocoder').getGeocoder('google', 'http')
Bar = require('./bars/models/bar')
User = require('./users/models/user')

router = express.Router()

userFunctions = require('./usersFunctions')

# ////////////////////////// BARS /////////////////////////////////////

router.route('/markers')
	.post (req, res) ->
		marker = new Marker(req.body)
		marker.type = req.body.type
		marker.title = req.body.title
		marker.image = req.body.image
		marker.save (err, marker) ->
			if(err)
				console.log 'error', err
			res.send(200, marker)

router.route('/bars')
	.post userFunctions.isAdmin, (req, res) ->
		res.redirect '/auth/login' unless req.isAuthenticated()
		bar = new Bar(req.body)
		bar.name = req.body.name
		bar.price = req.body.price
		bar.address = req.body.address
		bar.addedBy = req.user._id
		bar.isOn = false
		geocoder.geocode req.body.address, (err, result) ->
			console.log result
			bar.location = result
			bar.save (err, bar) ->
				if(err)
					console.log 'error', err
				res.send(200, bar)
			# res.json message: "Bar created"

	.get (req, res) ->
		Bar.find (err, bars) ->
			if(err)
				throw err
				res.json 500, err

			res.json(bars)

	# .delete userFunctions.isAdmin, (req, res) ->
	# 	console.log 'DELETE "bars"';
	# 	Bar.remove (err, bars) ->
	# 		if(err)
	# 			console.log 'error', err

router.route('/bar/:bar_id')
	.get (req, res) ->
		Bar.findById req.params.bar_id, (err, bar) ->
			if(err)
				res.send(err)

			res.json(bar)

	.put (req, res) ->
		res.redirect '/auth/login' unless req.isAuthenticated()
		Bar.findById req.params.bar_id, (err, bar) ->
			if(err)
				res.send(err)

			bar.name = req.body.name
			bar.address = req.body.address
			bar.price = req.body.price
			bar.isOn = req.body.isOn
			bar.modifiedBy = req.user._id
			geocoder.geocode req.body.address, (err, result) ->
				bar.location = result
				bar.save (err, bar) ->
					if(err)
						throw err
					res.send(200, bar)

	.delete userFunctions.isAdmin, (req, res) ->
		Bar.remove
			_id: req.params.bar_id
			(err, req) ->
				if err
					console.log 'error', err
				else
					res.redirect '/bars/'


# ////////////////////////// USERS /////////////////////////////////////

router.route('/users')
	.get (req, res) ->
		User.find (err, users) ->
			if(err)
				console.log 'error', err
			res.json(users)

	.delete (req, res) ->
		console.log 'DELETE all Users'
		User.remove (err, bars) ->
			if err
				console.log 'error', err
				res.send(500, err)
			else
				res.send message: "Successfully ALL REMOVED"

router.route('/user/:user_id')
	.get (req, res) ->
		console.log 'GET user/'

		User.findById req.params.user_id, (err, user) ->
			if(err)
				console.log 'error', err

			res.json(user)

	.delete userFunctions.isAdmin, (req, res) ->
		User.remove
			_id: req.params.user_id
			(err, req) ->
				if err
					throw err
				else res.redirect '/users/'

module.exports = router
