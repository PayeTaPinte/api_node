express = require('express')
router = express.Router()
passport = require('passport')

require('../config/passport')

User = require('./users/models/user')

router.get '/', (req, res) ->
	res.render 'index'

router.get '/login', (req, res) ->
	console.log 'Login: ' + req.user
	res.render 'login', { message: req.flash 'loginMessage' }

router.get '/signup', (req, res) ->
	res.render 'signup', { message: req.flash 'signupMessage' }

router.get '/profile', (req, res) ->
	res.render 'profile', user : req.user


router.get '/logout', (req, res) ->
	console.log 'avant logout: ' + req.user
	req.logout()
	console.log 'Logout: ' + req.user
	res.redirect('/auth/login')

router.post '/signup', passport.authenticate("local-signup",
	successRedirect: '/auth/profile'
	failureRedirect: '/auth/signup'
	failureFlash: true
)

router.post '/login', passport.authenticate('local-login'
	#successRedirect: '/bars'
	#failureRedirect: '/auth/login'
	#failureFlash: true	
), (req, res) ->
	console.log "wesh"
	console.log req.sessionID
	res.send 200, req.user

module.exports = router
