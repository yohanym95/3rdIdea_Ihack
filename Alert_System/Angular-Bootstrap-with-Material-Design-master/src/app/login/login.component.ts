import { Component, OnInit } from '@angular/core';
import { FormGroup, FormControl } from '@angular/forms';
import { AdminService } from '../admin.service';
import { Router } from '@angular/router';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.scss']
})
export class LoginComponent implements OnInit {

  login=new FormGroup({
    email:new FormControl(),
    password:new FormControl()
  })
  constructor(private adminservice:AdminService,private router:Router) { }

  ngOnInit() {
  }

  login_sent(){
    this.adminservice.login_admin(this.login.value).
    subscribe(data=>{
      this.router.navigate(['message']);
      console.log(data);
    });
    
  }

}
