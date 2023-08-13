//
//  MainScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 09/05/2023.
//

import SwiftUI

struct MainScreen: View {
    
    @State var selection:Int = 1
    var cityId : Int = 0
    var cityName : String = ""
    //var userId : Int

  
    init(@State selection:Int, cityId : Int,cityName : String) {
        UITabBar.appearance().backgroundColor = UIColor(Color(PRIMARY_COLOR))
        UITabBar.appearance().barTintColor = UIColor(Color(PRIMARY_COLOR))
        self.selection = selection
        self.cityId = cityId
        self.cityName = cityName
        //self.userId = userId
       // print("mainscreen : \(cityId )")
    }
    var body: some View {
        
        
     
            
            //tabview
            TabView(selection: $selection){
                
                //movie screen
                MoviesScreen(cityId:cityId,cityName: cityName)
                    .tabItem {
                        
                        Text("Movies")
                        Image(systemName: "play.square.fill")
                        
                    }
                    .tag(1)
                
                
                Text("\(selection)")
                    .tabItem {
                        Text("Cinema")
                        
                        Image(systemName: "tv.fill")
                        
                    }
                    .tag(2)
                
                Text("\(selection)")
                    .tabItem {
                        Text("Ticket")
                        Image(systemName: "ticket.fill")
                    }
                    .tag(3)
                
                
                Text("\(selection)")
                    .tabItem {
                        Text("Profile")
                        Image(systemName: "person.fill")
                    }.tag(4)
                
                
                
                
            }
            .accentColor(Color(BTN_COLOR))
          
        
    }
    
   
    
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(selection:1 ,cityId: 0,cityName:"")
    }
}

