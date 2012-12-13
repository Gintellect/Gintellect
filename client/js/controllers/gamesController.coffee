angular.module('app').controller 'gamesController'
, ['$scope', '$location', 'Game', 'Player'
, ($scope, $location, Game, Player) ->
  $scope.max = 10

  $scope.deleteGame = (id) ->
    Game.delete {id: id}
    , () ->
      $scope.getData()

  $scope.createGame = () ->
    game = { game_number: 1
    , game_name: $scope.gameName
    , players: [ {
    player_id: $scope.player1._id}
    , {player_id: $scope.player2._id }
    ] }
    Game.save game, () ->
      $scope.getData()

  $scope.getGames = () ->
    $scope.games = Game.query {max: $scope.max}
  
  $scope.getPlayers = () ->
    $scope.players= Player.query()

  $scope.getData = () ->
    $scope.getGames()
    $scope.getPlayers()

  $scope.showGame = (id) ->
    $location.path '/games/' + id

  $scope.getData()
]