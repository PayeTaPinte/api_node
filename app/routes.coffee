express = require('express')
Bar = require('./bars/models/bar')
User = require('./users/models/user')
geocoder = require('node-geocoder').getGeocoder('google', 'http')
router = express.Router()
userFunctions = require('./usersFunctions')

router.route('/bars')
	.get userFunctions.isAdmin, (req, res) ->
		Bar.find (err, bars) ->
			if bars
				# geocoder.geocode '29 champs elysée paris', (err, result) ->
				# 	console.log result[0].latitude

					res.render 'bars/index',
						bars: bars
						currentUser: req.user.local.username
			else
				throw 'no bars found'
			if err
				console.log 'error', err

router.route('/bar/new')
	.get userFunctions.isAdmin, (req, res) ->
		res.render 'bars/new'

router.route('/bar/:bar_id')
	.get userFunctions.isAdmin, (req, res) ->
		Bar.findById req.params.bar_id, (err, bar) ->
			if bar
				res.render 'bars/bar', 
					barId: bar.id
					barName: bar.name
					barAddress: bar.address
					barPrice: bar.price
			else
				throw 'no bar found'
			if err
				console.log 'error', err

router.route('/bar/edit/:bar_id')
	.get userFunctions.isAdmin, (req, res) ->
		Bar.findById req.params.bar_id, (err, bar) ->
			if bar
				res.render 'bars/edit',
					barId: bar._id
					barName: bar.name
					barAddress: bar.address
					barPrice: bar.price

router.route('/users/')
	.get userFunctions.isAdmin, (req, res) ->
		User.find (err, users) ->
			if users
				res.render 'users/index',
					users: users
					currentUser: req.user.local.username
			else
				throw 'No users found'
			if err
				console.log 'error', err

router.route('/user/:user_id')
	.get userFunctions.isAdmin, (req, res) ->
		User.findById req.params.user_id, (err, user) ->
			if user
				res.render 'users/user',
					userId: user.id

module.exports = router
