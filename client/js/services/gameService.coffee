angular.module('app').factory 'Game'
, ['$resource', ($resource) ->
  $resource '/api/games/:id', {}
  , { query:
        method: 'GET'
        parms: {}
        isArray: true
    }
]

angular.module('app').factory 'Turn'
, ['$resource', ($resource) ->
  $resource '/api/games/:id/turns', {}
  , {}
]