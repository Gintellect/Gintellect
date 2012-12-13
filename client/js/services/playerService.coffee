angular.module('app').factory 'Player'
, ['$resource', ($resource) ->
  $resource '/api/players/:id', {}
  , { query: { method: 'GET', parms: {}, isArray: true} }
]