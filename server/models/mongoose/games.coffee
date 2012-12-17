mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.Types.ObjectId

Player = mongoose.model 'Player'

turnSchema = new Schema {
player_id: 'ObjectId'
, turn_number: 'Number'
, moves: ['String'] }

gameSchema = new Schema {
game_number: 'Number'
, game_type: 'String'
, name: 'String'
, is_active: 'Boolean'
, representation: 'String'
, players : [{type: ObjectId, ref: 'Player'}]
, next_player: {type: ObjectId, ref: 'Player' }
, turns: [turnSchema]}

gameSchema.methods.takeTurn = (turn, callback) ->
  if @next_player == turn.player_id
    console.log 'correct person taking turn'

    @turns.push turn
    @save (err, game) ->
      callback err game
  else
    console.log 'not your turn'


mongoose.model 'Games', gameSchema