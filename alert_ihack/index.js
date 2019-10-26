const express=require('express');
const app=express();
const socket=require('socket.io');
const mongoose=require('mongoose');
const user=require('./routes/user');

app.use(express.json());

mongoose.connect('mongodb://localhost/ihack')
.then(()=> console.log('connected to MongoDB...'))
.catch(err=> console.log(err));

app.use('/api/user',user);

// app.get('/',(req,res)=>{
//     console.log('/ working');
//     res.send('hello world');

// });

// app.get('/api/course',(res,req)=>{
//     console.log('api course');
//     res.send('hiiiiiii');
// });

const PORT=process.env.PORT|| 3000;
const server=app.listen(3000,()=>{
    console.log('Listening on port 3000...');
});

const io=socket(server);

io.on('connection',function(socket){
    console.log('made socket connetion'+socket.id);

    socket.on('chat',function(data){
        io.sockets.emit('chat',data);
    })
});