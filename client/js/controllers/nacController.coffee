angular.module('app').controller 'nacController'
, ['$scope', '$location', '$routeParams'
, 'Game', 'User', 'Player'
, ($scope, $location, $routeParams, Game, User, Player) ->
  $scope.max = 10

  $scope.changeSelectedPlayer = () ->
    $scope.games = Game.query { player: $scope.player._id }

  refreshBoard = () ->
    $scope.player1 = Player.get { id: $scope.game.players[0] }
    , () ->
      $scope.player2 = Player.get { id: $scope.game.players[1] }
      , () ->
        if $scope.game.next_player == $scope.player1._id
          $scope.nextPlayer = $scope.player1
        else
          $scope.nextPlayer = $scope.player2
        renderBoard $scope.game.representation

  $scope.selectGame = (id) ->
    console.log 'in select game ' 
    $scope.game = Game.get { id: id }, () ->
      refreshBoard()

  $scope.getData = () ->
    $scope.players = Player.query()

    $scope.game = Game.get {id: $routeParams.id}, () ->
      refreshBoard()

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
    if not $scope.winner && not $scope.board[row][col]

      $scope.board[row][col] = $scope.nextMove
      if $scope.nextMove == 'X'
        $scope.nextPlayer = $scope.player2
        $scope.nextMove = 'O'
      else
        $scope.nextPlayer = $scope.player1
        $scope.nextMove = 'X'
      grade()

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
      for row_moves, row in value.split '|'
        for move, column in row_moves.split ''
          if move == '.'
            $scope.board[row][column] = ''
          else
            $scope.board[row][column] = move
      console.log($scope.board)
      grade()

  $scope.getData()
  $scope.reset()
]