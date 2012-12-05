mongoose = require 'mongoose'
mongo = require './mongo'
Schema = mongoose.Schema
util = require 'util'

playerSchema = mongoose.Schema {
user_id: 'ObjectId'
, name: 'String'
, mood: 'String'
}

Player = mongo.db.model 'Players', playerSchema

find = (options, callback) ->
  max = options?.max or 10000
  sort = options?.sort or {}
  query = options?.query or {}
  if max < 1
    callback
  else
    Player.find(query).sort(sort).limit(max).exec callback

findOneById = (id, callback) ->
  Player.findOne { _id : id}, (err, player) ->
    callback err, player

create = (json, callback) ->
  obj = new Player json
  obj.save (err, player) ->
    if err
      callback err
    else
      callback err, player

destroy =  (id, callback) ->
  Player.findOne { _id : id}, (err, player) ->
    if err
      callback err
    else
      player.remove (err) ->
        callback err

exports.find = find
exports.findOneById = findOneById
exports.create = create
exports.destroy = destroy