import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class UserService {
  address='http://localhost:3000/';
  constructor(private http:HttpClient) { }

  public get_location(){
   return this.http.get(this.address+'api/user/location');
  }
}
