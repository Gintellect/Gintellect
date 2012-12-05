express = require 'express'
mongoStore = require('session-mongoose')(express)
passport = require 'passport'
path = require 'path'
util = require 'util'
routes = require './routes'
dir =  path.normalize __dirname + "/../client"

DOMAIN_URI = process.env["GINTELLECT_WWW_DOMAIN_URI"] ?
"http://www.gintellect.com"
port = process.env.PORT ? process.argv.splice(2)[0] ? 8080

if port is not 80
  DOMAIN_URI = DOMAIN_URI + ":" + port

#configure all of the security settings
auth = require('./security/authentication')(passport, DOMAIN_URI)

app = express()

conf = {
  db : {
    host: process.env['DOTCLOUD_DB_MONGODB_HOST'] or 'localhost',
    port: process.env['DOTCLOUD_DB_MONGODB_PORT'] or '27017',
    username: process.env['GINTELLECT_WWW_DB_LOGIN'] or 'user',
    password: process.env['GINTELLECT_WWW_DB_PASSWORD'] or 'pass'
  }
}

app.configure () ->
  app.use express.favicon(dir + '/img/favicon.ico')
  app.use express.logger('dev')
  app.use express.cookieParser()
  app.use express.bodyParser()
  
  dbUrl = "mongodb://" + conf.db.username +
  ':' + conf.db.password + '@' + conf.db.host +
  ':' + conf.db.port + '/gintellect'

  mongooseSessionStore = new mongoStore({ url: dbUrl
  , interval: 300000 #five
  })

  app.use express.session( {cookie: {maxAge: 120000}
  , store: mongooseSessionStore
  , secret: process.env['GINTELLECT_SECRET'] || 'secret' })
  app.use passport.initialize()
  app.use passport.session()
  app.use express.static dir
  app.use app.router
  routes app, dir, auth

app.configure 'development', () ->
  app.use express.errorHandler({ dumpExceptions: true, showStack: true })

app.configure 'production', () ->
  app.use express.errorHandler()

app.listen port, ->
  console.log "started web server at " + DOMAIN_URI