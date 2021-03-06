api = require(__dirname + '/controllers/api')

module.exports = (app, dir, auth) ->
  
  #
  # json/api routes
  #

  app.get     '/api/players',         auth.userAction,      api.players.index
  app.post    '/api/players',         auth.userAction,      api.players.create
  app.get     '/api/players/:id',     auth.userAction,      api.players.show
  app.delete  '/api/players/:id',     auth.userAction,      api.players.destroy

  app.get     '/api/games',           auth.userAction,      api.games.index
  app.get     '/api/games/:id',       auth.userAction,      api.games.show
  app.delete  '/api/games/:id',       auth.userAction,      api.games.destroy
  app.post    '/api/games',           auth.userAction,      api.games.create

  app.post    '/api/games/:id/turns', auth.userAction,      api.turns.create

  #all other request routes will be handled by angular on the server
  #so we return the single page app and let the client handle the rest
  app.get '*', (req, res) ->
    res.sendfile "#{dir}/index.html"