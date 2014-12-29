(function() {
  var ptp_api;

  ptp_api = angular.module('ptp_api', []);

  ptp_api.controller('adminBarsCtrl', [
    '$scope', function($scope) {
      $scope.filter = '';
      $scope.isVisible = function(name, address) {
        var regexp;
        if ($scope.filter === '') {
          return true;
        }
        regexp = new RegExp($scope.filter, 'ig');
        return name.search(regexp) > -1 || address.search(regexp) > -1;
      };
      $scope.confirmRemove = function(id) {
        $scope.toggle = true;
        return $scope.barToRemove = $scope.bars[id];
      };
      $scope.bars = {};
      return $scope.addBar = function(id, name) {
        return $scope.bars[id] = {
          id: id,
          name: name
        };
      };
    }
  ]);

  ptp_api.controller('adminUsersCtrl', [
    '$scope', function($scope) {
      $scope.filter = '';
      $scope.isVisible = function(username, email) {
        var regexp;
        if ($scope.filter === '') {
          return true;
        }
        regexp = new RegExp($scope.filter, 'ig');
        return username.search(regexp) > -1 || email.search(regexp) > -1;
      };
      $scope.confirmRemove = function(id) {
        $scope.toggle = true;
        return $scope.userToRemove = $scope.users[id];
      };
      $scope.users = {};
      return $scope.addUser = function(id, name) {
        return $scope.users[id] = {
          id: id,
          name: name
        };
      };
    }
  ]);

}).call(this);

//# sourceMappingURL=main.js.map
