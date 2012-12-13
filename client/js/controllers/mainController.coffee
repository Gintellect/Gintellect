angular.module('app').controller 'mainController'
, ['$rootScope', '$http', '$scope', 'authService'
, ($rootScope, $http, $scope, authService) ->
  $scope.getLoggedInUser = ->
    console.log 'calling get user'
    $http.get('/api/user')
    .success (user) ->
      $rootScope.me = user
      $rootScope.loggedIn = true
    .error ->
      $rootScope.me = {}
      $rootScope.loggedIn = false

  $scope.isUserLoggedIn = ->
    $http.get('/api/loginstatus')
    .success (data, status) ->
      if data.loggedIn
        console.log 'user is logged in'
        $scope.getLoggedInUser()
        authService.loginConfirmed()
      else
        console.log 'user is not logged in'
        $rootScope.me = {}
        $rootScope.loggedIn = false

  if not $rootScope.loginTested
    console.log 'login has not been tested'
    console.log 'testing login'
    $scope.isUserLoggedIn()
    $rootScope.loginTested = true
]