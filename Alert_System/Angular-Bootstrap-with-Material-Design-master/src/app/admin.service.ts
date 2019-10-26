import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';
 

@Injectable({
  providedIn: 'root'
})
export class AdminService {
  address='http://localhost:3000/';
  constructor(private http:HttpClient) { }

  public login_admin(adimlogin){
    return this.http.post(this.address+'api/admin/login',adimlogin);
  }

  public send_information(message){
   return this.http.post(this.address+'api/message/save',message);
  }

}
