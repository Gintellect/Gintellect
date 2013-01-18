express = require 'express'
mongo = require './models/mongo'
mongoStore = require('session-mongoose')(express)
path = require 'path'
routes = require './routes'
conf = require './conf'
dir =  path.normalize __dirname + "/../client"
stack = require './common/middleware'
socket = require './socket'

app = express()
server = require('http').createServer(app)

# Hook Socket.io into Express
io = require('socket.io').listen(server)



app.configure ->
  app.use express.favicon(dir + '/img/favicon.ico')
  app.use express.logger('dev')
  app.use express.cookieParser()
  app.use express.bodyParser()
  
  dbUrl =
  "mongodb://" + conf.db.username +
  ':' + conf.db.password +
  '@' + conf.db.host +
  ':' + conf.db.port +
  '/' + conf.db.name

  mongoStoreOpts =
    url: dbUrl
    interval: 300000

  mongooseSessionStore = new mongoStore(mongoStoreOpts)

  sessionOpts =
    cookie:
      maxAge: 1200000
    store: mongooseSessionStore
    secret: conf.security.sessionSecret

  app.use express.session(sessionOpts)

  #configure the static files directory
  app.use express.static dir
  #mainly for the beneift of IE - we will explicitly define no cache
  #on all of our api routes
  app.use '/api', stack.noCache
  #configure all of the security settings
  mongoose = require('mongoose')
  auth = require('gint-security')(app, mongoose, conf.security)

  #configure the routes
  routes app, dir, auth

app.configure 'development', ->
  app.use express.errorHandler({ dumpExceptions: true, showStack: true })

app.configure 'production', ->
  app.use express.errorHandler()

port = process.env.PORT ? process.argv.splice(2)[0] ? 8080
console.log 'listening on port ' + port

io.sockets.on('connection', socket)

module.exports = 
  server: server
  app: app
