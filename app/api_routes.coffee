express = require('express')
geocoder = require('node-geocoder').getGeocoder('google', 'http')
Bar = require('./bars/models/bar')
User = require('./users/models/user')
Modification = require('./modifications/models/modification')

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
	.post (req, res) ->
		bar = new Bar(req.body)
		bar.name = req.body.name
		bar.price = req.body.price
		bar.address = req.body.address
		
		# bar.addedBy = req.user._id
		# if req.user._id
		# 	bar.addedBy = req.user._id
		# else
		# 	bar.addedBy = null
		bar.activities.babyfoot = req.body.activities.babyfoot
		bar.activities.pool = req.body.activities.pool
		bar.activities.darts = req.body.activities.darts
		bar.activities.concert = req.body.activities.concert
		
		if req.body.terrass
			bar.terrass = req.body.terrass
		else
			bar.terrass = false

		if req.body.isCb
			bar.isCb = req.body.isCb
		else
			bar.isCb = false

		if req.body.minCb
			bar.minCb = req.body.minCb
		else
			bar.minCb = null

		if req.body.has_happy
			bar.has_happy = req.body.has_happy
		else
			bar.has_happy = false

		if req.body.price_happy
			bar.price_happy = req.body.price_happy
		else
			bar.price_happy = null

		if req.body.start_happy
			bar.start_happy = req.body.start_happy
		else
			bar.start_happy = null

		if req.body.end_happy
			bar.end_happy = req.body.end_happy
		else
			bar.end_happy = null

		bar.isOn = false

		geocoder.geocode req.body.address, (err, result) ->
			bar.location = result
			bar.save (err, bar) ->
				if(err)
					console.log 'error', err
				console.log bar
				res.send(200, bar)

	.get (req, res) ->
		console.log '-----------------------------------------------------------> ' + req.isAuthenticated()
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
	.get userFunctions.isAdmin, (req, res) ->
		Bar.findById req.params.bar_id, (err, bar) ->
			if(err)
				res.send(err)

			res.json(bar)

	.put (req, res) ->
		# res.redirect '/auth/login' unless req.isAuthenticated()
		Bar.findById req.params.bar_id, (err, bar) ->
			if(err)
				res.send(err)

			bar.name = req.body.name
			bar.address = req.body.address
			bar.price = req.body.price
			bar.end_happy = req.body.end_happy
			bar.price_happy = req.body.price_happy
			bar.start_happy = req.body.start_happy
			bar.has_happy = req.body.has_happy
			bar.addedBy = req.body.addedBy
			bar.modifiedBy = req.body.modifiedBy
			bar.terrass = req.body.terrass
			bar.activities.babyfoot = req.body.babyfoot
			bar.activities.pool = req.body.pool
			bar.activities.darts = req.body.darts
			bar.activities.concert = req.body.concert
			bar.isCb = req.body.isCb
			bar.minCb = req.body.minCb
			bar.isOn = req.body.isOn

			bar.save (err, bar) ->
				if err
					throw err
				res.send(200, bar)

			# modif = new Modification(req.body)
			# modif.barId = bar._id
			# modif.name = req.body.name
			# modif.address = req.body.address
			# modif.price = req.body.price
			# modif.isOn = req.body.isOn
			# modif.modifiedBy = req.user._id
			# modif.location = bar.location
			# # geocoder.geocode req.body.address, (err, result) ->
			# # 	modif.location = result
			# modif.save (err, modif) ->
			# 	if(err)
			# 		throw err
			# 	res.send(200, modif)

	.delete userFunctions.isAdmin, (req, res) ->	
		Bar.remove
			_id: req.params.bar_id
			(err, req) ->
				if err
					console.log 'error', err
				else
					res.redirect '/bars/'

# ////////////////////////// MODIF /////////////////////////////////////

router.route('/modifications')
	.get (req, res) ->
		Modification.find (err, modifications) ->
			if (err)
				console.log err
			else
				res.json(modifications)

	.post (req, res) ->

		modif = new Modification(req.body)
		modif.barId = req.body.barId
		modif.name = req.body.name
		modif.address = req.body.address
		modif.price = req.body.price
		modif.end_happy = req.body.end_happy
		modif.price_happy = req.body.price_happy
		modif.start_happy = req.body.start_happy
		modif.has_happy = req.body.has_happy
		modif.addedBy = req.body.addedBy
		modif.modifiedBy = req.body.modifiedBy
		modif.terrass = req.body.terrass
		modif.activities.babyfoot = req.body.babyfoot
		modif.activities.pool = req.body.pool
		modif.activities.darts = req.body.darts
		modif.activities.concert = req.body.concert
		modif.isCb = req.body.isCb
		modif.minCb = req.body.minCb
		modif.isOn = req.body.isOn

		modif.save (err, modif) ->
			if(err)
				throw err
			console.log modif
			res.send(200, modif)

# ////////////////////////// USERS /////////////////////////////////////

router.route('/users')
	.get userFunctions.isAdmin, (req, res) ->
		User.find (err, users) ->
			if(err)
				console.log 'error', err
			res.json(users)

	.delete userFunctions.isAdmin, (req, res) ->
		console.log 'DELETE all Users'
		User.remove (err, bars) ->
			if err
				console.log 'error', err
				res.send(500, err)
			else
				res.send message: "Successfully ALL REMOVED"

router.route('/user/:user_id')
	.get userFunctions.isAdmin, (req, res) ->
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
