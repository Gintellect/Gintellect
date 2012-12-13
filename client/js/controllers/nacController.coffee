angular.module('app').controller 'nacController'
, ['$scope', '$location', '$routeParams'
, 'Game', 'User', 'Player'
, ($scope, $location, $routeParams, Game, User, Player) ->
  $scope.max = 10

  $scope.getData = () ->
    $scope.game = Game.get {id: $routeParams.id}, () ->
      $scope.player1 = Player.get { id: $scope.game.players[0].player_id }
      , () ->
        $scope.nextPlayer = $scope.player1
      $scope.player2 = Player.get { id: $scope.game.players[1].player_id }

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

  readUrl = (value) ->
    console.log('read url called')
    console.log(value)
    if value
      value = value.split('/')
      $scope.nextMove = value[1]
      angular.forEach value[0].split(';'), (row, col) ->
        console.log('row: ' + row)
        console.log('col: ' + col)
        console.log('row split: ' + row.split(','))
        $scope.board[col] = row.split(',')
        console.log($scope.board)
      grade()

  $scope.getData()
  $scope.reset()
]