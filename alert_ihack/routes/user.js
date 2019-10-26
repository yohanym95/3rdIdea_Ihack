const express=require('express');           // import express

const router=express.Router();                  // import router Class
const {User}=require('../models/user');         


router.post('/register',async(req,res)=>{           // rest api post for register app users
    try{
        let user=new User({                             // create json user object by getting data from js 
            fname:req.body.fname,
            lname:req.body.lname,
            email:req.body.email,
            password:req.body.password,
            phnumber:req.body.phnumber
        }); 

        let isemail=await User.findOne({email:req.body.email});         //find email is exist on that user
        console.log(isemail);
        if(isemail)                                                         // if email is exist return json message email has been taken
        return res.send({"msg":"this email has been taken"});

        let preuser=await user.save();  
        res.send({"msg":"you succefully registered"});                              // after suceefully registerd return you succefully registerd
    }catch(err){
        console.log(err);
        res.send({"msg":"try again"});
    }
});

router.post('/login',async(req,res)=>{                              // rest end point for login 
    try{
        let isreg=await User.findOne({email:req.body.email});       // find that email is exist
        if(!isreg)
        return res.send({"msg":"this email address has not been registered"});      //if email is not return this..

        if(isreg.password==req.body.password)
        return res.send({"msg":"true"});                //check password is correct and return true

        else{
            return res.send({"msg":"password is invalide"});
        }
    }catch(err){
            console.log(err);
            res.send({"msg":"try again"});              //if error is occured return try again
    }
})



module.exports=router;                  // export router object