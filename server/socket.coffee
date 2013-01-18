# 
# Serve content over a socket
# 

module.exports = (socket) ->
  socket.on 'watch:game', (data) ->
    console.log 'client registered to watch game ' + data.id
    socket.join data.id

  socket.on 'unwatch:game', (data) ->
    console.log 'client stopped watching game ' + data.id
    socket.leave data.id

  socket.on 'play:move', (data) ->
    console.log 'move played in game ' + data.id
    socket.broadcast.to(data.id).emit 'move:played', {id: data.id}
