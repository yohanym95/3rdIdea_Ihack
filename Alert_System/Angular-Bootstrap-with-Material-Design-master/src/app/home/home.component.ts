import { Component, OnInit } from '@angular/core';
import { ChatService } from '../chat.service';
import { FormGroup, FormControl } from '@angular/forms';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  socket;                                         // make local variable as socket
  chatbox=new FormGroup({
    sendmsg:new FormControl()                       //make reative form 
  
  });
  constructor(private chatservice:ChatService) {      // get chatservice
    this.socket=chatservice.socket;               // start connection with socket in backend
   }

  ngOnInit() {
    this.socket.on('chat',function(data){             // be emitted according to chat event in socket io
      console.log(data);
    })
  }
  sendmessage(){
    console.log(this.chatbox.value);
    this.socket.emit('chat',                      //emit message in backend 
      this.chatbox.value
    );
  }


  
}
