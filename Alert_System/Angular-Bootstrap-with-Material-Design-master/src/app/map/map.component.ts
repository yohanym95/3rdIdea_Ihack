import { Component, OnInit } from '@angular/core';
import { UserService } from '../user.service';

@Component({
  selector: 'app-map',
  templateUrl: './map.component.html',
  styleUrls: ['./map.component.scss']
})
export class MapComponent implements OnInit {
  loc;
  lat = 6.9271;
  lng = 79.8612;
  constructor(private userservice:UserService) { }

  ngOnInit() {
    this.userservice.get_location().
    subscribe(data=>{
      this.loc=data;
      this.lat=this.loc[0].lat;
      this.lng=this.loc[0].lng;
      console.log(this.loc[0]);

      // for(let item in this.loc){
      //   console.log(this.loc[item]);
      //   this.lat=this.loc[item].lat;
      //   this.lng=this.loc[item].lng;
      // }
    })
  }
  
}
