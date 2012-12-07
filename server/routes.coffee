api = require(__dirname + '/controllers/api')

module.exports = (app, dir, auth) ->
  
  #
  # json/api routes
  #

  # userAction routes
  app.get     '/api/user',            auth.userAction,      api.users.showMe
  app.put     '/api/user',            auth.userAction,      api.users.updateMe
  app.delete  '/api/user',            auth.userAction,      api.users.destroyMe

  app.get     '/api/players',         auth.userAction,      api.players.index
  app.post    '/api/players',         auth.userAction,      api.players.create
  app.get     '/api/players/:id',     auth.userAction,      api.players.show
  app.delete  '/api/players/:id',     auth.userAction,      api.players.destroy

  app.get     '/api/games',           auth.userAction,      api.games.index
  app.get     '/api/games/:id',       auth.userAction,      api.games.show
  app.delete  '/api/games/:id',       auth.userAction,      api.games.destroy
  app.post    '/api/games',           auth.userAction,      api.games.create

  app.post    '/api/turns',           auth.userAction,      api.games.create

  # sysAdminAction routes
  app.get     '/api/users',           auth.sysAdminAction,  api.users.index
  app.delete  '/api/users/:id',       auth.sysAdminAction,  api.users.destroy

  #
  #json/authentication routes
  #

  #This is a special route we're using to let angular poll when waiting
  #for OAuth / etc to be done in a separate window
  app.get     '/api/loginstatus',       auth.publicAction,    auth.loginStatus
  app.get     '/api/logout',            auth.publicAction,    auth.apiLogout

  #all other request routes will be handled by angular on the server
  #so we return the single page app and let the client handle the rest
  app.get '*', (req, res) ->
    res.sendfile "#{dir}/index.html"