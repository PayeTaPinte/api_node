express = require('express')
Bar = require('./bars/models/bar')
User = require('./users/models/user')
Modification = require('./modifications/models/modification')
geocoder = require('node-geocoder').getGeocoder('google', 'http')
router = express.Router()
userFunctions = require('./usersFunctions')

router.route('/bars')
	.get userFunctions.isAdmin, (req, res) ->
		console.log 'Yo ' + req.user.local.username + '!'
		console.log req.sessionID
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

							#AFFICHER LES MODIFICATIONS

			else
				throw 'no bar found'
			if err
				console.log 'error', err

router.route('/bar/edit/:bar_id')
	.get userFunctions.isAdmin, (req, res) ->
		Bar.findById req.params.bar_id, (err, bar) ->
			if bar
				res.render 'bars/edit',
					barName: bar.name
					barPrice: bar.price
					barAddress: bar.address
					barId: bar._id
					barIsOn: bar.isOn
					barMinCb: bar.minCb
					barIsCb: bar.isCb
					barTerrass: bar.terrass
					barPriceHappy: bar.price_happy
					barStartHappy: bar.start_happy
					barHasHappye: bar.has_happy
					barEndHappy: bar.end_happy
					barMetro: bar.metro
					barBabyfoot: bar.activities.babyfoot
					barPool: bar.activities.pool
					barDarts: bar.activities.darts
					barConcert: bar.activities.concert
					currentUser: req.user.local.username


router.route('/modifications')
	.get (req, res) ->
		Modification.find (err, modifications) ->
			if modifications
				res.render 'modifications/index',
					modifications: modifications

router.route('/modification/:modification_id')
	.get (req, res) ->
		Modification.findById req.params.modification_id, (err, modification) ->
			if modification
				Bar.find {_id: modification.barId}, (err, bar) ->
					console.log 'bar linked ', bar
					console.log 'modif bar id ', modification.barId
					res.render 'modifications/show',
						
						# bar
						barName: bar[0].name
						barAddress: bar[0].address
						barPrice: bar[0].price
						barId: bar[0]._id
						barIsOn: bar[0].isOn
						barMinCb: bar[0].minCb
						barIsCb: bar[0].isCb
						barTerrass: bar[0].terrass
						barPriceHappy: bar[0].price_happy
						barStartHappy: bar[0].start_happy
						barHasHappy: bar[0].has_happy
						barEndHappy: bar[0].end_happy
						barMetro: bar[0].metro
						barBabyfoot: bar[0].activities.babyfoot
						barPool: bar[0].activities.pool
						barDarts: bar[0].activities.darts
						barConcert: bar[0].activities.concert

						#modif
						modifId: modification.id
						modifName: modification.name
						modifAdress: modification.address
						modifPrice: modification.price
						modifIsOn: modification.isOn
						modifMinCb: modification.minCb
						modifIsCb: modification.isCb
						modifTerrass: modification.terrass
						modifPriceHappy: modification.price_happy
						modifHasHappy: modification.has_happy
						modifStartHappy: modification.start_happy
						modifEndHappy: modification.end_happy
						modifBabyfoot: modification.activities.babyfoot
						modifPool: modification.activities.pool
						modifDarts: modification.activities.darts
						modifConcert: modification.activities.concert

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
