port = process.env.PORT ? process.argv.splice(2)[0] ? 8080
console.log 'listening on port ' + port
require('./app').listen(port)