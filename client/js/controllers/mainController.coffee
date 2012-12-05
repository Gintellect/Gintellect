###global define###

define ['controllers/controllers']
, (controllers) ->
  'use strict'

  controllers.controller 'mainController'
  , ['$rootScope', '$http', '$scope'
  , ($rootScope, $http, $scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate',
      'AngularJS',
      'Testacular'
    ]
    $scope.getLoggedInUser = do ->
      $http.get('/api/user')
      .success (user) ->
        $rootScope.me = user
        $rootScope.loggedIn = true
  ]
