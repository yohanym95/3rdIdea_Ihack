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
import { MapComponent } from './map/map.component';
import { AgmCoreModule } from '@agm/core';
import { UserComponent } from './user/user.component';

@NgModule({
  declarations: [
    AppComponent,
    NavbarComponent,
    HomeComponent,
    LoginComponent,
    MessageComponent,
    MapComponent,
    UserComponent
  ],
  imports: [
    BrowserModule,
    ReactiveFormsModule,
    HttpClientModule,
    AgmCoreModule.forRoot({
      // apiKey: 'AIzaSyBIkxDymyz0c8QvZtji1HEWGGvtXBHzaNk'
      apiKey: 'AIzaSyCV4UEXFCrxhJY1VYMJ9YRgq_9jCn95or0'
    }),
    MDBBootstrapModule.forRoot(),
    RouterModule.forRoot([
      {path:'home',component:HomeComponent},
      {path:'map',component:MapComponent},
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
