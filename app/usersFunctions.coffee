module.exports.hasRole = (user, role) ->
	return role in user.roles

module.exports.isAdmin = (req, res, next)->
	console.log 'check isAdmin'
	if req.isAuthenticated() == true && 'admin' in req.user.roles
		next()
	else
		res.redirect '/auth/login'

module.exports.isUser = (req, res, next)->
	if req.isAuthenticated() == true
		next()
	else
		res.redirect '/auth/login'