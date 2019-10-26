const express=require('express'); 
const router=express.Router();  
const {Message}=require('../models/message'); 

router.post('/save',async(req,res)=>{
    try{
    let message=new Message({
        title:req.body.title,
        date:req.body.date,
        area:req.body.area,
        guides:req.body.guides
    });

    let premessage=await message.save();
    res.send({'msg':'succefully'});

    }catch(err){
        res.send({'msg':'try again'});
    }
});

module.exports=router;
