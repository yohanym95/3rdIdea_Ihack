const mongoose=require('mongoose');  

const Message=mongoose.model('message',new mongoose.Schema({
        title:{
            type:String
        },
        date:{
            type:String
        },
        area:{
            type:String
        },
        guides:{
            type:String
        }
        
}));

module.exports.Message=Message;
