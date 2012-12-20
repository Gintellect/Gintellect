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
  #annoying, but looks like this is what we need
  #to do to make it work, otherwise we get
  #wierd prototype issues when we cast to obj  
 
  players = (new Player item for item in json.players)
  delete json.players
  obj = new Game json

  for player, index in players
    obj.players.push player
    if index is 0
      obj.next_player = player

  obj.representation = '.........'

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
exports.destroy = destroy
exports.find = find