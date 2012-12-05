models = require '../models/models'

exports.create = (req, res) ->
  #find the game by id
  models.games.findOneById req.body.game_id
  , (err, game) ->
    if err
      res.json 404, {result: 'game not found'}
    else
      game.playTurn req.body, (err, game) ->
        if err
          res.json 500, {result: err}
        else
          res.json 200, game