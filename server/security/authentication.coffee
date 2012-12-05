util = require 'util'
path = require 'path'
dir = path.normalize __dirname + "/../../client"
module.exports = (passport, DOMAIN_URI) ->
  users = require('../models/models').users

  FacebookStrategy = require('passport-facebook').Strategy
  HmacStrategy = require('./hmac').Strategy

  FACEBOOK_APP_ID = process.env['GINTELLECT_WWW_FACEBOOK_APP_ID']
  FACEBOOK_APP_SECRET =  process.env["GINTELLECT_WWW_FACEBOOK_APP_SECRET"]

  passport.serializeUser = (user, done) ->
    done null, user.id

  passport.deserializeUser = (obj, done) ->
    users.findOneById obj, (err, user) ->
      if err
        done err, null
      else
        done null, user

  publicAction = (req, res, next) ->
    next()

  userAction = (req, res, next) ->
    console.log 'in user action'
    if req.isAuthenticated()
      console.log 'user is authenticated via session cookie'
      next()
    else
      console.log 'trying hmac'
      #the user was not authenticated via cookies, try hmac
      passport.authenticate('hmac', (err, user, info) ->
        console.log 'hmac has called back'
        if err
          next(err)
        else if not user
          console.log info
          res.json 401, info
        else
          console.log 'user is authenticated via hmac'
          next()
      )(req, res, next)

  adminAction = (req, res, next) ->
    userAction req, res, () ->
      #so we know we're logged in
      #TODO: check roles
      next()

  sysAdminAction = (req, res, next) ->
    userAction req, res, () ->
      #so we know we're logged in
      #TODO: check roles
      next()

  facebookCallback = (req, res) ->
    console.log 'in facebook callback'
    res.sendfile dir + '/views/success.html'

  emptyAction = (req, res) ->
    {}

  loginStatus = (req, res) ->
    if req.isAuthenticated()
      res.json 200, { loggedIn: true }
    else
      res.json 200, { loggedIn: false }

  logout = (req, res) ->
    req.logout()
    res.redirect '/'

  apiLogout = (req, res) ->
    req.logout()
    res.send 200

  passport.use new FacebookStrategy(
    { clientID: FACEBOOK_APP_ID
    , clientSecret: FACEBOOK_APP_SECRET
    , callbackURL: DOMAIN_URI + "/auth/facebook/callback"}
    , (accessToken, refreshToken, profile, done) ->
      # asynchronous verification, for effect...
      process.nextTick () ->
        users.findOrCreate { name: profile.displayName
        , provider_id : profile.id
        , user_ids: [{provider: 'Facebook', provider_id: profile.id}] }
        , (err, user) ->
          done(null, user)
  )

  passport.use new HmacStrategy((accessKey, done) ->
    # if there is an error , we should return:    #   done(err)
    users.findOneByProviderId accessKey, (err, user) ->
      if err
        done err
      else if not user
        #valid hmac, but unknown user
        done null, false, { message: 'No user found with that accessKey'}
      else
        #success, the access Key is associated with a user
        done null, user
  )

  publicAction: publicAction
  userAction: userAction
  adminAction: adminAction
  sysAdminAction: sysAdminAction
  loginStatus: loginStatus
  logout: logout
  apilogout: apiLogout
  facebookCallback: facebookCallback
  emptyAction: emptyAction