angular.module('app').controller 'socket'
, ['$scope', 'socket'
, ($scope, socket) ->
  socket.on 'send:time', (data) ->
    $scope.time = data.time
]