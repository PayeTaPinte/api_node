passport = require('passport')
LocalStrategy = require('passport-local').Strategy
User = require('../app/users/models/user')

passport.serializeUser (user, done) ->
	done null, user.id

passport.deserializeUser (id, done) ->
	User.findById id, (err, user) ->
		if !user
			UserAdmin.findById id, (err, user) ->
				done(err, user)
		else 
			done(err, user)

passport.use 'local-signup', new LocalStrategy(
	usernameField: 'username'
	passwordField: 'password'
	passReqToCallback: true
, (req, username, password, done) ->
	# asynchronous
	process.nextTick ->
		User.findOne {'local.username' : username}, (err,user) ->
			if(err)
				return done(err)

			if(user)
				return done null, false, req.flash 'signupMessage', 'That username is already used'
			else 
				console.log req.body
				newUser = new User()
				newUser.local.username = username
				newUser.local.email = req.body.email
				newUser.local.password = newUser.generateHash(password)

				newUser.save (err) ->
					if(err)
						throw err

					return done null, newUser
)

# ========================================
# ========================================
# ==============   LOGIN    ==============
# ========================================
# ========================================

passport.use "local-login", new LocalStrategy(
	usernameField: 'username'
	passwordField: 'password'
	passReqToCallback: true
, (req, username, password, done) ->
	process.nextTick ->
		console.log username
		User.findOne { 'local.username': username }, (err, user) ->
			if(err)
				return done(err)

			if(!user)
				return done(null, false, req.flash 'loginMessage', 'No user found / Wrong password')

			if(!user.validPassword(password))
				return done(null, false, req.flash 'loginMessage', 'No user found / Wrong password')

			return done(null, user)
)
