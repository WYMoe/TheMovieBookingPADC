//
//  MainScreen.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 09/05/2023.
//

import SwiftUI

struct MainScreen: View {
    var body: some View {
        ZStack{
            Color(PRIMARY_COLOR)
            VStack(spacing:0.0){
                AppbarView()
            }
        }.edgesIgnoringSafeArea([.top,.bottom])
    }
}

struct MainScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
    }
}

struct AppbarView: View {
    var body: some View {
        HStack{
            Image(systemName: IC_LOCATION)
                .resizable()
                .frame(width: 16,height: 16)
                .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
                .padding(.leading,28)
            Text("Yangon")
                .font(.system(size: 16))
                .foregroundColor(Color((PRIMAYR_LIGHT_COLOR)))
                .italic()
                .fontWeight(.bold)
            Spacer()
            Image(systemName: IC_SEARCH)
                .resizable()
                .frame(width: 22,height: 22)
                .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
                .padding(.trailing,20)
            
            // Spacer()
            Image(systemName: "bell.fill")
                .resizable()
                .frame(width: 22,height: 22)
                .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
                .padding(.trailing,20)
            //Spacer()
            Image(systemName: "qrcode.viewfinder")
                .resizable()
                .frame(width: 22,height: 22)
                .foregroundColor(Color(PRIMAYR_LIGHT_COLOR))
                .padding(.trailing,28)
            
            
        }
    }
}
