import { Component, OnInit } from '@angular/core';
import { ChatService } from '../chat.service';
import { FormGroup, FormControl } from '@angular/forms';

@Component({
  selector: 'app-home',
  templateUrl: './home.component.html',
  styleUrls: ['./home.component.scss']
})
export class HomeComponent implements OnInit {
  socket;
  chatbox=new FormGroup({
    sendmsg:new FormControl()
  
  });
  constructor(private chatservice:ChatService) {
    this.socket=chatservice.socket;
   }

  ngOnInit() {
    this.socket.on('chat',function(as){
      console.log(as);
    })
  }
  sendmessage(){
    console.log(this.chatbox.value);
    this.socket.emit('chat',
      this.chatbox.value
    );
  }


  
}
