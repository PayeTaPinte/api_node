express = require('express')
Bar = require('./bars/models/bar')
User = require('./users/models/user')

router = express.Router()

userFunctions = require('./usersFunctions')


# ////////////////////////// BARS /////////////////////////////////////


router.route('/bars')
	.post (req, res) ->
		res.redirect '/auth/login' unless req.isAuthenticated()
		console.log 'POST "bars"';
		bar = new Bar(req.body)
		bar.name = req.body.name

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

			bar.name = req.body.name;

			bar.save (err, bar) ->
				if err
					console.log 'error', err
				else
					res.send 200, bar

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

module.exports = router