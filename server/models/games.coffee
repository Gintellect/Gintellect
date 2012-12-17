mongoose = require 'mongoose'

Player = mongoose.model 'Player'
Game = mongoose.model 'Games' 

find = (options, callback) ->
  max = options?.max or 10000
  sort = options?.sort or {}
  query = options?.query or {}
  player = options?.player or {}
  if player 
    pl = new Player { _id : player }
    query.players = pl._id

  if max < 1
    callback
  else
    Game.find(query).sort(sort).limit(max).populate('players').exec callback

create = (json, callback) ->
  obj = new Game json
  
  player1 = new Player json.player_ids[0]
  player2 = new Player json.player_ids[1]

  obj.players.push player1
  obj.players.push player2 
  obj.next_player = player1

  obj.representation = '...|...|...'

  obj.save (err, game) ->
    callback err, game

destroy =  (id, callback) ->
  Game.findOne { _id : id}, (err, game) ->
    if err
      callback err
    else
      game.remove (err) ->
        callback err

findOneById = (id, callback) ->
  Game.findOne { _id : id}, (err, game) ->
    callback err, game

exports.findOneById = findOneById
exports.create = create
exports.takeTurn = takeTurn
exports.destroy = destroy
exports.find = find