###global define, require###

requirejs
  map:
    '*':
      'libs/angularResource': 'libs/angular-resource'
  shim:
    'libs/angular':
      exports: 'angular'
    'libs/angular-resource':
      deps: [
        'libs/angular'
      ]
    'libs/bootstrap':
      deps: [
        'libs/jquery-1.8.3'
      ]
  [
    'app'
    'libs/bootstrap'
    'bootstrap'
    'controllers/loginController'
    'controllers/logoutController'
    'controllers/mainController'
    'controllers/nacController'
    'controllers/usersController'
    'controllers/userController'
    'controllers/playersController'
    'controllers/gamesController'
    'responseInterceptors/auth'
    'directives/authDirective'
    'services/gameService'
    'services/userService'
    'services/userAccountService'
    'services/playerService'
  ], (app) ->
    app.config ['$routeProvider', '$locationProvider'
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
      .when '/games'
        controller: 'gamesController'
        templateUrl: '/views/games.html'
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
        templateUrl: 'views/user.html'
      .otherwise
        redirectTo: '/'
      $locationProvider.html5Mode(true)
      .hashPrefix '!'
    ]