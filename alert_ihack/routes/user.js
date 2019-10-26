const express=require('express');

const router=express.Router();
const {User}=require('../models/user');


router.post('/register',async(req,res)=>{
    try{
        let user=new User({
            fname:req.body.fname,
            lname:req.body.lname,
            email:req.body.email,
            password:req.body.password,
            phnumber:req.body.phnumber
        }); 

        let isemail=await User.findOne({email:req.body.email});
        console.log(isemail);
        if(isemail)
        return res.send({"msg":"this email has been taken"});

        let preuser=await user.save();
        res.send({"msg":"you succefully registered"});
    }catch(err){
        console.log(err);
        res.send({"msg":"try again"});
    }
});

router.post('/login',async(req,res)=>{
    try{
        let isreg=await User.findOne({email:req.body.email});
        if(!isreg)
        return res.send({"msg":"this email address has not been registered"});

        if(isreg.password==req.body.password)
        return res.send({"msg":"true"});

        else{
            return res.send({"msg":"password is invalide"});
        }
    }catch(err){
            console.log(err);
            res.send({"msg":"try again"});
    }
})



module.exports=router;