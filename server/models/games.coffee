mongoose = require 'mongoose'
mongo = require './mongo'

turnSchema = mongoose.Schema {
player_id: 'ObjectId'
, turn_number: 'Number'
, moves: ['String'] }

gameSchema = mongoose.Schema {
game_number: 'Number'
, game_type: 'String'
, game_name: 'String'
, is_active: 'Boolean'
, next_player: 'ObjectId'
, players: [{player_id: 'ObjectId'}]
, turns: [turnSchema]}

Game = mongo.db.model 'Game', gameSchema

gameSchema.methods.playTurn = (turn, callback) ->
  @turns.push turn
  @save (err, game) ->
    callback err game

find = (options, callback) ->
  max = options?.max or 10000
  sort = options?.sort or {}
  query = options?.query or {}
  if max < 1
    callback
  else
    Game.find(query).sort(sort).limit(max).exec callback

create = (json, callback) ->
  obj = new Game json
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

createTurn = (json, callback) ->


exports.findOneById = findOneById
exports.create = create
exports.destroy = destroy
exports.find = find