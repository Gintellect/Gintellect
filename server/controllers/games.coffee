models = require '../models/models'

exports.create = (req, res) ->
  models.games.create req.body, (err, game) ->
    if err
      res.json 500
    else
      res.json 200, game

exports.destroy = (req, res) ->
  models.games.destroy req.params.id, (err) ->
    if err
      res.json 404
    else
      res.json 200

exports.show = (req, res) ->
  models.games.findOneById req.params.id, (err, game) ->
    if err
      res.json 404
    else
      game.board = "........."
      res.json 200, game

exports.index = (req, res) ->
  max = do () ->
    if  isNaN req.query.max
      10
    else
      req.query.max || 10

  query = do () ->
    req.query.player or {}

  models.games.find {player: query, sort: {name: 'desc'}, limit: max }
  , (err, result) ->
    if err
      res.json 404
    else
      res.json 200, result