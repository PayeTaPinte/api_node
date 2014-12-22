ptp_api = angular.module 'ptp_api', []

ptp_api.controller 'adminBarsCtrl', ['$scope', ($scope) ->
	$scope.filter = ''
	$scope.isVisible = (name, address) ->
		return true if $scope.filter == ''
		regexp = new RegExp($scope.filter, 'ig')
		return name.search(regexp) > -1 || address.search(regexp) > -1
	
	$scope.confirmRemove = (id) ->
		$scope.toggle = true
		$scope.barToRemove = $scope.bars[id]

	$scope.bars = {}

	$scope.addBar = (id, name) ->
		$scope.bars[id] = 
			id: id
			name: name
]

ptp_api.controller 'adminUsersCtrl', ['$scope', ($scope) ->
	$scope.filter = ''
	$scope.isVisible = (username, email) ->
		return true if $scope.filter == ''
		regexp = new RegExp($scope.filter, 'ig')
		return username.search(regexp) > -1 || email.search(regexp) > -1

	$scope.confirmRemove = (id) ->
		$scope.toggle = true
		$scope.userToRemove = $scope.users[id]

	$scope.users = {}
	
	$scope.addUser = (id, name) ->
		$scope.users[id] = 
			id: id
			name: name
]
