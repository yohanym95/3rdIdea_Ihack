import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { MDBBootstrapModule } from 'angular-bootstrap-md';

import { AppComponent } from './app.component';
import { NavbarComponent } from './navbar/navbar.component';
import { HomeComponent } from './home/home.component';
import { ReactiveFormsModule } from '@angular/forms';
 
import { RouterModule } from '@angular/router';
import { LoginComponent } from './login/login.component';
import { HttpClientModule }    from '@angular/common/http';
import { MessageComponent } from './message/message.component';

@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    HomeComponent,
    LoginComponent,
    MessageComponent
  ],
  imports: [
    BrowserModule,
    ReactiveFormsModule,
    HttpClientModule,
    MDBBootstrapModule.forRoot(),
    RouterModule.forRoot([
      {path:'home',component:HomeComponent},
       {path:'message',component:MessageComponent},
      {path:'login',
          children:[
            {path:'',component:LoginComponent},
            
          ]}
    ])
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
