import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl } from '@angular/forms';
import { AdminService } from '../admin.service';

@Component({
  selector: 'app-message',
  templateUrl: './message.component.html',
  styleUrls: ['./message.component.scss']
})
export class MessageComponent implements OnInit {
  allmsg;

  message=new FormGroup({
    title:new FormControl(),
    date:new FormControl(),
    area:new FormControl(),
    guides:new FormControl()
  })
  constructor(private adminservice:AdminService) { }

  ngOnInit() {
    this.allmsg=this.adminservice.get_allmessage().
    subscribe(data=>{
      this.allmsg=data;
      console.log(data);
    })
    
  }
  get_message(){
    console.log(this.message.value);
    this.adminservice.send_information(this.message.value)
    .subscribe(data=>{
      console.log(data);
      this.message.reset();
    })
  }

}
