require
  shim:
    'libs/angular-resource': deps: [ 'libs/angular' ]
    'libs/bootstrap': deps: ['libs/jquery-1.8.3' ]
    'controllers/loginController':
      deps: [
        'app'
        , 'responseInterceptors/auth'
      ]
    'controllers/logoutController':
      deps: [
        'app'
        , 'responseInterceptors/auth'
      ]
    'controllers/mainController':
      deps: [
        'app'
        , 'responseInterceptors/auth'
      ]
    'controllers/nacController':
      deps: [
        'app'
        , 'services/gameService'
        , 'services/userService'
        , 'services/playerService'
      ]
    'controllers/playersController':
      deps: [
        'app'
        , 'services/playerService'
      ]
    'controllers/userController':
      deps: [
        'app'
        , 'services/userAccountService'
      ]
    'controllers/usersController':
      deps: [
        'app'
        , 'services/userService'
      ]
    'controllers/socket':
      deps: [
        'app'
        , 'services/socket'
      ]
    'directives/authDirective': deps: ['app']
    'responseInterceptors/auth': deps: ['app']
    'services/gameService': deps: ['app']
    'services/playerService': deps: ['app']
    'services/userAccountService': deps: ['app']
    'services/userService': deps: ['app']
    'services/socket': deps: ['app']
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
    'controllers/socket'
    'responseInterceptors/auth'
    'directives/authDirective'
    'routes'
  ], (require) ->
    require ['bootstrap']
 