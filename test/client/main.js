require({
  map: {
    '*': {
      'controllers/controllers': 'dist/client/js/controllers/controllers',
      'controllers/salesController': 'dist/client/js/controllers/salesController',
      'controllers/usersController': 'dist/client/js/controllers/usersController',
      'services/services': 'dist/client/js/services/services',
      'services/userService': 'dist/client/js/services/userService',
      'libs/angular': 'dist/client/js/libs/angular',
      'libs/angularResource': 'dist/client/js/libs/angular-resource',
      'libs/angularMocks': 'test/libs/angular-mocks'
    }
  },
  //note that as at least in testacular 0.5.x, shim cannot take note of the above maps
  //but the maps are ok to use elsewhere though
  shim: { 
    'dist/client/js/libs/angular': {
      exports: 'angular'
    },
    'dist/client/js/libs/angular-resource': {
      deps: [
        'dist/client/js/libs/angular'
      ]
    },
    'test/libs/angular-mocks': {
      deps: ['dist/client/js/libs/angular']
    }
  }
}, ['test/client/spec/controllers/usersSpec', 'test/client/spec/services/userSpec'], function() {
  window.__testacular__.start();
});