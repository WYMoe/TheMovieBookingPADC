//
//  ContentView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 04/05/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var isActive: Bool
    var body: some View {
        NavigationStack{
            
            ZStack{
                if isActive {
                  LoginScreen(showOTP: false)
                }else {
                   
                    SplashView()
                }
                
            }
            .onAppear{
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                            
                    self.isActive = true
                        }
            
            }
            .edgesIgnoringSafeArea([.top,.bottom])
        }
            
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(isActive: false)
        
    }
}




struct SplashView: View {
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
            Color.black
            VStack{
                Image(IC_LOGO)
                Image(IC_TITLE)
            }
            
        
        }
    }
}
