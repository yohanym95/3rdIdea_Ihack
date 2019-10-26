const express=require('express');  // import express 
const app=express();
const socket=require('socket.io'); // import socket.io
const mongoose=require('mongoose');
const user=require('./routes/user'); // routing for user.js

app.use(express.json());        // use middlewear to bind json data to req.body

mongoose.connect('mongodb://localhost/ihack')       // get mongodb connection
.then(()=> console.log('connected to MongoDB...'))      
.catch(err=> console.log(err));

app.use('/api/user',user);                      // it route api/user to user.js

const PORT=process.env.PORT|| 3000;             // get port number by envirenment variable or by hand
const server=app.listen(3000,()=>{
    console.log('Listening on port 3000...');
});

const io=socket(server);                                //bind web server to socket

io.on('connection',function(socket){                 // begin web socket connection
    console.log('made socket connetion'+socket.id);

    socket.on('chat',function(data){                    // chat event to be emitted 
        console.log(data);
        io.sockets.emit('chat',data);                       //chat event to emit
    })
});