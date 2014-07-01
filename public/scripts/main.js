(function() {
  var ptp_api;

  ptp_api = angular.module('ptp_api', []);

  ptp_api.controller('adminBarsCtrl', [
    '$scope', function($scope) {
      $scope.filter = '';
      return $scope.isVisible = function(name, price, address) {
        var regexp;
        if ($scope.filter === '') {
          return true;
        }
        regexp = new RegExp($scope.filter, 'ig');
        return name.search(regexp) > -1 || address.search(regexp) > -1;
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=main.js.map
