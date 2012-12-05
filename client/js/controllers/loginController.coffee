###global define###

define ['controllers/controllers'
, 'responseInterceptors/auth']
, (controllers) ->
  'use strict'

  controllers.controller 'loginController'
  , [ '$rootScope', '$scope', '$http', '$timeout', 'authService'
  , ($rootScope, $scope, $http, $timeout, authService) ->
    #when we're in this controller we should keep testing to see
    #if the user has managed to login yet.
    $scope.getLoggedInUser = () ->
      $http.get('/api/user')
      .success (user) ->
        $rootScope.me = user
        $rootScope.loggedIn = true

    $scope.testLogin = () ->
      $http.get('/api/loginstatus')
      .success (data, status) ->
        if data.loggedIn
          $scope.getLoggedInUser()
          authService.loginConfirmed()
        else
          $timeout $scope.testLogin, 1000
      .error (data, status) ->
        $timeout $scope.testLogin, 1000

    $scope.testLogin()
  ]