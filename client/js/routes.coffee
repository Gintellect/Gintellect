angular.module('app').config ['$routeProvider', '$locationProvider'
, ($routeProvider, $locationProvider) ->
  $routeProvider
  .when '/'
    controller: 'mainController'
    templateUrl: '/views/main.html'
  .when '/login'
    controller: 'loginController'
    templateUrl: '/views/login.html'
  .when '/logout'
    controller: 'logoutController'
    templateUrl: '/views/logout.html'
  .when '/games/:id'
    controller: 'nacController'
    templateUrl: '/views/noughts-and-crosses.html'
  .when '/games/noughts-and-crosses'
    controller: 'nacController'
    templateUrl: '/views/noughts-and-crosses.html'
  .when '/players'
    controller: 'playersController'
    templateUrl: '/views/players.html'
  .when '/user'
    controller: 'userController'
    templateUrl: '/views/user.html'
  .otherwise
    redirectTo: '/'
  $locationProvider.html5Mode(true)
  .hashPrefix '!'
]