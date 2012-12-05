###global define###

define ['libs/angular', 'services/services', 'libs/angularResource']
, (angular, services) ->
  'use strict'

  services.factory 'Game', ['$resource', ($resource) ->
    $resource '/api/games/:id', {}
    , { query: { method: 'GET', parms: {}, isArray: true} }
  ]