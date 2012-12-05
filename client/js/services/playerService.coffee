###global define###

define ['libs/angular', 'services/services'
, 'libs/angularResource']
, (angular, services) ->
  'use strict'

  services.factory 'Player', ['$resource', ($resource) ->
    $resource '/api/players/:id', {}
    , { query: { method: 'GET', parms: {}, isArray: true} }
  ]