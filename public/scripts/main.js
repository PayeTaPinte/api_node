(function() {
  var ptp_api;

  ptp_api = angular.module('ptp_api', []);

  ptp_api.controller('barsCtrl', [
    '$scope', '$http', function($scope, $http) {
      var removeBar;
      $http.get('/api/bars').success(function(data) {
        return $scope.bars = data;
      });
      return removeBar = function(x) {
        return $http["delete"]('/api/bar/x').success(function(data) {
          return console.log(data);
        });
      };
    }
  ]);

  ptp_api.controller('barDtlCtrl', [
    '$scope', '$http', '$location', function($scope, $http, $location) {
      $scope.message = 'hello bardetails';
      return $scope.getBar = function(barId) {
        return $http.get('/api/bar/' + barId).success(function(data) {
          return $scope.bar = data;
        });
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=main.js.map
