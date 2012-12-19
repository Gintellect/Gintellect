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

gameSchema.methods.takeTurn = (turnJson, callback) ->

  turn = @turns.create(turnJson)
  turn.turn_number = @turns.length + 1
  if @next_player.toString() == turn.player_id.toString()
    console.log 'correct person taking turn'
    #check that the move is legal
    space = parseInt(turn.moves[0],10)
    spaceInc = space + 1
    console.log 'spaceInc ' + spaceInc
    
    if @representation.charAt(space) == '.'
      if @next_player.toString() == @players[0].toString()
        console.log 'playing X in place ' + space.toString()
        newRepresentation = @representation[0...space] +
        'X' + @representation[spaceInc..]
        @representation = newRepresentation
        @next_player = @players[1]
      else
        console.log 'playing O in place ' + space
        newRepresentation = @representation[0...space] +
        'O' + @representation[spaceInc..]
        @representation = newRepresentation
        @next_player = @players[0]
   
      @turns.push turn
      @save (err, game) ->
        callback err, game
    else
      console.log 'illegal move'
      callback 'illegal move', @
  else
    console.log 'not your turn'
    callback 'not your turn', @


mongoose.model 'Games', gameSchema