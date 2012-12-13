angular.module('app').controller 'playersController'
, ['$scope', 'Player'
, ($scope, Player) ->

  $scope.createPlayer = (name) ->
    player = {user_id: $scope.me.id, name: name}
    player.mood = 'tired'
    Player.save player, () ->
      $scope.refresh()

  $scope.getPlayers = () ->
    $scope.players = Player.query()
  
  $scope.deletePlayer = (id) ->
    Player.delete {id: id}
    , () ->
      $scope.refresh()

  $scope.refresh = () ->
    $scope.getPlayers()

  $scope.refresh()
]