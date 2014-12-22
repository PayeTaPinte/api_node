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
		currentUser: req.user.local.username

router.route('/bar/:bar_id')
	.get userFunctions.isAdmin, (req, res) ->
		Bar.findById req.params.bar_id, (err, bar) ->
			if bar
				User.find {_id: bar.addedBy}, (err, resultAdd) ->
					User.find {_id: bar.modifiedBy}, (err, resultModify) ->
						res.render 'bars/bar', 
							barId: bar.id
							barName: bar.name
							barAddress: bar.address
							barPrice: bar.price
							resultAdd: resultAdd[0]
							resultModify: resultModify[0]
							currentUser: req.user.local.username

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
					barIsOn: bar.isOn
					currentUser: req.user.local.username

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
				Bar.find {addedBy: user._id}, (err, result) ->
					res.render 'users/user',
						userId: user.id
						result: result
						currentUser: req.user.local.username

module.exports = router
