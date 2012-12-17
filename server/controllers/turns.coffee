models = require '../models/models'

exports.create = (req, res) ->
  #find the game by id
  models.games.findOneById req.query.game
  , (err, game) ->
    if err
      res.json 404, {result: 'game not found'}
    else
      game.takeTurn req.body, (err, game) ->
        if err
          res.json 500, {result: err}
        else
          res.json 200, game