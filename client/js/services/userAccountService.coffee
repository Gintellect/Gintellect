###global define###

define ['libs/angular', 'services/services', 'libs/angularResource']
, (angular, services) ->
  'use strict'

  methods = 
    query: 
      method: 'GET'
      params: {}
      isArray: true
    resetApi: 
      method: 'PUT' 
      params: 
        resetApi: true

  services.factory 'UserAccount', ['$resource', ($resource) ->
    $resource '/api/user', {}, methods
  ]