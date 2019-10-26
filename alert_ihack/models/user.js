const mongoose=require('mongoose');

const User=mongoose.model('user',new mongoose.Schema({
    fname:{
        type:String
    },
    lname:{
        type:String
    },
    email:{
        type:String
    },
    password:{
        type:String
    },
    phnumber:{
        type:Number
    }
}));

module.exports.User=User;