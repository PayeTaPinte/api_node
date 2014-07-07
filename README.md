/api/bars  				==> json
	|_ get: everyone
	|_ post: members
	|_ delete: admins

/api/bar/:bar_id		==> json
	|_ get: everyone
	|_ put: admins
	|_ delete: admins

/api/users 				==> json
	|_ get: members
	|_ post: everyone
	|_ delete: admins

/api/user/:user_id		==> json
	|_ get: members
	|_ put: members
	|_ delete: admins




---------------->  EVERYONE  <----------------

	/api/bars
		get: everyone => OK
		post: members => OK
		delete: admin => NOT YET

que fait-on pour le model bar
réflechir sur l'affichage des unités de monnaies selon les pays
instagram en flux #ptp

modified
	bar model
	