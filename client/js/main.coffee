require
  shim:
    'libs/angular-resource': deps: [ 'libs/angular' ]
    'libs/bootstrap': deps: ['libs/jquery-1.8.3' ]
    'controllers/loginController':
      deps: [
        'libs/angular', 'app'
        , 'responseInterceptors/auth'
      ]
    'controllers/logoutController':
      deps: [
        'libs/angular', 'app'
        , 'responseInterceptors/auth'
      ]
    'controllers/mainController':
      deps: [
        'libs/angular', 'app'
        , 'responseInterceptors/auth'
      ]
    'controllers/nacController':
      deps: [
        'libs/angular', 'app'
        , 'services/gameService'
        , 'services/userService'
        , 'services/playerService'
      ]
    'controllers/playersController':
      deps: [
        'libs/angular', 'app'
        , 'services/playerService'
      ]
    'controllers/userController':
      deps: [
        'libs/angular', 'app'
        , 'services/userAccountService'
      ]
    'controllers/usersController':
      deps: [
        'libs/angular', 'app'
        , 'services/userService'
      ]
    'directives/authDirective':
      deps: [
        'libs/angular', 'app'
      ]
    'responseInterceptors/auth':
      deps: [
        'libs/angular', 'app'
      ]
    'services/gameService':
      deps: [
        'libs/angular', 'app'
        , 'libs/angular-resource'
      ]
    'services/playerService':
      deps: [
        'libs/angular', 'app'
        , 'libs/angular-resource'
      ]
    'services/userAccountService':
      deps: [
        'libs/angular', 'app'
        , 'libs/angular-resource'
      ]
    'services/userService':
      deps: [
        'libs/angular', 'app'
        , 'libs/angular-resource'
      ]
    'app': deps: ['libs/angular', 'libs/angular-resource']
    'bootstrap': deps: ['libs/angular', 'app']
    'routes': deps: ['libs/angular', 'app']
  [
    'require'
    'libs/bootstrap'
    'controllers/loginController'
    'controllers/logoutController'
    'controllers/mainController'
    'controllers/nacController'
    'controllers/usersController'
    'controllers/userController'
    'controllers/playersController'
    'responseInterceptors/auth'
    'directives/authDirective'
    'routes'
  ], (require) ->
    require ['bootstrap']
 