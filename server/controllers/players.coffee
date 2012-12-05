models = require '../models/models'

exports.create = (req, res) ->
  req.body.user_id = req.user._id
  models.players.create req.body, (err, player) ->
    if err
      res.json 500
    else
      res.json 200, player

exports.destroy = (req, res) ->
  models.players.destroy req.params.id, (err) ->
    if err
      res.json 404
    else
      res.json 200

exports.show = (req, res) ->
  models.players.findOneById req.params.id, (err, player) ->
    if err
      res.json 404
    else
      res.json 200, player

exports.index = (req, res) ->
 
  max = () ->
    if  isNaN req.query.max
      10
    else
      req.query.max || 10

  max = max()

  models.players.find {query: {user_id: req.user._id}
  , sort: {name: 'desc'}, limit: max }
  , (err, result) ->
    if err
      res.json 404
    else
      res.json 200, result
