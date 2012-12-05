api = require(__dirname + '/controllers/api')
passport = require 'passport'

module.exports = (app, dir, auth) ->
  
  #
  # json/api routes
  #

  #
  # user routes
  #

  # /user is a bit special, as it only allows the user access to their own
  # account record
  app.get     '/api/user',              auth.userAction,      api.users.showMe
  app.put     '/api/user',              auth.userAction,      api.users.updateMe
  app.delete  '/api/user',              auth.userAction,      api.users.destroyMe

  app.get     '/api/players',           auth.userAction,      api.players.index
  app.post    '/api/players',           auth.userAction,      api.players.create
  app.get     '/api/players/:id',       auth.userAction,      api.players.show
  app.delete  '/api/players/:id',       auth.userAction,      api.players.destroy

  app.get     '/api/games',             auth.userAction,      api.games.index
  app.get     '/api/games/:id',         auth.userAction,      api.games.show
  app.delete  '/api/games/:id',         auth.userAction,      api.games.destroy
  app.post    '/api/games',             auth.userAction,      api.games.create

  app.post    '/api/turns',             auth.userAction,      api.games.create

  # sysAdmin routes
  app.get     '/api/users',             auth.sysAdminAction,  api.users.index
  app.delete  '/api/users/:id',         auth.sysAdminAction,  api.users.destroy

 
  #
  #json/authentication routes
  #

  #This is a special route we're using to let angular poll when waiting
  #for OAuth / etc to be done in a separate window
  app.get     '/api/loginstatus',       auth.publicAction,    auth.loginStatus
  app.get     '/api/logout',            auth.publicAction,    auth.apiLogout


  #
  #non json/api routes - kept to a bare minimum
  #

  # FACEBOOK authentication
  #   The first step in Facebook authentication will involve
  #   redirecting the user to facebook.com.  After authorization, Facebook will
  #   redirect the user back to this application at /auth/facebook/callback
  #
  app.get '/auth/facebook'
  , passport.authenticate 'facebook' #middleware that redirects us onto facebook
  , auth.emptyAction #this will not be called, as we will have been redirected

  app.get '/auth/facebook/callback'
  , passport.authenticate('facebook', { failureRedirect: '/login' })
  , auth.facebookCallback

  #all other request routes will be handled by angular on the server
  #so we return the single page app and let the client handle the rest
  app.get '*', (req, res) ->
    res.sendfile "#{dir}/index.html"