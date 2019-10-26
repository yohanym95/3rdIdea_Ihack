const mongoose=require('mongoose'); 

const Admin=mongoose.model('admin',new mongoose.Schema({
    email:{
        type:String
    },
    password:{
        type:String
    }
}));
module.exports.Admin=Admin;