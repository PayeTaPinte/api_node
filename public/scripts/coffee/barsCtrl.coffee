ptp_api = angular.module 'ptp_api', []

ptp_api.controller 'adminBarsCtrl', ['$scope', ($scope) ->
	$scope.filter = ''
	$scope.isVisible = (name, price, address) ->
		return true if $scope.filter == ''
		regexp = new RegExp($scope.filter, 'ig')
		return name.search(regexp) > -1 || address.search(regexp) > -1
]