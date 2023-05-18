//
//  MainScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 09/05/2023.
//

import SwiftUI

struct MainScreen: View {
    
    @State var selection:Int = 1
    init(@State selection:Int) {
        UITabBar.appearance().backgroundColor = UIColor(Color(PRIMARY_COLOR))
        UITabBar.appearance().barTintColor = UIColor(Color(PRIMARY_COLOR))
        self.selection = selection
     }
    var body: some View {


        NavigationStack {
          
                TabView(selection: $selection){
                        MoviesScreen()
                            .tabItem {
                                //Spacer()
                                Text("Movies")
                                
                                Image(systemName: "play.square.fill")
                                //Spacer()
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
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen(selection: 1)
    }
}

