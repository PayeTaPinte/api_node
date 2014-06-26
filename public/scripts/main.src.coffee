ptp_api = angular.module 'ptp_api', []

ptp_api.controller 'barsCtrl', ['$scope', '$http', ($scope, $http) ->

	$http.get('/api/bars').success (data) ->
		$scope.bars = data

	removeBar = (x) ->
		$http.delete('/api/bar/x').success (data) ->
			console.log data
]

ptp_api.controller 'barDtlCtrl', ['$scope', '$http', '$location', ($scope, $http, $location) ->
	$scope.message = 'hello bardetails'
	$scope.getBar = (barId) ->
		$http.get('/api/bar/'+barId).success (data) ->
			$scope.bar = data
]
