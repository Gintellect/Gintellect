port = process.env.PORT ? process.argv.splice(2)[0] ? 3005

require('./app').listen(port)