express = require 'express'
mongo = require './models/mongo'
mongoStore = require('session-mongoose')(express)
path = require 'path'
routes = require './routes'
conf = require './conf'
dir =  path.normalize __dirname + "/../client"
users = require('./models/models').users
stack = require './common/middleware'

app = express()

app.configure ->
  app.use express.favicon(dir + '/img/favicon.ico')
  app.use express.logger('dev')
  app.use express.cookieParser()
  app.use express.bodyParser()
  
  dbUrl = "mongodb://" + conf.db.username +
  ':' + conf.db.password + '@' + conf.db.host +
  ':' + conf.db.port + '/gintellect'

  mongoStoreOpts =
    url: dbUrl
    interval: 300000

  mongooseSessionStore = new mongoStore(mongoStoreOpts)

  sessionOpts =
    cookie:
      maxAge: 1200000
    store: mongooseSessionStore
    secret: process.env['GINTELLECT_SECRET'] || 'secret'

  app.use express.session(sessionOpts)

  #configure the static files directory
  app.use express.static dir
  #mainly for the beneift of IE - we will explicitly define no cache
  #on all of our api routes
  app.use '/api', stack.noCache
  #configure all of the security settings
  auth = require('gintellect-security')(app, users, conf.security)

  #configure the routes
  routes app, dir, auth

app.configure 'development', ->
  app.use express.errorHandler({ dumpExceptions: true, showStack: true })

app.configure 'production', ->
  app.use express.errorHandler()

module.exports = app