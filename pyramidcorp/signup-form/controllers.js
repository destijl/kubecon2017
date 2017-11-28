var redisApp = angular.module('redis', ['ui.bootstrap']);

/**
 * Constructor
 */
function RedisController() {}

RedisController.prototype.onRedis = function() {
    var email = this.scope_.email;
    var cardno = this.scope_.cardno;
    this.scope_.email = "";
    this.scope_.cardno = "";
    this.http_.get("signup.php?cmd=signup&email=" + email + "&cardno=" + cardno)
            .success(angular.bind(this, function(data) {
                this.scope_.redisResponse = "Successfully signed up!";
                this.scope_.count = data.count;
            }));
};

redisApp.controller('RedisCtrl', function ($scope, $http, $location) {
        $scope.controller = new RedisController();
        $scope.controller.scope_ = $scope;
        $scope.controller.location_ = $location;
        $scope.controller.http_ = $http;

        $scope.controller.http_.get("signup.php?cmd=getcount")
            .success(function(data) {
                console.log(data);
                $scope.count = data.count;
            });
});
