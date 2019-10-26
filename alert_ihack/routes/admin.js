const express=require('express'); 
const router=express.Router();   
const {Admin}=require('../models/admin');  

router.post('/login',async(req,res)=>{
    try{
        let isadmin=await Admin.findOne({email:req.body.email});       // find that email is exist
        if(!isadmin)
        return res.send({"msg":"this email address is not valid"});      //if email is not return this..

        if(isadmin.password==req.body.password)
        return res.send({"msg":"true"});                //check password is correct and return true

        else{
            return res.send({"msg":"password is invalide"});
        }
    }catch(err){
            console.log(err);
            res.send({"msg":"try again"});              //if error is occured return try again
    }
});

router.post('/register',async(req,res)=>{
    try{
    let admin=new Admin({
       email:req.body.email,
       password: req.body.password 
    });
    admin.save();
    res.send({"msg":"you succefully registered"});
    }catch(err){
        res.send
    }

})

module.exports=router;