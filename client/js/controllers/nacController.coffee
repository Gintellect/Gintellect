angular.module('app').controller 'nacController'
, ['$scope', '$location', '$routeParams'
, 'Game', 'Turn', 'User', 'Player'
, ($scope, $location, $routeParams, Game, Turn, User, Player) ->
  $scope.max = 10

  $scope.changeSelectedPlayer = () ->
    $scope.games = Game.query { player: $scope.player._id }

  refreshGame = () ->
    $scope.player1 = Player.get { id: $scope.game.players[0] }
    , () ->
      $scope.player2 = Player.get { id: $scope.game.players[1] }
      , () ->
        refreshBoard()

  refreshBoard = () ->
    console.log 'refreshing board'
    if $scope.game.next_player == $scope.player1._id
      $scope.nextPlayer = $scope.player1
    else
      $scope.nextPlayer = $scope.player2
    renderBoard $scope.game.representation

  $scope.selectGame = (id) ->
    console.log 'in select game '
    $scope.game = Game.get { id: id }, () ->
      refreshGame()

  $scope.createGame = () ->
    game = { game_number: 1
    , name: $scope.gameName
    , players: [ {
    _id: $scope.newplayer1._id}
    , {_id: $scope.newplayer2._id }
    ] }
    Game.save game, () ->
      $scope.getData()

  $scope.getData = () ->
    $scope.players = Player.query()

  $scope.cellStyle =
    'height': '50px'
    'width': '50px'
    'border': '1px solid black'
    'text-align': 'center'
    'vertical-align': 'middle'
    'cursor': 'pointer'
  
  $scope.reset = () ->
    $scope.board = [
      ['', '', ''],
      ['', '', ''],
      ['', '', '']
    ]
    $scope.nextMove = 'X'
    $scope.winner = ''

  $scope.dropPiece = (row, col) ->
    move = row * 3 + col

    turn = 
      player_id: $scope.player._id
      turn_number: 1
      moves: [move]

    Turn.save {id: $scope.game._id}, turn, () ->
      console.log 'turn saved, selecting game'
      $scope.selectGame($scope.game._id)


  grade = () ->
    same = (a, b, c) ->
      if a==b && b==c
        a
      else
        ''

    row = (row) ->
      same b[row][0], b[row][1], b[row][2]

    col = (col) ->
      same b[0][col], b[1][col], b[2][col]
    
    diagonal = (i) ->
      same b[0][1-i], b[1][1], b[2][1+i]
    b = $scope.board
    $scope.winner =
      row(0) || row(1) || row(2) ||
      col(0) || col(1) || col(2) ||
      diagonal(-1) || diagonal(1)
    if $scope.winner
      if $scope.winner == 'X'
        $scope.winningPlayer = $scope.player1
      else
        $scope.winningPlayer = $scope.player2

  renderBoard = (value) ->
    console.log(value)
    if value
      i = 0
      for row in [0..2]
        for column in [0..2]
          if value[i] == '.'
            $scope.board[row][column] = ''
          else
            $scope.board[row][column] = value[i]
          i = i+1

      grade()

  $scope.getData()
  $scope.reset()
]