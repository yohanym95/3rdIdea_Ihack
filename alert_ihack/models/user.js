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

const Location=mongoose.model('location',new mongoose.Schema({
    lat:{
        type:String
    },
    lng:{
        type:String
    }
}))

module.exports.User=User;           //export User class
module.exports.Location=Location;