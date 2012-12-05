###global define###

define ['controllers/controllers'
, 'services/userAccountService']
, (controllers) ->
  'use strict'

  controllers.controller 'userController'
  , ['$scope', 'UserAccount'
  , ($scope, UserAccount) ->

    $scope.deleteUser = (id) ->
      UserAccount.delete()

    $scope.resetApi = () ->
      console.log 'reset api'
      UserAccount.resetApi()

    $scope.user = UserAccount.get()
  ]