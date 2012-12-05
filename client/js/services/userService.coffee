###global define###

define ['libs/angular', 'services/services', 'libs/angularResource']
, (angular, services) ->
  'use strict'

  services.factory 'User', ['$resource', ($resource) ->
    $resource '/api/users/:id', {}
    , { query: { method: 'GET', parms: {}, isArray: true} }
  ]