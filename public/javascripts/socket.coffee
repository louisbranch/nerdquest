io = require('socket.io')
socket = io.connect('http://localhost:9393')
socket.on 'news', (data) ->
  console.log(data)
  socket.emit('my other event', { my: 'data' })
