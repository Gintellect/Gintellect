# 
# Serve content over a socket
# 

module.exports = (socket) ->
  socket.emit('send:name', {
    name: 'Bob'
  })

  setInterval () ->
    socket.emit 'send:time', 
    time: (new Date()).toString()
  , 1000
