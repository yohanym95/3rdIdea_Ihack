const mongoose=require('mongoose');                     // import mongoose 

const User=mongoose.model('user',new mongoose.Schema({          // create user schema and model class
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

module.exports.User=User;           //export User class