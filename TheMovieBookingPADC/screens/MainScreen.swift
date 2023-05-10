//
//  MainScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 09/05/2023.
//

import SwiftUI

struct MainScreen: View {
    

    
    var body: some View {
        
                
                TabView{
                    MoviesScreen()
                        .tabItem {
                            Text("Movies")
                                .foregroundColor(Color(PRIMARY_DARK_COLOR))
                            Image(systemName: "play.square.fill")
                                .foregroundColor(Color(BTN_COLOR))
                        }
                    
                    MoviesScreen()
                        .tabItem {
                            Text("Cinema")
                                .foregroundColor(Color(PRIMARY_DARK_COLOR))
                            Image("cinema tab icon")
                                .foregroundColor(Color(BTN_COLOR))
                        }
                    MoviesScreen()
                        .tabItem {
                            Text("Ticket")
                            Image("ticket tab icon")
                        }
                    MoviesScreen()
                        .tabItem {
                            Text("Profile")
                            Image("profile tab icon")
                        }
                   
                    
                    
                    
                }//.foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
                .accentColor(Color(BTN_COLOR))
            
         
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}

