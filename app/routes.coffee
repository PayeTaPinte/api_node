express = require('express')
Bar = require('./bars/models/bar')
User = require('./users/models/user')
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

module.exports = router
