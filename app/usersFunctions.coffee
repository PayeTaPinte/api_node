module.exports.hasRole = (user, role) ->
	return role in user.roles

module.exports.isAdmin = (req, res, next)->
	if req.isAuthenticated() == true && 'admin' in req.user.roles
		console.log 'is admin'
		next()
	else
		res.redirect '/auth/login'

module.exports.isUser = (req, res, next)->
	console.log 'avant verif: ', req.user
	if req.user != null
		console.log 'is user: ' + req.user
		next()
	else
		res.redirect '/auth/login'