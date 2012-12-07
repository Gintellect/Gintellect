express = require 'express'
mongoStore = require('session-mongoose')(express)
path = require 'path'
routes = require './routes'
conf = require './conf'
dir =  path.normalize __dirname + "/../client"
users = require('./models/models').users

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
      maxAge: 120000
    store: mongooseSessionStore
    secret: process.env['GINTELLECT_SECRET'] || 'secret'

  app.use express.session(sessionOpts)

  #configure the static files directory
  app.use express.static dir

  #configure all of the security settings
  auth = require('gintellect-security')(app, users, conf.security)

  #configure the routes
  routes app, dir, auth

app.configure 'development', ->
  app.use express.errorHandler({ dumpExceptions: true, showStack: true })

app.configure 'production', ->
  app.use express.errorHandler()

app.listen conf.www.port, ->
  console.log "started web server at " + conf.security.DOMAIN_URI