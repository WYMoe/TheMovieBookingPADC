//
//  AppbarView.swift
//  TheMovieBookingPADC
//
//  Created by Wai Yan Moe on 10/05/2023.
//

import SwiftUI

struct AppbarView: View {
    var body: some View {
        HStack{
            Image(systemName: IC_LOCATION)
                .resizable()
                .frame(width: 16,height: 16)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .padding(.leading,28)
            Text("Yangon")
                .font(.system(size: 16))
                .foregroundColor(Color((PRIMARY_LIGHT_COLOR)))
                .italic()
                .fontWeight(.bold)
            Spacer()
            Image(systemName: IC_SEARCH)
                .resizable()
                .frame(width: 22,height: 22)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .padding(.trailing,20)
            
            // Spacer()
            Image(systemName: "bell.fill")
                .resizable()
                .frame(width: 22,height: 22)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .padding(.trailing,20)
            //Spacer()
            Image(systemName: "qrcode.viewfinder")
                .resizable()
                .frame(width: 22,height: 22)
                .foregroundColor(Color(PRIMARY_LIGHT_COLOR))
                .padding(.trailing,28)
            
            
        }
    }
}

struct AppbarView_Previews: PreviewProvider {
    static var previews: some View {
        AppbarView()
    }
}
