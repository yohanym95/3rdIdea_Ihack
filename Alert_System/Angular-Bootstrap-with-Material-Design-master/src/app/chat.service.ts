import { Injectable } from '@angular/core';
import * as io from 'socket.io-client';
@Injectable({
  providedIn: 'root'
})
export class ChatService {
  socket;
  constructor() {
    this.socket = io.connect('http://localhost:3000/');           // start connection with backend
    // ws://echo.websocket.org 
    // this.socket=io.connect('ws://echo.websocket.org'); 
  }


}
