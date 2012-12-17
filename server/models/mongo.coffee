mongoose = require 'mongoose'

#requiring these model files pops their schemas into
#the mongoose object
require './mongoose/users'
require './mongoose/players'
require './mongoose/games'

host = process.env['DOTCLOUD_DB_MONGODB_HOST'] || 'localhost'
port = process.env['DOTCLOUD_DB_MONGODB_PORT'] ||  27017
port = parseInt port
user = process.env['GINTELLECT_WWW_DB_LOGIN'] || ''
pass = process.env['GINTELLECT_WWW_DB_PASSWORD'] || ''

opts = { user: user, pass: pass }

console.log 'creating mongoose connection'
mongoose.connect host, 'gintellect', port, opts