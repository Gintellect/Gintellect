models = require '../models/models'

exports.create = (req, res) ->
  #find the game by id
  models.games.findOneById req.params.id
  , (err, game) ->
    if err
      res.json 404, {result: 'game not found ' + err}
    else if game
      game.takeTurn req.body, (err, game) ->
        if err
          res.json 200, {result: err}
        else
          res.json 200, {
            result: 0
            message: 'success'
            game: game
          }
    else
      res.json 404, { result: 'game not found '}