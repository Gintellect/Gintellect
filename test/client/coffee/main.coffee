###global require###

require
  map:
    '*':
      'controllers/usersController': 'dist/client/js/controllers/usersController'
      'services/userService': 'dist/client/js/services/userService'
      'libs/angular': 'dist/client/js/libs/angular'
      'libs/angular-resource': 'dist/client/js/libs/angular-resource'
      'libs/angularMocks': 'test/libs/angular-mocks'
  shim:
    'dist/client/js/libs/angular-resource': deps: ['dist/client/js/libs/angular']
    'test/libs/angular-mocks': deps: ['dist/client/js/libs/angular']
    'dist/client/js/controllers/usersController': deps: [
      'dist/client/js/libs/angular'
      'dist/client/js/app'
      'dist/client/js/services/userService'
    ]
    'dist/client/js/services/userService': deps: [
      'dist/client/js/libs/angular'
      'dist/client/js/app'
      'dist/client/js/libs/angular-resource'

    ]
    'dist/client/js/app': deps: [
      'dist/client/js/libs/angular'
      'dist/client/js/libs/angular-resource'
    ]
  [
    'test/client/spec/controllers/usersSpec'
    'test/client/spec/services/userSpec'
  ], () ->
    window.__testacular__.start()